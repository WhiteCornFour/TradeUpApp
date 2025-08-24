import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_product_detail/shop_make_an_offer/controller/shop_make_an_offer_controller.dart';
import 'package:tradeupapp/widgets/general/general_button_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail/shop_make_an_offer/shop_make_an_offer_banner_section_widget.dart';
import 'package:tradeupapp/widgets/general/general_custom_app_bar_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail/shop_make_an_offer/shop_make_an_offer_price_caculator_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail/shop_make_an_offer/shop_make_an_offer_product_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_section_title_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_text_field_widget.dart';

class MakeAnOfferShop extends StatelessWidget {
  const MakeAnOfferShop({super.key});

  @override
  Widget build(BuildContext context) {
    final makeAnOfferController = Get.put(MakeAnOfferController());
    final TextEditingController priceController = TextEditingController();

    priceController.addListener(() {
      makeAnOfferController.updatePrice(priceController.text);
    });

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
          padding: EdgeInsets.all(20),
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
              SizedBox(height: 16),

              //Saler
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Avatar
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 8),

                  //User Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'John Doe',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Iconsax.verify5,
                            color: AppColors.background,
                            size: 18,
                          ),
                        ],
                      ),
                      SizedBox(height: 4),

                      Row(
                        children: [
                          Icon(Iconsax.star5, color: Colors.amber, size: 18),
                          SizedBox(width: 4),
                          Text(
                            '5',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '(13)',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 16),

              //Product
              MakeAnOfferProductCardShop(
                productName: 'Nike Air Force 1',
                productCondition: 'Brand New',
                productPrice: '\$1500.0',
                imagePath: 'assets/images/sample_images/sample.png',
              ),
              SizedBox(height: 16),

              //Make your Price
              AddProductSectionTitleShop(
                title: 'Make your Price',
                subtitle:
                    'Suggest a price you are willing to pay. The seller will receive your offer and respond accordingly.',
              ),
              SizedBox(height: 10),
              AddProductTextFieldShop(
                label: makeAnOfferController.originPrice.toStringAsFixed(0),
                maxLength: 50,
                maxLines: 1,
                controller: priceController,
                isPrice: true,
              ),
              SizedBox(height: 10),

              //Calculator
              Obx(
                () => MakeAnOfferPriceCalculatorShop(
                  originPrice: makeAnOfferController.originPrice,
                  offerAmount: makeAnOfferController.offerAmount.value,
                ),
              ),
              SizedBox(height: 20),

              //Send Offer Button
              ButtonGeneral(
                text: 'Send an Offer',
                backgroundColor: AppColors.header,
                onPressed: () {
                  if (makeAnOfferController.offerAmount.value != null) {
                    Get.snackbar(
                      "Offer Sent",
                      "You offered \$${makeAnOfferController.offerAmount.value!.toStringAsFixed(2)}",
                    );
                  }
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
