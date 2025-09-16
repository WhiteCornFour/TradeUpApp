import 'package:cloud_firestore/cloud_firestore.dart';

class OfferDetailsModel {
  String? idUserCheckout;
  double? totalPayment;
  Timestamp? createdAt;
  double? paymentMethod; // 0: Credit Card, 1: Paypal
  String cardId = "";
  int? status;

  String? offerDetailId;

  OfferDetailsModel({
    this.idUserCheckout,
    this.totalPayment,
    this.createdAt,
    this.paymentMethod,
    this.cardId = "",
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'idUserCheckout': idUserCheckout,
      'totalPayment': totalPayment,
      'createdAt': createdAt,
      'paymentMethod': paymentMethod,
      'cardId': cardId,
      'status': status,
    };
  }

  factory OfferDetailsModel.fromJson(Map<String, dynamic> json) {
    return OfferDetailsModel(
      idUserCheckout: json['idUserCheckout'],
      totalPayment: (json['totalPayment'] as num?)?.toDouble(),
      createdAt: json['createdAt'],
      paymentMethod: (json['paymentMethod'] as num?)?.toDouble(),
      cardId: json['cardId'] ?? "",
      status: json['status'],
    );
  }
}
