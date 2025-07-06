  import 'package:flutter/material.dart';

  class CategoryModel {
    late String _name;
    late IconData _icon;
    late int _count;
    late Color _color;

    CategoryModel.listItem(String name, IconData icon, int count, Color color) {
      _name = name;
      _icon = icon;
      _count = count;
      _color = color;
    }

    // Getter
    String get name => _name;
    IconData get icon => _icon;
    int get count => _count;
    Color get color => _color;

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
  }
