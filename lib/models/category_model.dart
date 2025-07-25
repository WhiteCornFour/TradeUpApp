import 'package:flutter/material.dart';

class CategoryModel {
  late String _name;
  late IconData _icon;
  late int _count;
  late Color _color; // Màu nhạt
  late Color _colorStrong; // Màu đậm
  late String _imagePath;

  CategoryModel.listItem(
    String name,
    IconData icon,
    int count,
    Color color,
    Color colorStrong,
    String imagePath,
  ) {
    _name = name;
    _icon = icon;
    _count = count;
    _color = color;
    _colorStrong = colorStrong;
    _imagePath = imagePath;
  }

  // Getter
  String get name => _name;
  IconData get icon => _icon;
  int get count => _count;
  Color get color => _color;
  Color get colorStrong => _colorStrong;
  String get imagePath => _imagePath;

  // Setter
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
}
