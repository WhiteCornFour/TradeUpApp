import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/models/category_model.dart';
import 'package:tradeupapp/screens/main_app/home/controller/home_controller.dart';
import 'package:tradeupapp/widgets/general/general_category_head_banner_widget.dart';
import 'package:tradeupapp/widgets/general/general_grid_view_product_vertical_list_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_sort_option_group/home_sort_option_group_widget.dart';

class CategoryProductsGeneral extends StatelessWidget {
  const CategoryProductsGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryModel? category = Get.arguments as CategoryModel?;
    if (category == null) {
      return const Scaffold(
        body: Center(child: Text("No category data found")),
      );
    }

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
              onBack: () {
                homeController.selectedSortOption.value = 'Newest';
                Get.back();
              },
              title: category.name,
              subTitle: category.description,
              imagePath: category.imagePath,
              overlayColor: category.colorStrong,
            ),

            const SizedBox(height: 15),
            SortOptionGroupHome(),
            SizedBox(height: 15),

            //Grid View List Product
            Obx(() {
              final products = homeController.getFilteredProducts(
                inputProducts: filteredProducts,
              );

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: GridViewProductVerticalListGeneral(
                  productList: products,
                  userIdToUserName: homeController.userIdToUserName,
                ),
              );
            }),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
