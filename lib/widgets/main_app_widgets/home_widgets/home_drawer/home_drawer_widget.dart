import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/screens/general/general_search_product.dart';
import 'package:tradeupapp/screens/main_app/home/controller/home_controller.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_drawer/home_drawer_categories_choice_chips_group_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_drawer/home_drawer_condition_choice_chips_group_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_drawer/home_drawer_price_slider_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_search_bar_widget.dart';
import 'package:tradeupapp/widgets/general/general_button_widget.dart';
import 'package:tradeupapp/widgets/general/general_header_section_widget.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({super.key});

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  final TextEditingController keywordController = TextEditingController();

  // state tạm trong drawer
  List<String> selectedCategories = [];
  double minPrice = 0.0;
  double maxPrice = 0.0;
  String condition = "";

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.4,
      builder: (_, controller) => Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: ListView(
          controller: controller,
          children: [
            //Search Bar
            const SizedBox(height: 12),
            HeaderSectionGeneral(
              title: 'Search Bar',
              icon: Iconsax.search_favorite,
              paddingHorizontal: 0,
              paddingVertical: 0,
              showViewAll: false,
            ),
            const SizedBox(height: 12),
            SearchBarHome(
              controller: keywordController,
              hintText: 'Enter your keywords',
            ),
            const SizedBox(height: 20),

            //Categories
            DrawerCategoriesChoiceChipsGroupHome(
              categories: homeController.categoryList,
              onSelectionChanged: (cats) {
                setState(() {
                  selectedCategories = cats;
                });
              },
            ),
            const SizedBox(height: 20),

            //Price
            DrawerPriceSliderHome(
              onPriceChanged: (min, max) {
                setState(() {
                  minPrice = min;
                  maxPrice = max;
                });
              },
            ),
            const SizedBox(height: 20),

            //Condition
            DrawerConditionChoiceChipsGroupHome(
              onSelectionChanged: (value) {
                setState(() {
                  condition = value;
                });
              },
            ),
            const SizedBox(height: 20),

            //Apply Button
            ButtonGeneral(
              height: 52,
              width: double.infinity,
              text: 'Apply',
              backgroundColor: AppColors.header,
              onPressed: () {
                print('========== FILTER STATE ==========');
                print('Keyword: ${keywordController.text}');
                print('Selected Categories: $selectedCategories');
                print('Min Price: $minPrice');
                print('Max Price: $maxPrice');
                print('Condition: $condition');
                print('=================================');

                //Gọi hàm search với dữ liệu gom lại từ drawer
                homeController.searchProductsWithFilters(
                  keyword: keywordController.text,
                  categories: selectedCategories,
                  minPrice: minPrice,
                  maxPrice: maxPrice,
                  condition: condition,
                );

                Get.back();
                if (Get.currentRoute != '/SearchProductGeneral') {
                  Get.to(() => const SearchProductGeneral());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

