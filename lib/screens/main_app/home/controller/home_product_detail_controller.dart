import 'package:get/get.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/user_model.dart';

class ProductDetailController extends GetxController {
  /// ---------
  /// Variables
  /// ---------

  //Ảnh đang chọn
  var selectedImage = ''.obs;

  void setImage(String url) {
    selectedImage.value = url;
  }

  //Rating sau khi tinh
  RxDouble rating = 0.0.obs;

  //Lay user model
  var user = Rxn<UserModel>();

  final db = DatabaseService();

  //Hàm fetch User theo id
  Future<void> loadUserDataById(String userId) async {
    final fetchedUser = await db.fetchUserModelById(userId);
    user.value = fetchedUser;
    _calculatorRating(); 
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
