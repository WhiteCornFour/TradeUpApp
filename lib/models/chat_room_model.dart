import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {
  final String idUser1;
  final String idUser2;
  final String lastMessage;
  final Timestamp lastTime;
  final int status; // 0 active || 1 delete || 2 block

  // Optional fields
  String? otherUserName;
  String? otherUserAvatar;
  String? idChatRoom;

  String? get getIdChatRoom => idChatRoom;

  ChatRoomModel({
    required this.idUser1,
    required this.idUser2,
    required this.lastMessage,
    required this.lastTime,
    required this.status,
    this.otherUserName,
    this.otherUserAvatar,
    this.idChatRoom,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    Timestamp parseTimestamp(dynamic value) {
      if (value is Timestamp) {
        return value;
      } else if (value is String) {
        try {
          return Timestamp.fromDate(DateTime.parse(value));
        } catch (e) {
          return Timestamp.now();
        }
      } else {
        return Timestamp.now();
      }
    }

    return ChatRoomModel(
      idUser1: json['idUser1'] ?? '',
      idUser2: json['idUser2'] ?? '',
      lastMessage: json['lastMessage'] ?? '',
      lastTime: parseTimestamp(json['lastTime']),
      status: json['status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUser1': idUser1,
      'idUser2': idUser2,
      'lastMessage': lastMessage,
      'lastTime': lastTime,
      'status': status,
    };
  }

  ChatRoomModel copyWith({
    String? idUser1,
    String? idUser2,
    String? lastMessage,
    Timestamp? lastTime,
    int? status,
    String? otherUserName,
    String? otherUserAvatar,
    String? idChatRoom,
  }) {
    return ChatRoomModel(
      idUser1: idUser1 ?? this.idUser1,
      idUser2: idUser2 ?? this.idUser2,
      lastMessage: lastMessage ?? this.lastMessage,
      lastTime: lastTime ?? this.lastTime,
      status: status ?? this.status,
      otherUserName: otherUserName ?? this.otherUserName,
      otherUserAvatar: otherUserAvatar ?? this.otherUserAvatar,
      idChatRoom: idChatRoom ?? this.idChatRoom,
    );
  }
}
