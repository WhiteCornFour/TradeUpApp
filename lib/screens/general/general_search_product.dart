import 'package:flutter/material.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_searching_group/home_searching_group_bar_and_filter.dart';
import 'package:tradeupapp/widgets/general/general_grid_view_product_vertical_list_widget.dart';
import 'package:tradeupapp/widgets/general/general_category_head_banner_widget.dart';

class SearchProductGeneral extends StatelessWidget {
  const SearchProductGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Head Banner
            CategoryHeadBannerGeneral(
              title: 'Search Results',
              subTitle: 'Found 4 results for keyword "iPhone"',
              imagePath:
                  'assets/images/categories_background_images/appliances_background.jpg',
              overlayColor: Colors.deepPurple,
              height: 220,
            ),

            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(20),
              child: SearchingGroupBarAndFilterHome(),
            ),

            //Grid View Products
            GridViewProductVerticalListGeneral(itemCount: 10),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
