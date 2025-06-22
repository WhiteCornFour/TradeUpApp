import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/AppColors.dart';

class TextInput extends StatelessWidget {
  const TextInput({super.key, required this.controller, required this.name});
  final TextEditingController controller;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Roboto-Regular',
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: name,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: TextStyle(
            color: AppColors.header,
            fontSize: 20,
            fontFamily: 'Roboto-Bold',
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.header, width: 2),
          ),
        ),
      ),
    );
  }
}
