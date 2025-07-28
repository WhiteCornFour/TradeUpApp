import 'package:flutter/material.dart';

class SnackbarHelperGeneral {
  static void showCustomSnackBar(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.red,
    int seconds = 2,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 36, vertical: 10),
        padding: EdgeInsets.all(16),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
        duration: Duration(seconds: seconds),
      ),
    );
  }
}
