import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/screens/general/general_category_products.dart';
import 'package:tradeupapp/screens/main_app/home/controller/home_controller.dart';
import 'package:tradeupapp/widgets/general/general_category_card_button_widget.dart';
import 'package:tradeupapp/widgets/general/general_custom_app_bar_widget.dart';

class AllCategoriesGeneral extends StatelessWidget {
  const AllCategoriesGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBarGeneral(
        showBackArrow: false,
        backgroundColor: Colors.white,
        leadingIcon: Iconsax.arrow_left_2,
        leadingOnPressed: Get.back,
        title: const Text(
          'All Categories',
          style: TextStyle(fontFamily: 'Roboto-Medium'),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Obx(() {
              final categoryList = homeController.categoryList;

              if (categoryList.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: categoryList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 125,
                ),
                itemBuilder: (context, index) => CategoryCardButtonGeneral(
                  category: categoryList[index],
                  showBorder: true,
                  onTap: () {
                    Get.to(
                      () => const CategoryProductsGeneral(),
                      arguments:
                          categoryList[index], //Truyền category đúng ở đây
                    );
                  },
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
