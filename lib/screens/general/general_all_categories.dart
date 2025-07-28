import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/data/category_data.dart';
import 'package:tradeupapp/screens/general/general_category_products.dart';
import 'package:tradeupapp/widgets/general/general_category_card_button_widget.dart';
import 'package:tradeupapp/widgets/general/general_custom_app_bar_widget.dart';

class AllCategoriesGeneral extends StatelessWidget {
  const AllCategoriesGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarGeneral(
        showBackArrow: false,
        backgroundColor: Colors.white,
        leadingIcon: Iconsax.arrow_left_2,
        leadingOnPressed: Get.back,
        title: Text(
          'All Categories',
          style: TextStyle(fontFamily: 'Roboto-Medium'),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: categories.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              mainAxisExtent: 125,
            ),
            itemBuilder: (context, index) => CategoryCardButtonGeneral(
              category: categories[index],
              showBorder: true,
              onTap: () {
                Get.to(
                  () => CategoryProductsGeneral(),
                  arguments: categories[index],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
