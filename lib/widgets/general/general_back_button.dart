import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class BackButtonCustomGeneral extends StatelessWidget {
  const BackButtonCustomGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Icon(
        Platform.isIOS
            ? Icons.arrow_back_ios
            : Icons
                  .arrow_back, // iOS thì icon có đuôi, Android thì mũi tên thường
        color: AppColors.header,
        size: 25,
      ),
    );
  }
}
