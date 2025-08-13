import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tradeupapp/models/category_model.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/models/search_history_model.dart';
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

  Future<void> addProduct(ProductModel product) async {
    try {
      //Tạo ID mới cho sản phẩm
      final docRef = FirebaseFirestore.instance.collection('products').doc();

      //Set ID cho sản phẩm trước khi lưu
      product.id = docRef.id;

      //Đảm bảo giá trị price là double
      if (product.productPrice != null) {
        product.productPrice = product.productPrice!.toDouble();
      }

      //Lưu dữ liệu lên Firestore
      await docRef.set(product.toMap());

      print("Adding product successfull: ${docRef.id}");
    } catch (e) {
      print("Error adding product: $e");
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

  //Lấy danh sách sản phẩm từ Firebase về
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('products')
          .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  //Lấy danh sách Category từ Firebase
  Future<List<CategoryModel>> getAllCategories() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('categories')
        .get();

    final categories = snapshot.docs.map((doc) {
      return CategoryModel.fromFirestore(doc.data());
    }).toList();

    return categories;
  }

  //Đếm số lượng sản phẩm của Category dựa trên Category Name chỉ đếm một loại
  Map<String, int> countByCategory(
    List<ProductModel> productList,
    List<String> categoryNames,
  ) {
    Map<String, int> counts = {};

    //Khởi tạo tất cả category count = 0
    for (var category in categoryNames) {
      counts[category] = 0;
    }

    for (var product in productList) {
      if (product.categoryList != null) {
        for (var cat in product.categoryList!) {
          if (counts.containsKey(cat)) {
            counts[cat] = counts[cat]! + 1;
          } else {
            //Nếu category mới chưa có trong map thì tạo mới
            counts[cat] = 1;
          }
        }
      }
    }

    return counts;
  }

  //Lấy tất cả User có trong danh sách
  Future<List<UserModal>> getAllUsers() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .get();

      List<UserModal> users = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return UserModal.fromMap(data, docId: doc.id);
      }).toList();

      return users;
    } catch (e) {
      print('Error getting users: $e');
      return [];
    }
  }

  //Thêm lịch sử search
  Future<void> addOrUpdateSearchHistory(
    SearchHistoryModel searchHistory,
  ) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('searchHistory')
          .where('userId', isEqualTo: searchHistory.userId)
          .where('searchContent', isEqualTo: searchHistory.searchContent)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        //Nếu đã tồn tại -> cập nhật createdAt
        final docId = querySnapshot.docs.first.id;
        await FirebaseFirestore.instance
            .collection('searchHistory')
            .doc(docId)
            .update({'createdAt': Timestamp.now()});
        print(
          "Updated search history time for: ${searchHistory.searchContent}",
        );
      } else {
        //Nếu chưa tồn tại -> thêm mới searchHistory
        final docRef = FirebaseFirestore.instance
            .collection('searchHistory')
            .doc();

        searchHistory.id = docRef.id;

        await docRef.set(searchHistory.toMap());
        print("Added new search history: ${searchHistory.searchContent}");
      }
    } catch (e) {
      print("Error add/update search history: $e");
    }
  }

  //Lấy danh sách lịch sử tìm kiếm của người dùng
  Future<List<SearchHistoryModel>> getUserSearchHistory(String userId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('searchHistory')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => SearchHistoryModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Error getting user search history: $e');
      return [];
    }
  }
}
