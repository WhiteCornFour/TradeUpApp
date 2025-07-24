import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';

class BackButtonCustom extends StatelessWidget {
  const BackButtonCustom({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context, true),
      child: Row(
        mainAxisSize: MainAxisSize.min, // không chiếm hết chiều ngang
        children: [
          Icon(Icons.arrow_back_ios, color: AppColors.header, size: 20),
          SizedBox(width: 4), // Khoảng cách nhỏ giữa icon và chữ
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
