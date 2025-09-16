import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class ButtonCreateOrderPayment extends StatelessWidget {
  final Function onPressed;
  const ButtonCreateOrderPayment({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.background,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create order',
              style: TextStyle(
                fontFamily: 'Roboto-Medium',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.text,
              ),
            ),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward, color: AppColors.text, weight: 10),
          ],
        ),
      ),
    );
  }
}
