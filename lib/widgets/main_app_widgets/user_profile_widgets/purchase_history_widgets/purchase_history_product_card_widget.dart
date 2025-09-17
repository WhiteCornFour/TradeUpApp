import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/offer_details_model.dart';
import 'package:tradeupapp/models/offer_model.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/models/user_model.dart';

class ProductCardPurchaseHistory extends StatelessWidget {
  final ProductModel productModel;
  final OfferModel offerModel;
  final OfferDetailsModel offerDetailsModel;

  const ProductCardPurchaseHistory({
    super.key,
    required this.productModel,
    required this.offerModel,
    required this.offerDetailsModel,
  });

  /// format thời gian
  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat("MMM dd, yyyy - HH:mm").format(dateTime);
  }

  /// map phương thức thanh toán
  String mapPaymentMethod(double? method) {
    switch (method) {
      case 0:
        return "Credit Card";
      case 1:
        return "Paypal";
      case 2:
        return "Cash";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Store info ---
          FutureBuilder<UserModel?>(
            future: DatabaseService().fetchUserModelById(productModel.userId!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (!snapshot.hasData || snapshot.hasError) {
                return const Text(
                  "Failed to load seller info",
                  style: TextStyle(
                    color: AppColors.header,
                    fontFamily: "Roboto-Medium",
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }

              final user = snapshot.data!;
              return Row(
                children: [
                  CircleAvatar(
                    backgroundImage: user.avtURL == null
                        ? AssetImage("assets/images/logo.png")
                        : NetworkImage(user.avtURL!),
                    radius: 24,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName ?? "Unknown seller",
                        style: const TextStyle(
                          color: AppColors.header,
                          fontFamily: "Roboto-Regular",
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        user.address ?? "No address",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontFamily: "Roboto-Regular",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          /// --- Product ---
          const Text(
            "Product",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.header,
              fontFamily: "Roboto-Medium",
            ),
          ),
          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child:
                productModel.imageList != null &&
                    productModel.imageList!.isNotEmpty
                ? Image.network(
                    productModel.imageList!.first,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "assets/images/logo.png",
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(height: 12),

          Text(
            productModel.productName ?? "No product name",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.header,
              fontFamily: "Roboto-Medium",
            ),
          ),
          const SizedBox(height: 8),

          /// --- Offer Info ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Price: \$${offerModel.price ?? 0}",
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                  fontFamily: "Roboto-Regular",
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Offer: \$${offerDetailsModel.totalPayment ?? 0}",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto-Regular",
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const Divider(height: 24, thickness: 1),

          /// --- Payment Info ---
          Row(
            children: [
              const Icon(Icons.access_time, size: 18, color: Colors.grey),
              const SizedBox(width: 6),
              Text(
                "Paid at: ${formatTimestamp(offerDetailsModel.createdAt!)}",
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.header,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto-Regular",
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.credit_card, size: 18, color: Colors.grey),
              const SizedBox(width: 6),
              Text(
                "Payment Method: ${mapPaymentMethod(offerDetailsModel.paymentMethod)}",
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.header,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto-Regular",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
