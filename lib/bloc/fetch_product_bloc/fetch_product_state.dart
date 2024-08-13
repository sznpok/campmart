part of 'fetch_product_bloc.dart';

@immutable
sealed class FetchProductState {}

final class FetchProductInitial extends FetchProductState {}

final class FetchProductLoading extends FetchProductState {}

final class FetchProductLoaded extends FetchProductState {
  final List<Products>? products;

  FetchProductLoaded({this.products});
}

final class FetchProductError extends FetchProductState {
  final String? message;

  FetchProductError({this.message});
}

final class FetchProductAuthError extends FetchProductState {}
