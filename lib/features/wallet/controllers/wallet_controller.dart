import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/models/transaction_model.dart';
import 'package:sixam_mart/features/wallet/domain/models/wallet_filter_body_model.dart';
import 'package:sixam_mart/features/wallet/domain/models/fund_bonus_model.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:universal_html/html.dart' as html;
import 'package:sixam_mart/features/wallet/domain/services/wallet_service_interface.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../common/widgets/custom_snackbar.dart';

class WalletController extends GetxController implements GetxService {
  final WalletServiceInterface walletServiceInterface;
  WalletController({required this.walletServiceInterface});

  List<Transaction>? _transactionList;
  List<Transaction>? get transactionList => _transactionList;
  
  List<String> _offsetList = [];
  
  int _offset = 1;
  int get offset => _offset;
  
  int? _pageSize;
  int? get popularPageSize => _pageSize;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  String? _digitalPaymentName;
  String? get digitalPaymentName => _digitalPaymentName;


  String? _payment_id;
  String? get payment_id => _payment_id;
  
  bool _amountEmpty = true;
  bool get amountEmpty => _amountEmpty;
  
  List<FundBonusModel>? _fundBonusList;
  List<FundBonusModel>? get fundBonusList => _fundBonusList;
  
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  
  String _type = 'all';
  String get type => _type;
  
  List<WalletFilterBodyModel> _walletFilterList = [];
  List<WalletFilterBodyModel> get walletFilterList => _walletFilterList;

  void setWalletFilerType(String type, {bool isUpdate = true}) {
    _type = type;
    if(isUpdate) {
      update();
    }
  }

  void insertFilterList(){
    _walletFilterList = [];
    for(int i=0; i < AppConstants.walletTransactionSortingList.length; i++){
      _walletFilterList.add(WalletFilterBodyModel.fromJson(AppConstants.walletTransactionSortingList[i]));
    }
  }

  void changeDigitalPaymentName(String name, {bool isUpdate = true}){
    _digitalPaymentName = name;
    if(isUpdate) {
      update();
    }
  }

  void isTextFieldEmpty(String value, {bool isUpdate = true}){
    _amountEmpty = value.isNotEmpty;
    if(isUpdate) {
      update();
    }
  }

  void setOffset(int offset) {
    _offset = offset;
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  Future<void> getWalletTransactionList(String offset, bool reload, String walletType) async {
    if(offset == '1' || reload) {
      _offsetList = [];
      _offset = 1;
      _transactionList = null;
      if(reload) {
        update();
      }

    }
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      TransactionModel? transactionModel = await walletServiceInterface.getWalletTransactionList(offset, walletType);

      if (transactionModel != null) {
        if (offset == '1') {
          _transactionList = [];
        }
        _transactionList!.addAll(transactionModel.data!);
        _pageSize = transactionModel.totalSize;

        _isLoading = false;
        update();
      }
    } else {
      if(isLoading) {
        _isLoading = false;
        update();
      }
    }
  }
  String _fundType = "wallet"; // ya "subscription"

  Future<void> addFundToWallet(double amount, String paymentMethod) async {
    _fundType = "wallet";
    _isLoading = true;
    update();
    Response response = await walletServiceInterface.addFundToWallet(amount, paymentMethod);
    if (response.statusCode == 200) {
      String redirectUrl = response.body['redirect_link'];
      if(paymentMethod == "razor_pay"){
        Get.back();
        RegExp regExp = RegExp(r'[?&]payment_id=([^&]+)');
        Match? match = regExp.firstMatch(redirectUrl);
        String paymentId = "";
        if (match != null) {
          _payment_id = match.group(1)!;
        }else{
          showCustomSnackBar("Something Went Wrong please Try Again!");
        }

        Response razorPayOrder = await walletServiceInterface.createRazorpayOrder(amount);
        print("farukh----4");
        print(razorPayOrder.body);

        Razorpay razorpay = Razorpay();
        var options = {
          'key': '${razorPayOrder.body['api_key']}',
          'amount': amount,
          'order_id': '${razorPayOrder.body['order_id']}', // Generate order_id using Orders API
          'name': 'Nimisho',
          'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
          'external': {
            'wallets': ['paytm']
          }
        };
        razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
        razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
        razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
        razorpay.open(options);
      }else{
        Get.back();
        if(GetPlatform.isWeb) {
          html.window.open(redirectUrl,"_self");
        } else{
          Get.toNamed(RouteHelper.getPaymentRoute('0', 0, '', 0, false, '', addFundUrl: redirectUrl, guestId: ''));
        }
      }


    }
    _isLoading = false;
    update();
  }


  Future<void> addFundForSubscriptionWallet(double amount, String paymentMethod,String order_id) async {
    if (_isLoading) return; // 🚀 prevent duplicate

    _fundType = "subscription";

    _isLoading = true;
    update();
    Response response = await walletServiceInterface.addFundToForSubWallet(amount, paymentMethod,order_id);
    if (response.statusCode == 200) {
      String redirectUrl = response.body['redirect_link'];
      if(paymentMethod == "razor_pay"){
        Response razorPayOrder = await walletServiceInterface.createRazorpayOrder(amount);

        RegExp regExp = RegExp(r'[?&]payment_id=([^&]+)');
        Match? match = regExp.firstMatch(redirectUrl);
        String paymentId = "";
        if (match != null) {
          _payment_id = match.group(1)!;
        }else{
          showCustomSnackBar("Something Went Wrong please Try Again!");
        }
        Razorpay razorpay = Razorpay();
        var options = {
          'key': '${razorPayOrder.body['api_key']}',
          'amount': amount,
          'order_id': '${razorPayOrder.body['order_id']}', // Generate order_id using Orders API
          'name': 'Nimisho',
          'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
          'external': {
            'wallets': ['paytm']
          }
        };
        razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
        razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
        razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
        razorpay.open(options);
      }else{
        Get.back();
        if(GetPlatform.isWeb) {
          html.window.open(redirectUrl,"_self");
        } else{
          Get.toNamed(RouteHelper.getPaymentRoute('0', 0, '', 0, false, '', addFundUrl: redirectUrl, guestId: ''));
        }
      }
    }
    _isLoading = false;
    update();
  }
  void handlePaymentErrorResponse(PaymentFailureResponse response){

    showCustomSnackBar("Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }
  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    Response responses = await walletServiceInterface.getPaymentVerify('$payment_id', '${response.paymentId}','${response.orderId}','${response.signature}');
    Get.back();
    if (_fundType == "wallet") {
      Get.toNamed(RouteHelper.getWalletRoute(fundStatus: 'success', token: UniqueKey().toString()));
    } else if (_fundType == "subscription") {
      Get.toNamed(RouteHelper.getSubscriptionRoute());
    }
  }
  

  void handleExternalWalletSelected(ExternalWalletResponse response){
    showCustomSnackBar("External Wallet Selected ${response.walletName}");
  }

  Future<void> getWalletBonusList({bool isUpdate = true}) async {
    _isLoading = true;
    if(isUpdate) {
      update();
    }

    List<FundBonusModel>? bonuses = await walletServiceInterface.getWalletBonusList();
    if (bonuses != null) {
      _fundBonusList = [];
      _fundBonusList!.addAll(bonuses);

      _isLoading = false;
      update();
    }
  }

  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if(notify) {
      update();
    }
  }

  void setWalletAccessToken(String accessToken){
    walletServiceInterface.setWalletAccessToken(accessToken);
  }

  String getWalletAccessToken (){
    return walletServiceInterface.getWalletAccessToken();
  }

}