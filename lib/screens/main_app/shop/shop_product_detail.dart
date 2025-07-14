import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail_bottom_navigation_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail_image_slider_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail_header_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail_price_tag_widget.dart';
import 'package:tradeupapp/widgets/system_widgets/system_book_marked_toggle_icon_widget.dart';
import 'package:tradeupapp/widgets/system_widgets/system_custom_app_bar_widget.dart';

class ProductDetailShop extends StatefulWidget {
  const ProductDetailShop({super.key});

  @override
  State<ProductDetailShop> createState() => _ProductDetailShopState();
}

class _ProductDetailShopState extends State<ProductDetailShop> {
  @override
  Widget build(BuildContext context) {
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
                        firstImage:
                            'lib/assets/images/sample_images/sample2.jpg',
                        imageList: [
                          'lib/assets/images/sample_images/sample4.jpg',
                          'lib/assets/images/sample_images/sample3.jpg',
                          'lib/assets/images/sample_images/sample4.jpg',
                          'lib/assets/images/sample_images/sample2.jpg',
                          'lib/assets/images/sample_images/sample4.jpg',
                        ],
                      ),

                      // Overlay gradient đen ở trên cùng
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

                      // AppBar đặt trên cùng
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: CustomAppBarSystem(
                          showBackArrow: true,
                          actions: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: BookmarkedToggleButtonSystem(),
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
                        ProductDetailHeaderShop(
                          rating: '5.0',
                          ratingCount: '199',
                          userAvatar:
                              'https://media.istockphoto.com/id/1317804578/photo/one-businesswoman-headshot-smiling-at-the-camera.jpg?s=612x612&w=0&k=20&c=EqR2Lffp4tkIYzpqYh8aYIPRr-gmZliRHRxcQC5yylY=',
                          userName: 'Kathe Timber',
                          isVerification: true,
                        ),

                        SizedBox(height: 16),

                        //Content Product Detail
                        //Price Tag
                        ProductDetailPriceTagShop(
                          isOnSale: true,
                          discountTag: '25%',
                          originalPrice: '\$135.00',
                          finalPrice: '\$100.25',
                        ),

                        SizedBox(height: 16),

                        //Title
                        Text(
                          'JBL Flip 6',
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
                                text: 'Status: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Roboto-Regular',
                                  color: Colors.black54,
                                ),
                              ),
                              TextSpan(
                                text: 'Available',
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
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Tag: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Roboto-Regular',
                                  color: Colors.black54,
                                ),
                              ),
                              TextSpan(
                                text: 'Electronics, Computers',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Roboto-Bold',
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 16),
                        //Checkout Button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Iconsax.receipt_item,
                                  size: 24,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 20),
                                Text(
                                  'Make An Offer',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Roboto-Bold',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 16),
                        Divider(),
                        SizedBox(height: 16),
                        //Description
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Roboto-Bold',
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),

                        ReadMoreText(
                          'JBL Flip 6 delivers powerful, crystal-clear sound with JBL Original Pro Sound technology. '
                          '\nWith a bold design and IP67 waterproof and dustproof rating, it’s perfect for indoor and outdoor use. '
                          '\nEnjoy up to 12 hours of playtime on a single charge. ',
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
            bottomNavigationBar: ShopProductDetailBottomNavigation(),
          ),
        ),
      ),
    );
  }
}
