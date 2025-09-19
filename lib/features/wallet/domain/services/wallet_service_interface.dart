import 'package:get/get.dart';
import 'package:sixam_mart/common/models/transaction_model.dart';
import 'package:sixam_mart/features/wallet/domain/models/fund_bonus_model.dart';

abstract class WalletServiceInterface{
  Future<TransactionModel?> getWalletTransactionList(String offset, String sortingType);
  Future<dynamic> addFundToWallet(double amount, String paymentMethod);
  Future<dynamic> createRazorpayOrder(double amount);
  Future<dynamic> addFundToForSubWallet(double amount, String paymentMethod, String subScriptionid);
  Future<List<FundBonusModel>?> getWalletBonusList();
  Future<Response> getPaymentVerify(String payment_id,String razorpay_id,String order_id,String signature);
  Future<void> setWalletAccessToken(String token);
  String getWalletAccessToken();
}