import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/AppColors.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/search_bar_and_filter.dart';
import 'package:tradeupapp/widgets/main_app_widgets/system_widgets/head_bar_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            HeaderBarContainer(
              backgroundColor: AppColors.header,
              padding: EdgeInsets.symmetric(vertical: 25),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Text(
                              'Welcome back ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Player',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const Icon(Icons.favorite, color: Colors.white),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  SearchBarAndFilter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
