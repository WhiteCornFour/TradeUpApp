import 'package:flutter/material.dart';

class ProductDetailTagButtonShop extends StatelessWidget {
  const ProductDetailTagButtonShop({
    super.key,
    required this.label,
    this.icon,
    this.width,
    this.height = 40,
    this.onPressed,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.textColor = Colors.black,
    this.iconColor,
    this.borderRadius = 20,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.spacing = 8,
  });

  final String label;
  final IconData? icon;
  final double? width;
  final double height;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color? iconColor;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: iconColor ?? textColor),
              SizedBox(width: spacing),
            ],
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: fontSize,
                  color: textColor,
                  fontWeight: fontWeight,
                  fontFamily: 'Roboto-Medium',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
