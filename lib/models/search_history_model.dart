import 'package:cloud_firestore/cloud_firestore.dart';

class SearchHistoryModel {
  String? _id;
  String? _searchContent;
  String? _userId;
  Timestamp? _createdAt;

  SearchHistoryModel({
    String? id,
    String? searchContent,
    String? userId,
    Timestamp? createdAt,
  }) : _id = id,
       _searchContent = searchContent,
       _userId = userId,
       _createdAt = createdAt ?? Timestamp.now();

  //Getter
  String? get id => _id;
  String? get searchContent => _searchContent;
  String? get userId => _userId;
  Timestamp? get createdAt => _createdAt;

  //Setter
  set id(String? value) => _id = value;
  set searchContent(String? value) => _searchContent = value;
  set userId(String? value) => _userId = value;
  set createdAt(Timestamp? value) => _createdAt = value;

  //Tạo từ Map
  factory SearchHistoryModel.fromMap(
    Map<String, dynamic> map, {
    String? docId,
  }) {
    return SearchHistoryModel(
      id: docId ?? map['id'],
      searchContent: map['searchContent'],
      userId: map['userId'],
      createdAt: map['createdAt'] is Timestamp ? map['createdAt'] : null,
    );
  }

  //Chuyển sang Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'searchContent': searchContent,
      'userId': userId,
      'createdAt': createdAt ?? Timestamp.now(),
    };
  }
}
