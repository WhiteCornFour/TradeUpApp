import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:tradeupapp/models/notification_model.dart';
import 'package:tradeupapp/widgets/main_app_widgets/news_widgets/news_list_tile_services.dart';

class ListTileNews extends StatelessWidget {
  const ListTileNews({
    super.key,
    required this.notification,
    required this.onMorePressed,
    required this.onTap,
  });

  final NotificationModel notification;
  final VoidCallback? onMorePressed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    //Xử lý thời gian: Timestamp -> DateTime -> String
    String formattedDate = '';
    if (notification.createdAt != null) {
      final DateTime dateTime = notification.createdAt!.toDate();
      formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: notification.isRead == 0 ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar + icon nhỏ
            Stack(
              clipBehavior: Clip.none,
              children: [
                buildNotificationAvatar(
                  actorAvatar: notification.actorAvatar,
                  isSystem: notification.actorUserId == null,
                  size: 76,
                ),
                Positioned(
                  bottom: -2,
                  right: -5,
                  child: buildNotificationIcon(notification.type ?? 0),
                ),
              ],
            ),

            const SizedBox(width: 12),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildNotificationText(notification),
                  const SizedBox(height: 4),
                  Text(
                    formattedDate,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Nút more
            IconButton(
              icon: const Icon(Iconsax.more, size: 20),
              onPressed: onMorePressed,
            ),
          ],
        ),
      ),
    );
  }
}
