import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/firebase/notification_service.dart';
import 'package:tradeupapp/screens/main_app/news/controller/news_controller.dart';
import 'package:tradeupapp/screens/main_app/profile/buy_history/purchase_history.dart';
import 'package:tradeupapp/screens/main_app/profile/view_offer/view_offer.dart';
import 'package:tradeupapp/screens/main_app/shop/personal.dart';
import 'package:tradeupapp/widgets/general/general_loading_screen.dart';
import 'package:tradeupapp/widgets/main_app_widgets/news_widgets/news_bottom_sheet_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/news_widgets/news_list_tile_widget.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _News();
}

class _News extends State<News> {
  final newsController = Get.put(NewsController());
  final ns = NotificationService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await newsController.loadNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      //1. Kiểm tra trạng thái Loading
      if (newsController.isLoading.value) {
        return const Scaffold(
          body: LoadingScreenGeneral(message: "Loading Notifications..."),
        );
      }

      //2.Tất cả điều kiện check dữ liệu
      String? errorMessage;
      if (newsController.notificationList.isEmpty) {
        errorMessage = 'Cannot load notification data!';
      }

      //Kiểm tra List đủ phần tử để tránh lỗi sublist out of range
      if (errorMessage != null) {
        return Scaffold(
          body: Center(
            child: Text(
              errorMessage,
              style: const TextStyle(
                color: AppColors.header,
                fontFamily: 'Roboto-Black',
                fontSize: 20,
              ),
            ),
          ),
        );
      }

      return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                //Notification Header
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 25,
                    top: 20,
                    bottom: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'notifications',
                        style: TextStyle(
                          fontFamily: 'Roboto-Medium',
                          color: Colors.black,
                          fontSize: 26,
                          height: 1.0,
                        ),
                      ),

                      //Badge hiển thị số lượng chưa đọc
                      Obx(() {
                        final unreadCount = newsController.notificationList
                            .where((n) => n.isRead == 0)
                            .length;

                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            const Icon(
                              Iconsax.notification,
                              color: AppColors.header,
                              size: 34,
                            ),
                            if (unreadCount > 0)
                              Positioned(
                                right: 0,
                                bottom: 12,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 18,
                                    minHeight: 18,
                                  ),
                                  child: Text(
                                    unreadCount.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),

                //List of Notification
                Obx(() {
                  if (newsController.notificationList.isEmpty) {
                    return const Center(
                      child: Text(
                        "No notifications found or has been deleted.",
                        style: TextStyle(
                          fontFamily: 'Roboto Regular',
                          fontSize: 40,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: newsController.notificationList.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final notification =
                          newsController.notificationList[index];

                      return ListTileNews(
                        notification: notification,
                        onTap: () async {
                          //Đánh dấu là đã đọc
                          await newsController.markNotificationAsRead(
                            notification,
                          );

                          switch (notification.type) {
                            case 0: //Nhan tin nhan
                              newsController.openChatFromNotification(
                                currentUserId: notification.targetUserId!,
                                idOtherUser: notification.actorUserId!,
                              );
                              break;

                            case 1: //Like san pham
                              Get.to(
                                () => Personal(
                                  idUser: notification.targetUserId!,
                                ),
                              );
                              break;

                            case 2: //Acept/Decline offer
                              Get.to(() => ViewOffer());
                              break;

                            case 3: //Nhan offer
                              Get.to(() => ViewOffer());
                              break;

                            case 4: //Check out
                              Get.to(() => BuyHistory());
                              break;

                            case 5: //He thong thong bao
                              break;

                            default:
                          }
                        },
                        onMorePressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) {
                              return NotificationBottomSheetNews(
                                imagePath: "assets/images/logo-transparent.png",
                                notification: notification,
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      );
    });
  }
}
