import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/data/category_data.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_add_product/controller/shop_add_product_controller.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_drawer/home_drawer_choice_chips_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_help_box/shop_add_product_help_box_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_image_list/shop_add_product_image_list_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_progress_bar_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_section_title_widget.dart';

class AddProductPageTwoShop extends StatefulWidget {
  const AddProductPageTwoShop({super.key});

  @override
  State<AddProductPageTwoShop> createState() => _AddProductPageTwoShop();
}

class _AddProductPageTwoShop extends State<AddProductPageTwoShop> {
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
            title: 'Add Image and Choose Tags',
            subTitle: 'Adding more information for product',
          ),
          SizedBox(height: 30),

          //Suggest Help Dialog
          AddProductHelpBoxShop(),
          SizedBox(height: 30),

          //Add Image Section
          AddProductSectionTitleShop(
            title: 'Add product images',
            subtitle:
                'Add up to 5 images. First image is your product cover image '
                'that will be highlighted everywhere.',
          ),
          SizedBox(height: 20),
          AddProductImageListShop(),
          SizedBox(height: 30),

          //Choose Categoires
          AddProductSectionTitleShop(
            title: 'Choosing product categories',
            subtitle:
                'You can select up to three category tags for your product.',
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: categories.map((category) {
              final isSelected = addProductController.categories.contains(
                category.name,
              );
              return DrawerChoiceChipsHome(
                text: category.name,
                selected: isSelected,
                color: category.colorStrong,
                onSelected: (value) {
                  setState(() {
                    if (isSelected) {
                      addProductController.categories.remove(category.name);
                    } else {
                      if (addProductController.categories.length < 3) {
                        addProductController.categories.add(category.name);
                      } else if (addProductController.categories.length == 3) {
                        SnackbarHelperGeneral.showCustomSnackBar(
                          'Reaching tag limit, please unchoosed one tags before chosing another one!!!',
                        );
                      }
                    }
                  });
                },
              );
            }).toList(),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
