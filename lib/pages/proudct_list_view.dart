import 'package:cached_network_image/cached_network_image.dart';
import 'package:campmart/bloc/fetch_product_bloc/fetch_product_bloc.dart';
import 'package:campmart/pages/cart_screen.dart';
import 'package:campmart/pages/product_detail_view.dart';
import 'package:campmart/utils/constant.dart';
import 'package:campmart/utils/custom_storage.dart';
import 'package:campmart/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_screen.dart';

class ProductGrid extends StatefulWidget {
  ProductGrid({super.key});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  void initState() {
    BlocProvider.of<FetchProductBloc>(context).add(FetchProduct());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddProductBottomSheet(),
            ),
          );
        },
        label: const Text("Add"),
        icon: const Icon(Icons.add),
      ),*/
      appBar: AppBar(
        title: const Text('All Products'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CartScreen()));
          },
          icon: const Icon(Icons.shopping_cart),
        ),
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
        child: BlocProvider(
          create: (context) => FetchProductBloc()..add(FetchProduct()),
          child: BlocConsumer<FetchProductBloc, FetchProductState>(
            listener: (context, state) {
              if (state is FetchProductAuthError) {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  await deleteTokenAccess();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                });
              }
            },
            builder: (context, state) {
              if (state is FetchProductError) {
                return const Center(
                  child: Text("No data found"),
                );
              }
              if (state is FetchProductLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is FetchProductLoaded) {
                return state.products.isNotEmpty
                    ? RefreshIndicator(
                        onRefresh: () async {
                          BlocProvider.of<FetchProductBloc>(context)
                              .add(FetchProduct());
                        },
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "${ApiUrl.basUrl}${product.productImage}",
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Icon(
                                            Icons.image,
                                            size: SizeConfig.screenWidth! / 4,
                                            color: Colors.grey,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(
                                            Icons.image,
                                            size: SizeConfig.screenWidth! / 4,
                                            color: Colors.grey,
                                          ),
                                          width: double.infinity,
                                        ),
                                      ),
                                      Text(
                                        "Product: ${product.productName ?? ""}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      SizedBox(
                                          height:
                                              SizeConfig.screenHeight! * 0.01),
                                      Text(
                                        'New Price:\$${product.productPrice != null ? product.productPrice!.toStringAsFixed(2) : ""}',
                                      ),
                                      Text(
                                        "Old Price:\$${product.oldPrice != null ? product.oldPrice!.toStringAsFixed(2) : ""}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                              decoration: product.available!
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const Center(
                        child: Text("No data"),
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
      ),
    );
  }
}
