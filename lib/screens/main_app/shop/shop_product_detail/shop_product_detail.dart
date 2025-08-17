import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/models/category_model.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/screens/main_app/home/controller/home_controller.dart';
import 'package:tradeupapp/screens/main_app/home/controller/home_product_detail_controller.dart';
import 'package:tradeupapp/screens/main_app/profile/save_product/controller/save_product_controller.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail/shop_product_detail_bottom_navigation_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail/shop_product_detail_image_slider_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail/shop_product_detail_header_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail/shop_product_detail_price_tag_widget.dart';
import 'package:tradeupapp/widgets/general/general_book_marked_toggle_icon_widget.dart';
import 'package:tradeupapp/widgets/general/general_custom_app_bar_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail/shop_product_detail_tag_button_widget.dart';
import 'package:tradeupapp/widgets/general/general_button_widget.dart';

class ProductDetailShop extends StatefulWidget {
  const ProductDetailShop({
    super.key,
    required this.product,
    required this.userId,
  });

  final ProductModel product;
  final String? userId;

  @override
  State<ProductDetailShop> createState() => _ProductDetailShopState();
}

class _ProductDetailShopState extends State<ProductDetailShop> {
  final homeController = Get.find<HomeController>();
  final productDetailController = Get.put(ProductDetailController());
  final saveController = Get.find<SaveProductController>();

  List<CategoryModel> get categories => homeController.categoryList;

  List<CategoryModel> get selectedCategories {
    final productCategoryIds = widget.product.categoryList ?? [];
    return categories
        .where((cat) => productCategoryIds.contains(cat.name))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await productDetailController.loadUserDataById(widget.userId ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    print('Product In Detail Shop: ${product.productName}');
    print('User in Shop Product Detail: ${widget.userId}');

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        color: Colors.white,
        child: SafeArea(
          top: false,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //Product Image Slider
                  Stack(
                    children: [
                      ProductDetailImageSliderShop(
                        firstImage: widget.product.imageList?.isNotEmpty == true
                            ? product.imageList!.first
                            : 'assets/images/unavailable_image.jpg',
                        imageList: product.imageList ?? [],
                      ),

                      // Dark Overlay
                      Container(
                        height:
                            MediaQuery.of(context).padding.top +
                            kToolbarHeight +
                            16,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black54, Colors.transparent],
                          ),
                        ),
                      ),

                      // AppBar
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: CustomAppBarGeneral(
                          showBackArrow: false,
                          leadingIcon: Iconsax.arrow_left_2,
                          leadingOnPressed: Get.back,
                          actions: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Obx(() {
                                final currentUserId =
                                    homeController.currentUserId;
                                if (currentUserId == null)
                                  return const SizedBox();

                                final productId =
                                    widget.product.productId ?? '';
                                final isSaved =
                                    saveController.savedStatus[productId] ??
                                    false;

                                return BookmarkedToggleButtonGeneral(
                                  initialState: isSaved,
                                  onChanged: (_) {
                                    saveController.toggleSaveProduct(
                                      currentUserId,
                                      productId,
                                    );
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  //Product Details
                  Padding(
                    padding: EdgeInsets.only(top: 10, right: 24, left: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Header Product Detail
                        Obx(() {
                          final user = productDetailController.user.value;

                          return ProductDetailHeaderShop(
                            rating: '${productDetailController.rating}',
                            ratingCount: '${user?.totalReviews ?? 0}',
                            userAvatar:
                                user?.avtURL ??
                                'https://media.istockphoto.com/id/1317804578/photo/one-businesswoman-headshot-smiling-at-the-camera.jpg?s=612x612&w=0&k=20&c=EqR2Lffp4tkIYzpqYh8aYIPRr-gmZliRHRxcQC5yylY=',
                            userName: user?.fullName ?? 'Unknown Username',
                            isVerification: false,
                          );
                        }),
                        SizedBox(height: 16),

                        //Content Product Detail
                        //Price Tag
                        ProductDetailPriceTagShop(
                          finalPrice: product.productPrice ?? 0.00,
                        ),

                        SizedBox(height: 16),

                        //Title
                        Text(
                          product.productName ?? 'Unknown Product',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Roboto-Regular',
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 16),

                        //Status
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Condition: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Roboto-Regular',
                                  color: Colors.black54,
                                ),
                              ),
                              TextSpan(
                                text: product.selectedCondition ?? 'Unknown',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Roboto-Bold',
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 16),

                        //Tag
                        Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Roboto-Bold',
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: selectedCategories.map((category) {
                            return ProductDetailTagButtonShop(
                              label: category.name,
                              icon: category.icon,
                              backgroundColor: category.color,
                              textColor: Colors.black87,
                              iconColor: Colors.black54,
                              onPressed: () {
                                // handle click
                                print('Selected: ${category.name}');
                              },
                            );
                          }).toList(),
                        ),

                        SizedBox(height: 16),

                        //Make An Offer Button
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ButtonGeneral(
                            width: double.infinity,
                            text: 'Make An Offer',
                            icon: Iconsax.receipt_item,
                            backgroundColor: AppColors.header,
                            isOutlined: true,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(height: 8),

                        ReadMoreText(
                          product.productDescription ?? 'Unknown Description',
                          trimLines: 3,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: ' View more',
                          trimExpandedText: ' View less',
                          moreStyle: TextStyle(
                            color: AppColors.background,
                            fontSize: 14,
                            fontFamily: 'Roboto-Bold',
                            fontWeight: FontWeight.w500,
                          ),
                          lessStyle: TextStyle(
                            color: AppColors.background,
                            fontSize: 14,
                            fontFamily: 'Roboto-Bold',
                            fontWeight: FontWeight.w500,
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto-Regular',
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 16),
                        Divider(),
                        SizedBox(height: 16),
                        //Reviews
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Reviews(199)',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Roboto-Bold',
                                color: Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: ShopProductDetailBottomNavigation(product: product),
          ),
        ),
      ),
    );
  }
}
