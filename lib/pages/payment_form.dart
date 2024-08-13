import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class PaymentForm extends StatefulWidget {
  const PaymentForm({super.key});

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _payWithKhalti(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final amount =
          int.parse(_amountController.text) * 100; // Convert to paisa
      KhaltiScope.of(context).pay(
        config: PaymentConfig(
          amount: amount,
          productIdentity: 'product_id_12345',
          productName: 'Sample Product',
        ),
        preferences: [
          PaymentPreference.khalti,
          // Add other preferences if you want (e.g., eBanking, mobile banking)
        ],
        onSuccess: (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Payment Successful!')),
          );
          // Handle payment success here
        },
        onFailure: (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Payment Failed: ${failure.message}')),
          );
          // Handle payment failure here
        },
        onCancel: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Payment Cancelled')),
          );
          // Handle payment cancellation here
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Khalti Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount (in NPR)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _payWithKhalti(context),
                child: Text('Pay with Khalti'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
