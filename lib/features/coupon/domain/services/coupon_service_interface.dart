import 'package:sixam_mart/features/coupon/domain/models/coupon_model.dart';
import 'package:get/get.dart';

import '../models/subcription_model.dart';

abstract class CouponServiceInterface{
  Future<List<CouponModel>?> getCouponList();
  Future<Response> pauseYourSubscription(int? id);
  Future<List<Subscription>?> getSubscriptionList();
  Future<List<CouponModel>?> getTaxiCouponList();
  Future<CouponModel?> applyCoupon(String couponCode, int? storeID);
  Future<CouponModel?> applyTaxiCoupon(String couponCode, int? providerId);
}