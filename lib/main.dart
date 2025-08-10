import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeupapp/screens/authentication/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tradeupapp/screens/authentication/on_boarding.dart';
import 'package:tradeupapp/screens/main_app/chat/message.dart';
import 'package:tradeupapp/screens/main_app/index.dart';
import 'package:tradeupapp/screens/general/general_category_products.dart';
import 'package:tradeupapp/screens/main_app/shop/personal.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  checkFirebaseConnected();

  //Check if user have already seen the OnBoarding screeen yet by using SharedPreference
  final prefs = await SharedPreferences.getInstance();
  final seenOnBoarding = prefs.getBool('seenOnBoarding') ?? false;

  runApp(
    GetMaterialApp(
      title: 'SwapIT',
      //If seenOnBoarding was false, go to OnBoarding, else go to AuthChecker
      debugShowCheckedModeBanner: false,
      home: seenOnBoarding ? const AuthChecker() : const OnBoarding(),
      //Get to category page
      getPages: [
        GetPage(
          name: '/category/:categoryName',
          page: () => CategoryProductsGeneral(),
        ),
        GetPage(
          name: '/login', // ➤ Thêm dòng này
          page: () => Login(), // ➤ Thay bằng widget màn hình login của bạn
        ),
      ],
    ),
  );
}

void checkFirebaseConnected() async {
  bool isConnected = Firebase.apps.isNotEmpty;
  print('Firebase connected: $isConnected');
}

//Ghi nhớ đăng nhập người dùng
class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Đang chờ dữ liệu
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Nếu đã đăng nhập và đã xác minh email
        if (snapshot.hasData && snapshot.data!.emailVerified) {
          return MainAppIndex();
        }

        // Chưa đăng nhập hoặc chưa xác minh email
        return Login();
      },
    );
  }
}
