import 'package:flutter/material.dart';

class HeaderBarContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  const HeaderBarContainer({
    super.key,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.only(top: 30, bottom: 20),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.deepPurple, // fallback nếu không truyền
        borderRadius: borderRadius ??
            const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
      ),
      child: child,
    );
  }
}
