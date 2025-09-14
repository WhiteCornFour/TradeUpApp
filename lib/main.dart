import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tradeupapp/firebase/notification_service.dart';
import 'package:tradeupapp/widgets/general/general_loading_screen.dart';
import 'firebase_options.dart';
import 'package:tradeupapp/screens/authentication/login.dart';
import 'package:tradeupapp/screens/authentication/on_boarding.dart';
import 'package:tradeupapp/screens/main_app/index.dart';
import 'package:tradeupapp/screens/general/general_category_products.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//Global notifications plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Init Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  _checkFirebaseConnected();

  //Init local notification
  await NotificationService.init();

  //Xin quyền thông báo Android 13+
  await Permission.notification.request();

  //Init Local Notifications (Hiển thị thông báo của điện thoại)
  const AndroidInitializationSettings initSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initSettings = InitializationSettings(
    android: initSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      final payload = response.payload;
      if (payload != null && payload.isNotEmpty) {
        _handleMessageFromPayload(payload);
      }
    },
  );

  //Init Firebase Cloud Messsaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //Yêu cầu quyền notification (iOS)
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  //Kiểm tra xem có nhận được quyền k (iOS)
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    // ignore: avoid_print
    print('User granted permission');
  } else {
    // ignore: avoid_print
    print('User declined or has not accepted permission');
  }

  //Foreground: Listener khi nhận FCM message (Khi đang xài app)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('Foreground message received: ${message.notification?.title}');

    //prepare payload data from message.data (if any)
    Map<String, dynamic>? payloadData = message.data.isNotEmpty
        ? Map<String, dynamic>.from(message.data)
        : null;

    if (message.notification != null) {
      await NotificationService.showLocalNotification(
        title: message.notification!.title ?? 'No title',
        body: message.notification!.body ?? 'No body',
        imageUrl: message.notification!.android?.imageUrl,
        payload: payloadData,
      );
    }
  });

  //Background: app đang chạy nền
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('onMessageOpenedApp: ${message.data}');
    _handleMessage(message); // handle navigation
  });

  //Terminated: app bị kill, mở từ notification
  RemoteMessage? initialMessage = await FirebaseMessaging.instance
      .getInitialMessage();
  if (initialMessage != null) {
    print('getInitialMessage: ${initialMessage.data}');
    _handleMessage(initialMessage);
  }

  //Check if user has seen OnBoarding
  final prefs = await SharedPreferences.getInstance();
  final seenOnBoarding = prefs.getBool('seenOnBoarding') ?? false;

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    // Load environment variables from the .env file
    await dotenv.load(fileName: ".env");
  });

  runApp(
    GetMaterialApp(
      title: 'SwapIT',
      debugShowCheckedModeBanner: false,
      home: seenOnBoarding ? const AuthChecker() : const OnBoarding(),
      getPages: [
        GetPage(
          name: '/category/:categoryName',
          page: () => CategoryProductsGeneral(),
        ),
        GetPage(name: '/login', page: () => Login()),
      ],
    ),
  );
}

///-----------------------------------
/// Main dart data function management
///-----------------------------------

// Handle RemoteMessage (from FCM) navigation
void _handleMessage(RemoteMessage message) {
  final data = message.data;
  if (data['screen'] == 'offers') {
    Get.to(() => MainAppIndex());
  } else {
    // handle other screens if needed
    print('Unhandled message data: $data');
  }
}

// Handle payload string (from local notification)
void _handleMessageFromPayload(String payload) {
  try {
    final Map<String, dynamic> data =
        json.decode(payload) as Map<String, dynamic>;
    if (data['screen'] == 'offers') {
      Get.to(() => MainAppIndex());
    } else {
      print('Payload has no screen key: $data');
    }
  } catch (e) {
    print('Failed to parse notification payload: $e');
  }
}

//Kiểm tra xem đã kết nối Firebase chưa
void _checkFirebaseConnected() {
  final isConnected = Firebase.apps.isNotEmpty;
  //ignore: avoid_print
  print('Firebase connected: $isConnected');
}

//Kiểm tra trạng thái đăng nhập
class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: LoadingScreenGeneral()));
        }

        if (snapshot.hasData && snapshot.data!.emailVerified) {
          //Set up token
          NotificationService().setupTokenListener();
          return const MainAppIndex();
        }

        return const Login();
      },
    );
  }
}
