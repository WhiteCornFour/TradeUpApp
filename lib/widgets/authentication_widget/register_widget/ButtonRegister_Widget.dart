import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/AppColors.dart';

class ButtonRegister_Widget extends StatelessWidget {
  final VoidCallback onPressed;
  const ButtonRegister_Widget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 150,
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 20),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.header),
          child: Text(
            "Register",
            style: TextStyle(
              color: AppColors.text,
              fontSize: 15,
              fontFamily: 'Roboto-Bold',
            ),
          ),
        ),
      ),
    );
  }
}
