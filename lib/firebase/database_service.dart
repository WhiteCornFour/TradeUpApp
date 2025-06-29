import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addUser(
    String yourName,
    String passWord,
    String email,
    String phoneNumber, {
    int role = 1,
  }) async {
    await FirebaseFirestore.instance.collection('users').add({
      'yourname': yourName,
      'passWord': passWord,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
    });
  }
}
