import 'package:campmart/pages/cash_delivery_view.dart';
import 'package:campmart/pages/payment_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/fetch_product_bloc/fetch_product_bloc.dart';
import '../model/product_model.dart';
import '../widgets/custom_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, this.product});

  final Products? product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My Cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<FetchProductBloc, FetchProductState>(
                builder: (context, state) {
                  if (state is CartUpdated) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.cartItems.length,
                            itemBuilder: (context, index) {
                              final product = state.cartItems[index];
                              return ListTile(
                                title: Text(product.productName!),
                                subtitle:
                                    Text('Price:\$${product.productPrice}'),
                                trailing: IconButton(
                                  icon: Icon(Icons.remove_shopping_cart),
                                  onPressed: () {
                                    context
                                        .read<FetchProductBloc>()
                                        .add(RemoveFromCart(product: product));
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Total Price: \$${state.totalPrice!.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                title: "Checkout",
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaymentForm(
                                        product: product ??
                                            Products(
                                              productName: "not found",
                                              productPrice:
                                                  state.totalPrice!.toInt(),
                                              productCategory: "not found",
                                              productDescription: "not found",
                                              productLocation: "not found",
                                            ),
                                      ),
                                    ),
                                  );
                                },
                                width: MediaQuery.of(context).size.width * 0.3,
                                borderRadius: 30,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: CustomButton(
                                title: "Cash on Delivery",
                                bgColor: Colors.blue,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CashOnDeliveryForm(),
                                    ),
                                  );
                                },
                                width: MediaQuery.of(context).size.width * 0.1,
                                borderRadius: 30,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  return Center(child: Text('Your cart is empty'));
                },
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
