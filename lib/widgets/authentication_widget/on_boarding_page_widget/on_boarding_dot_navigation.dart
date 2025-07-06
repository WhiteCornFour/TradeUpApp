import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';
import 'package:tradeupapp/screens/authentication/controllers/on_boarding_controller.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Positioned(
      //kBottomNavigationBarHeight: height default of bottom navigation bar
      bottom: kBottomNavigationBarHeight + 25,
      left: 24,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: ExpandingDotsEffect(
          activeDotColor: AppColors.header,
          dotHeight: 6,
        ),
      ),
    );
  }
}
