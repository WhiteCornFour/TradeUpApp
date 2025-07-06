import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';

class ButtonHome extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const ButtonHome({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        //set state for background color
        backgroundColor: WidgetStateProperty.all(
          isSelected ? AppColors.header : Colors.white,
        ),
        //set state for text color
        foregroundColor: WidgetStateProperty.all(
          isSelected ? Colors.white : AppColors.header,
        ),
        side: WidgetStateProperty.all(
          BorderSide(color: AppColors.header, width: 2),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      //custom text
      child: Text(
        text,
        style: const TextStyle(fontFamily: 'Roboto-Regular', fontSize: 13),
      ),
    );
  }
}
