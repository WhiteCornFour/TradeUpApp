import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_add_product/controller/shop_add_product_controller.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_help_box/shop_add_product_help_box_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_info_card_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_progress_bar_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_section_title_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_text_field_widget.dart';

class AddProductPageThreeShop extends StatelessWidget {
  const AddProductPageThreeShop({super.key});

  @override
  Widget build(BuildContext context) {
    final addProductController = Get.find<AddProductController>();
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          //Progress Bar
          AddProductProgressBarShop(
            title: 'Creating New Feeds',
            subTitle: 'Making a new feed for your product.',
          ),
          SizedBox(height: 30),

          //Help Box
          AddProductHelpBoxShop(),
          SizedBox(height: 30),

          //Info Card
          AddProductSectionTitleShop(
            title: 'Product Overview',
            subtitle: 'Review your product details before publishing',
          ),
          SizedBox(height: 20),
          AddProductInfoCardShop(),
          SizedBox(height: 30),

          // Write for your feed
          AddProductSectionTitleShop(
            title: 'Product Story',
            subtitle: 'Describe your product to attract more buyers',
          ),
          SizedBox(height: 10),
          AddProductTextFieldShop(
            label: "Share an engaging story for your feed post",
            maxLength: 500,
            maxLines: 6,
            controller: addProductController.productStoryController,
          ),
        ],
      ),
    );
  }
}
