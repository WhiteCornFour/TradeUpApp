import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:tradeupapp/main.dart';

class NotificationService {
  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  //Lưu token duy nhất của người dùng lên hệ thống
  Future<void> saveTokenToUser(String token) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final userRef = FirebaseFirestore.instance.collection("users").doc(uid);

    //Xóa token này khỏi tất cả user khác (đảm bảo token duy nhất)
    final allUsers = await FirebaseFirestore.instance.collection("users").get();
    for (var doc in allUsers.docs) {
      if (doc.id != uid &&
          (doc.data()['fcmTokens'] as List?)?.contains(token) == true) {
        await doc.reference.update({
          "fcmTokens": FieldValue.arrayRemove([token]),
        });
      }
    }

    //Thêm token cho user hiện tại
    await userRef.set({
      "fcmTokens": FieldValue.arrayUnion([token]),
    }, SetOptions(merge: true));
  }

  //Xóa token khi người dùng log out
  Future<void> removeTokenFromUser() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final token = await FirebaseMessaging.instance.getToken();
    if (token == null) return;

    await FirebaseFirestore.instance.collection("users").doc(uid).update({
      "fcmTokens": FieldValue.arrayRemove([token]),
    });
  }

  //Lắng nghe khi token refresh
  Future<void> setupTokenListener() async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await saveTokenToUser(token);
    }

    // Lắng nghe token refresh (Firebase có thể đổi token bất kỳ lúc nào)
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      await saveTokenToUser(newToken);
    });
  }

  Future<void> sendPushNotification({
    required String token,
    required String title,
    required String body,
  }) async {
    print("Token gửi lên server: $token");
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/sendNotification'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "token": token,
        "notification": {"title": title, "body": body},
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "screen": "offers",
        },
      }),
    );

    print("Server status: ${response.statusCode}");
    print("Server response: ${response.body}");
  }

  // Hiển thị notification ngay trên app (local)
  static Future<void> showLocalNotification({
    required String title,
    required String body,
    String? imageUrl,
    Map<String, dynamic>? payload,
  }) async {
    BigPictureStyleInformation? style;

    if (imageUrl != null) {
      try {
        final response = await http.get(Uri.parse(imageUrl));
        if (response.statusCode == 200) {
          final bytes = response.bodyBytes;
          final bigPicture = ByteArrayAndroidBitmap(bytes);
          style = BigPictureStyleInformation(
            bigPicture,
            contentTitle: title,
            summaryText: body,
          );
        }
      } catch (e) {
        print("Error loading image for notification: $e");
      }
    }

    final androidDetails = AndroidNotificationDetails(
      'local_channel',
      'Local Notifications',
      channelDescription: 'Channel for local notifications',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: style,
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: payload != null ? json.encode(payload) : null,
    );
  }

  //TEST
  static Future<void> testNotification({required String token}) async {
    final imageUrl =
        "https://res.cloudinary.com/dhmzkwjlf/image/upload/v1757182036/ajewrarytpyrh2kwh3ib.jpg";
    try {
      // print("Token gửi lên server: $token");
      final response = await http.post(
        Uri.parse(
          'http://10.0.2.2:3000/sendNotification',
        ), // emulator dùng 10.0.2.2, thiết bị thật dùng IP PC hoặc domain
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "token": token,
          "title": "Xin chào!",
          "body": "Đây là notification test có hình ảnh",
          "image": imageUrl,
        }),
      );

      print("Server response: ${response.body}");
    } catch (e) {
      print("Error sending notification: $e");
    }
  }
}
