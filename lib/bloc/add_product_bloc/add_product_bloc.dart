import 'package:bloc/bloc.dart';
import 'package:campmart/repo/product_repo.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc() : super(AddProductInitial()) {
    on<AddProduct>((event, emit) async {
      final ProductRepo productRepo = ProductRepo();
      emit(AddProductLoading());
      try {
        final result = await productRepo.postProduct(
          event.productName,
          event.document,
          event.productPrice,
          event.productCategory,
          event.productDescription,
          event.productLocation,
        );
        if (result.statusCode == 201) {
          emit(AddProductSuccess());
        } else if (result.statusCode == 400 || result.statusCode == 500) {
          final errorMessage = result.data['message'] ?? 'Unknown error';
          emit(AddProductFailure(message: errorMessage));
        } else if (result.statusCode == 401) {
          emit(AddProductAuthState());
        }
      } on DioException catch (e) {
        if (e.response?.statusCode == 401) {
          emit(AddProductAuthState());
        } else {
          emit(AddProductFailure(
            message: e.toString(),
          ));
        }
      } catch (e) {
        emit(AddProductFailure(message: e.toString()));
      }
    });
  }
}
