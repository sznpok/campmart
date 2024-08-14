import 'package:cached_network_image/cached_network_image.dart';
import 'package:campmart/pages/payment_form.dart';
import 'package:campmart/utils/theme.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../utils/constant.dart';
import '../utils/size.dart';

class ProductDetailPage extends StatelessWidget {
  final Products product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
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
      ),
      appBar: AppBar(
        title: Text(product.productName!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl:
                    "${ApiUrl.basUrl}public/products/${product.productImage}",
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
                        'Price:\$${product.productPrice != null ? product.productPrice!.toStringAsFixed(2) : ""}',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: primaryColor),
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
                'Location: ${product.productLocation ?? ""}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.03),
              Text(
                product.productDescription ?? "",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
