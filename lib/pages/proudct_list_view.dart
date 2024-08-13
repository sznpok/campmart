import 'package:cached_network_image/cached_network_image.dart';
import 'package:campmart/pages/product_detail_view.dart';
import 'package:campmart/utils/size.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products = [
    Product(
      imageUrl: 'https://example.com/product1.jpg',
      name: 'Product 1',
      category: 'Category 1',
      price: 29.99,
      location: 'New York, USA',
      description: 'This is the description of Product 1.',
    ),
    Product(
      imageUrl: 'https://example.com/product2.jpg',
      name: 'Product 2',
      category: 'Category 2',
      price: 39.99,
      location: 'Los Angeles, USA',
      description: 'This is the description of Product 2.',
    ),
    // Add more products here...
  ];

  ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.8,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(product: product),
                  ),
                );
              },
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CachedNetworkImage(
                          imageUrl: product.imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Icon(
                            Icons.image,
                            size: SizeConfig.screenWidth! / 4,
                            color: Colors.grey,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          width: double.infinity,
                        ),
                      ),
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text('\$${product.price.toStringAsFixed(2)}'),
                      Text(product.category),
                      Text(product.location),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
