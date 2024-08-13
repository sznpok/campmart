import 'package:cached_network_image/cached_network_image.dart';
import 'package:campmart/bloc/fetch_product_bloc/fetch_product_bloc.dart';
import 'package:campmart/pages/product_detail_view.dart';
import 'package:campmart/utils/custom_storage.dart';
import 'package:campmart/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/product_model.dart';
import 'login_screen.dart';

class ProductGrid extends StatefulWidget {
  ProductGrid({super.key});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
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

  @override
  void initState() {
    BlocProvider.of<FetchProductBloc>(context).add(FetchProduct());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('All Products'),
        actions: [
          IconButton(
            onPressed: () async {
              await deleteTokenAccess();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<FetchProductBloc, FetchProductState>(
          listener: (context, state) {
            if (state is FetchProductAuthError) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await deleteTokenAccess();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              });
            }
          },
          builder: (context, state) {
            if (state is FetchProductError) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            }
            if (state is FetchProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FetchProductLoaded) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: state.products!.length,
                itemBuilder: (context, index) {
                  final product = state.products![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailPage(product: product),
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
                                imageUrl: product.productImage!,
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
                            ),
                            Text(
                              "Product: ${product.productName ?? ""}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            SizedBox(height: SizeConfig.screenHeight! * 0.01),
                            Text(
                                'Price:\$${product.productPrice != null ? product.productPrice!.toStringAsFixed(2) : ""}'),
                            Text("Location: ${product.productLocation ?? ""}"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
