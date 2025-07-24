import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  Future<void> addUser({
    required String yourName,
    required String passWord,
    required String email,
    required String phoneNumber,
    int role = 1,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("Người dùng chưa đăng nhập");
      return;
    }

    final uid = user.uid;
    final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

    // Kiểm tra xem document đã tồn tại chưa
    final snapshot = await userDoc.get();
    if (snapshot.exists) {
      print("Người dùng đã tồn tại trong Firestore.");
      return;
    }

    // Nếu chưa, thêm người dùng
    await userDoc.set({
      'yourname': yourName,
      'passWord': passWord,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
    });

    print("Thêm người dùng thành công.");
  }

  Future<Map<String, dynamic>?> loadCurrentUser() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('Chua dang nhap');
        return null;
      }
      print(currentUser.uid);
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      if (docSnapshot.exists) {
        return docSnapshot.data();
      } else {
        print('Khong tim thay thong tin cua nguoi dung');
        return null;
      }
    } catch (e) {
      print('Loi khi load user: $e');
      return null;
    }
  }
}
