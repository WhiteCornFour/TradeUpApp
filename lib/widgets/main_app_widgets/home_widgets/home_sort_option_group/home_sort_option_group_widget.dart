import 'package:flutter/material.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_sort_option_group/home_sort_option_button_widget.dart';

class SortOptionGroupHome extends StatefulWidget {
  const SortOptionGroupHome({super.key});

  @override
  State<SortOptionGroupHome> createState() => _SortOptionGroupHomeState();
}

class _SortOptionGroupHomeState extends State<SortOptionGroupHome> {
  String selected = 'Relevance'; //button standard

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SortOptionButtonHome(
            text: 'Relevance',
            isSelected: selected == 'Relevance',
            onPressed: () {
              setState(() {
                selected = 'Relevance';
              });
            },
          ),
          const SizedBox(width: 12),
          SortOptionButtonHome(
            text: 'Newest',
            isSelected: selected == 'Newest',
            onPressed: () {
              setState(() {
                selected = 'Newest';
              });
            },
          ),
          const SizedBox(width: 12),
          SortOptionButtonHome(
            text: 'Price',
            isSelected: selected == 'Price',
            onPressed: () {
              setState(() {
                selected = 'Price';
              });
            },
          ),
        ],
      ),
    );
  }
}
