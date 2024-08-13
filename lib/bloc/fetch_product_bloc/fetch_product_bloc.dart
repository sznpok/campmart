import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../model/product_model.dart';
import '../../repo/product_repo.dart';

part 'fetch_product_event.dart';
part 'fetch_product_state.dart';

class FetchProductBloc extends Bloc<FetchProductEvent, FetchProductState> {
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
            message: e.message,
          ));
        }
      } catch (e) {
        emit(FetchProductError(
          message: e.toString(),
        ));
      }
    });
  }
}
