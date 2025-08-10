import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';
class ButtonChatWithUserPersonal extends StatelessWidget {
  const ButtonChatWithUserPersonal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      height: 40,
      minWidth: 100,
      color: AppColors.background,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.message, size: 20, color: AppColors.text),
          SizedBox(width: 10),
          Text(
            'Send message',
            style: TextStyle(
              color: AppColors.text,
              fontFamily: 'Roboto-Medium',
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}