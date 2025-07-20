import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';

class ButtonSubmitEditProfile extends StatelessWidget {
  const ButtonSubmitEditProfile({super.key});

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
            onPressed: () {},
            color: AppColors.header,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            highlightColor: AppColors.background,
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
