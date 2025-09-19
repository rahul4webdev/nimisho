import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/custom_asset_image_widget.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/common/widgets/hover/text_hover.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/add_favourite_view.dart';
import 'package:sixam_mart/common/widgets/cart_count_view.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/discount_tag.dart';
import 'package:sixam_mart/common/widgets/hover/on_hover.dart';
import 'package:sixam_mart/common/widgets/not_available_widget.dart';
import 'package:sixam_mart/common/widgets/organic_tag.dart';

import '../../../features/cart/controllers/cart_controller.dart';
import '../cart_count_button.dart';
import '../corner_banner/banner.dart';
import '../corner_banner/corner_discount_tag.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final bool isPopularItem;
  final bool isFood;
  final bool isShop;
  final bool isPopularItemCart;
  final int? index;
  const ItemCard({super.key, required this.item, this.isPopularItem = false, required this.isFood, required this.isShop, this.isPopularItemCart = false, this.index});

  @override
  Widget build(BuildContext context) {
    double? discount = item.discount;
    String? discountType = item.discountType;

    return OnHover(
      isItem: true,
      child: Stack(children: [
        Container(
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            color: Theme.of(context).cardColor,
          ),
          child: CustomInkWell(
            onTap: () => Get.find<ItemController>().navigateToItemPage(item, context),
            radius: Dimensions.radiusSmall,
            child: TextHover(
              builder: (isHovered) {
                return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                    flex: 6,
                    child: Stack(children: [
                      Padding(
                        // padding: EdgeInsets.only(top: isPopularItem ? Dimensions.paddingSizeExtraSmall : 0, left: isPopularItem ? Dimensions.paddingSizeExtraSmall : 0, right: isPopularItem ? Dimensions.paddingSizeExtraSmall : 0),
                        padding: EdgeInsets.only(top:   0, left:   0, right:   0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(Dimensions.radiusSmall),
                            topRight: const Radius.circular(Dimensions.radiusSmall),
                            // bottomLeft: Radius.circular(isPopularItem ? Dimensions.radiusSmall : 0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            // bottomRight: Radius.circular(isPopularItem ? Dimensions.radiusSmall : 0),
                          ),
                          child: CustomImage(
                            isHovered: isHovered,
                            placeholder: Images.placeholder,
                            image: '${item.imageFullUrl}',
                            fit: BoxFit.cover, width: double.infinity, height: double.infinity,
                          ),
                        ),
                      ),

                      AddFavouriteView(
                        item: item,
                        top: 2,
                        right: 2,
                      ),

                      item.isStoreHalalActive! && item.isHalalItem! ? const Positioned(
                        top: 40, right: 15,
                        child: CustomAssetImageWidget(
                          Images.halalTag,
                          height: 20, width: 20,
                        ),
                      ) : const SizedBox(),

                      DiscountTag(
                        discount: discount,
                        discountType: discountType,
                        freeDelivery: false,
                        fromTop: 2,
                        inLeft: false,
                        fontSize: 7,
                      ),
                      // Positioned(
                      //     left: 0,
                      //     child: CornerDiscountTag(
                      //       bannerPosition: CornerBannerPosition.topRight,
                      //       elevation: 0,
                      //       discount: discount,
                      //       discountType: discountType,
                      //       freeDelivery: false,
                      //     )
                      // ),
                      OrganicTag(item: item, placeInImage: false,fontSize: 7,placeTop: true,),

                      (item.stock != null && item.stock! < 0) ? Positioned(
                        bottom: 10, left : 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withValues(alpha: 0.5),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radiusLarge),
                              bottomRight: Radius.circular(Dimensions.radiusLarge),
                            ),
                          ),
                          child: Text('out_of_stock'.tr, style: robotoRegular.copyWith(color: Theme.of(context).cardColor, fontSize: Dimensions.fontSizeSmall)),
                        ),
                      ) : const SizedBox(),

                      // isShop ? const SizedBox() : Positioned(
                      //   bottom: 10, right: 20,
                      //   child: CartCountView(
                      //     item: item,
                      //     index: index,
                      //   ),
                      // ),

                      Get.find<ItemController>().isAvailable(item) ? const SizedBox() : NotAvailableWidget(radius: Dimensions.radiusLarge, isAllSideRound: isPopularItem),

                    ]),
                  ),

                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: EdgeInsets.only(left: Dimensions.paddingSizeSmall, right: isShop ? 0 : Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeSmall, bottom: isShop ? 0 : Dimensions.paddingSizeSmall),
                      child: Stack(clipBehavior: Clip.none, children: [

                        Align(
                          alignment: isPopularItem ? Alignment.centerLeft : Alignment.centerLeft,
                          child: Column(
                              crossAxisAlignment: isPopularItem ? CrossAxisAlignment.start : CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                            (isFood || isShop) ? Text(item.storeName ?? '', style: robotoRegular.copyWith(color: Theme.of(context).disabledColor))
                                : Text(item.name ?? '', style: robotoBold, maxLines:2, overflow: TextOverflow.ellipsis),

                            (isFood || isShop) ? Flexible(
                              child: Text(
                                item.name ?? '',
                                style: robotoBold, maxLines:2, overflow: TextOverflow.ellipsis,
                              ),
                            )
                                // : item.ratingCount! > 0 ? Row(mainAxisAlignment: isPopularItem ? MainAxisAlignment.center : MainAxisAlignment.start, children: [
                            //   Icon(Icons.star, size: 14, color: Theme.of(context).primaryColor),
                            //   const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                            //
                            //   Text(item.avgRating!.toStringAsFixed(1), style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                            //   const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                            //
                            //   Text("(${item.ratingCount})", style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor)),
                            // ])
                                : const SizedBox(height: 0,),

                            // // showUnitOrRattings(context);
                            // (isFood || isShop) ? item.ratingCount! > 0 ? Row(mainAxisAlignment: isPopularItem ? MainAxisAlignment.center : MainAxisAlignment.start, children: [
                            //   Icon(Icons.star, size: 14, color: Theme.of(context).primaryColor),
                            //   const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                            //
                            //   Text(item.avgRating!.toStringAsFixed(1), style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                            //   const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                            //
                            //   Text("(${item.ratingCount})", style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor)),
                            //
                            // ]) : const SizedBox() : (Get.find<SplashController>().configModel!.moduleConfig!.module!.unit! && item.unitType != null) ? Text(
                            //   '(${ item.unitType ?? ''})',
                            //   style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).hintColor),
                            // ) : const SizedBox(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    if (discount != null && discount > 0)
                                      Text(
                                        PriceConverter.convertPrice(
                                          Get.find<ItemController>().getStartingPrice(item),
                                        ),
                                        style: robotoMedium.copyWith(
                                          fontSize: Dimensions.fontSizeOverSmall,
                                          color: Theme.of(context).disabledColor,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                        textDirection: TextDirection.ltr,
                                      ),
                                    if (discount != null && discount > 0)
                                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                    Text(
                                      PriceConverter.convertPrice(
                                        Get.find<ItemController>().getStartingPrice(item),
                                        discount: discount,
                                        discountType: discountType,
                                      ),
                                      textDirection: TextDirection.ltr,
                                      style: robotoMedium.copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // discount != null && discount > 0  ? Text(
                            //   PriceConverter.convertPrice(Get.find<ItemController>().getStartingPrice(item)),
                            //   style: robotoMedium.copyWith(
                            //     fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor,
                            //     decoration: TextDecoration.lineThrough,
                            //   ), textDirection: TextDirection.ltr,
                            // ) : const SizedBox(),
                            // // SizedBox(height: item.discount != null && item.discount! > 0 ? Dimensions.paddingSizeExtraSmall : 0),
                            //
                            // Text(
                            //   PriceConverter.convertPrice(
                            //     Get.find<ItemController>().getStartingPrice(item), discount: discount,
                            //     discountType: discountType,
                            //   ),
                            //   textDirection: TextDirection.ltr, style: robotoMedium,
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CartCountViewNew(
                                item: item,
                                index: index,
                              ),
                            ),
                            const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                          ]),
                        ),

                        isShop ? Positioned(
                          bottom: 0, right: 0,
                          child: CartCountView(
                            item: item,
                            index: index,
                            child: Container(
                              height: 35, width: 38,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(Dimensions.radiusLarge),
                                  bottomRight: Radius.circular(Dimensions.radiusLarge),
                                ),
                              ),
                              child: Icon(isPopularItemCart ? Icons.add_shopping_cart : Icons.add, color: Theme.of(context).cardColor, size: 20),
                            ),
                          ),
                        ) : const SizedBox(),
                        // Positioned(
                        //   bottom: 0,
                        //   right: 15,
                        //   child: InkWell(
                        //     onTap: (){
                        //       Get.find<CartController>().clearCartOnline().then((success) async {
                        //         if(success) {
                        //           Get.find<ItemController>().navigateToSubscriptionPage(item, context);
                        //         }
                        //       });
                        //     },
                        //     child: Icon(Icons.ac_unit),
                        //   ),
                        // )

                      ]),
                    ),
                  ),
                ]);
              },
            ),
          ),
        ),
      ]),
    );


  }
}