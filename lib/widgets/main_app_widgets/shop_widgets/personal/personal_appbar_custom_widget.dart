import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/widgets/general/general_back_button.dart';

class AppBarCustomPersonal extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const AppBarCustomPersonal({super.key, this.title = 'Personal'});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: preferredSize.height,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          alignment: Alignment.center, // căn giữa tất cả
          children: [
            Align(
              alignment: Alignment.centerLeft, // nút back bên trái
              child: BackButtonCustomGeneral(),
            ),
            Center(
              child: Text(
                title,
                style: TextStyle(
                  color: AppColors.header,
                  fontFamily: 'Roboto-Regular',
                  fontSize: 23,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
