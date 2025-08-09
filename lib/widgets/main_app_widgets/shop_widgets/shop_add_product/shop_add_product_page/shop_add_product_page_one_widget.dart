import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_add_product/controller/shop_add_product_controller.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_dropdown_menu_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_help_box/shop_add_product_help_box_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_progress_bar_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_section_title_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_text_field_widget.dart';

class AddProductPageOneShop extends StatefulWidget {
  const AddProductPageOneShop({super.key});

  @override
  State<AddProductPageOneShop> createState() => _AddProductPageOneShop();
}

class _AddProductPageOneShop extends State<AddProductPageOneShop> {
  final addProductController = Get.find<AddProductController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Progress Bar
          AddProductProgressBarShop(
            title: 'Add Product Information',
            subTitle: 'Provide basic product details',
          ),
          SizedBox(height: 30),

          //Suggest Help Dialog
          AddProductHelpBoxShop(),
          SizedBox(height: 30),

          //Product Name
          AddProductSectionTitleShop(
            title: 'Product Name',
            subtitle:
                'Enter a clear and concise product name so buyers can easily find it.',
          ),
          SizedBox(height: 10),
          AddProductTextFieldShop(
            label: 'e.g. iPhone 14 Pro Max 256GB',
            maxLength: 50,
            maxLines: 1,
            controller: addProductController.productNameController,
          ),
          SizedBox(height: 20),

          //Product Price
          AddProductSectionTitleShop(
            title: 'Product Price',
            subtitle:
                'Enter the selling price for your product. Numbers only.\nExample: 1200 or 1200.50',
          ),
          SizedBox(height: 10),
          AddProductTextFieldShop(
            label: 'e.g. 1200',
            maxLines: 1,
            maxLength: 10,
            controller: addProductController.productPriceController,
            isPrice: true,
          ),
          SizedBox(height: 20),

          //Product Condition (Dropdown Menu)
          AddProductSectionTitleShop(
            title: 'Product Condition',
            subtitle:
                'Select the condition of your product so buyers know what to expect.',
          ),
          SizedBox(height: 10),
          AddProductProductDropdownMenuShop(
            selectedCondition: addProductController.selectedCondition.value,
            onChanged: (value) {
              setState(() {
                addProductController.selectedCondition.value = value;
              });
            },
          ),
          SizedBox(height: 20),

          //Product Description
          AddProductSectionTitleShop(
            title: 'Product Description',
            subtitle:
                'Describe your product in detail, including key features and any defects.\nExample: iPhone 14 Pro Max, purchased in 2023, still under warranty, includes box and accessories.',
          ),
          SizedBox(height: 10),
          AddProductTextFieldShop(
            label: 'Write a detailed description...',
            maxLength: 500,
            maxLines: 5,
            controller: addProductController.productDescriptionController,
          ),
        ],
      ),
    );
  }
}
