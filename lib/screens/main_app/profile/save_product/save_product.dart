import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/screens/main_app/profile/save_product/controller/save_product_controller.dart';
import 'package:tradeupapp/widgets/general/general_back_button.dart';
import 'package:tradeupapp/widgets/general/general_grid_view_product_vertical_list_widget.dart';

class SaveProduct extends StatefulWidget {
  const SaveProduct({super.key});

  @override
  State<SaveProduct> createState() => _SaveProductState();
}

class _SaveProductState extends State<SaveProduct> {
  final saveProductController = Get.find<SaveProductController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await saveProductController.loadUsersAndMap();
      await saveProductController.loadAllSaveProductByUserId();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButtonCustomGeneral(),
                      const Text(
                        'Save Product',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40),
                Center(
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/save_product_image.png',
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Your Favorite Picks, All in One Place',
                    style: TextStyle(
                      color: AppColors.header,
                      fontSize: 20,
                      fontFamily: 'Roboto-Black',
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Here’s a list of products you’ve saved. Browse them anytime you like.',
                    style: TextStyle(
                      color: AppColors.header,
                      fontSize: 15,
                      fontFamily: 'Roboto-Medium',
                    ),
                  ),
                ),
                SizedBox(height: 20),

                const SizedBox(height: 15),
                Obx(() {
                  final products = saveProductController.saveProductList
                      .toList();
                  final userMap = saveProductController.userIdToUserName;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridViewProductVerticalListGeneral(
                      productList: products,
                      userIdToUserName: userMap,
                    ),
                  );
                }),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
