import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';

class TextFieldRegister extends StatelessWidget {
  const TextFieldRegister({
    super.key,
    required this.controller,
    required this.name,
    required this.obscureText,
  });
  final TextEditingController controller;
  final String name;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Text(
              '*',
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
                fontFamily: 'Roboto-Regular',
              ),
            ),
            SizedBox(width: 2),
            Text(
              name,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          autofocus: true,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
