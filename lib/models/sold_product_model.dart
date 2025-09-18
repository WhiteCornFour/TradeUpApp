import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/models/offer_model.dart';

class SoldProductModel {
  final ProductModel product;
  final OfferModel offer;

  SoldProductModel({
    required this.product,
    required this.offer,
  });
}
