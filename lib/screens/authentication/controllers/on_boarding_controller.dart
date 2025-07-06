import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeupapp/screens/authentication/login.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  ///Variables
  ///obs is another widget which changes the device without using stateful widget
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  //Update current index when page scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  //Jump to specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  // Update current index & jump to next page
  void nextPage() async {
    if (currentPageIndex.value == 2) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(
        'seenOnBoarding',
        true,
      ); //Set status seenOnBoarding equal true
      Get.off(() => const Login());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.animateToPage(
        page,
        duration: const Duration(
          milliseconds: 500,
        ), // Adjust the duration as needed
        curve: Curves.easeInOut, // Adjust the animation curve if desired
      );
    }
  }

  //Update current index & jump to last page
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
