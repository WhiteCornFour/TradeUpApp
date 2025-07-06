import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CirculationIconHome extends StatelessWidget {
  const CirculationIconHome({
    super.key,
    required this.icon,
    this.size,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });

  final IconData icon;
  final Color? color;
  final double? size;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor ?? Colors.white.withOpacity(0.9),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(Iconsax.heart5, color: color, size: size),
      ),
    );
  }
}
