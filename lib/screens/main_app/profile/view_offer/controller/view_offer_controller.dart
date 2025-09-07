import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/offer_model.dart';

class ViewOfferController extends GetxController {
  ///-----------
  /// Variables (Danh sách các biến khai báo trong Controller)
  ///-----------

  //Gọi Service từ database
  final db = DatabaseService();

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
      // 1. Lấy toàn bộ offers cùng productId
      final allOffers = await db.getOffersByProductId(offer.productId!);

      // 2. Chuyển các offer khác (trừ cái vừa accept) sang status = 2
      for (var other in allOffers) {
        if (other.offerId != offer.offerId) {
          await db.declineOffer(other.offerId!);
        }
      }

      // 3. Cập nhật offer được accept
      await db.acceptOffer(offer.offerId!);

      // 4. Reload lại danh sách
      await loadOffers();
    } catch (e) {
      print("Lỗi acceptOffer: $e");
    } finally {
      isLoading(false);
    }
  }

  //Decline Offer
  Future<void> declineOffer(String offerId) async {
    try {
      isLoading(true);
      await db.declineOffer(offerId);
      await loadOffers();
    } catch (e) {
      print("Lỗi declineOffer: $e");
    } finally {
      isLoading(false);
    }
  }
}
