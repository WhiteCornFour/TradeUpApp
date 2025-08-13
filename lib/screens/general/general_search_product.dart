import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/screens/main_app/home/controller/home_controller.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_searching_group/home_searching_group_bar_and_filter.dart';
import 'package:tradeupapp/widgets/general/general_grid_view_product_vertical_list_widget.dart';
import 'package:tradeupapp/widgets/general/general_category_head_banner_widget.dart';

class SearchProductGeneral extends StatelessWidget {
  const SearchProductGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    //Lấy query từ trang trước
    final searchQuery = Get.arguments as String? ?? '';
    final homeController = Get.find<HomeController>();

    //Lọc danh sách dựa trên keyword (search query) đưọc gửi từ Search Delegate
    final filteredProducts = homeController.searchProducts(searchQuery);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Head Banner
            CategoryHeadBannerGeneral(
              title: 'Search Results',
              subTitle:
                  'Found ${filteredProducts.length} results for keyword "$searchQuery"',
              imagePath:
                  'https://res.cloudinary.com/dhmzkwjlf/image/upload/v1754933274/background/search_background_nomelc.jpg',
              overlayColor: Colors.deepPurple,
              height: 220,
            ),

            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(20),
              child: SearchingGroupBarAndFilterHome(),
            ),

            // Grid View Products
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
              child: GridViewProductVerticalListGeneral(
                productList: filteredProducts,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
