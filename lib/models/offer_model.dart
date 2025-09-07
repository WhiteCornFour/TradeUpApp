import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tradeupapp/models/product_model.dart';

class OfferModel {
  // Firestore fields
  String? _offerId;
  String? _senderId;
  String? _receiverId;
  String? _productId;
  int? _status; // 0: Chưa phản hồi, 1: Đồng ý, 2: Từ chối
  double? _price;
  double? _offerPrice;
  String? _type;
  Timestamp? _createdAt;

  // Extra fields cho UI
  ProductModel? _product;
  String? _senderName;
  String? _senderAvatar;
  String? _receiverName;

  OfferModel({
    String? offerId,
    String? senderId,
    String? receiverId,
    String? productId,
    int? status,
    double? price,
    double? offerPrice,
    String? type,
    Timestamp? createdAt,
    // UI only
    ProductModel? product,
    String? senderName,
    String? senderAvatar,
    String? receiverName,
  }) : _offerId = offerId,
       _senderId = senderId,
       _receiverId = receiverId,
       _productId = productId,
       _status = status,
       _price = price,
       _offerPrice = offerPrice,
       _type = type,
       _createdAt = createdAt,
       _product = product,
       _senderName = senderName,
       _senderAvatar = senderAvatar,
       _receiverName = receiverName;

  // Getters
  String? get offerId => _offerId;
  String? get senderId => _senderId;
  String? get receiverId => _receiverId;
  String? get productId => _productId;
  int? get status => _status;
  double? get price => _price;
  double? get offerPrice => _offerPrice;
  String? get type => _type;
  Timestamp? get createdAt => _createdAt;

  // UI Getters
  ProductModel? get product => _product;
  String? get senderName => _senderName;
  String? get senderAvatar => _senderAvatar;
  String? get receiverName => _receiverName;

  // Setters
  set product(ProductModel? value) => _product = value;
  set senderName(String? value) => _senderName = value;
  set senderAvatar(String? value) => _senderAvatar = value;
  set receiverName(String? value) => _receiverName = value;

  // Firestore map -> object
  factory OfferModel.fromMap(Map<String, dynamic> map, {String? docId}) {
    return OfferModel(
      offerId: docId,
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      productId: map['productId'],
      status: map['status'],
      price: (map['price'] as num?)?.toDouble(),
      offerPrice: (map['offerPrice'] as num?)?.toDouble(),
      type: map['type'],
      createdAt: map['createdAt'],
    );
  }

  // Object -> Firestore map
  Map<String, dynamic> toMap() {
    return {
      'senderId': _senderId,
      'receiverId': _receiverId,
      'productId': _productId,
      'status': _status,
      'price': _price,
      'offerPrice': _offerPrice,
      'type': _type,
      'createdAt': _createdAt,
    };
  }
}
