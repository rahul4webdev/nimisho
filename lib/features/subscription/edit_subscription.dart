import 'package:sixam_mart/features/coupon/controllers/coupon_controller.dart';
import 'package:sixam_mart/features/coupon/domain/models/subcription_model.dart'
    hide Images;
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/subscription/subscription.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/common/widgets/custom_app_bar.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/common/widgets/footer_view.dart';
import 'package:sixam_mart/common/widgets/menu_drawer.dart';
import 'package:sixam_mart/common/widgets/no_data_screen.dart';
import 'package:sixam_mart/common/widgets/not_logged_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/web_page_title_widget.dart';
import 'package:sixam_mart/features/coupon/widgets/coupon_card_widget.dart';
import 'package:sixam_mart/util/images.dart';

import '../../common/widgets/confirmation_dialog.dart';
import '../../common/widgets/custom_button.dart';
import '../../util/styles.dart';
import '../coupon/widgets/subscription_card.dart';

class EditMySubscriprion extends StatefulWidget {
  int index;

  EditMySubscriprion({required this.index});

  @override
  State<EditMySubscriprion> createState() => _EditMySubscriprionState();
}

class _EditMySubscriprionState extends State<EditMySubscriprion> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
   Subscription subscription =  Get.find<CouponController>().subscriptionList![widget.index];
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(title: 'Subscription'.tr),
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: GetBuilder<ItemController>(
        builder: (itemController) {
          return !itemController.isLoading ? Column(
            children: [
              ItemCustomSubscription(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                child: Row(children: [
                  Text('quantity'.tr, style:robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
                  const Expanded(child: SizedBox()),
                  Container(
                    decoration: BoxDecoration(color: Theme.of(context).disabledColor, borderRadius: BorderRadius.circular(5)),
                    child: Row(children: [
                      InkWell(
                        onTap: (){
                          itemController.subscriptionqauntityUpdate(type: false);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                          child: Icon(Icons.remove, size: 20),
                        ),
                      ),

                      Text(
                        '${itemController.subscriptionqauntity}',
                        style:robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge),
                      ),

                      InkWell(
                        onTap: (){
                          itemController.subscriptionqauntityUpdate(type: true);

                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                          child: Icon(Icons.add, size: 20),
                        ),
                      ),
                    ]),
                  ),
                ]),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                      buttonText: 'Update'.tr,
                      onPressed: () {
                        Get.dialog(ConfirmationDialog(
                            icon: Images.warning,
                            description:
                                'are_you_sure_update_your_subscription_details'.tr,
                            onYesPressed: () {
                              int? id = subscription.id;
                              Get.find<ItemController>().updateYourSubscription(id);
                              Get.back();
                              Get.back();
                            }));
                      },
                      width: 150),
                  CustomButton(
                    buttonText: subscription.status=="pause"?"Active":"Pause",
                    onPressed: () {
                      Get.dialog(ConfirmationDialog(
                          icon: Images.warning,
                          description:
                              'are_you_sure_pause_your_subscription_details'.tr,
                          onYesPressed: () {
                            Get.find<CouponController>().pauseYourSubscription(subscription.id);
                            Get.back();
                            Get.back();

                          }));
                    },
                    width: 150,
                    color: subscription.status=="pause" ? Colors.blueAccent : Colors.red,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              )
            ],
          ) : const Center(child: CircularProgressIndicator());
        }
      ),
    );
  }
}
