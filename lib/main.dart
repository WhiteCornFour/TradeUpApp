import 'package:flutter/material.dart';
import 'package:tradeupapp/screens/authentication/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  checkFirebaseConnected();
  runApp(
    MaterialApp(
      title: 'SwapIT',
      debugShowCheckedModeBanner: false,
      home: Login(), // ← gọi Login ở đây
    ),
  );
}

void checkFirebaseConnected() async {
  bool isConnected = Firebase.apps.isNotEmpty;
  print('Firebase connected: $isConnected');
}

