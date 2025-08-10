import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';
class ButtonAddNewFeedPersonal extends StatelessWidget {
  const ButtonAddNewFeedPersonal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 16, bottom: 20),
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: AppColors.background,
            child: Icon(Icons.add, color: AppColors.text, size: 20),
          ),
        ),
      ),
    );
  }
}