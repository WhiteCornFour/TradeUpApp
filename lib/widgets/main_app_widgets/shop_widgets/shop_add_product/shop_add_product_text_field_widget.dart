import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class AddProductTextFieldShop extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final int maxLines;
  final int maxLength;
  final bool isPrice;

  const AddProductTextFieldShop({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    required this.maxLength,
    required this.maxLines,
    this.isPrice = false,
  });

  @override
  Widget build(BuildContext context) {
    const borderRadiusValue = 12.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          maxLines: maxLines,
          maxLength: maxLength,
          obscureText: obscureText,
          keyboardType: isPrice
              ? TextInputType.numberWithOptions(decimal: true)
              : TextInputType.text,
          inputFormatters:
              isPrice //Nếu cờ là true thì thực hiện
              ? [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d*\.?\d{0,2}'),
                  ), //Chuyển sang bàn phím là số với: chỉ số + 1 dấu . và tối đa 2 số thập phân
                ]
              : [], //Không thì bình thường, là chuỗi
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            hintText: label,
            hintStyle: TextStyle(
              fontSize: 15,
              fontFamily: 'Roboto-Regular',
              color: Color.fromARGB(255, 171, 171, 171),
            ),
            //Icon xuất hiện ở đầu mỗi Text Field
            prefixIcon: isPrice
                ? Padding(
                    padding: EdgeInsets.only(left: 14, right: 5, top: 1),
                    child: Text(
                      '\$',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Roboto-Bold',
                        color: Colors.grey,
                      ),
                    ),
                  )
                : null,
            prefixIconConstraints: isPrice
                ? BoxConstraints(minWidth: 0, minHeight: 0)
                : null,
            counterText: isPrice ? '' : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusValue),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusValue),
              borderSide: BorderSide(color: AppColors.background, width: 2),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusValue),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
