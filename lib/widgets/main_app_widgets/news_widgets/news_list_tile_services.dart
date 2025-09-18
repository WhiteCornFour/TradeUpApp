import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/models/notification_model.dart';

//Hàm build Notification Message
Widget buildNotificationText(NotificationModel item) {
  // Style dùng chung
  const baseStyle = TextStyle(fontSize: 14, color: Colors.black);

  if (item.type == 5) {
    // Hệ thống
    return Text(
      item.message ?? "",
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: baseStyle,
    );
  }

  // Các loại user action
  List<TextSpan> spans = [
    TextSpan(
      text: "${item.actorName ?? ''} ",
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    ),
  ];

  switch (item.type) {
    case 1: // tim bài
      // actorName + message + productName
      spans.add(TextSpan(text: (item.message ?? "liked your feed")));
      if (item.productName != null) {
        spans.add(TextSpan(text: " ${item.productName}."));
      }
      break;

    case 2: // nhận thông báo accept/decline
      final msg = item.message ?? "";

      if (msg.contains("accepted")) {
        spans.add(
          const TextSpan(
            text: "accepted",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        );
        spans.add(TextSpan(text: msg.replaceFirst("accepted", "")));
      } else if (msg.contains("declined")) {
        spans.add(
          const TextSpan(
            text: "declined",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        );
        spans.add(TextSpan(text: msg.replaceFirst("declined", "")));
      } else {
        spans.add(TextSpan(text: msg));
      }

      if (item.productName != null) {
        spans.add(TextSpan(text: " ${item.productName}."));
      }
      break;

    case 3: // nhận offer
      // actorName + message + productName
      spans.add(const TextSpan(text: "sent you an offer"));
      if (item.productName != null) {
        spans.add(TextSpan(text: " for ${item.productName}"));
      }

      if (item.offerType != null && item.offerPrice != null) {
        if (item.offerType == "raise") {
          spans.add(
            const TextSpan(
              text: " up to ",
              style: TextStyle(color: Colors.green),
            ),
          );
          spans.add(
            TextSpan(
              text: "${item.offerPrice}\$.",
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else if (item.offerType == "counter") {
          spans.add(
            const TextSpan(
              text: " down to ",
              style: TextStyle(color: Colors.red),
            ),
          );
          spans.add(
            TextSpan(
              text: "${item.offerPrice}\$.",
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
      }
      break;

    case 4: // checkout
      // actorName + "checked out" + productName
      spans.add(
        TextSpan(
          text: "${item.message ?? 'has checked out for'} ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      );

      if (item.productName != null) {
        spans.add(TextSpan(text: item.productName));
      }

      spans.add(const TextSpan(text: "."));
      break;

    default:
      spans.add(TextSpan(text: item.message ?? ""));
  }

  return Text.rich(
    TextSpan(style: baseStyle, children: spans),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  );
}

//Hàm build Icon/Màu
Widget buildNotificationIcon(int type) {
  IconData iconData;
  Color bgColor;

  switch (type) {
    case 0: // gửi tin nhắn
      iconData = Iconsax.message;
      bgColor = Colors.blue;
      break;
    case 1: // tim bài
      iconData = Iconsax.heart5;
      bgColor = Colors.red;
      break;
    case 2: // accept/decline offer
      iconData = Iconsax.receipt_item;
      bgColor = Colors.blue;
      break;
    case 3: // gửi offer
      iconData = Iconsax.archive;
      bgColor = Colors.blue;
      break;
    case 4: // checkout
      iconData = Iconsax.shopping_bag;
      bgColor = Colors.blue;
      break;
    default: // hệ thống
      iconData = Iconsax.notification;
      bgColor = Colors.blue;
  }

  return Container(
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
    child: Icon(iconData, color: Colors.white, size: 17),
  );
}

//Hàm build ảnh cho Notification
Widget buildNotificationAvatar({
  required String? actorAvatar,
  required bool isSystem, // true = hệ thống, false = user
  double size = 76,
}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: AppColors.background, width: 2),
    ),
    child: ClipOval(
      child: actorAvatar != null && actorAvatar.startsWith('http')
          ? Image.network(
              actorAvatar,
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  isSystem
                      ? 'assets/images/logo-transparent.png'
                      : 'assets/images/avatar-user.png',
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                );
              },
            )
          : Image.asset(
              isSystem
                  ? 'assets/images/logo-transparent.png'
                  : 'assets/images/avatar-user.png',
              width: size,
              height: size,
              fit: BoxFit.cover,
            ),
    ),
  );
}
