import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/models/user_model.dart';

class SaveProductController extends GetxController {
  ///-----------
  /// Variables (Danh sách các biến khai báo trong Controller)
  ///-----------

  final db = DatabaseService();

  //Danh sách User lấy từ Firebase
  var userList = <UserModel>[].obs;

  //Danh sách Save Product lấy từ Firebase
  var saveProductList = <ProductModel>[].obs;

  //Map cho User Id va User Name
  var userIdToUserName = <String, String>{}.obs;

  //Map lưu trạng thái bookmark theo từng productId
  var savedStatus = <String, bool>{}.obs;

  ///----------------------
  /// Loading Data Function (Danh sách hàm để load và xử lý dữ liệu từ Firebase)
  ///----------------------

  bool get isUserListEmpty => userList.isEmpty;
  bool get isSaveProductListEmpty => saveProductList.isEmpty;
  bool get isUserIdMapEmpty => userIdToUserName.isEmpty;
  
  @override
  void onInit() {
    super.onInit();
    loadUsersAndMap();
    loadAllSaveProductByUserId();
  }

  //Hàm load thông tin danh sách toàn bộ User
  Future<void> loadUsersAndMap() async {
    final users = await db.getAllUsers();
    userList.assignAll(users);

    // Cập nhật map ngay sau khi userList có dữ liệu
    userIdToUserName.clear();
    for (var u in users) {
      if (u.userId != null && u.fullName != null) {
        userIdToUserName[u.userId!] = u.fullName!;
      }
    }
    userIdToUserName.refresh(); // để Obx nhận thay đổi
  }

  //Hàm lấy tên user từ userId
  String getUserNameById(String? userId) {
    if (userId == null) return 'Unknown User';
    return userIdToUserName[userId] ?? 'Unknown User';
  }

  ///----------------------
  /// Hàm quản lý trạng thái toggle của Bookmark
  ///----------------------

  //Kiểm tra và lưu trạng thái sản phẩm
  Future<void> checkIfSaved(String userId, String productId) async {
    final isSavedResult = await db.isProductSaved(userId, productId);
    savedStatus[productId] = isSavedResult;
  }

  //Toggle trạng thái bookmark
  Future<void> toggleSaveProduct(String userId, String productId) async {
    final currentState = savedStatus[productId] ?? false;
    final newState = !currentState;

    if (newState) {
      //Thêm vào Firestore
      await db.addSaveProduct({
        'userId': userId,
        'productId': productId,
        'createdAt': Timestamp.now(),
      });
    } else {
      //Xóa khỏi Firestore
      final saveProductId = await db.getSaveProductById(userId, productId);
      if (saveProductId != null) {
        await db.removeSaveProduct(saveProductId);
      }
    }

    //Cập nhật trạng thái UI
    savedStatus[productId] = newState;
  }

  ///------------------------------------
  /// Hàm lấy danh sách sản phảm được lưu
  ///------------------------------------

  Future<void> loadAllSaveProductByUserId() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    print('$userId: Save product');
    final savedProducts = await db.getSavedProductsList(userId);
    saveProductList.assignAll(savedProducts);
  }
}
