import 'package:flutter/material.dart';

import 'package:tradeupapp/widgets/general/general_back_button.dart';

class CustomAppBarGeneral extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarGeneral({
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
    return  AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        leading: showBackArrow
            ? BackButtonCustomGeneral()
            : leadingIcon != null
            ? IconButton(
                onPressed: leadingOnPressed,
                icon: Icon(leadingIcon, color: Colors.black),
              )
            : null,
        title: title,
        titleSpacing: 16,
        actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
