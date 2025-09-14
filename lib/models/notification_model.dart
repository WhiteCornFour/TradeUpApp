import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? _notificationId;
  String? _targetUserId; // user nhận thông báo
  String? _actorUserId; // user thực hiện hành động

  String? _message;
  Timestamp? _createdAt;

  int? _type;
  // 0: ai đó gửi tin nhắn
  // 1: ai đó tim bài
  // 2: ai đó accept/decline offer
  // 3: ai đó gửi offer cho bạn
  // 4: ai đó checkout sản phẩm
  // 5: hệ thống thông báo

  int? _isRead; // 0: chưa đọc, 1: đã đọc, 2: bị xóa

  //Liên kết đối tượng
  String? _productId;
  String? _offerId;

  //Local fields
  String? _actorName;
  String? _actorAvatar;
  String? _productName;
  String? _offerType;
  double? _offerPrice;

  //Constructor
  NotificationModel({
    String? notificationId,
    String? targetUserId,
    String? actorUserId,
    String? message,
    Timestamp? createdAt,
    int? type,
    int? isRead,
    String? productId,
    String? offerId,
    String? actorName,
    String? actorAvatar,
    String? productName,
    String? offerType,
    double? offerPrice,
  }) : _notificationId = notificationId,
       _targetUserId = targetUserId,
       _actorUserId = actorUserId,
       _message = message,
       _createdAt = createdAt ?? Timestamp.now(),
       _type = type ?? 5,
       _isRead = isRead ?? 1,
       _productId = productId,
       _offerId = offerId,
       _actorName = actorName,
       _actorAvatar = actorAvatar,
       _productName = productName,
       _offerType = offerType,
       _offerPrice = offerPrice;

  //Getters
  String? get notificationId => _notificationId;
  String? get targetUserId => _targetUserId;
  String? get actorUserId => _actorUserId;
  String? get message => _message;
  Timestamp? get createdAt => _createdAt;
  int? get type => _type;
  int? get isRead => _isRead;
  String? get productId => _productId;
  String? get offerId => _offerId;

  String? get actorName => _actorName;
  String? get actorAvatar => _actorAvatar;
  String? get productName => _productName;
  String? get offerType => _offerType;
  double? get offerPrice => _offerPrice;

  //Setters
  set notificationId(String? value) => _notificationId = value;
  set targetUserId(String? value) => _targetUserId = value;
  set actorUserId(String? value) => _actorUserId = value;
  set message(String? value) => _message = value;
  set createdAt(Timestamp? value) => _createdAt = value;
  set type(int? value) => _type = value;
  set isRead(int? value) => _isRead = value;
  set productId(String? value) => _productId = value;
  set offerId(String? value) => _offerId = value;

  set actorName(String? value) => _actorName = value;
  set actorAvatar(String? value) => _actorAvatar = value;
  set productName(String? value) => _productName = value;
  set offerType(String? value) => _offerType = value;
  set offerPrice(double? value) => _offerPrice = value;

  //Convert object -> Map (Firebase)
  Map<String, dynamic> toMap() {
    return {
      'targetUserId': _targetUserId,
      'actorUserId': _actorUserId,
      'message': _message,
      'createdAt': _createdAt ?? Timestamp.now(),
      'type': _type ?? 5,
      'isRead': _isRead ?? 1,
      'productId': _productId,
      'offerId': _offerId,
      // LƯU Ý: không push actorName/actorAvatar lên Firestore
    };
  }

  // Create object from Map (Firebase)
  factory NotificationModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return NotificationModel(
      notificationId: id,
      targetUserId: map['targetUserId'],
      actorUserId: map['actorUserId'],
      message: map['message'],
      createdAt: map['createdAt'] is Timestamp ? map['createdAt'] : null,
      type: map['type'],
      isRead: map['isRead'],
      productId: map['productId'],
      offerId: map['offerId'],
      // actorName và actorAvatar sẽ gán thủ công bên Controller/Service
    );
  }
}
