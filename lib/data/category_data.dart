import 'package:flutter/material.dart';
import 'package:tradeupapp/models/category_model.dart';

final List<CategoryModel> categories = [
  CategoryModel.listItem('Electronics', Icons.electrical_services, 112, Colors.blue[100]!),
  CategoryModel.listItem('Vehicles', Icons.directions_car, 78, Colors.orange[100]!),
  CategoryModel.listItem('Appliances', Icons.kitchen, 54, Colors.green[100]!),
  CategoryModel.listItem('Fashion', Icons.checkroom, 98, Colors.purple[100]!),
  CategoryModel.listItem('Phones', Icons.phone_android, 134, Colors.teal[100]!),
  CategoryModel.listItem('Computers', Icons.computer, 88, Colors.lightBlue[100]!),
  CategoryModel.listItem('Sports', Icons.sports_soccer, 43, Colors.red[100]!),
  CategoryModel.listItem('Books', Icons.menu_book, 61, Colors.brown[100]!),
  CategoryModel.listItem('Toys', Icons.videogame_asset, 49, Colors.yellow[100]!),
  CategoryModel.listItem('Beauty', Icons.favorite, 72, Colors.pink[100]!),
  CategoryModel.listItem('Furniture', Icons.chair, 35, Colors.cyan[100]!),
  CategoryModel.listItem('Food', Icons.shopping_basket, 58, Colors.lime[100]!),
  CategoryModel.listItem('Pets', Icons.pets, 26, Colors.indigo[100]!),
  CategoryModel.listItem('Others', Icons.apps, 12, Colors.grey[300]!),
];
