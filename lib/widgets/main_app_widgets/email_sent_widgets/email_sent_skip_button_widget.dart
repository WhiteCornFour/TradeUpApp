import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';

class SkipButtonEmailSent extends StatelessWidget {
  const SkipButtonEmailSent({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        'Skip, I\'ll check later',
        style: TextStyle(
          color: AppColors.background,
          fontFamily: 'Roboto-Regular',
          fontSize: 15,
        ),
      ),
    );
  }
}
