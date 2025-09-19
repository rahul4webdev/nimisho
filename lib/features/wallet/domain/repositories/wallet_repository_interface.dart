import 'package:get/get.dart';
import 'package:sixam_mart/interfaces/repository_interface.dart';

abstract class WalletRepositoryInterface extends RepositoryInterface{
  Future<dynamic> addFundToWallet(double amount, String paymentMethod);
  Future<dynamic> addFundToForSubWallet(double amount, String paymentMethod, String subScriptionid);
  Future<void> setWalletAccessToken(String token);
  Future<Response> getPaymentVerify(String payment_id,String razorpay_id,String order_id,String signature);
  Future<dynamic> createRazorpayOrder(double amount);


  String getWalletAccessToken();
  @override
  Future getList({int? offset, String? sortingType, bool isBonusList = false});
}