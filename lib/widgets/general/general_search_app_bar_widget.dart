import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/screens/general/general_search_product.dart';
import 'package:tradeupapp/screens/main_app/home/controller/home_controller.dart';

void showSystemSearchGeneral(BuildContext context) {
  showSearch(context: context, delegate: CustomSearchDelegate());
}

final homeController = Get.find<HomeController>();

class CustomSearchDelegate extends SearchDelegate {
  //Cập nhật realtime khi searchHistoryList thay đổi
  List<String> get searchTerms => homeController.searchHistoryList
      .map((item) => item.searchContent ?? '')
      .toList();

  //Build Action: Delete Search Query
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () => query = '',
          icon: Icon(Iconsax.close_circle, color: Colors.grey),
        ),
    ];
  }

  //Close Search Delegate
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(Iconsax.arrow_left_2, color: Colors.black),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Search no matter uppercase or not, compare it to searchTerns, only take 10 first
    final matchQuery = searchTerms
        .where((term) => term.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return buildSearchItem(context, matchQuery[index]);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final matchQuery = searchTerms
        .where((term) => term.toLowerCase().contains(query.toLowerCase()))
        .take(10)
        .toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return buildSearchItem(context, matchQuery[index]);
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    //If query empty then none search
    if (query.trim().isEmpty) {
      return;
    }

    homeController.saveSearchHistory(query);

    close(context, null); // Đóng search bar
    Get.to(() => SearchProductGeneral(), arguments: query); // Truyền query sang
  }

  //Theme Custom for Search Delegate
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(backgroundColor: Colors.white, elevation: 0),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.grey.shade600,
          fontFamily: 'Roboto-Regular',
        ),
        border: InputBorder.none,
      ),
      textTheme: Theme.of(context).textTheme.copyWith(
        titleLarge: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: 'Roboto-Regular',
        ),
      ),
    );
  }

  //Custom Tile For Build Results and Suggestions
  Widget buildSearchItem(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {
          query = title;
          showResults(context);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Iconsax.tag, color: Colors.grey),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16, fontFamily: 'Roboto-Regular'),
                ),
              ),
              IconButton(
                icon: Icon(Iconsax.arrow_up_1, color: Colors.grey),
                onPressed: () {
                  query = title;
                  showSuggestions(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
