import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/screens/main_app/home/controller/home_controller.dart';
import 'package:tradeupapp/screens/main_app/home/controller/home_drawer_controller.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_searching_group/home_searching_group_bar_and_filter.dart';
import 'package:tradeupapp/widgets/general/general_grid_view_product_vertical_list_widget.dart';
import 'package:tradeupapp/widgets/general/general_category_head_banner_widget.dart';

class SearchProductGeneral extends StatelessWidget {
  const SearchProductGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    //Lấy query từ trang trước
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final homeController = Get.find<HomeController>();
    final homeDrawerController = Get.find<HomeDrawerController>();

    //Khai báo danh sách kết quả sau khi  lic
    List<ProductModel> filteredProducts = [];
    String displayMessage = '';

    //Lọc danh sách dựa trên keyword (search query) đưọc gửi từ Search Delegate
    if (args['type'] == 'keyword') {
      final keyword = args['keyword'] ?? '';
      filteredProducts = homeController.searchProducts(keyword);
      displayMessage =
          'Found ${filteredProducts.length} results for keyword "$keyword"';
    } else if (args['type'] == 'filter') {
      filteredProducts = homeDrawerController.filteredProducts;
      displayMessage =
          'Found ${filteredProducts.length} results with applied filters';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Head Banner
            CategoryHeadBannerGeneral(
              title: 'Search Results',
              subTitle: displayMessage,
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
                userIdToUserName: homeController.userIdToUserName,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
