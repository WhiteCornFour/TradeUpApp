import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/screens/main_app/home/controller/home_controller.dart';

class DotIndicatorHome extends StatelessWidget {
  const DotIndicatorHome({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          bool isActive = homeController.currentPage.value == index;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive ? AppColors.background : Colors.grey[400],
              shape: BoxShape.circle,
            ),
            child: AnimatedScale(
              scale: isActive ? 1.0 : 0.67,
              duration: const Duration(milliseconds: 300),
              child: const DecoratedBox(
                decoration: BoxDecoration(shape: BoxShape.circle),
              ),
            ),
          );
        }),
      ),
    );
  }
}
