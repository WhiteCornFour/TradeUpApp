import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CategoryModel {
  late String _id;
  late String _name;
  late IconData _icon;
  late int _count;
  late Color _color; 
  late Color _colorStrong; 
  late String _imagePath;
  late String _description;
  late int _position;

  CategoryModel.listItem(
    this._name,
    this._icon,
    this._count,
    this._color,
    this._colorStrong,
    this._imagePath,
    this._position,
  );

  //Thêm constructor từ Firestore
  CategoryModel.fromFirestore(Map<String, dynamic> data) {
    _id = data['id'] ?? '';
    _name = data['name'] ?? '';
    _imagePath = data['image'] ?? '';
    _description = data['description'] ?? '';
    _count = 0;
    _position = data['position'] ?? 0;

    //Lấy màu sắc và icon dựa theo _id
    final iconAndColors =
        _categoryIconAndColors[_id.toLowerCase()] ?? _defaultIconAndColors;

    _icon = iconAndColors['icon']!;
    _color = iconAndColors['colorLight']!;
    _colorStrong = iconAndColors['colorDark']!;
  }

  // Getter
  String get id => _id;
  String get name => _name;
  IconData get icon => _icon;
  int get count => _count;
  Color get color => _color;
  Color get colorStrong => _colorStrong;
  String get imagePath => _imagePath;
  String get description => _description;
  int get position => _position;

  // Setter
  set id(String value) {
    _id = value;
  }

  set name(String value) {
    _name = value;
  }

  set icon(IconData value) {
    _icon = value;
  }

  set count(int value) {
    _count = value;
  }

  set color(Color value) {
    _color = value;
  }

  set colorStrong(Color value) {
    _colorStrong = value;
  }

  set imagePath(String value) => _imagePath = value;
  set description(String value) => _description = value;
  set position(int value) => _position = value;

  static final Map<String, Map<String, dynamic>> _categoryIconAndColors = {
    'electronics': {
      'icon': Iconsax.electricity,
      'colorLight': Colors.blue[100]!,
      'colorDark': Colors.blue[600]!,
    },
    'vehicles': {
      'icon': Iconsax.car,
      'colorLight': Colors.orange[100]!,
      'colorDark': Colors.orange[600]!,
    },
    'appliances': {
      'icon': Iconsax.monitor_mobbile,
      'colorLight': Colors.green[100]!,
      'colorDark': Colors.green[600]!,
    },
    'fashion': {
      'icon': Iconsax.shop,
      'colorLight': Colors.purple[100]!,
      'colorDark': Colors.purple[600]!,
    },
    'phones': {
      'icon': Iconsax.mobile,
      'colorLight': Colors.teal[100]!,
      'colorDark': Colors.teal[600]!,
    },
    'computers': {
      'icon': Iconsax.monitor,
      'colorLight': Colors.lightBlue[100]!,
      'colorDark': Colors.blue[600]!,
    },
    'sports': {
      'icon': Iconsax.activity,
      'colorLight': Colors.red[100]!,
      'colorDark': Colors.red[600]!,
    },
    'books': {
      'icon': Iconsax.book,
      'colorLight': Colors.brown[100]!,
      'colorDark': Colors.brown[600]!,
    },
    'toys': {
      'icon': Iconsax.game,
      'colorLight': Colors.yellow[100]!,
      'colorDark': Colors.yellow[800]!,
    },
    'beauty': {
      'icon': Iconsax.heart,
      'colorLight': Colors.pink[100]!,
      'colorDark': Colors.pink[400]!,
    },
    'furniture': {
      'icon': Iconsax.building,
      'colorLight': Colors.cyan[100]!,
      'colorDark': Colors.cyan[600]!,
    },
    'food': {
      'icon': Iconsax.shopping_bag,
      'colorLight': Colors.lime[100]!,
      'colorDark': Colors.lime[700]!,
    },
    'pets': {
      'icon': Iconsax.candle,
      'colorLight': Colors.indigo[100]!,
      'colorDark': Colors.indigo[600]!,
    },
    'others': {
      'icon': Iconsax.element_3,
      'colorLight': Colors.grey[200]!,
      'colorDark': Colors.grey[600]!,
    },
  };

  static final _defaultIconAndColors = {
    'icon': Iconsax.element_3,
    'colorLight': Colors.grey[200]!,
    'colorDark': Colors.grey[600]!,
  };
}
