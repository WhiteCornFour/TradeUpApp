import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tradeupapp/models/user_model.dart';

class DatabaseService {
  //RegisterController: Ham them 1 user vao firebase khi nguoi dung dang ky thanh cong
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

  //Load thong tin user hien tai
  Future<Map<String, dynamic>?> fetchDataCurrentUser() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('Chua dang nhap');
        return null;
      }
      //print(currentUser.uid);
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

  //ProfileController: Hàm cập nhật role của người dùng sang bussiness khi truyền vào idUser
  Future<void> updateUserRoleDB(String idUser, int role) async {
    await FirebaseFirestore.instance.collection('users').doc(idUser).update({
      'role': role,
    });
  }

  //EditProfileController: Hàm cập nhật thông tin user
  Future<void> updateDataUser(Map<String, dynamic> data, String idUser) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(idUser)
          .update(data);
    } catch (e) {
      print('Error updateDataUser: $e');
    }
  }

  //ReportController: Hàm thêm 1 report mới vào db
  Future<void> addNewReport(Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection('reports').add(data);
    } catch (e) {
      print('Error addNewReport: $e');
    }
  }

  //ChatRoomController: Hàm fetch thông tin của user khi truyền vào id
  Future<UserModal?> fetchUserModelById(String idUser) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(idUser)
          .get();

      if (docSnapshot.exists) {
        return UserModal.fromMap(docSnapshot.data()!);
      } else {
        print('User not found');
        return null;
      }
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  //MessageController: Hàm cập nhật lại status của 1 chat room khi truyền vào một idChatRoom
  Future<void> updateStatusRoom(String idChatRoom, int status) async {
    if (idChatRoom.isEmpty) {
      print('Khong tim thay $idChatRoom');
      return;
    }
    try {
      await FirebaseFirestore.instance
          .collection('chatRoom')
          .doc(idChatRoom)
          .update({'status': status});
    } catch (e) {
      print('Error: $e');
    }
  }

  //MessageController: hàm thêm 1 new message
  Future<void> addNewMessage(
    Map<String, dynamic> message,
    String idChatRoom,
  ) async {
    try {
      final chatRoomRef = FirebaseFirestore.instance
          .collection('chatRoom')
          .doc(idChatRoom);
      final messagesRef = chatRoomRef.collection('messages');

      // Thêm message mới vào subcollection
      await messagesRef.add(message);

      // Cập nhật lastMessage và lastTime
      await chatRoomRef.update({
        'lastMessage': message['content'],
        'lastTime': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  //MessageController: cập nhật status của message sang 1 truyền vào id của message đó
  Future<void> updateStatusMessage(String idMessage, String idChatRoom) async {
    try {
      final chatRoomRef = FirebaseFirestore.instance
          .collection('chatRoom')
          .doc(idChatRoom);

      final messagesRef = chatRoomRef.collection('messages');

      // 1. Cập nhật status của message
      await messagesRef.doc(idMessage).update({'status': 1});

      // 2. Lấy message cuối cùng còn lại
      final lastMessageQuery = await messagesRef
          .where('status', isEqualTo: 0)
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      String lastMessageText;

      if (lastMessageQuery.docs.isNotEmpty) {
        final lastMessageData = lastMessageQuery.docs.first.data();
        lastMessageText =
            (lastMessageData['content'] != null &&
                lastMessageData['content'].toString().isNotEmpty)
            ? lastMessageData['content']
            : (lastMessageData['imageUrl'] != null &&
                  lastMessageData['imageUrl'].toString().isNotEmpty)
            ? 'Sent a photo'
            : "Let's start the conversation";
      } else {
        // Không còn tin nhắn nào
        lastMessageText = "Let's start the conversation";
      }

      // 3. Cập nhật lại lastMessage
      await chatRoomRef.update({'lastMessage': lastMessageText});
    } catch (e) {
      print('Error updateStatusMessage: $e');
    }
  }
}
