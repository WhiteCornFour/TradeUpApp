import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/models/offer_details_model.dart';
import 'package:tradeupapp/screens/main_app/profile/profile.dart';
import 'package:tradeupapp/screens/main_app/shop/payment/controller/payment_controller.dart';
import 'package:tradeupapp/widgets/general/general_back_button.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';

class PaymentPaypal extends StatefulWidget {
  final double amount;
  final String offerId;

  const PaymentPaypal({super.key, required this.amount, required this.offerId});

  @override
  State<PaymentPaypal> createState() => _PaymentPaypalState();
}

class _PaymentPaypalState extends State<PaymentPaypal> {
  String checkoutUrl = "";
  String orderId = "";
  late PaymentController paymentController;
  Future<void> _createOrder() async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:3000/create-order"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "amount": widget.amount.toStringAsFixed(2), // "10.00"
        }),
      );

      final data = jsonDecode(response.body);
      if (data["links"] != null) {
        orderId = data["id"];
        final links = data["links"] as List;
        final approveLink = links.firstWhere(
          (link) => link["rel"] == "approve",
        )["href"];
        setState(() {
          checkoutUrl = approveLink;
        });
      } else {
        // ignore: avoid_print
        print("Không tìm thấy links trong response: $data");
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error creating PayPal order: $e");
    }
  }

  Future<void> _captureOrder() async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:3000/capture-order/$orderId"),
      );

      final data = jsonDecode(response.body);
      // ignore: avoid_print
      print("Capture result: $data");
    } catch (e) {
      // ignore: avoid_print
      print("Error capturing order: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    paymentController = Get.find<PaymentController>();
    _createOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButtonCustomGeneral(),
        title: Text(
          "PayPal Checkout",
          style: TextStyle(
            color: AppColors.header,
            fontFamily: "Roboto-Medium",
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: checkoutUrl.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(checkoutUrl)),
                onLoadStop: (controller, url) async {
                  if (url.toString().contains("/success")) {
                    await _captureOrder();
                    if (mounted) {
                      final offerDetail = OfferDetailsModel(
                        cardId: "",
                        createdAt: Timestamp.now(),
                        idUserCheckout: paymentController.idCurrentUser,
                        paymentMethod: 1,
                        status: 0,
                        totalPayment: widget.amount,
                      );
                      paymentController.handleAddOfferDetail(
                        widget.offerId,
                        offerDetail,
                      );
                      SnackbarHelperGeneral.showCustomSnackBar(
                        "Payment completed successfully!",
                        backgroundColor: Colors.green,
                      );
                      Get.offAll(() => Profile()); // thay thế hết stack
                    }
                  } else if (url.toString().contains("/cancel")) {
                    if (mounted) {
                      SnackbarHelperGeneral.showCustomSnackBar(
                        "Payment cancelled!",
                        backgroundColor: Colors.red,
                      );
                      Get.offAll(() => Profile()); // thay thế hết stack
                    }
                  }
                },
              ),
            ),
    );
  }
}
