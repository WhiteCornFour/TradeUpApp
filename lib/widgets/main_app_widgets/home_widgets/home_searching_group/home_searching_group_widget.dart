import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_searching_group/home_searching_group_bar_and_filter.dart';

class SearchingGroupHome extends StatelessWidget {
  const SearchingGroupHome({super.key, required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Container Text + SearchBar
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 40,
            bottom: 26,
          ),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.header,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 170, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explore and trade up to',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Roboto-Regular',
                        height: 1.3,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '$itemCount products',
                      style: TextStyle(
                        color: Color.fromARGB(255, 233, 205, 119),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'and find what you love!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Roboto-Regular',
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SearchingGroupBarAndFilterHome(),
            ],
          ),
        ),

        //Girl Image
        Positioned(
          top: -20,
          left: -10,
          child: SizedBox(
            height: 184,
            child: Image.asset(
              'lib/assets/images/girl_white_shirt_holding_something.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
