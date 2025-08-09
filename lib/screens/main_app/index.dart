import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/screens/main_app/chat/chat_room.dart';
import 'package:tradeupapp/screens/main_app/home/home.dart';
import 'package:tradeupapp/screens/main_app/shop/shop.dart';
import 'package:tradeupapp/screens/main_app/news/news.dart';
import 'package:tradeupapp/screens/main_app/profile/profile.dart';

class MainAppIndex extends StatefulWidget {
  const MainAppIndex({super.key});

  @override
  State<MainAppIndex> createState() => _Index();
}

class _Index extends State<MainAppIndex> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0; //thứ tự trang

  final screens = [Home(), Chat(), Shop(), News(), Profile()];

  final items = <Widget>[
    Icon(Iconsax.home, size: 30),
    Icon(Iconsax.message, size: 30),
    Icon(Iconsax.shopping_bag, size: 30),
    Icon(Iconsax.notification, size: 30),
    Icon(Iconsax.user, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        color: AppColors.header,
        child: SafeArea(
          top: false,
          child: ClipRect(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: screens[index],
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(iconTheme: IconThemeData(color: Colors.white)),
                  child: CurvedNavigationBar(
                    key: navigationKey,
                    height: 64,
                    color: AppColors.header,
                    buttonBackgroundColor: AppColors.header,
                    animationCurve: Curves.easeInOut,
                    animationDuration: Duration(milliseconds: 500),
                    backgroundColor: Colors.transparent,
                    index: index,
                    items: items,
                    onTap: (index) => setState(() => this.index = index),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
