import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/screens/main_app/shop/controllers/payment_controller.dart';

class ShowInforProductPayment extends StatelessWidget {
  const ShowInforProductPayment({
    super.key,
    required this.controller,
    required this.data,
    required this.totalPrice,
  });

  final PaymentController controller;
  final ProductModel data;
  final String totalPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CarouselSlider.builder(
            itemCount: data.imageList!.length,
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.85, // Để có khoảng trống 2 bên giống Shopee
              autoPlayInterval: Duration(seconds: 7),
              onPageChanged: (index, reason) {
                controller.currentIndex.value = index;
              },
            ),
            itemBuilder: (context, index, realIndex) {
              final imagePath = data.imageList![index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              );
            },
          ),
        ),

        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(data.imageList!.length, (index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: controller.currentIndex.value == index ? 16 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: controller.currentIndex.value == index
                      ? AppColors.background
                      : AppColors.backgroundGrey,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ),

        //Thong tin san pham
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                data.productName ?? "Loading...",
                style: TextStyle(
                  color: AppColors.header,
                  fontFamily: 'Roboto-Medium',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),

              Text(
                data.selectedCondition ?? "Loading...",
                style: TextStyle(
                  color: AppColors.background,
                  fontFamily: 'Roboto-Regular',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),

              Flexible(
                child: Text(
                  data.productDescription ?? "Loading...",
                  softWrap: true,
                  maxLines: 2,
                  style: TextStyle(
                    color: AppColors.header,
                    fontFamily: 'Roboto-Regular',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              //border duoi chu
              Container(
                margin: EdgeInsets.only(bottom: 10, top: 10),
                height: 1.5,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.backgroundGrey,
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total orders',
                      style: TextStyle(
                        color: AppColors.header,
                        fontFamily: 'Roboto-Medium',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),

                    Text(
                      totalPrice,
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'Roboto-Medium',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
