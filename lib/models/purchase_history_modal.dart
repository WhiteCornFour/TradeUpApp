import 'package:tradeupapp/models/offer_details_model.dart';
import 'package:tradeupapp/models/offer_model.dart';
import 'package:tradeupapp/models/product_model.dart';

class PurchaseHistoryModal {
  final OfferModel offerModel;
  final ProductModel productModel;
  final OfferDetailsModel offerDetailsModel;

  PurchaseHistoryModal({
    required this.productModel,
    required this.offerModel,
    required this.offerDetailsModel,
  });
}
