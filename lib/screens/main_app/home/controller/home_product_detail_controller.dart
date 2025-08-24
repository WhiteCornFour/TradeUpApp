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
        _calculateRating(fetchedUser.rating, fetchedUser.totalReviews);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void _calculateRating(double? totalRating, int? totalReviews) {
    if (totalReviews != null && totalReviews > 0 && totalRating != null) {
      double avg = totalRating / totalReviews;
      rating.value = double.parse(avg.toStringAsFixed(1));
    } else {
      rating.value = 0.0;
    }
  }
}
