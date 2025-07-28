import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/models/category_model.dart';
import 'package:tradeupapp/screens/general/general_all_categories.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_drawer/home_drawer_choice_chips_widget.dart';
import 'package:tradeupapp/widgets/general/general_header_section_widget.dart';

class DrawerCategoriesChoiceChipsGroupHome extends StatefulWidget {
  final List<CategoryModel> categories;

  const DrawerCategoriesChoiceChipsGroupHome({
    super.key,
    required this.categories,
  });

  @override
  State<DrawerCategoriesChoiceChipsGroupHome> createState() =>
      _DrawerCategoriesChoiceChipsGroupHomeState();
}

class _DrawerCategoriesChoiceChipsGroupHomeState
    extends State<DrawerCategoriesChoiceChipsGroupHome> {
  //Categories List that was chosen by user
  final Set<String> selectedCategories = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Header Section: Categories
        HeaderSectionGeneral(
          title: 'Categories',
          icon: Iconsax.category,
          paddingHorizontal: 0,
          paddingVertical: 0,
          onTap: () => Get.to(() => AllCategoriesGeneral()),
        ),
        const SizedBox(height: 12),

        // Choice chips
        Wrap(
          spacing: 6,
          children: widget.categories.map((category) {
            final isSelected = selectedCategories.contains(category.name);
            return DrawerChoiceChipsHome(
              text: category.name,
              selected: isSelected,
              color: category.colorStrong,
              onSelected: (value) {
                setState(() {
                  if (isSelected) {
                    selectedCategories.remove(category.name);
                  } else {
                    selectedCategories.add(category.name);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
