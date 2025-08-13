import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/models/category_model.dart';
import 'package:tradeupapp/screens/main_app/home/controller/home_controller.dart';
import 'package:tradeupapp/widgets/general/general_category_head_banner_widget.dart';
import 'package:tradeupapp/widgets/general/general_grid_view_product_vertical_list_widget.dart';

class CategoryProductsGeneral extends StatelessWidget {
  const CategoryProductsGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryModel category = Get.arguments as CategoryModel;

    final homeController = Get.find<HomeController>();

    final filteredProducts = homeController.getProductListByCategory(
      category,
      homeController.productList,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Head Banner
            CategoryHeadBannerGeneral(
              title: category.name,
              subTitle: category.description,
              imagePath: category.imagePath,
              overlayColor: category.colorStrong,
            ),
            SizedBox(height: 30),

            //Grid View List Product
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GridViewProductVerticalListGeneral(
                productList: filteredProducts,
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
