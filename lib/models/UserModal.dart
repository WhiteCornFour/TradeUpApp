class UserModal {
  late String _email;
  late String _password;
  late String _name;
  late String _avtURL;
  late String _bio;
  late String _address;
  late String _phonenumber;
  late double _rating;
  late int _role;

  UserModal.registerStandard(
    String name,
    String password,
    String email,
    String phonenumber,
  ) {
    _name = name;
    _password = password;
    _email = email;
    _phonenumber = phonenumber;
  }

  UserModal.registerGoogle(String email) {
    _email = email;
  }

  // Getters
  String get email => _email;
  String get password => _password;
  String get name => _name;
  String get avtURL => _avtURL;
  String get bio => _bio;
  String get address => _address;
  String get phonenumber => _phonenumber;
  double get rating => _rating;
  int get role => _role;

  // Setters
  set email(String value) => _email = value;
  set password(String value) => _password = value;
  set name(String value) => _name = value;
  set avtURL(String value) => _avtURL = value;
  set bio(String value) => _bio = value;
  set address(String value) => _address = value;
  set phonenumber(String value) => _phonenumber = value;
  set rating(double value) => _rating = value;
  set role(int value) => _role = value;
}
