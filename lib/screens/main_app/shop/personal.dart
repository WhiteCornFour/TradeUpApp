import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/screens/main_app/shop/controllers/personal_controller.dart';
import 'package:tradeupapp/widgets/general/general_custom_dialog.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/personal/personal_appbar_custom_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/personal/personal_avt_user_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/personal/personal_button_add_new_feed_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/personal/personal_button_chat_with_user_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/personal/personal_dialog_rating_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/personal/personal_information_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_post_card/shop_post_card_widget.dart';

class Personal extends StatefulWidget {
  final String idUser;

  const Personal({super.key, required this.idUser});

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  late final PersonalController personalController;
  final idCurrentUser = AuthServices().currentUser!.uid;

  @override
  void initState() {
    personalController = Get.put(PersonalController(idUser: widget.idUser));
    super.initState();
  }

  //hàm covert thời gian của createAt
  String _formatTimestampToNgayGio(Timestamp? timestamp) {
    if (timestamp == null) return 'Unknown';
    final date = timestamp.toDate().toLocal();
    final ngay = DateFormat('d/M/yyyy').format(date);
    final gio = DateFormat('HH:mm').format(date);
    return '$ngay at $gio';
  }

  //Show dialog de rating
  void _showDialogRating(BuildContext context) {
    DialogRatingPersonal.show(
      context,
      onSubmit: (ratingPoint) {
        personalController.handleUpdateRating(ratingPoint);
      },
    );
  }

  //Show dialog de xac nhan chat voi user
  void _showDialogChatWithUser() {
    CustomDialogGeneral.show(
      context,
      'Confirm to Start Chat',
      'Are you sure you want to start a conversation with ${personalController.userData.value!.fullName!}?',
      () {
        personalController.handleSendMessage();
      },
      numberOfButton: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    // 0 show button chat with user || 1 show floating button add new feed
    var isVisibleButton = idCurrentUser == widget.idUser ? 1 : 0;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 236, 255),
      appBar: AppBarCustomPersonal(),
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none, // cho avatar tràn ra ngoài
          children: [
            // Container trắng bên dưới
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: 50),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, -1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //Show information user
                  Obx(() {
                    var user = personalController.userData.value;
                    if (user != null) {
                      return InformationPersonal(
                        fullname: user.fullName ?? 'user123',
                        tagName: user.tagName ?? '@user123',
                        rating: personalController.rating.toString(),
                        bio: user.bio ?? '',
                        totalReview: user.totalReviews.toString(),
                      );
                    }
                    return InformationPersonal(
                      fullname: 'Loading...',
                      tagName: "Loading...",
                      rating: 'Loading...',
                      bio: 'Loading...',
                      totalReview: '',
                    );
                  }),

                  //Button chat with user
                  isVisibleButton == 0
                      ? ButtonChatWithUserPersonal(
                          idUser: 'Hihi',
                          onPressedChat: _showDialogChatWithUser,
                          onPressedRating: () {
                            _showDialogRating(context);
                          },
                        )
                      : SizedBox(),

                  SizedBox(height: 10),
                  //Product list
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Feeds',
                      style: TextStyle(
                        color: AppColors.header,
                        fontFamily: 'Roboto-Medium',
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  //Danh sach cac bai feed cua user nay
                  Expanded(
                    child: Obx(() {
                      if (personalController.productList.isEmpty) {
                        return Center(
                          child: Center(
                            child: Text(
                              'No posts available.',
                              style: TextStyle(
                                color: AppColors.header,
                                fontFamily: 'Roboto-Medium',
                                fontSize: 19,
                              ),
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: personalController.productList.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final product = personalController.productList[index];
                          return PostCardShop(
                            imageUrls: product.imageList ?? [],
                            description: product.productDescription ?? '',
                            userName:
                                personalController.userData.value?.fullName ??
                                '',
                            userAvatar:
                                personalController.userData.value?.avtURL ?? '',
                            timeAgo: _formatTimestampToNgayGio(
                              product.createdAt!,
                            ),
                            likeCount: 123,
                            userId: product.userId,
                            currentUserId: idCurrentUser,
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Avatar User
            Obx(() {
              var user = personalController.userData.value;
              if (user != null) {
                return AvtUserPersonal(imageURL: user.avtURL ?? '');
              }
              return AvtUserPersonal(imageURL: ''); // hoặc widget placeholder
            }),

            //Floating Button Add new feed
            isVisibleButton == 1 ? ButtonAddNewFeedPersonal() : SizedBox(),
          ],
        ),
      ),
    );
  }
}
