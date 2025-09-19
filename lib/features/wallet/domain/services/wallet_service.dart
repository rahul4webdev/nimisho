import 'package:get/get.dart';
import 'package:sixam_mart/common/models/transaction_model.dart';
import 'package:sixam_mart/features/wallet/domain/models/fund_bonus_model.dart';
import 'package:sixam_mart/features/wallet/domain/repositories/wallet_repository_interface.dart';
import 'package:sixam_mart/features/wallet/domain/services/wallet_service_interface.dart';

class WalletService implements WalletServiceInterface {
  final WalletRepositoryInterface walletRepositoryInterface;
  WalletService({required this.walletRepositoryInterface});

  @override
  Future<TransactionModel?> getWalletTransactionList(String offset, String sortingType) async {
    return await walletRepositoryInterface.getList(offset: int.parse(offset), sortingType: sortingType);
  }

  @override
  Future<Response> addFundToWallet(double amount, String paymentMethod) async {
    return await walletRepositoryInterface.addFundToWallet(amount, paymentMethod);
  }
  @override
  Future<Response> addFundToForSubWallet(double amount, String paymentMethod, String subScriptionid) async {
    return await walletRepositoryInterface.addFundToForSubWallet(amount, paymentMethod,subScriptionid);
  }
  @override
  Future<Response> getPaymentVerify(String payment_id, String razorpay_id,String order_id,String signature) async {
    return await walletRepositoryInterface.getPaymentVerify(payment_id, razorpay_id,order_id,signature);
  }
  @override
  Future<Response> createRazorpayOrder(double amount) async {
    return await walletRepositoryInterface.createRazorpayOrder(amount);
  }

  @override
  Future<List<FundBonusModel>?> getWalletBonusList() async {
    return await walletRepositoryInterface.getList(isBonusList: true);
  }

  @override
  Future<void> setWalletAccessToken(String token) {
    return walletRepositoryInterface.setWalletAccessToken(token);
  }

  @override
  String getWalletAccessToken() {
    return walletRepositoryInterface.getWalletAccessToken();
  }

}