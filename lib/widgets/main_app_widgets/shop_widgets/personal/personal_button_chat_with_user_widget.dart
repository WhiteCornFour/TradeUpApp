import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class ButtonChatWithUserPersonal extends StatelessWidget {
  final Function onPressedRating;
  final VoidCallback onPressedChat;
  final String idUser;

  const ButtonChatWithUserPersonal({
    super.key,
    required this.idUser,
    required this.onPressedRating,
    required this.onPressedChat,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Nút nhắn tin với người dùng
        MaterialButton(
          onPressed: onPressedChat,
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
        ),

        //Nút đánh giá người dùng
        MaterialButton(
          onPressed: () {
            onPressedRating();
          },
          height: 40,
          minWidth: 100,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16),
            side: BorderSide(color: AppColors.background),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, size: 20, color: AppColors.background),
              SizedBox(width: 10),
              Text(
                'Rating',
                style: TextStyle(
                  color: AppColors.background,
                  fontFamily: 'Roboto-Medium',
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
