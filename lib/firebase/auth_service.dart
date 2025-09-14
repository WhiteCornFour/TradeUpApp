import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tradeupapp/firebase/notification_service.dart';

ValueNotifier<AuthServices> authServices = ValueNotifier(AuthServices());

class AuthServices {
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final NotificationService notificationService = NotificationService();

  User? get currentUser => firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await credential.user?.sendEmailVerification();
    return credential;
  }

  Future<bool> checkEmailExistsInFirestore(String email) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return result.docs.isNotEmpty; // true = đã tồn tại
  }

  Future<void> forgotPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //Hàm sign in
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //Sau khi login thành công thì set up token
      await NotificationService().setupTokenListener();

      return credential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<void> signOut() async {
    await NotificationService().removeTokenFromUser();
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }

  Future<void> resetPassword({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateUserName({required String username}) async {
    await currentUser!.updateDisplayName(username);
  }

  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.delete();
    await firebaseAuth.signOut();
  }

  Future<void> resetPasswordFromCurrentPassword({
    required String currentPassword,
    required String newPassword,
    required String email,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(newPassword);
  }

  Future<UserCredential> signInWithGoogle() async {
    //Lấy token service của Google
    await googleSignIn.initialize(
      serverClientId:
          '1050847711151-fn9of0cd54rd10ogenf0e26nnk3hccc3.apps.googleusercontent.com',
    );

    //Thoát tài khoản cũ nếu có
    await googleSignIn.signOut();

    //Mở giao diện đăng nhập Google
    final GoogleSignInAccount account = await googleSignIn.authenticate(
      scopeHint: ['email'],
    );

    //Lấy thông tin xác thực
    final gAuth = account.authentication;

    final credential = GoogleAuthProvider.credential(idToken: gAuth.idToken);

    final userCredential = await firebaseAuth.signInWithCredential(credential);

    //Sau khi login thành công, lưu FCM tokenSau khi login thành công
    await NotificationService().setupTokenListener();
    return userCredential;
  }

  //Gửi 1 email để người dùng reset password
  Future<void> changePassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
