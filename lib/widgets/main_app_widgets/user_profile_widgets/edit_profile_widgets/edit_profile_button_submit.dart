import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class ButtonSubmitEditProfile extends StatelessWidget {
  final Function onPressed;
  const ButtonSubmitEditProfile({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: 15),
          child: MaterialButton(
            padding: EdgeInsets.symmetric(vertical: 10),
            onPressed: () {
              onPressed();
            },
            color: AppColors.background,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            highlightColor: AppColors.header,
            child: Text(
              'Sumbit change',
              style: TextStyle(
                color: AppColors.text,
                fontSize: 18,
                fontFamily: 'Roboto-Medium',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
