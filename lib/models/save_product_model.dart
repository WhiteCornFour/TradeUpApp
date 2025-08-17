import 'package:cloud_firestore/cloud_firestore.dart';

class SaveProductModel {
  String? _saveProductId;
  String? _userId;
  String? _productId;
  Timestamp? _createdAt;

  //Constructor
  SaveProductModel({
    String? saveProductId,
    String? userId,
    String? productId,
    Timestamp? createdAt,
  }) : _saveProductId = saveProductId,
       _userId = userId,
       _productId = productId,
       _createdAt = createdAt;

  //Getter
  String? get saveProductId => _saveProductId;
  String? get userId => _userId;
  String? get productId => _productId;
  Timestamp? get createdAt => _createdAt;

  //Setter
  set saveProductId(String? value) => _saveProductId = value;
  set userId(String? value) => _userId = value;
  set productId(String? value) => _productId = value;
  set createdAt(Timestamp? value) => _createdAt = value;

  //Factory: chuyển từ Firestore Map sang object
  factory SaveProductModel.fromMap(Map<String, dynamic> map, {String? docId}) {
    return SaveProductModel(
      saveProductId: docId,
      userId: map['userId'],
      productId: map['productId'],
      createdAt: map['createdAt'],
    );
  }

  //Convert object thành Map để lưu vào Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': _userId,
      'productId': _productId,
      'createdAt': _createdAt,
    };
  }
}
