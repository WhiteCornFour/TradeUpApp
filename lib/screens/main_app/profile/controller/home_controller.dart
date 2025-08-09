import 'package:get/get.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/user_model.dart';

class HomeController extends GetxController {
  var user = Rxn<UserModal>();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    () => loadUser();
  }

  Future<void> loadUser() async {
    isLoading.value = true;
    final userData = await DatabaseService().fetchDataCurrentUser();
    if (userData != null) {
      user.value = UserModal.fromMap(userData);
    }
    isLoading.value = false;
  }
}
