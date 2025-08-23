import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/screens/general/general_all_categories.dart';

import 'package:tradeupapp/screens/main_app/chat/controllers/chat_room_controller.dart';

import 'package:tradeupapp/screens/general/general_all_products.dart';

import 'package:tradeupapp/screens/main_app/home/controller/home_controller.dart';
import 'package:tradeupapp/screens/main_app/profile/save_product/controller/save_product_controller.dart';
import 'package:tradeupapp/screens/main_app/shop/controllers/shop_controller.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_dot_indicator_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_sort_option_group/home_sort_option_group_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_category_group_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_drawer/home_drawer_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_header_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_searching_group/home_searching_group_widget.dart';
import 'package:tradeupapp/widgets/general/general_header_section_widget.dart';
import 'package:tradeupapp/widgets/general/general_grid_view_product_vertical_list_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final PageController _pageController = PageController(viewportFraction: 0.92);
  final homeController = Get.put(HomeController());
  final shopController = Get.put(ShopController());
  final saveController = Get.put(SaveProductController());
  final db = DatabaseService();

  //Biến giữ số lượng cho Categories
  Map<String, int> categoryCounts = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await homeController.loadUser();
      await homeController.loadUsersAndMap();
      await homeController.loadProducts();
      await homeController.loadCategories();

      if (homeController.user.value != null) {
        homeController.loadSearchHistory();
      }
    });
    //Chuan bi du lieu cho chat room controller
    Get.put(ChatRoomController());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      //1. Kiểm tra trạng thái Loading
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

      //2.Tất cả điều kiện check dữ liệu
      String? errorMessage;
      if (homeController.user.value == null) {
        errorMessage = 'Cannot load user data!';
      } else if (homeController.categoryList.length < 14) {
        errorMessage = 'Cannot load categories list data!';
        // } else if (homeController.productList.isEmpty) {
        //   errorMessage = 'Cannot load product list data!';
      } else if (homeController.userList.isEmpty) {
        errorMessage = 'Cannot load users list data!';
      }

      final user = homeController.user.value!;
      final productList = homeController.productList;
      final categoryList = homeController.categoryList;

      //Kiểm tra categoryList đủ phần tử để tránh lỗi sublist out of range
      if (errorMessage != null) {
        return Scaffold(
          body: Center(
            child: Text(
              errorMessage,
              style: const TextStyle(
                color: AppColors.header,
                fontFamily: 'Roboto-Black',
                fontSize: 20,
              ),
            ),
          ),
        );
      }

      return Scaffold(
        endDrawer: DrawerHome(),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Header include: Avatar, Username, ViewProfile
                HeaderHome(
                  userName: user.fullName ?? 'Cannot Find User Name',
                  userAvatar: user.avtURL ?? '',
                  role: user.role ?? 0,
                ),
                //Search Group
                SearchingGroupHome(itemCount: productList.length),
                //Sort by Category
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
                      homeController.currentPage.value = index;
                    },

                    children: [
                      CategoryGroupHome(
                        categories: categoryList.sublist(0, 3),
                        layoutType: 1,
                      ),
                      CategoryGroupHome(
                        categories: categoryList.sublist(3, 7),
                        layoutType: 2,
                      ),
                      CategoryGroupHome(
                        categories: categoryList.sublist(7, 11),
                        layoutType: 2,
                      ),
                      CategoryGroupHome(
                        categories: categoryList.sublist(11, 14),
                        layoutType: 3,
                      ),
                    ],
                  ),
                ),
                //Dot indicator
                DotIndicatorHome(),
                const SizedBox(height: 20),
                //Discover
                HeaderSectionGeneral(
                  title: 'Discover',
                  icon: Iconsax.ticket_star,
                  onTap: () {
                    homeController.selectedSortOption.value = 'Newest';
                    Get.to(() => AllProductsGeneral());
                  },
                ),
                //Option Group
                const SizedBox(height: 10),
                SortOptionGroupHome(),
                //List of Product
                const SizedBox(height: 15),
                Obx(() {
                  final products = homeController.getFilteredProducts(
                    inputProducts: homeController.productList,
                    limitTo10: true,
                  );

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: GridViewProductVerticalListGeneral(
                      productList: products,
                      userIdToUserName: homeController.userIdToUserName,
                    ),
                  );
                }),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      );
    });
  }
}
