part of 'fetch_product_bloc.dart';

@immutable
sealed class FetchProductState {}

class FetchProductInitial extends FetchProductState {}

class FetchProductLoading extends FetchProductState {}

class FetchProductLoaded extends FetchProductState {
  final List<Products> products;

  FetchProductLoaded({required this.products});
}

class FetchProductError extends FetchProductState {
  final String message;

  FetchProductError({required this.message});
}

class FetchProductAuthError extends FetchProductState {}

class CartUpdated extends FetchProductState {
  final List<Products> cartItems;
  final double? totalPrice;

  CartUpdated({required this.cartItems, this.totalPrice});
}

class CartOperationError extends FetchProductState {
  final String message;

  CartOperationError({required this.message});
}
