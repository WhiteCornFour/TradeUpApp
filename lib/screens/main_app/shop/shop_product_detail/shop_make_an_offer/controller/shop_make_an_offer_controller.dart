import 'package:get/get.dart';

class MakeAnOfferController extends GetxController {
  ///-----------
  /// Variables (Danh sách các biến khai báo trong Controller)
  ///-----------

  //Giá gốc sản phẩm
  final double originPrice = 1500;

  //Giá người dùng nhập vào
  final RxnDouble offerAmount = RxnDouble();

  ///----------------------
  /// Hàm quản lý trạng thái của Price Caculator
  ///----------------------
  //Cập nhật khi mà người dùng nhập giá
  void updatePrice(String value) {
    final cleaned = value.replaceAll(RegExp(r'[^0-9.]'), '');
    offerAmount.value = double.tryParse(cleaned);
  }
}
