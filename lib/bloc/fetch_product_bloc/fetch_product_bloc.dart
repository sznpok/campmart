import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../model/product_model.dart';
import '../../repo/product_repo.dart';

part 'fetch_product_event.dart';
part 'fetch_product_state.dart';

class FetchProductBloc extends Bloc<FetchProductEvent, FetchProductState> {
  List<Products> _cartItems = [];
  double _totalPrice = 0.0;

  FetchProductBloc() : super(FetchProductInitial()) {
    on<FetchProduct>((event, emit) async {
      final ProductRepo productRepo = ProductRepo();
      emit(FetchProductLoading());
      try {
        final response = await productRepo.fetchProducts();
        if (response.statusCode == 200) {
          final List<dynamic> dataList = response.data['products'];
          final List<Products> products =
              dataList.map((data) => Products.fromJson(data)).toList();
          emit(FetchProductLoaded(products: products));
        } else if (response.statusCode == 401) {
          emit(FetchProductAuthError());
        } else {
          emit(FetchProductError(
            message: response.data['message'] ?? 'Unknown error',
          ));
        }
      } on DioException catch (e) {
        if (e.response?.statusCode == 401) {
          emit(FetchProductAuthError());
        } else {
          emit(FetchProductError(
            message: e.message!,
          ));
        }
      } catch (e) {
        emit(FetchProductError(
          message: e.toString(),
        ));
      }
    });

    on<AddToCart>((event, emit) {
      _cartItems.add(event.product);
      _updateTotalPrice();
      emit(CartUpdated(cartItems: _cartItems, totalPrice: _totalPrice));
    });

    on<RemoveFromCart>((event, emit) {
      _cartItems.remove(event.product);
      _updateTotalPrice();
      emit(CartUpdated(cartItems: _cartItems, totalPrice: _totalPrice));
    });
  }

  void _updateTotalPrice() {
    _totalPrice = _cartItems.fold(
      0.0,
      (sum, item) => sum + (item.productPrice?.toDouble() ?? 0.0),
    );
  }
}
