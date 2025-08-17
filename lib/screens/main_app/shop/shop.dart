import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/screens/main_app/shop/controllers/shop_controller.dart';
import 'package:tradeupapp/screens/main_app/shop/personal.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_product_detail/shop_product_detail.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_pop_menu/shop_pop_menu_widget.dart';
import 'package:tradeupapp/widgets/general/general_search_app_bar_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_post_card/shop_post_card_widget.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  final shopController = Get.find<ShopController>();
  final idCurrentUser = AuthServices().currentUser!.uid;

  //hàm covert thời gian của createAt
  String _formatTimestampToNgayGio(Timestamp? timestamp) {
    if (timestamp == null) return 'Unknown';
    final date = timestamp.toDate().toLocal();
    final ngay = DateFormat('d/M/yyyy').format(date);
    final gio = DateFormat('HH:mm').format(date);
    return '$ngay at $gio';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search + Market + Menu
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 25,
                  top: 20,
                  bottom: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Feeds',
                      style: TextStyle(
                        fontFamily: 'Roboto-Bold',
                        fontSize: 26,
                        height: 1.0,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Iconsax.search_normal),
                          color: AppColors.header,
                          onPressed: () => showSystemSearchGeneral(context),
                        ),
                        IconButton(
                          icon: const Icon(Iconsax.shop),
                          color: AppColors.header,
                          onPressed: () {
                            Get.to(Personal(idUser: idCurrentUser));
                          },
                        ),
                        const PopMenuShop(),
                      ],
                    ),
                  ],
                ),
              ),

              // List of Post Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Obx(() {
                  if (shopController.feedList.isEmpty) {
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(height: 100),
                          SizedBox(
                            height: 300,
                            width: 500,
                            child: Image(
                              image: AssetImage('assets/images/noposts.png'),
                            ),
                          ),
                          Text(
                            'No feeds available!',
                            style: TextStyle(
                              color: AppColors.header,
                              fontFamily: 'Roboto-Medium',
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  //Loading chờ load đầy đủ thông tin user
                  if (shopController.isLoadingUsers.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: AppColors.background,
                        color: AppColors.text,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: shopController.feedList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final feed = shopController.feedList[index];
                      final user = shopController.usersCache[feed.userId];

                      return PostCardShop(
                        onPressed: () {
                          Get.to(
                            () => ProductDetailShop(
                              product: feed,
                              userId: feed.userId,
                            ),
                          );
                        },
                        imageUrls: feed.imageList ?? [],
                        description: feed.productDescription ?? '',
                        userName: user?.fullName ?? 'Loading...',
                        timeAgo: _formatTimestampToNgayGio(feed.createdAt),
                        likeCount: 123,
                        userAvatar: user?.avtURL ?? '',
                        userId: feed.userId,
                        currentUserId: idCurrentUser,
                        productId: feed.productId,
                      );
                    },
                  );
                }),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
