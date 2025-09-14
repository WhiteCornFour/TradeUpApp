import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/screens/main_app/home/controller/home_controller.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_sort_option_group/home_sort_option_button_widget.dart';

class SortOptionGroupHome extends StatefulWidget {
  const SortOptionGroupHome({super.key});

  @override
  State<SortOptionGroupHome> createState() => _SortOptionGroupHomeState();
}

class _SortOptionGroupHomeState extends State<SortOptionGroupHome> {
  final homeController = Get.find<HomeController>();
  String selected = 'Newest'; //button standard

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SortOptionButtonHome(
              text: 'Newest',
              isSelected: homeController.selectedSortOption.value == 'Newest',
              onPressed: () => homeController.changeSortOption('Newest'),
            ),
            const SizedBox(width: 12),
            SortOptionButtonHome(
              text: 'Highest \$',
              isSelected: homeController.selectedSortOption.value == 'High \$',
              onPressed: () => homeController.changeSortOption('High \$'),
            ),
            const SizedBox(width: 12),
            SortOptionButtonHome(
              text: 'Lowest \$',
              isSelected: homeController.selectedSortOption.value == 'Low \$',
              onPressed: () => homeController.changeSortOption('Low \$'),
            ),
          ],
        ),
      ),
    );
  }
}
