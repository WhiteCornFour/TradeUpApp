import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_drawer/home_drawer_choice_chips_widget.dart';
import 'package:tradeupapp/widgets/general/general_header_section_widget.dart';

class DrawerConditionChoiceChipsGroupHome extends StatefulWidget {
  const DrawerConditionChoiceChipsGroupHome({super.key});

  @override
  State<DrawerConditionChoiceChipsGroupHome> createState() =>
      _DrawerConditionChoiceChipsGroupHomeState();
}

class _DrawerConditionChoiceChipsGroupHomeState
    extends State<DrawerConditionChoiceChipsGroupHome> {
  String selectedCondition = 'New';

  final List<String> conditions = ['New', 'Used', 'Refurbished'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Header Section: Condition
        HeaderSectionGeneral(
          title: 'Condition',
          icon: Iconsax.refresh,
          showViewAll: false,
          paddingHorizontal: 0,
          paddingVertical: 0,
        ),
        const SizedBox(height: 12),

        //Condition Chips
        Wrap(
          spacing: 10,
          children: conditions.map((condition) {
            return DrawerChoiceChipsHome(
              text: condition,
              selected: selectedCondition == condition,
              color: AppColors.header,
              onSelected: (bool selected) {
                setState(() {
                  selectedCondition = condition;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
