class UserModal {
  String? _userId;
  String? _email;
  String? _password;
  String? _fullName;
  String? _avtURL;
  String? _bio;
  String? _address;
  String? _phoneNumber;
  double? _rating;
  String? _tagName;
  int? _role;
  //Truyền sau
  int? total_reviews;
  int? get totalReviews => total_reviews;
  // Constructor
  UserModal({
    String? userId,
    String? email,
    String? password,
    String? fullName,
    String? avtURL,
    String? bio = '',
    String? address,
    String? phoneNumber,
    double? rating,
    String? tagName,
    int? role,
  }) : _userId = userId,
       _email = email,
       _password = password,
       _fullName = fullName,
       _avtURL = avtURL,
       _bio = bio,
       _address = address,
       _phoneNumber = phoneNumber,
       _rating = rating,
       _tagName = tagName,
       _role = role;

  // Getter/setter
  String? get userId => _userId;
  String? get email => _email;
  String? get password => _password;
  String? get fullName => _fullName;
  String? get avtURL => _avtURL;
  String? get bio => _bio;
  String? get address => _address;
  String? get phoneNumber => _phoneNumber;
  double? get rating => _rating;
  String? get tagName => _tagName;
  int? get role => _role;

  set userId(String? value) => _userId = value;
  set email(String? value) => _email = value;
  set password(String? value) => _password = value;
  set fullName(String? value) => _fullName = value;
  set avtURL(String? value) => _avtURL = value;
  set bio(String? value) => _bio = value;
  set address(String? value) => _address = value;
  set phoneNumber(String? value) => _phoneNumber = value;
  set rating(double? value) => _rating = value;
  set tagName(String? value) => _tagName = value;
  set role(int? value) => _role = value;

  //Factory fromMap
  factory UserModal.fromMap(Map<String, dynamic> map, {String? docId}) {
    return UserModal(
      userId: docId,
      email: map['email'],
      password: map['passWord'],
      fullName: map['yourname'],
      avtURL: map['avtURL'],
      bio: map['bio'] ?? '',
      address: map['address'],
      phoneNumber: map['phoneNumber'],
      rating: map['rating']?.toDouble(),
      tagName: map['tagName'],
      role: map['role'],
    );
  }

  //Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'email': _email,
      'passWord': _password,
      'yourname': _fullName,
      'avtURL': _avtURL,
      'bio': _bio,
      'address': _address,
      'phoneNumber': _phoneNumber,
      'rating': _rating,
      'tagName': _tagName,
      'role': _role,
    };
  }
}
