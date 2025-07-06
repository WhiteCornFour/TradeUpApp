import 'package:flutter/material.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_button_widget.dart';

class ButtonGroupHome extends StatefulWidget {
  const ButtonGroupHome({super.key});

  @override
  State<ButtonGroupHome> createState() => _ButtonGroupHomeState();
}

class _ButtonGroupHomeState extends State<ButtonGroupHome> {
  String selected = 'Relevance'; //button standard

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonHome(
            text: 'Relevance',
            isSelected: selected == 'Relevance',
            onPressed: () {
              setState(() {
                selected = 'Relevance';
              });
            },
          ),
          const SizedBox(width: 12),
          ButtonHome(
            text: 'Newest',
            isSelected: selected == 'Newest',
            onPressed: () {
              setState(() {
                selected = 'Newest';
              });
            },
          ),
          const SizedBox(width: 12),
          ButtonHome(
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
