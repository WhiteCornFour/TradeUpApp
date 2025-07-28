import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/models/category_model.dart';
import 'package:tradeupapp/screens/general/general_category_products.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_category_card_widget.dart';

class CategoryGroupHome extends StatelessWidget {
  final List<CategoryModel> categories;
  final int layoutType;

  const CategoryGroupHome({
    super.key,
    required this.categories,
    required this.layoutType,
  });

  @override
  Widget build(BuildContext context) {
    switch (layoutType) {
      case 1:
        return buildSlide1();
      case 2:
        return buildSlide2();
      case 3:
        return buildSlide3();
      default:
        return const SizedBox();
    }
  }

  //Slide 1: 1 lớn trái, 2 nhỏ phải
  Widget buildSlide1() {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        padding: const EdgeInsets.all(6),
        width: 308,
        height: 194,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 242, 236, 255),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            CategoryCardHome(
              category: categories[0],
              onTap: () {
                Get.to(
                  () => CategoryProductsGeneral(),
                  arguments: categories[0],
                );
              },
              width: 138,
              height: 180,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: CategoryCardHome(
                      category: categories[1],
                      onTap: () {
                        Get.to(
                          () => CategoryProductsGeneral(),
                          arguments: categories[1],
                        );
                      },
                      width: 118,
                      height: double.infinity,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: CategoryCardHome(
                      category: categories[2],
                      onTap: () {
                        Get.to(
                          () => CategoryProductsGeneral(),
                          arguments: categories[2],
                        );
                      },
                      width: 118,
                      height: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Slide 2: 2 trên 2 dưới, đối xứng to nhỏ
  Widget buildSlide2() {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        padding: const EdgeInsets.all(6),
        width: 308,
        height: 194,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 242, 236, 255),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CategoryCardHome(
                      category: categories[0],
                      onTap: () {
                        Get.to(
                          () => CategoryProductsGeneral(),
                          arguments: categories[0],
                        );
                      },
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CategoryCardHome(
                      category: categories[1],
                      onTap: () {
                        Get.to(
                          () => CategoryProductsGeneral(),
                          arguments: categories[1],
                        );
                      },
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CategoryCardHome(
                      category: categories[2],
                      onTap: () {
                        Get.to(
                          () => CategoryProductsGeneral(),
                          arguments: categories[2],
                        );
                      },
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CategoryCardHome(
                      category: categories[3],
                      onTap: () {
                        Get.to(
                          () => CategoryProductsGeneral(),
                          arguments: categories[3],
                        );
                      },
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Slide 3: 2 nhỏ trái, 1 lớn phải
  Widget buildSlide3() {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        padding: const EdgeInsets.all(6),
        width: 308,
        height: 194,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 242, 236, 255),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Column(
              children: [
                Expanded(
                  child: CategoryCardHome(
                    category: categories[0],
                    onTap: () {
                      Get.to(
                        () => CategoryProductsGeneral(),
                        arguments: categories[0],
                      );
                    },
                    width: 118,
                    height: double.infinity,
                  ),
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: CategoryCardHome(
                    category: categories[1],
                    onTap: () {
                      Get.to(
                        () => CategoryProductsGeneral(),
                        arguments: categories[1],
                      );
                    },
                    width: 118,
                    height: double.infinity,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 6),

            CategoryCardHome(
              category: categories[2],
              onTap: () {
                Get.to(
                  () => CategoryProductsGeneral(),
                  arguments: categories[2],
                );
              },
              width: 138,
              height: 180,
            ),
          ],
        ),
      ),
    );
  }
}
