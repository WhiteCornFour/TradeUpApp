import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/models/user_model.dart';
import 'package:tradeupapp/screens/main_app/chat/message.dart';
import 'package:tradeupapp/widgets/general/general_custom_dialog.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';

class ShopController extends GetxController {
  ///-----------
  /// Variables (Danh sách các biến khai báo trong Controller)
  ///-----------
  
  RxList<ProductModel> feedList = <ProductModel>[].obs;
  RxMap<String, UserModel> usersCache = <String, UserModel>{}.obs;
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

      //Lọc sản phẩm của user đang đăng nhập
      final currentUserId = AuthServices().currentUser!.uid;

      final filteredProducts = products
          .where((p) => p.userId != currentUserId)
          .toList();

      feedList.assignAll(filteredProducts);
      await _fetchUsersForFeeds(filteredProducts);

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

  // Kiểm tra phòng chat trước khi hỏi
  Future<void> handleCheckOrStartChat(
    String idUser,
    BuildContext context,
    String userName,
  ) async {
    final idCurrentUser = AuthServices().currentUser!.uid;

    String? result = await db.checkChatRoomStatus(idCurrentUser, idUser);

    if (result == "Block") {
      SnackbarHelperGeneral.showCustomSnackBar(
        'This chat room has been blocked and you cannot send messages.',
        backgroundColor: Colors.red,
        seconds: 2,
      );
      return;
    }

    if (result != null) {
      //Đã có phòng chat → vào thẳng
      print('Chat room exists with ID: $result');
      Get.to(Message(idOtherUser: idUser, idChatRoom: result));
    } else {
      //Chưa có phòng → hiện dialog xác nhận
      CustomDialogGeneral.show(
        context,
        'Confirm to Start Chat',
        'Are you sure you want to start a conversation with $userName?',
        () async {
          String? newId = await db.createNewChatRoom(idCurrentUser, idUser);
          if (newId != null) {
            print('Created new chat room with ID: $newId');
            Get.to(Message(idOtherUser: idUser, idChatRoom: newId));
          }
        },
        numberOfButton: 2,
      );
    }
  }

  //Fetch data tagName
  Future<String> fetchTagNameByUserId(String userId) async {
    try {
      final tagName = await db.getTagNameFromUserId(userId);
      return tagName;
    } catch (e) {
      print('Lỗi khi lấy tagName: $e');
      return 'Unknown';
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

  //Hàm hiển thị Bottom sheet: Share với các người dùng user đã chat với
  void showSharePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Thanh kéo trên cùng
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                //Chụp ảnh bằng camera
                ListTile(
                  leading: const Icon(Iconsax.camera, color: AppColors.header),
                  title: const Text(
                    'Take a photo with Camera',
                    style: TextStyle(
                      fontFamily: 'Roboto-Medium',
                      fontSize: 15,
                      color: AppColors.header,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),

                const Divider(height: 1),

                //Nút hủy
                ListTile(
                  leading: const Icon(
                    Iconsax.close_circle,
                    color: Colors.redAccent,
                  ),
                  title: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'Roboto-Medium',
                      fontSize: 15,
                      color: Colors.redAccent,
                    ),
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
