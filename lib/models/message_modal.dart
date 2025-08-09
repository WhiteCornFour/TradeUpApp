import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModal {
  String content;
  String imageUrl;
  String idSender;
  Timestamp timestamp;
  int status; // 0 active || 1 delete
  String? idMessage;

  MessageModal({
    required this.content,
    required this.imageUrl,
    required this.idSender,
    required this.status,
    required this.timestamp,
  });

  factory MessageModal.fromJson(Map<String, dynamic> json) {
    return MessageModal(
      content: json['content'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      idSender: json['senderId'] ?? '',
      status: json['status'] ?? 0,
      timestamp: json['timestamp'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'imageUrl': imageUrl,
      'senderId': idSender,
      'timestamp': timestamp,
      'status': status,
    };
  }
}
