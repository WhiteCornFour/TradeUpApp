import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/screens/authentication/controllers/on_boarding_controller.dart';
import 'package:tradeupapp/widgets/authentication_widget/on_boarding_page_widget/on_boarding_next_button.dart';
import 'package:tradeupapp/widgets/authentication_widget/on_boarding_page_widget/on_boarding_dot_navigation.dart';
import 'package:tradeupapp/widgets/authentication_widget/on_boarding_page_widget/on_boarding_skip.dart';
import 'package:tradeupapp/widgets/authentication_widget/on_boarding_page_widget/on_boarding_page_widget.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          //Horizontal scrollable pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                image: 'lib/assets/images/on_boarding_images/product.gif',
                title: 'Discover unique products',
                subTitle:
                    'From tech gadgets to trending outfits, discover what suits you best in just a tap.',
              ),
              OnBoardingPage(
                image: 'lib/assets/images/on_boarding_images/adding.gif',
                title: 'List or shop in just a few steps',
                subTitle:
                    'Buy or sell instantly with a smooth, trusted experience.',
              ),
              OnBoardingPage(
                image: 'lib/assets/images/on_boarding_images/working.gif',
                title: 'Join a friendly community',
                subTitle:
                    'Connect with verified users and build lasting trade relationships.',
              ),
            ],
          ),

          //Skip button
          const OnBoardingSkip(),

          //Dot navigation smooth page indicator
          const OnBoardingDotNavigation(),

          //Next button
          OnBoardingNextButton(),
        ],
      ),
    );
  }
}
