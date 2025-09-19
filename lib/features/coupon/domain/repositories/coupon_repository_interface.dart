import 'package:sixam_mart/interfaces/repository_interface.dart';

import '../models/coupon_model.dart';
import '../models/subcription_model.dart';
import 'package:get/get.dart';

abstract class CouponRepositoryInterface extends RepositoryInterface{
  @override
  Future getList({int? offset, bool couponList = false, bool taxiCouponList = false});
  Future<List<Subscription>?> getSubscriptionList();
  Future<Response> pauseYourSubscription(int? id);
  Future<dynamic> applyCoupon(String couponCode, int? storeID);
  Future<dynamic> applyTaxiCoupon(String couponCode, int? providerId);
}