import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarHelperGeneral {
  static void showCustomSnackBar(
    String message, {
    Color backgroundColor = Colors.red,
    int seconds = 2,
  }) {
    Get.snackbar(
      '',
      '',
      titleText: const SizedBox.shrink(),
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: backgroundColor,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
      padding: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: Duration(seconds: seconds),
      colorText: Colors.white,
    );
  }
}
