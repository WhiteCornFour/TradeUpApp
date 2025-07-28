import 'package:flutter/material.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_drawer/home_drawer_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_search_bar_widget.dart';
import 'package:tradeupapp/widgets/general/general_search_app_bar_widget.dart';

class SearchingGroupBarAndFilterHome extends StatelessWidget {
  const SearchingGroupBarAndFilterHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Search Bar
        Expanded(
          child: SearchBarHome(
            isReadOnly: true,
            onTap: () => showSystemSearchGeneral(context),
          ),
        ),

        const SizedBox(width: 10),
        //Filter Button
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              builder: (context) => DrawerHome(),
            );
          },

          child: Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black26),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  offset: Offset(0, 2),
                  color: Colors.black12,
                ),
              ],
            ),
            child: Icon(Icons.tune, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
