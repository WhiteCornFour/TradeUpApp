import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class BackButtonCustomGeneral extends StatelessWidget {
  const BackButtonCustomGeneral({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_back_ios, color: AppColors.header, size: 20),
          Text(
            'Back',
            style: TextStyle(
              color: AppColors.header,
              fontFamily: 'Roboto-Medium',
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
