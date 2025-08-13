import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/screens/main_app/home/controller/home_controller.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_product_card_vertical_widget.dart';

class GridViewProductVerticalListGeneral extends StatelessWidget {
  const GridViewProductVerticalListGeneral({
    super.key,
    required this.productList,
    this.crossAxisCount = 2,
    this.crossAxisSpacing = 16,
    this.mainAxisSpacing = 16,
    this.mainAxisExtent = 288,
  });

  final List<ProductModel> productList;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double mainAxisExtent;

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    if (productList.isEmpty) {
      //Hiển thị thông báo khi không có sản phẩm
      return SizedBox(
        height: 300,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/no_products_found.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Sorry, there are no products available.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontFamily: 'Roboto-Regular',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    //Nếu có sản phẩm thì hiển thị GridView bình thường
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: productList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          mainAxisExtent: mainAxisExtent,
        ),
        itemBuilder: (_, index) => ProductCardVerticalHome(
          product: productList[index],
          userIdToUserName: homeController.userIdToUserName,
        ),
      ),
    );
  }
}
