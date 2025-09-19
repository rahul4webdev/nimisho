import 'package:get/get.dart';
import 'package:sixam_mart/features/coupon/domain/models/coupon_model.dart';
import 'package:sixam_mart/features/coupon/domain/repositories/coupon_repository_interface.dart';
import 'package:sixam_mart/features/coupon/domain/services/coupon_service_interface.dart';

import '../models/subcription_model.dart';

class CouponService implements CouponServiceInterface{
  final CouponRepositoryInterface couponRepositoryInterface;
  CouponService({required this.couponRepositoryInterface});

  @override
  Future<List<CouponModel>?> getCouponList() async {
    return await couponRepositoryInterface.getList(couponList: true);
  }


  @override
  Future<List<CouponModel>?> getTaxiCouponList() async {
    return await couponRepositoryInterface.getList(taxiCouponList: true);
  }

  @override
  Future<CouponModel?> applyCoupon(String couponCode, int? storeID) async {
    return await couponRepositoryInterface.applyCoupon(couponCode, storeID);
  }

  @override
  Future<List<Subscription>?> getSubscriptionList() async {
    return await couponRepositoryInterface.getSubscriptionList();
  }
  @override
  Future<Response> pauseYourSubscription(int? subscription_id) async {
    return await couponRepositoryInterface.pauseYourSubscription(subscription_id);
  }

  @override
  Future<CouponModel?> applyTaxiCoupon(String couponCode, int? providerId) async {
    return await couponRepositoryInterface.applyTaxiCoupon(couponCode, providerId);
  }

}