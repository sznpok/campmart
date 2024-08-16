import 'package:cached_network_image/cached_network_image.dart';
import 'package:campmart/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/fetch_product_bloc/fetch_product_bloc.dart';
import '../model/product_model.dart';
import '../utils/constant.dart';
import '../utils/size.dart';
import '../widgets/custom_toast.dart';
import 'cart_screen.dart';

class ProductDetailPage extends StatelessWidget {
  final Products product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.read<FetchProductBloc>().add(AddToCart(product: product));
          showToast(title: "Product Added to cart successfully");
        },
        label: const Text(
          "Add to Cart",
        ),
      ),
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentForm(
                product: product,
              ),
            ),
          );
        },
        backgroundColor: Colors.blue,
        label: const Text("Pay"),
        icon: const Icon(Icons.payment),
      ),*/
      appBar: AppBar(
        title: Text(product.productName!),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
            icon: Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: "${ApiUrl.basUrl}${product.productImage}",
                fit: BoxFit.cover,
                placeholder: (context, url) => Icon(
                  Icons.image,
                  size: SizeConfig.screenWidth! / 4,
                  color: Colors.grey,
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.image,
                  size: SizeConfig.screenWidth! / 4,
                  color: Colors.grey,
                ),
                width: double.infinity,
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.05),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName ?? "",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: SizeConfig.screenHeight! * 0.01),
                      Text(
                        'New Price:\$${product.productPrice != null ? product.productPrice!.toStringAsFixed(2) : ""}',
                      ),
                      Text(
                        "Old Price:\$${product.oldPrice != null ? product.oldPrice!.toStringAsFixed(2) : ""}",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              decoration: product.available!
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                      ),
                    ],
                  ),
                  Chip(
                    label: Text(product.productCategory ?? ""),
                    backgroundColor: primaryColor,
                    labelStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: secondaryColor,
                            ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.03),
              Text(
                product.productDescription ?? "",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              /*ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Cash on Delivery'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CashOnDeliveryForm(),
                    ),
                  );
                },
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
