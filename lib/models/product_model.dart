class ProductModel {
  String? _id;
  String? _userId;
  String? _productName;
  double? _productPrice;
  String? _productDescription;
  String? _selectedCondition;
  List<String>? _categoryList;
  List<String>? _imageList;
  String? _productStory;
  int? _status;
  String? _createdAt;

  //Constructor
  ProductModel({
    String? id,
    String? userId,
    String? productName,
    double? productPrice,
    String? productDescription,
    String? selectedCondition,
    List<String>? categoryList,
    List<String>? imageList,
    String? productStory,
    int? status,
    String? createdAt,
  }) : _id = id,
       _userId = userId,
       _productName = productName,
       _productPrice = productPrice,
       _productDescription = productDescription,
       _selectedCondition = selectedCondition,
       _categoryList = categoryList ?? [],
       _imageList = imageList ?? [],
       _productStory = productStory,
       _status = status ?? 1,
       _createdAt = createdAt;

  //Getters
  String? get id => _id;
  String? get userId => _userId;
  String? get productName => _productName;
  double? get productPrice => _productPrice;
  String? get productDescription => _productDescription;
  String? get selectedCondition => _selectedCondition;
  List<String>? get categoryList => _categoryList;
  List<String>? get imageList => _imageList;
  String? get productStory => _productStory;
  int? get status => _status;
  String? get createdAt => _createdAt;

  //Setters
  set id(String? value) => _id = value;
  set userId(String? value) => _userId = value;
  set productName(String? value) => _productName = value;
  set productPrice(double? value) => _productPrice = value;
  set productDescription(String? value) => _productDescription = value;
  set selectedCondition(String? value) => _selectedCondition = value;
  set categoryList(List<String>? value) => _categoryList = value;
  set imageList(List<String>? value) => _imageList = value;
  set productStory(String? value) => _productStory = value;
  set status(int? value) => _status = value;
  set createdAt(String? value) => _createdAt = value;

  //Convert object to Map (for Firebase or JSON) -> Chuyển dữ liệu để tải lên Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'userId': _userId,
      'productName': _productName,
      'productPrice': _productPrice,
      'productDescription': _productDescription,
      'selectedCondition': _selectedCondition,
      'categoryList': _categoryList,
      'imageList': _imageList,
      'productStory': _productStory,
      'status': _status,
      'createdAt': _createdAt,
    };
  }

  //Create object from Map -> Lấy dữ liệu từ Firebase đem về và chuyển thành Object dạng Product Model
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      userId: map['userId'],
      productName: map['productName'],
      //Ép kiểu về double ngay khi lấy từ Firestore
      productPrice: (map['productPrice'] is int)
          ? (map['productPrice'] as int).toDouble()
          : map['productPrice'],
      productDescription: map['productDescription'],
      selectedCondition: map['selectedCondition'],
      categoryList: List<String>.from(map['categoryList'] ?? []),
      imageList: List<String>.from(map['imageList'] ?? []),
      productStory: map['productStory'],
      status: map['status'],
      createdAt: map['createdAt'],
    );
  }
}
