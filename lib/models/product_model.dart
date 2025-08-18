import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? _productId;
  String? _userId;
  String? _productName;
  double? _productPrice;
  String? _productDescription;
  String? _selectedCondition;
  List<String>? _categoryList;
  List<String>? _imageList;
  String? _productStory;
  int? _status; // 0 chưa bán, 1 đã bán
  Timestamp? _createdAt;
  List<String>? _likedBy;

  // Constructor
  ProductModel({
    String? productId,
    String? userId,
    String? productName,
    double? productPrice,
    String? productDescription,
    String? selectedCondition,
    List<String>? categoryList,
    List<String>? imageList,
    String? productStory,
    int? status,
    Timestamp? createdAt,
    List<String>? likedBy,
  }) : _productId = productId,
       _userId = userId,
       _productName = productName,
       _productPrice = productPrice,
       _productDescription = productDescription,
       _selectedCondition = selectedCondition,
       _categoryList = categoryList ?? [],
       _imageList = imageList ?? [],
       _productStory = productStory,
       _status = status ?? 1,
       _createdAt = createdAt ?? Timestamp.now(),
       _likedBy = likedBy ?? [];

  // Getters
  String? get productId => _productId;
  String? get userId => _userId;
  String? get productName => _productName;
  double? get productPrice => _productPrice;
  String? get productDescription => _productDescription;
  String? get selectedCondition => _selectedCondition;
  List<String>? get categoryList => _categoryList;
  List<String>? get imageList => _imageList;
  String? get productStory => _productStory;
  int? get status => _status;
  Timestamp? get createdAt => _createdAt;
  List<String>? get likedBy => _likedBy;

  // Setters
  set productId(String? value) => _productId = value;
  set userId(String? value) => _userId = value;
  set productName(String? value) => _productName = value;
  set productPrice(double? value) => _productPrice = value;
  set productDescription(String? value) => _productDescription = value;
  set selectedCondition(String? value) => _selectedCondition = value;
  set categoryList(List<String>? value) => _categoryList = value;
  set imageList(List<String>? value) => _imageList = value;
  set productStory(String? value) => _productStory = value;
  set status(int? value) => _status = value;
  set createdAt(Timestamp? value) => _createdAt = value;
  set likedBy(List<String>? value) => _likedBy = value;

  // Convert object to Map (Firebase)
  Map<String, dynamic> toMap() {
    return {
      'productId': _productId,
      'userId': _userId,
      'productName': _productName,
      'productPrice': _productPrice,
      'productDescription': _productDescription,
      'selectedCondition': _selectedCondition,
      'categoryList': _categoryList,
      'imageList': _imageList,
      'productStory': _productStory,
      'status': _status,
      'createdAt': _createdAt ?? Timestamp.now(),
      'likedBy': _likedBy ?? [],
    };
  }

  // Create object from Map (Firebase)
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'],
      userId: map['userId'],
      productName: map['productName'],
      productPrice: (map['productPrice'] is int)
          ? (map['productPrice'] as int).toDouble()
          : map['productPrice'],
      productDescription: map['productDescription'],
      selectedCondition: map['selectedCondition'],
      categoryList: List<String>.from(map['categoryList'] ?? []),
      imageList: List<String>.from(map['imageList'] ?? []),
      productStory: map['productStory'],
      status: map['status'],
      createdAt: map['createdAt'] is Timestamp ? map['createdAt'] : null,
      likedBy: List<String>.from(map['likedBy'] ?? []),
    );
  }
}
