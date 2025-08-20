import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/screens/main_app/home/controller/home_controller.dart';
// import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_searching_group/home_searching_group_bar_and_filter.dart';
import 'package:tradeupapp/widgets/general/general_grid_view_product_vertical_list_widget.dart';
import 'package:tradeupapp/widgets/general/general_category_head_banner_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_sort_option_group/home_sort_option_group_widget.dart';

class SearchProductGeneral extends StatelessWidget {
  const SearchProductGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        //Lấy keyword hiện tại từ reactive
        final filteredProducts = homeController.filteredProducts;
        final message = homeController.searchKeywordByDelegate.isNotEmpty
            ? 'Found ${filteredProducts.length} results with "${homeController.searchKeywordByDelegate}"'
            : 'Found ${filteredProducts.length} results with filter';

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Head Banner
                  CategoryHeadBannerGeneral(
                    title: 'Search Results',
                    subTitle: message,
                    imagePath:
                        'https://res.cloudinary.com/dhmzkwjlf/image/upload/v1754933274/background/search_background_nomelc.jpg',
                    overlayColor: Colors.deepPurple,
                    height: 220,
                    onBack: () {
                      homeController.selectedSortOption.value = 'Newest';
                      Get.back();
                    },
                  ),

                  // const SizedBox(height: 10),
                  // Padding(
                  //   padding: const EdgeInsets.all(20),
                  //   child: SearchingGroupBarAndFilterHome(),
                  // ),

                  //Option Group
                  SizedBox(height: 15),
                  SortOptionGroupHome(),
                  SizedBox(height: 15),

                  Obx(() {
                    final filteredProducts = homeController.filteredProducts;

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

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
