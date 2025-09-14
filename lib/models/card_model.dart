class CardModel {
  String? cardType;
  String? cardHolderName;
  String? cardNumber; // để String thay vì int, vì số thẻ có thể dài 16 số
  String? exDate;
  String? cvv;
  int? status; // 0 = ẩn, 1 = hiển thị

  String? idCard;

  CardModel({
    this.cardType,
    this.cardHolderName,
    this.cardNumber,
    this.exDate,
    this.cvv,
    this.status,
  });

  // Convert object -> Map (lưu vào Firestore/SQLite)
  Map<String, dynamic> toMap() {
    return {
      'cardType': cardType,
      'cardHolderName': cardHolderName,
      'cardNumber': cardNumber,
      'exDate': exDate,
      'cvv': cvv,
      'status': status,
    };
  }

  // Convert Map -> Object (lấy từ Firestore/SQLite)
  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      cardType: map['cardType'],
      cardHolderName: map['cardHolderName'],
      cardNumber: map['cardNumber'],
      exDate: map['exDate'],
      cvv: map['cvv'],
      status: map['status'],
    );
  }

  // Optional: copyWith để dễ update object
  CardModel copyWith({
    String? cardType,
    String? cardHolderName,
    String? cardNumber,
    String? exDate,
    String? cvv,
    int? status,
  }) {
    return CardModel(
      cardType: cardType ?? this.cardType,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cardNumber: cardNumber ?? this.cardNumber,
      exDate: exDate ?? this.exDate,
      cvv: cvv ?? this.cvv,
      status: status ?? this.status,
    );
  }
}
