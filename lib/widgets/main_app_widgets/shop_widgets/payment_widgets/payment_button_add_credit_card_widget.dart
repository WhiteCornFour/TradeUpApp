import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class ButtonAddCreditCardPayment extends StatelessWidget {
  final Function onPressedAddNew;
  const ButtonAddCreditCardPayment({super.key, required this.onPressedAddNew});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.background, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: MaterialButton(
        onPressed: () {
          onPressedAddNew();
        },
        child: Row(
          children: [
            SizedBox(width: 5),
            Icon(
              Icons.add_circle_outline,
              color: AppColors.background,
              size: 30,
            ),
            SizedBox(width: 25),
            Text(
              "Add new card",
              style: TextStyle(
                color: AppColors.background,
                fontFamily: 'Roboto-Medium',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
