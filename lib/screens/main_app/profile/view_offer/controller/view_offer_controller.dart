import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/firebase/notification_service.dart';
import 'package:tradeupapp/models/notification_model.dart';
import 'package:tradeupapp/models/offer_model.dart';

class ViewOfferController extends GetxController {
  ///-----------
  /// Variables (Danh sách các biến khai báo trong Controller)
  ///-----------

  //Gọi Service từ database
  final db = DatabaseService();

  //Gọi Service từ NotificationService
  final ns = NotificationService();

  //Danh sách Offer người dùng nhận được lấy từ Firebase
  var receivedList = <OfferModel>[].obs;

  //Danh sách Offer người dùng gửi đi lấy từ Firebase
  var sendList = <OfferModel>[].obs;

  //Trạng thái Loading cho trang
  var isLoading = true.obs;

  //Hàm load offers của người dùng hiện taị gửi đi và nhận được
  Future<void> loadOffers() async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    try {
      isLoading(true);
      //Offer nhận
      final received = await db.getUserReceivedOfferList(currentUserId);
      for (var offer in received) {
        //Lấy product từ productId
        final product = await db.getProductById(offer.productId!);
        offer.product = product;

        final senderInfo = await db.getUserNameFromUserId(offer.senderId!);
        offer.senderName = senderInfo;
      }
      receivedList.assignAll(received);

      //Offer đã gửi
      final sent = await db.getUserSentOfferList(currentUserId);
      for (var offer in sent) {
        final product = await db.getProductById(offer.productId!);
        offer.product = product;

        final receiverInfo = await db.getUserNameFromUserId(offer.receiverId!);
        offer.receiverName = receiverInfo;
      }
      sendList.assignAll(sent);
    } catch (e) {
      print('Lỗi load offer: $e');
    } finally {
      isLoading(false);
    }
  }

  //Accept Offer
  Future<void> acceptOffer(OfferModel offer) async {
    try {
      isLoading(true);

      //1. Lấy toàn bộ offers cùng productId
      final allOffers = await db.getOffersByProductId(offer.productId!);

      //2. Group offers theo userId
      Map<String, List<OfferModel>> grouped = {};
      for (var o in allOffers) {
        grouped.putIfAbsent(o.senderId!, () => []);
        grouped[o.senderId!]!.add(o);
      }

      //3 Lấy thêm thông tin để hiển thị thông báo rõ ràng
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      final actorDoc = await db.fetchUserModelById(currentUserId);
      final actorName = actorDoc?.fullName ?? 'Someone';

      final productDoc = await db.getProductById(offer.productId!);
      final productName = productDoc?.productName ?? '';

      //4. Lặp từng user
      for (var entry in grouped.entries) {
        final userId = entry.key;
        final userOffers = entry.value;

        if (userId == offer.senderId) {
          //4.1.1 Đây là người được accept cungx như offer của người đó đc accept
          for (var o in userOffers) {
            if (o.offerId == offer.offerId) {
              await db.acceptOffer(o.offerId!);
            } else {
              //Decline các offer khác của cùng người đó
              await db.declineOffer(o.offerId!);
            }
          }

          //4.1.2 Tạo object Notification và lưu vào Firestore
          final notification = NotificationModel(
            targetUserId: userId,
            actorUserId: FirebaseAuth.instance.currentUser!.uid,
            productId: offer.productId,
            offerId: offer.offerId,
            type: 2,
            message: "accepted your offer for",
            isRead: 0,
          );
          await db.addNotification(notification);

          //4.1.3 Lấy token của người nhận
          final userDoc = await FirebaseFirestore.instance
              .collection("users")
              .doc(userId)
              .get();
          final tokens = List<String>.from(userDoc.data()?["fcmTokens"] ?? []);

          //4.1.4 Xét token và gửi cho người có token tương ứng
          for (final token in tokens) {
            await ns.sendPushNotification(
              token: token,
              title: "Offer Update",
              body: "$actorName accepted your offer for $productName",
            );
          }
        } else {
          //4.2.1 Những user còn lại thì decline toàn bộ offers của họ
          for (var o in userOffers) {
            await db.declineOffer(o.offerId!);
          }

          //4.2.2 Lấy thêm thông tin để hiển thị thông báo rõ ràng
          final actorDoc = await db.fetchUserModelById(
            FirebaseAuth.instance.currentUser!.uid,
          );
          final actorName = actorDoc?.fullName ?? 'Someone';

          final productDoc = await db.getProductById(offer.productId!);
          final productName = productDoc?.productName ?? '';

          String declineMessage; //Bien hien thi loi nhan bi tu choi
          //4.2.4 Nếu họ có nhiều hơn 1 offer
          if (userOffers.length > 1) {
            declineMessage =
                "$actorName declined ${userOffers.length} of your offers for $productName";
            await db.addNotification(
              NotificationModel(
                targetUserId: userId,
                actorUserId: FirebaseAuth.instance.currentUser!.uid,
                productId: offer.productId,
                type: 2,
                message: "declined ${userOffers.length} of your offers for",
                isRead: 1,
              ),
            );
          } else {
            //4.2.6 Chỉ 1 offer bị decline
            declineMessage = "$actorName declined your offer for $productName";
            await db.addNotification(
              NotificationModel(
                targetUserId: userId,
                actorUserId: FirebaseAuth.instance.currentUser!.uid,
                productId: offer.productId,
                offerId: userOffers.first.offerId,
                type: 2, // decline
                message: "declined your offer for",
                isRead: 1,
              ),
            );
          }

          //5: Nếu những offer khác có tồn tại thì gửi push notification cho tất cả những người bị từ chối
          final userDoc = await FirebaseFirestore.instance
              .collection("users")
              .doc(userId)
              .get();
          final tokens = List<String>.from(userDoc.data()?["fcmTokens"] ?? []);
          for (final token in tokens) {
            await ns.sendPushNotification(
              token: token,
              title: "Offer Update",
              body: declineMessage,
            );
          }
        }
      }

      //6: Reload lại danh sách
      await loadOffers();
    } catch (e) {
      print("Lỗi acceptOffer: $e");
    } finally {
      isLoading(false);
    }
  }

  //Decline Offer
  Future<void> declineOffer(OfferModel offer) async {
    try {
      isLoading(true);

      //1. Decline offer trong DB
      await db.declineOffer(offer.offerId!);

      //2. Lấy thêm thông tin để hiển thị rõ ràng
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      final actorDoc = await db.fetchUserModelById(currentUserId);
      final actorName = actorDoc?.fullName ?? 'Someone';

      final productDoc = await db.getProductById(offer.productId!);
      final productName = productDoc?.productName ?? '';

      //3. Thêm Notification vào Firestore
      final notification = NotificationModel(
        targetUserId: offer.senderId,
        actorUserId: currentUserId,
        productId: offer.productId,
        offerId: offer.offerId,
        type: 2,
        message: "declined your offer for",
        isRead: 0,
      );
      await db.addNotification(notification);

      //4. Gửi Push Notification qua FCM
      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(offer.senderId)
          .get();
      final tokens = List<String>.from(userDoc.data()?["fcmTokens"] ?? []);

      for (final token in tokens) {
        await ns.sendPushNotification(
          token: token,
          title: "Offer Update",
          body: "$actorName declined your offer for $productName",
        );
      }

      //5. Reload lại danh sách
      await loadOffers();
    } catch (e) {
      print("Lỗi declineOffer: $e");
    } finally {
      isLoading(false);
    }
  }
}
