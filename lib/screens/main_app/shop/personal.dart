import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/screens/main_app/shop/controllers/personal_controller.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_product_detail.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/personal/personal_appbar_custom_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/personal/personal_avt_user_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/personal/personal_button_add_new_feed_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/personal/personal_button_chat_with_user_widget.dart';
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
                        rating: user.rating.toString(),
                        bio: user.bio ?? '',
                      );
                    }
                    return InformationPersonal(
                      fullname: 'Loading...',
                      tagName: "Loading...",
                      rating: 'Loading...',
                      bio: 'Loading...',
                    );
                  }),

                  //Button chat with user
                  isVisibleButton == 0
                      ? ButtonChatWithUserPersonal()
                      : SizedBox(),

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
                    child: ListView.builder(
                      itemCount: 10,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return PostCardShop(
                          onPressed: () => Get.to(() => ProductDetailShop()),
                          imageUrls: [
                            'assets/images/sample_images/sample2.jpg',
                            'assets/images/sample_images/sample3.jpg',
                            'assets/images/sample_images/sample4.jpg',
                          ],
                          description:
                              'JBL Flip 6 is a portable waterproof speaker with bold sound. '
                              '\nWith its racetrack-shaped driver, this speaker delivers high output and booming bass. '
                              '\nIt features PartyBoost for pairing multiple speakers and has up to 12 hours of battery life. '
                              '\nContact throug bio.',
                          userName: 'Kathe Timber',
                          userAvatar:
                              'https://media.istockphoto.com/id/1317804578/photo/one-businesswoman-headshot-smiling-at-the-camera.jpg?s=612x612&w=0&k=20&c=EqR2Lffp4tkIYzpqYh8aYIPRr-gmZliRHRxcQC5yylY=',
                          timeAgo: '1 minute ago',
                          likeCount: 123,
                        );
                      },
                    ),
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
