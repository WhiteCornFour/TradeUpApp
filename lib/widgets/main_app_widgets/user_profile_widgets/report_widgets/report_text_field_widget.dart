import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class TextFieldReport extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final int maxLines;
  final int maxLength;

  const TextFieldReport({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    required this.maxLength,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          maxLines: maxLines,
          maxLength: maxLength,
          obscureText: obscureText,
          autofocus: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            hint: Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 171, 171, 171),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.header, width: 2),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
