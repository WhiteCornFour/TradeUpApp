import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/models/category_model.dart';
import 'package:tradeupapp/widgets/system_widgets/system_category_head_banner_widget.dart';
import 'package:tradeupapp/widgets/system_widgets/system_grid_view_product_vertical_list_widget.dart';

class CategoryProductsSystem extends StatelessWidget {
  const CategoryProductsSystem({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryModel category = Get.arguments as CategoryModel;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Head Banner
            CategoryHeadBannerSystem(
              title: category.name,
              imagePath: category.imagePath,
              overlayColor: category.colorStrong,
            ),
            SizedBox(height: 30),

            //Grid View List Product
            GridViewProductVerticalListSystem(itemCount: 10),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
