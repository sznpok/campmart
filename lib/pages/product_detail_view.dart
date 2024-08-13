import 'package:cached_network_image/cached_network_image.dart';
import 'package:campmart/utils/theme.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../utils/size.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Icon(
                  Icons.image,
                  size: SizeConfig.screenWidth! / 4,
                  color: Colors.grey,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                        product.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: SizeConfig.screenHeight! * 0.01),
                      Text(
                        'Price:\$${product.price.toStringAsFixed(2)}',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: primaryColor),
                      ),
                    ],
                  ),
                  Chip(
                    label: Text(product.category),
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
                'Location: ${product.location}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.03),
              Text(
                product.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
