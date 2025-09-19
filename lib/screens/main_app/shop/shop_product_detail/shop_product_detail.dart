import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/models/category_model.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_product_detail/shop_make_an_offer/controller/shop_make_an_offer_controller.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_product_detail/shop_make_an_offer/shop_make_an_offer.dart';
import 'package:tradeupapp/screens/general/general_share_show_bottom_sheet.dart';
import 'package:tradeupapp/screens/main_app/chat/controllers/chat_room_controller.dart';
import 'package:tradeupapp/screens/main_app/chat/controllers/message_controller.dart';
import 'package:tradeupapp/screens/main_app/home/controller/home_controller.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_product_detail/controller/shop_product_detail_controller.dart';
import 'package:tradeupapp/screens/main_app/profile/save_product/controller/save_product_controller.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_product_detail/shop_offer_list/shop_offer_list.dart';
import 'package:tradeupapp/widgets/general/general_loading_screen.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail/shop_product_detail_bottom_navigation_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail/shop_product_detail_image_slider_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail/shop_product_detail_header_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail/shop_product_detail_price_tag_widget.dart';
import 'package:tradeupapp/widgets/general/general_book_marked_toggle_icon_widget.dart';
import 'package:tradeupapp/widgets/general/general_custom_app_bar_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail/shop_product_detail_tag_button_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail/shop_product_detail_top_offer_card.dart';

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
  final makeAnOfferController = Get.put(MakeAnOfferController());
  ChatRoomController? chatRoomController;

  //Trạng thái Loading cho trang
  var isLoading = true.obs;

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
    chatRoomController = Get.find<ChatRoomController>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await productDetailController.loadUserDataById(widget.userId ?? '');
      await productDetailController.loadTopOffer(
        widget.product.productId ?? '',
      );
      await productDetailController.loadOffersOfProduct(
        widget.product.productId ?? '',
      );
      makeAnOfferController.originPrice.value =
          widget.product.productPrice ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        color: Colors.white,
        child: SafeArea(
          top: false,
          child: Obx(() {
            //1. Loading state
            if (productDetailController.isLoading.value) {
              return const Scaffold(
                body: LoadingScreenGeneral(
                  message: "Loading product details...",
                ),
              );
            }

            //2. Kiểm tra dữ liệu user
            final user = productDetailController.user.value;
            if (user == null) {
              return const Scaffold(
                body: Center(
                  child: Text(
                    "Cannot load seller information!",
                    style: TextStyle(
                      color: AppColors.header,
                      fontFamily: 'Roboto-Black',
                      fontSize: 20,
                    ),
                  ),
                ),
              );
            }

            //3. Render UI chính
            return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    //Product Image Slider
                    Stack(
                      children: [
                        ProductDetailImageSliderShop(
                          firstImage: product.imageList?.isNotEmpty == true
                              ? product.imageList!.first
                              : 'assets/images/unavailable_image.jpg',
                          imageList: product.imageList ?? [],
                        ),
                        //Overlay + AppBar
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
                                  if (currentUserId == null) {
                                    return const SizedBox();
                                  }
                                  final productId = product.productId ?? '';
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
                      padding: const EdgeInsets.only(
                        top: 10,
                        right: 24,
                        left: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Header Product Detail (user info, rating)
                          ProductDetailHeaderShop(
                            sellerId:
                                productDetailController.user.value?.userId ??
                                'Null id',
                            onPressedShareProduct: () {
                              ShareShowBottomSheetGeneral.show(
                                context,
                                chatRoomController!.filteredChatRooms,
                                chatRoomController!.searchController,
                                chatRoomController!.isLoading.value,
                                (idChatRoom) {
                                  MessageController().handleSendProduct(
                                    product.productId!,
                                    idChatRoom,
                                  );
                                },
                              );
                            },
                            rating: '${productDetailController.rating.value}',
                            ratingCount:
                                '${productDetailController.ratingCount.value}',
                            userAvatar:
                                productDetailController.user.value?.avtURL,
                            userName:
                                productDetailController.user.value?.fullName ??
                                'Unknown Username',
                            isVerification: false,
                          ),
                          const SizedBox(height: 16),

                          //Price Tag
                          ProductDetailPriceTagShop(
                            finalPrice: product.productPrice ?? 0.00,
                          ),

                          const SizedBox(height: 16),

                          //Title
                          Text(
                            product.productName ?? 'Unknown Product',
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'Roboto-Regular',
                              color: Colors.black,
                            ),
                          ),

                          const SizedBox(height: 16),

                          //Condition
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Condition: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Roboto-Regular',
                                    color: Colors.black54,
                                  ),
                                ),
                                TextSpan(
                                  text: product.selectedCondition ?? 'Unknown',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Roboto-Bold',
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          //Category
                          Text(
                            'Category',
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'Roboto-Bold',
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
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
                                onPressed: () =>
                                // ignore: avoid_print
                                    print('Selected: ${category.name}'),
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 16),

                          //Description
                          Text(
                            'Description',
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'Roboto-Bold',
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ReadMoreText(
                            product.productDescription ?? 'Unknown Description',
                            trimLines: 3,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: ' View more',
                            trimExpandedText: ' View less',
                            moreStyle: const TextStyle(
                              color: AppColors.background,
                              fontSize: 14,
                              fontFamily: 'Roboto-Bold',
                              fontWeight: FontWeight.w500,
                            ),
                            lessStyle: const TextStyle(
                              color: AppColors.background,
                              fontSize: 14,
                              fontFamily: 'Roboto-Bold',
                              fontWeight: FontWeight.w500,
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Roboto-Regular',
                              color: Colors.black,
                            ),
                          ),

                          const SizedBox(height: 16),

                          //Final Deal Agreement For This Product
                          Text(
                            'Deal Agreed',
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'Roboto-Bold',
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Obx(() {
                            final offer =
                                productDetailController.topOffer.value;
                            return ProductDetailTopOfferCardShop(
                              userName: offer?.senderName ?? "Unknown User",
                              userAvatar: offer?.senderAvatar,
                              offerPrice: offer?.offerPrice,
                              offerType: offer?.type,
                              status: offer?.status,
                            );
                          }),

                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),

                          //Offers
                          Obx(() {
                            final offerCount =
                                productDetailController.offerList.length;
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => ShopOfferList());
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Offers($offerCount)',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Roboto-Bold',
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Obx(() {
                final topOffer = productDetailController.topOffer.value;

                // Nếu có top offer và status = 1 thì ẩn
                if (topOffer != null && topOffer.status == 1) {
                  return const SizedBox.shrink();
                }

                // Nếu chưa có deal thì hiển thị
                return ShopProductDetailBottomNavigation(
                  product: product,
                  onPressed: () => Get.to(
                    () => MakeAnOfferShop(
                      product: product,
                      userId: widget.userId,
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
