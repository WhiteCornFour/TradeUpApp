import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/screens/main_app/index.dart';
import 'package:tradeupapp/screens/main_app/shop/personal.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_add_product/controller/shop_add_product_controller.dart';
import 'package:tradeupapp/widgets/general/general_loading_screen.dart';
import 'package:tradeupapp/widgets/general/general_search_app_bar_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_page/shop_add_product_page_one_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_page/shop_add_product_page_three_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_page/shop_add_product_page_two_widget.dart';
import 'package:tradeupapp/widgets/authentication_widgets/on_boarding_page_widgets/on_boarding_page_widget.dart';
import 'package:tradeupapp/widgets/general/general_custom_app_bar_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_bottom_button_group_widget.dart';

class AddProductShop extends StatefulWidget {
  const AddProductShop({super.key});

  @override
  State<AddProductShop> createState() => _AddProductShopState();
}

class _AddProductShopState extends State<AddProductShop> {
  late final AddProductController addProductController;

  @override
  void initState() {
    super.initState();
    //Tạo controller khi vào chức năng Add Product
    addProductController = Get.put(AddProductController());

    //Set tiến độ ban đầu = 1/3 khi bắt đầu vào chức năng
    addProductController.updateProgress(1 / 3, 1);
  }

  @override
  void dispose() {
    //Xoá controller khi thoát chức năng để lần sau vào lại sẽ reset
    Get.delete<AddProductController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      //1. Trạng thái loading
      if (addProductController.isSubmitting.value) {
        return const Scaffold(
          body: LoadingScreenGeneral(message: "Upload your product..."),
        );
      }
      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: CustomAppBarGeneral(
          showBackArrow: false,
          backgroundColor: Colors.white,
          leadingIcon: Iconsax.arrow_left_2,
          leadingOnPressed: Get.back,
          title: const Text(
            'Add Product',
            style: TextStyle(fontFamily: 'Roboto-Medium'),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: addProductController.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: addProductController.updateStepIndicator,
                  children: const [
                    AddProductPageOneShop(),
                    AddProductPageTwoShop(),
                    AddProductPageThreeShop(),
                    OnBoardingPage(
                      image: 'assets/images/success_product.gif',
                      title: 'Product Created Successfully!',
                      subTitle:
                          'Your product is now live and ready to be viewed.',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AddProductWizardNavigationButtonsShop(
                  currentStep: addProductController.currentStepIndex.value,
                  totalSteps: 4,
                  onNext: addProductController.nextStep,
                  onBack: addProductController.previousStep,
                  onFinish: () async {
                    await addProductController.submitProduct();
                  },
                  onManageProducts: () {
                    final userId = homeController.user.value?.userId ?? "";
                    Get.to(() => Personal(idUser: userId));
                  },
                  onBackHome: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (Get.isRegistered<AddProductController>()) {
                        Get.delete<AddProductController>();
                      }
                      Get.offAll(() => MainAppIndex());
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
