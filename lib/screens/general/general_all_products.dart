import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/screens/main_app/home/controller/home_controller.dart';
import 'package:tradeupapp/widgets/general/general_category_head_banner_widget.dart';
import 'package:tradeupapp/widgets/general/general_grid_view_product_vertical_list_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_sort_option_group/home_sort_option_group_widget.dart';

class AllProductsGeneral extends StatelessWidget {
  const AllProductsGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    homeController.selectedSortOption.value = 'Newest';
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CategoryHeadBannerGeneral(
                  onBack: () {
                    homeController.selectedSortOption.value = 'Newest';
                    Get.back();
                  },
                  title: 'All products',
                  subTitle:
                      'We are now bringing up to ${homeController.productList.length} products.',
                  imagePath:
                      'https://res.cloudinary.com/dhmzkwjlf/image/upload/v1754933274/background/search_background_nomelc.jpg',
                  overlayColor: Colors.deepPurple,
                  height: 220,
                ),

                //Option Group
                const SizedBox(height: 15),
                SortOptionGroupHome(),
                SizedBox(height: 15),

                //Grid View List Product
                Obx(() {
                  final products = homeController.getFilteredProducts(
                    inputProducts: homeController.productList,
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
        ),
      ),
    );
  }
}
