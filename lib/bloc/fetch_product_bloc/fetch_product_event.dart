part of 'fetch_product_bloc.dart';

@immutable
sealed class FetchProductEvent {}

final class FetchProduct extends FetchProductEvent {}

class AddToCart extends FetchProductEvent {
  final Products product;

  AddToCart({required this.product});
}

class RemoveFromCart extends FetchProductEvent {
  final Products product;

  RemoveFromCart({required this.product});
}
