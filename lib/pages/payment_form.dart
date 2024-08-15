import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/khalti_bloc/khalit_bloc.dart';
import '../bloc/khalti_bloc/khalit_event.dart';
import '../bloc/khalti_bloc/khalit_state.dart';
import '../model/product_model.dart';

class PaymentForm extends StatefulWidget {
  final Products product;

  const PaymentForm({super.key, required this.product});

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  initState() {
    super.initState();
    _amountController.text = widget.product.productPrice.toString();
  }

  void _startPayment(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final amount =
          int.parse(_amountController.text) * 100; // Convert to paisa
      context.read<KhaltiBloc>().add(
            StartPaymentEvent(
              context: context,
              amount: amount,
              productIdentity: widget.product.sId ?? "",
              productName: widget.product.productName!,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Khalti Payment'),
      ),
      body: BlocListener<KhaltiBloc, KhaltiState>(
        listener: (context, state) {
          if (state is PaymentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Payment Successful: ${state.token}')),
            );
          } else if (state is PaymentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Payment Failed: ${state.error}')),
            );
          } else if (state is PaymentCancelled) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Payment Cancelled')),
            );
          }
        },
        child: Padding(
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
                BlocBuilder<KhaltiBloc, KhaltiState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () => _startPayment(context),
                      child: Text('Pay with Khalti'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}
