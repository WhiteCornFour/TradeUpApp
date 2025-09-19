import 'package:get/get.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/sold_product_model.dart';
import 'package:tradeupapp/models/user_model.dart';

class SalesHistoryController extends GetxController {
  final db = DatabaseService();
  final idCurrentUser = AuthServices().currentUser!.uid;
  UserModel? currentUser;
  RxList<SoldProductModel> soldProducts = RxList<SoldProductModel>();

  String? buyerName;
  String? buyerAvt;

  RxBool isLoading = false.obs;

  void handleGetProduct() async {
    try {
      isLoading.value = true;
      final products = await db.getSoldProducts(idCurrentUser);
      soldProducts.assignAll(products);

      //Load data currentUser
      final data = await db.fetchDataCurrentUser();
      currentUser = UserModel.fromMap(data!);
    } catch (e) {
      // ignore: avoid_print
      print("Error handleGetProduct: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handleGetDataBuyer(String idUser) async {
    final data = await db.fetchUserModelById(idUser);
    if (data != null) {
      buyerName = data.fullName;
      buyerAvt = data.avtURL;
    }
  }

  /// Sắp xếp tăng dần theo thời gian tạo Offer (cũ -> mới)
  void sortByCreatedAtAscending() {
    soldProducts.sort((a, b) {
      final aDate = a.offer.createdAt?.toDate() ?? DateTime(0);
      final bDate = b.offer.createdAt?.toDate() ?? DateTime(0);
      return aDate.compareTo(bDate);
    });
    soldProducts.refresh();
  }

  /// Sắp xếp giảm dần theo thời gian tạo Offer (mới -> cũ)
  void sortByCreatedAtDescending() {
    soldProducts.sort((a, b) {
      final aDate = a.offer.createdAt?.toDate() ?? DateTime(0);
      final bDate = b.offer.createdAt?.toDate() ?? DateTime(0);
      return bDate.compareTo(aDate);
    });
    soldProducts.refresh();
  }
}
