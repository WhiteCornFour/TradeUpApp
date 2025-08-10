import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_add_product/controller/shop_add_product_controller.dart';

class AddProductProgressBarShop extends StatefulWidget {
  const AddProductProgressBarShop({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  State<AddProductProgressBarShop> createState() =>
      _AddProductProgressBarShopState();
}

class _AddProductProgressBarShopState extends State<AddProductProgressBarShop> {
  final addProductController = AddProductController.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Progress bar animation
          //Animation cho vòng tròn
          TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: addProductController.oldProgress.value,
              end: addProductController.currentProgress.value,
            ),
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOutCubic,
            builder: (context, value, _) {
              return CircularPercentIndicator(
                radius: 30,
                lineWidth: 6,
                percent: value.clamp(0.0, 1.0),
                progressColor: AppColors.background,
                backgroundColor: const Color.fromARGB(255, 209, 209, 209),
                circularStrokeCap: CircularStrokeCap.round,
                //Số bên trong vòng tròn
                center: TweenAnimationBuilder<int>(
                  tween: IntTween(
                    begin: addProductController.oldStep.value,
                    end: addProductController.currentStep.value,
                  ),
                  duration: const Duration(milliseconds: 600),
                  builder: (context, number, _) {
                    return Text(
                      "$number/3",
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto-Bold',
                      ),
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(width: 16),

          //Title + Subtitle
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontFamily: 'Roboto-Bold',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.subTitle,
                style: const TextStyle(
                  fontFamily: 'Roboto-Regular',
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
