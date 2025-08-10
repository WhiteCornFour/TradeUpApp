import 'package:get/get.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/user_model.dart';

class PersonalController extends GetxController {
  final String idUser;
  PersonalController({required this.idUser});

  Rxn<UserModal> userData = Rxn<UserModal>();

  //Khai bao bien db
  final db = DatabaseService();

  @override
  void onInit() {
    super.onInit();
    _fetchUserDataById();
  }

  void _fetchUserDataById() async {
    userData.value = await db.fetchUserModelById(idUser);
  }
}
