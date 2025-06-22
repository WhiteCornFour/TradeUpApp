import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/AppColors.dart';

class ButtonForgotPW_Widget extends StatelessWidget {
  final VoidCallback onPressed;
  const ButtonForgotPW_Widget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 20),

        child: MaterialButton(
          minWidth: double.infinity,
          height: 50,
          onPressed: onPressed,
          color: AppColors.header,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "Send",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
