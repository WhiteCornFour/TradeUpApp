import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';
class ButtonSubmitChangePassword extends StatelessWidget {
  final VoidCallback onPressed;
  const ButtonSubmitChangePassword({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        minWidth: double.infinity,
        height: 50,
        color: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onPressed,
        child: Text(
          'Send Instructions',
          style: TextStyle(
            color: AppColors.text,
            fontFamily: 'Roboto-Black',
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}