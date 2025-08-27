import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class CreditCardItemPayment extends StatelessWidget {
  final String selectedValue;
  final String value;
  final ValueChanged<String?> onChanged;

  const CreditCardItemPayment({
    super.key,
    required this.selectedValue,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Menu Radio dạng Column
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.backgroundGrey, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Nội dung bên trái
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/visa.png',
                        height: 50,
                        width: 50,
                      ),
                      SizedBox(width: 15),
                      Text(
                        'VietinBank',
                        style: TextStyle(
                          color: AppColors.header,
                          fontFamily: 'Roboto-Regular',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  Text(
                    '**** 123',
                    style: TextStyle(
                      color: AppColors.header,
                      fontFamily: 'Roboto-Regular',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // Radio button bên phải
                  Radio<String>(
                    value: 'A',
                    groupValue: selectedValue,
                    activeColor: AppColors.background,
                    onChanged: onChanged,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
