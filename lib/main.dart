import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradeupapp/screens/authentication/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tradeupapp/screens/main_app/index.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  checkFirebaseConnected();
  runApp(
    MaterialApp(
      title: 'SwapIT',
      debugShowCheckedModeBanner: false,
      home: AuthChecker(),
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
          return Index();
        }

        // Chưa đăng nhập hoặc chưa xác minh email
        return Login();
      },
    );
  }
}
