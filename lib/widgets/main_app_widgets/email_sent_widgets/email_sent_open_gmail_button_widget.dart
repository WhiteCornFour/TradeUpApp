import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class OpenGmailButtonEmailSent extends StatelessWidget {
  const OpenGmailButtonEmailSent({super.key, required this.func});
  final VoidCallback func;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
      color: AppColors.header,
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onPressed: func,
      child: Text(
        'Open Gmail App',
        style: TextStyle(
          color: AppColors.text,
          fontSize: 18,
          fontFamily: 'Roboto-Medium',
        ),
      ),
    );
  }
}
