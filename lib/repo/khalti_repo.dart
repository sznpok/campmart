import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class KhaltiRepository {
  Future<void> makePayment({
    required BuildContext context,
    required int amount,
    required String productIdentity,
    required String productName,
    required Function(PaymentSuccessModel) onSuccess,
    required Function(PaymentFailureModel) onFailure,
    required Function() onCancel,
  }) async {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: amount,
        productIdentity: productIdentity,
        productName: productName,
        mobile: "9860876602",
      ),
      preferences: [PaymentPreference.khalti, PaymentPreference.eBanking],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }
}
