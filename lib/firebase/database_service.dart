import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  
  Future<void> addUser(
    String yourName,
    String userName,
    String passWord,
    String email,
    String phoneNumber,
  ) async {
    await FirebaseFirestore.instance.collection('users').add({
      'yourname': yourName,
      'userName': userName,
      'passWord': passWord,
      'email': email,
      'phoneNumber': phoneNumber,
    });
  }
}
