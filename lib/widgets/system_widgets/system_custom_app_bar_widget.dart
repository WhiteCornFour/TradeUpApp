import 'package:flutter/material.dart';

import 'package:tradeupapp/utils/back_button.dart';

class CustomAppBarSystem extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarSystem({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.backgroundColor = Colors.transparent,
    this.showBackArrow = true,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final Color backgroundColor;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        leading: showBackArrow
            ? BackButtonCustom()
            : leadingIcon != null
            ? IconButton(
                onPressed: leadingOnPressed,
                icon: Icon(leadingIcon, color: Colors.black),
              )
            : null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
