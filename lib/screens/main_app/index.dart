import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/AppColors.dart';
import 'package:tradeupapp/screens/main_app/favorite/favorite.dart';
import 'package:tradeupapp/screens/main_app/home/home.dart';
import 'package:tradeupapp/screens/main_app/search/search.dart';
import 'package:tradeupapp/screens/main_app/set_up/set_up.dart';
import 'package:tradeupapp/screens/main_app/profile/profile.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _Index();
}

class _Index extends State<Index> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;

  final screens = [Home(), Favorite(), Search(), SetUp(), Profile()];

  final items = <Widget>[
    Icon(Icons.home, size: 30),
    Icon(Icons.search, size: 30),
    Icon(Icons.favorite, size: 30),
    Icon(Icons.settings, size: 30),
    Icon(Icons.person, size: 30),
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
