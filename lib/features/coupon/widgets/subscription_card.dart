import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/common/controllers/theme_controller.dart';
import 'package:sixam_mart/features/coupon/domain/models/coupon_model.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import '../../../helper/route_helper.dart';
import '../../item/controllers/item_controller.dart';
import '../../wallet/controllers/wallet_controller.dart';
import '../domain/models/subcription_model.dart';

class SubscriptionCardWidget extends StatelessWidget {
  final Subscription subscription;
  final int index;

  const SubscriptionCardWidget({
    super.key,
    required this.subscription,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    Get.find<WalletController>().getWalletBonusList(isUpdate: false);

    Size size = MediaQuery.of(context).size;
    TimeOfDay parseTimeString(String timeString) {
      // Split the string by ':' to get hours and minutes
      final parts = timeString.split(':');
      if (parts.length != 2) {
        throw FormatException('Invalid time format. Expected "HH:MM"');
      }

      final hour = int.tryParse(parts[0]) ?? 0;
      final minute = int.tryParse(parts[1]) ?? 0;

      return TimeOfDay(hour: hour, minute: minute);
    }
    return InkWell(
      onTap: (){

        ItemController itemController = Get.find<ItemController>();
        itemController.setSubscription(selectedSubType: '${subscription.type}');
        itemController.setSubscriptionQuantity(quantity: subscription.data!.cart![0].quantity ?? 0);
        itemController.setstartDate(
            selectStartDate: DateTime.parse(subscription.startAt!));
        itemController.setendDate(
            selectEndTime: DateTime.parse(subscription!.endAt!));
        final scheduleTimeStr = subscription.scheduleTime!;

// Split into start and end parts
        final [startStr, endStr] = scheduleTimeStr.split('-');

// Parse into TimeOfDay objects
        final startTime = parseTimeString(startStr);
        final endTime = parseTimeString(endStr);
        print('${startTime}/${endTime}');

        itemController.setEditSelectedDays(selectedDayss: subscription!.weekday!);
        itemController.setSheduleTime(
            selectStartTime: startTime, selectEndTime: endTime);
        if(subscription.status == "pending"){
          Get.offNamed(RouteHelper.getAddMoneyRoute(subscriptionId: subscription.id.toString(),paymentMethode:'razor_pay' ));
        }else{
          Get.toNamed(RouteHelper.getEditSubscriptionRoute(index));
        }

      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        height: 100, // Fixed compact height
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Row(
                children: [
                  // Product Image Section - Left side
                  Container(
                    width: 120,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                    ),
                    child: subscription.product?.imageFullUrl != null
                        ? Image.network(
                      subscription.product!.imageFullUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.image_not_supported,
                            size: 30,
                            color: Colors.grey,
                          ),
                        );
                      },
                    )
                        : Container(
                      color: Colors.grey,
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  // Product Details Section - Right side
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Top section - Name and Type
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Name
                              Text(
                                subscription.product?.name ?? "Product Name",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),


                              // Subscription Type Badge
                            ],
                          ),

                          // Bottom section - Price and Quantity
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Price
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    '${subscription.product?.price ?? "0"}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[600],
                                    ),
                                  ),
                                ],
                              ),
                              // Quantity
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.inventory_2_outlined,
                                      size: 12,
                                      color: Colors.grey[600],
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      'Qty: ${subscription.data?.cart?.isNotEmpty == true ? subscription.data!.cart![0].quantity : 0}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Status Indicator (Top Right)
              Positioned(
                top: 8,
                right: 8,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getSubscriptionTypeColor(subscription.type ?? "daily"),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        (subscription.type ?? "daily").toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: subscription.status == "active"
                            ? Colors.green.withOpacity(0.9)
                            : subscription.status == "pending" ? Colors.yellow.withOpacity(0.9) : Colors.red.withOpacity(0.9) ,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${subscription.status}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Action Buttons (Bottom Right)

            ],
          ),
        ),
      ),
    );
  }

  Color _getSubscriptionTypeColor(String subscriptionType) {
    switch (subscriptionType.toLowerCase()) {

      case 'alternate':
        return Colors.purple!;
      case 'weekly':
        return Colors.orange!;
      case 'daily':
        return Colors.teal!;
      default:
        return Colors.grey!;
    }
  }
}
