import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/models/category_model.dart';
import 'package:tradeupapp/screens/general/general_all_categories.dart';
import 'package:tradeupapp/screens/main_app/profile/controller/home_controller.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_sort_option_group/home_sort_option_group_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_category_group_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_drawer/home_drawer_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_header_widget.dart';
import 'package:tradeupapp/data/category_data.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_searching_group/home_searching_group_widget.dart';
import 'package:tradeupapp/widgets/general/general_header_section_widget.dart';
import 'package:tradeupapp/widgets/general/general_grid_view_product_vertical_list_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final List<CategoryModel> allCategories = categories;
  final PageController _pageController = PageController(viewportFraction: 0.92);
  int _currentPage = 0;
  final homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.loadUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeController.isLoading.value) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColors.background,
              color: AppColors.text,
            ),
          ),
        );
      }

      if (homeController.user.value == null) {
        return const Scaffold(
          body: Center(
            child: Text(
              'Cannot load user data!',
              style: TextStyle(
                color: AppColors.header,
                fontFamily: 'Roboto-Black',
                fontSize: 20,
              ),
            ),
          ),
        );
      }

      final user = homeController.user.value!;
      print(user.fullName);

      return Scaffold(
        endDrawer: DrawerHome(),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderHome(
                  userName: user.fullName ?? 'Cannot Find User Name',
                  userAvatar: user.avtURL ?? '',
                  role: user.role ?? 0,
                ),
                SearchingGroupHome(itemCount: 138),
                HeaderSectionGeneral(
                  title: 'Sort by Category',
                  icon: Iconsax.category,
                  onTap: () => Get.to(() => AllCategoriesGeneral()),
                ),
                SizedBox(
                  height: 210,
                  child: PageView(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    pageSnapping: true,
                    children: [
                      CategoryGroupHome(
                        categories: allCategories.sublist(0, 3),
                        layoutType: 1,
                      ),
                      CategoryGroupHome(
                        categories: allCategories.sublist(3, 7),
                        layoutType: 2,
                      ),
                      CategoryGroupHome(
                        categories: allCategories.sublist(7, 11),
                        layoutType: 2,
                      ),
                      CategoryGroupHome(
                        categories: allCategories.sublist(11, 14),
                        layoutType: 3,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 12 : 8,
                        height: _currentPage == index ? 12 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.background
                              : Colors.grey[400],
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 20),
                HeaderSectionGeneral(
                  title: 'Discover',
                  icon: Iconsax.ticket_star,
                ),
                const SizedBox(height: 10),
                SortOptionGroupHome(),
                const SizedBox(height: 15),
                GridViewProductVerticalListGeneral(itemCount: 4),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      );
    });
  }
}
