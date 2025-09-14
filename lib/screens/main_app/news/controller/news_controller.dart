import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/notification_model.dart';
import 'package:tradeupapp/screens/main_app/chat/message.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';

class NewsController extends GetxController {
  ///-----------
  /// Variables (Danh sách các biến khai báo trong Controller)
  ///-----------

  //Gọi Service từ database
  final db = DatabaseService();

  //Danh sách Notification người dùng nhận được lấy từ Firebase
  var notificationList = <NotificationModel>[].obs;

  //Trạng thái Loading cho trang
  var isLoading = true.obs;

  //Load notifications của user
  Future<void> loadNotifications() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      isLoading.value = true;

      //Lấy danh sách notification gốc từ DB
      final list = await db.getUserNotifications(userId);

      //Dùng Future.wait để fetch user info song song
      final updatedList = await Future.wait(
        list.map((noti) async {
          if (noti.actorUserId != null && noti.actorUserId!.isNotEmpty) {
            final actor = await db.fetchUserModelById(noti.actorUserId!);
            if (actor != null) {
              noti.actorName = actor.fullName;
              noti.actorAvatar = actor.avtURL;
            }
          }

          //Lấy thông tin sản phẩm
          if (noti.productId != null && noti.productId!.isNotEmpty) {
            final product = await db.getProductById(noti.productId!);
            if (product != null) {
              noti.productName = product.productName;
            }
          }

          //Lấy thông tin offer
          if (noti.offerId != null && noti.offerId!.isNotEmpty) {
            final offer = await db.getOfferById(noti.offerId!);
            if (offer != null) {
              noti.offerType = offer.type;
              noti.offerPrice = offer.price;
            }
          }

          return noti;
        }),
      );

      notificationList.assignAll(updatedList);
    } catch (e) {
      print("Error loadNotifications: $e");
    } finally {
      isLoading.value = false;
    }
  }

  //Hàm mở chat khi click vào thông báo type = 0
  Future<void> openChatFromNotification({
    required String currentUserId,
    required String idOtherUser,
  }) async {
    try {
      final idChatRoom = await db.checkChatRoomStatus(
        currentUserId,
        idOtherUser,
      );

      if (idChatRoom != null && idChatRoom != "Block") {
        //Có phòng chat sẵn thì đi tới Message
        Get.to(() => Message(idOtherUser: idOtherUser, idChatRoom: idChatRoom));
      } else if (idChatRoom == "Block") {
        //Nếu bị block
        SnackbarHelperGeneral.showCustomSnackBar(
          "Sorry but you have been block from this user.",
        );
      } else {
        //Nếu chưa có phòng tạo mới
        final newRoomId = await db.createNewChatRoom(
          currentUserId,
          idOtherUser,
        );
        if (newRoomId != null) {
          Get.to(
            () => Message(idOtherUser: idOtherUser, idChatRoom: newRoomId),
          );
        }
      }
    } catch (e) {
      print("Error openChatFromNotification: $e");
      SnackbarHelperGeneral.showCustomSnackBar(
        "Can not open chat room, please try again later.",
      );
    }
  }

  // Mark as read
  Future<void> markNotificationAsRead(NotificationModel notification) async {
    try {
      if (notification.notificationId == null) return;

      await db.updateNotificationIsRead(notification.notificationId!);

      final index = notificationList.indexWhere(
        (n) => n.notificationId == notification.notificationId,
      );
      if (index != -1) {
        notificationList[index].isRead = 1;
        notificationList.refresh();
      }
    } catch (e) {
      print("Error markNotificationAsRead: $e");
    }
  }

  // Mark as delete (isRead = 2)
  Future<void> markNotificationAsDelete(NotificationModel notification) async {
    try {
      if (notification.notificationId == null) return;

      await db.updateNotificationAsDelete(notification.notificationId!);

      //Xóa trực tiếp khỏi danh sách local để UI cập nhật ngay
      notificationList.removeWhere(
        (n) => n.notificationId == notification.notificationId,
      );
      notificationList.refresh();
    } catch (e) {
      print("Error markNotificationAsDelete: $e");
    }
  }
}
