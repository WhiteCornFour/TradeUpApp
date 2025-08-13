import 'dart:async';

import 'package:get/get.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/models/user_model.dart';

class ShopController extends GetxController {
  RxList<ProductModel> feedList = <ProductModel>[].obs;
  RxMap<String, UserModal> usersCache = <String, UserModal>{}.obs;
  final db = DatabaseService();
  StreamSubscription? _subscription;

  var isLoadingUsers = false.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchInitialProducts();
  }

  void _fetchInitialProducts() {
    _subscription?.cancel();
    _subscription = db.getProductsRealTime().listen((products) async {
      isLoadingUsers.value = true;
      feedList.assignAll(products);
      await _fetchUsersForFeeds(products);
      isLoadingUsers.value = false;
    });
  }

  Future<void> _fetchUsersForFeeds(List<ProductModel> products) async {
    for (var product in products) {
      if (product.userId != null && !usersCache.containsKey(product.userId)) {
        final user = await db.fetchUserModelById(product.userId!);
        if (user != null) {
          usersCache[product.userId!] = user;
        }
      }
    }
  }

  void handleFilterNewest() {
    // Mới nhất trước
    feedList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
  }

  void handleFilterOldest() {
    // Cũ nhất trước
    feedList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
