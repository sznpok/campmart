part of 'add_product_bloc.dart';

@immutable
sealed class AddProductState {}

final class AddProductInitial extends AddProductState {}

final class AddProductLoading extends AddProductState {}

final class AddProductFailure extends AddProductState {
  final String message;

  AddProductFailure({required this.message});
}

final class AddProductSuccess extends AddProductState {}

final class AddProductAuthState extends AddProductState {}
