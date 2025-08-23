import 'package:get/get.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/user_model.dart';

class ProductDetailController extends GetxController {
  /// ---------
  /// Variables
  /// ---------

  //Trạng thái Loading cho trang
  var isLoading = false.obs;

  //Ảnh đang chọn
  var selectedImage = ''.obs;

  void setImage(String url) {
    selectedImage.value = url;
  }

  //Điểm rating trung bình
  RxDouble rating = 0.0.obs;

  //Tổng số review
  RxInt ratingCount = 0.obs;

  //Thông tin user (chủ shop)
  var user = Rxn<UserModel>();

  final db = DatabaseService();

  //Hàm fetch User theo id
  Future<void> loadUserDataById(String userId) async {
    isLoading.value = true;
    try {
      final fetchedUser = await db.fetchUserModelById(userId);
      if (fetchedUser != null) {
        user.value = fetchedUser;

        // Cập nhật tổng số review
        ratingCount.value = fetchedUser.totalReviews ?? 0;

        // Cập nhật điểm trung bình
        _calculatorRating();
      }
    } finally {
      isLoading.value = false;
    }
  }

  void _calculatorRating() {
    if (user.value != null) {
      final totalReviews = (user.value!.totalReviews ?? 0).toDouble();
      final totalRating = (user.value!.rating ?? 0).toDouble();

      if (totalReviews > 0) {
        double avg = totalRating / totalReviews;
        rating.value = double.parse(
          avg.toStringAsFixed(1),
        ); // Làm tròn 1 chữ số
      } else {
        rating.value = 0.0;
      }
    }
  }
}
