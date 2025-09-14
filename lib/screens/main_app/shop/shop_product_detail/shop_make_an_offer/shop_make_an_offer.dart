import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_product_detail/controller/shop_product_detail_controller.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_product_detail/shop_make_an_offer/controller/shop_make_an_offer_controller.dart';
import 'package:tradeupapp/widgets/general/general_button_widget.dart';
import 'package:tradeupapp/widgets/general/general_loading_screen.dart';
import 'package:tradeupapp/widgets/general/general_search_app_bar_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail/shop_make_an_offer/shop_make_an_offer_banner_section_widget.dart';
import 'package:tradeupapp/widgets/general/general_custom_app_bar_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail/shop_make_an_offer/shop_make_an_offer_price_caculator_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail/shop_make_an_offer/shop_make_an_offer_product_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_section_title_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_text_field_widget.dart';

class MakeAnOfferShop extends StatelessWidget {
  const MakeAnOfferShop({
    super.key,
    required this.product,
    required this.userId,
  });

  final ProductModel product;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    final makeAnOfferController = Get.find<MakeAnOfferController>();
    final productDetailController = Get.find<ProductDetailController>();
    final TextEditingController priceController = TextEditingController();

    priceController.addListener(() {
      makeAnOfferController.updatePrice(priceController.text);
    });

    return Obx(() {
      //1. Loading state
      if (makeAnOfferController.isLoading.value) {
        return const Scaffold(
          body: LoadingScreenGeneral(message: "Sending your offer..."),
        );
      }

      //2. Check dữ liệu seller
      final seller = productDetailController.user.value;
      if (seller == null ||
          product.productId == null ||
          product.productName == null ||
          product.productPrice == null) {
        return const Scaffold(
          body: Center(
            child: Text(
              "Cannot load seller/product information!",
              style: TextStyle(
                color: AppColors.header,
                fontFamily: 'Roboto-Black',
                fontSize: 20,
              ),
            ),
          ),
        );
      }

      //3. Render UI chính
      return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBarGeneral(
          showBackArrow: false,
          backgroundColor: Colors.white,
          leadingIcon: Iconsax.arrow_left_2,
          leadingOnPressed: Get.back,
          title: const Text(
            'Make An Offer',
            style: TextStyle(fontFamily: 'Roboto-Medium'),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                //Banner
                MakeAnOfferBannerSectionShop(
                  image: 'assets/images/make_an_offer.jpg',
                  title: "How 'Make An Offer' Works",
                  subTitle:
                      'Suggest your own price for the item. '
                      'The seller will review your offer and can accept, reject, or counter.',
                ),
                const SizedBox(height: 16),

                //Saler
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.grey[300],
                      child: const Icon(Icons.person, color: Colors.black),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              seller.fullName ?? 'Unknown Username',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Iconsax.verify5,
                              color: AppColors.background,
                              size: 18,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Iconsax.star5,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${productDetailController.rating.value}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${productDetailController.ratingCount.value})',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                //Product
                MakeAnOfferProductCardShop(
                  productName: product.productName ?? 'Unknown Product',
                  productCondition:
                      product.selectedCondition ?? 'Unknown Condition',
                  productPrice: '\$${product.productPrice}',
                  imagePath: product.imageList?.isNotEmpty == true
                      ? product.imageList!.first
                      : 'assets/images/unavailable_image.jpg',
                ),
                const SizedBox(height: 16),

                //Make your Price
                const AddProductSectionTitleShop(
                  title: 'Make your Price',
                  subtitle:
                      'Suggest a price you are willing to pay. The seller will receive your offer and respond accordingly.',
                ),
                const SizedBox(height: 10),
                AddProductTextFieldShop(
                  label: makeAnOfferController.originPrice.value
                      .toStringAsFixed(1),
                  maxLength: 50,
                  maxLines: 1,
                  controller: priceController,
                  isPrice: true,
                ),
                const SizedBox(height: 10),

                //Calculator
                Obx(
                  () => MakeAnOfferPriceCalculatorShop(
                    originPrice: makeAnOfferController.originPrice.value,
                    offerAmount: makeAnOfferController.offerAmount.value,
                  ),
                ),
                const SizedBox(height: 20),

                //Send Offer Button
                Obx(() {
                  final isDisabled =
                      makeAnOfferController.offerAmount.value == null ||
                      makeAnOfferController.offerAmount.value ==
                          makeAnOfferController.originPrice.value;

                  return ButtonGeneral(
                    text: 'Send an Offer',
                    backgroundColor: isDisabled
                        ? AppColors.backgroundGrey
                        : AppColors.header,
                    onPressed: isDisabled
                        ? null
                        : () {
                            makeAnOfferController.createOffer(
                              senderId: homeController.currentUserId ?? '',
                              receiverId: product.userId ?? '',
                              productId: product.productId ?? '',
                            );
                          },
                  );
                }),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    });
  }
}
