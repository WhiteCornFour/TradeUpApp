import 'package:get/get.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/purchase_history_modal.dart';

class PurchaseHistoryController extends GetxController {
  final db = DatabaseService();

  RxBool isLoading = false.obs;

  final idCurrentUser = AuthServices().currentUser!.uid;

  RxList<PurchaseHistoryModal> purchaseHistorys =
      RxList<PurchaseHistoryModal>();

  void handleGetPurchaseProducts() async {
    try {
      isLoading.value = true;
      final data = await db.getPurchaseProducts(idCurrentUser);
      if (data != null) {
        purchaseHistorys.value = data;
      }
    } catch (e) {
      printError(info: "Error handleGetBoughtProducts: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Sắp xếp tăng dần theo thời gian tạo Offer (cũ -> mới)
  void sortByCreatedAtAscending() {
    purchaseHistorys.sort((a, b) {
      final aDate = a.offerDetailsModel.createdAt?.toDate() ?? DateTime(0);
      final bDate = b.offerDetailsModel.createdAt?.toDate() ?? DateTime(0);
      return aDate.compareTo(bDate);
    });
    purchaseHistorys.refresh();
  }

  /// Sắp xếp giảm dần theo thời gian tạo Offer (mới -> cũ)
  void sortByCreatedAtDescending() {
    purchaseHistorys.sort((a, b) {
      final aDate = a.offerDetailsModel.createdAt?.toDate() ?? DateTime(0);
      final bDate = b.offerDetailsModel.createdAt?.toDate() ?? DateTime(0);
      return bDate.compareTo(aDate);
    });
    purchaseHistorys.refresh();
  }
}
