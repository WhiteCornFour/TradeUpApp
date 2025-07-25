import 'package:flutter/material.dart';

class IconSystem extends StatelessWidget {
  const IconSystem({
    super.key,
    required this.icon,
    this.width,
    this.height,
    this.size = 24,
    this.onPressed,
    this.color,
    this.backgroundColor,
    this.borderColor = Colors.transparent,
    this.borderWidth = 1.0,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor ?? Colors.white.withOpacity(0.9),
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: size),
      ),
    );
  }
}
