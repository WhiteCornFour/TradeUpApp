import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';
class ButtomSubmitReport extends StatelessWidget {
  final VoidCallback onPressed;
  const ButtomSubmitReport({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Center(
        child: MaterialButton(
          height: 50,
          color: AppColors.background,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20),
          ),
          onPressed: onPressed,
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                'Submit this report',
                style: TextStyle(
                  color: AppColors.text,
                  fontFamily: 'Roboto-Black',
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
