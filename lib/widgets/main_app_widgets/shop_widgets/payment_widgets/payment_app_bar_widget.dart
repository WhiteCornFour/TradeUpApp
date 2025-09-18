import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/widgets/general/general_back_button.dart';

class AppBarPayment extends StatelessWidget implements PreferredSizeWidget {
  const AppBarPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackButtonCustomGeneral(),
      backgroundColor: AppColors.backgroundGrey,
      centerTitle: true,
      title: Text(
        'Payment',
        style: TextStyle(
          color: AppColors.header,
          fontFamily: 'Roboto-Medium',
          fontSize: 26,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 50);
}
