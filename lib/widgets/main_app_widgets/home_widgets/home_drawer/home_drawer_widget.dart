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

class DrawerHome extends StatelessWidget {
  const DrawerHome({super.key});

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
            SizedBox(height: 12),
            //Header Section: Search Bar
            HeaderSectionGeneral(
              title: 'Search Bar',
              icon: Iconsax.search_favorite,
              paddingHorizontal: 0,
              paddingVertical: 0,
              showViewAll: false,
            ),
            SizedBox(height: 12),
            SearchBarHome(hintText: 'Enter your keywords'),
            SizedBox(height: 20),

            //Categories Tag
            DrawerCategoriesChoiceChipsGroupHome(categories: homeController.categoryList),
            SizedBox(height: 20),

            //Price Bar
            DrawerPriceSliderHome(),
            SizedBox(height: 20),

            //Condition
            DrawerConditionChoiceChipsGroupHome(),
            SizedBox(height: 20),

            //Distance(optional)

            //Apply Button
            ButtonGeneral(
              height: 52,
              width: double.infinity,
              text: 'Apply',
              backgroundColor: AppColors.header,
              onPressed: () => Get.to(() => SearchProductGeneral()),
            ),
          ],
        ),
      ),
    );
  }
}
