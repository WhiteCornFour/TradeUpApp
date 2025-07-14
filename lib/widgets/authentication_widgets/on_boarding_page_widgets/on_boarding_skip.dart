import 'package:flutter/material.dart';
import 'package:tradeupapp/screens/authentication/controllers/on_boarding_controller.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      //ktoolbarHeight: default height of Appbar
      top: kToolbarHeight,
      right: 24,
      child: TextButton(
        onPressed: () => OnBoardingController.instance.skipPage(),
        child: const Text(
          'Skip',
          style: TextStyle(color: Colors.black, fontFamily: 'Roboto-Regular'),
        ),
      ),
    );
  }
}
