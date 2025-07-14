import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';
import 'package:tradeupapp/screens/authentication/controllers/on_boarding_controller.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 24,
      bottom: kBottomNavigationBarHeight,
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: AppColors.header,
          padding: const EdgeInsets.all(5),
          minimumSize: const Size(50, 50),
        ),
        child: Icon(Iconsax.arrow_right_3, color: Colors.white, size: 24),
      ),
    );
  }
}
