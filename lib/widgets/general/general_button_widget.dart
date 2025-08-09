import 'package:flutter/material.dart';

class ButtonGeneral extends StatelessWidget {
  const ButtonGeneral({
    super.key,
    this.text = '',
    this.onPressed,
    this.backgroundColor = Colors.black,
    this.borderRadius = 12.0,
    this.width = double.infinity,
    this.height = 52.0,
    this.icon,
    this.iconDistance = 12,
    this.isOutlined = false,
    this.fontSize = 16,
  });

  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final double borderRadius;
  final double? width;
  final double height;
  final double iconDistance;
  final IconData? icon;
  final bool isOutlined;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final Color contentColor = isOutlined ? backgroundColor : Colors.white;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? Colors.white : backgroundColor,
          side: isOutlined
              ? BorderSide(color: backgroundColor, width: 1.5)
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 24, color: contentColor),
              SizedBox(width: iconDistance),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: 'Roboto-Bold',
                color: contentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
