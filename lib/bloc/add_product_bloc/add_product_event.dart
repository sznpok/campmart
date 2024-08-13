part of 'add_product_bloc.dart';

@immutable
sealed class AddProductEvent {}

class AddProduct extends AddProductEvent {
  final String productName;
  final String productPrice;
  final String productCategory;
  final String productDescription;
  final String productLocation;
  final XFile? document;

  AddProduct({
    required this.productName,
    required this.productPrice,
    required this.productCategory,
    required this.productDescription,
    required this.productLocation,
    required this.document,
  });
}
