import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/models/notification_model.dart';
import 'package:tradeupapp/screens/main_app/news/controller/news_controller.dart';
import 'package:tradeupapp/screens/main_app/profile/report/report.dart';
import 'package:tradeupapp/widgets/main_app_widgets/news_widgets/news_list_tile_services.dart';
// file chứa buildNotificationText

class NotificationBottomSheetNews extends StatelessWidget {
  final String imagePath;
  final NotificationModel notification; // thay vì String notificationText

  const NotificationBottomSheetNews({
    super.key,
    required this.imagePath,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final newsController = Get.find<NewsController>();

    return SafeArea(
      child: SizedBox(
        height: 380,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            // Thanh kéo nhỏ trên cùng
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 10),

            // Notification info
            Column(
              children: [
                buildNotificationAvatar(
                  actorAvatar: notification.actorAvatar,
                  isSystem: notification.actorUserId == null,
                  size: 76,
                ),
                const SizedBox(height: 10),

                //Text message
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 40,
                    child: buildNotificationText(notification),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(thickness: 1),
            ),
            const SizedBox(height: 10),

            // Các lựa chọn
            _buildSheetItem(
              icon: Iconsax.trash,
              title: "Delete notification",
              onTap: () {
                Navigator.pop(context);
                newsController.markNotificationAsDelete(notification);
              },
            ),
            _buildSheetItem(
              icon: Iconsax.notification,
              title: "Mark at read",
              onTap: () {
                Navigator.pop(context);
                newsController.markNotificationAsRead(notification);
              },
            ),
            _buildSheetItem(
              icon: Iconsax.warning_2,
              title: "Report a problem",
              isDestructive: true,
              onTap: () {
                Navigator.pop(context);
                Get.to(() => Report());
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  static Widget _buildSheetItem({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isDestructive ? Colors.red : Colors.black,
                size: 22,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto-Regular',
                    fontWeight: FontWeight.w500,
                    color: isDestructive ? Colors.red : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
