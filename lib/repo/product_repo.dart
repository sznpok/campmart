import 'dart:developer';

import 'package:campmart/utils/constant.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ProductRepo {
  Dio dio = Dio();
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    'Authorization': 'Bearer ${ApiToken.token}',
  };

  Future<Response> fetchProducts() async {
    String url = "${ApiUrl.basUrl}/products/allproducts";
    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        log("Response: ${response.data}");
        return response;
      } else {
        return response;
      }
    } on DioException catch (e) {
      log("DioException: ${e.message}");
      rethrow;
    } catch (e) {
      log("General Exception: ${e.toString()}");
      throw Exception("General Error: ${e.toString()}");
    }
  }

  Future<Response> postProduct(
    String productName,
    XFile? document,
    String productPrice,
    String productCategory,
    String productDescription,
    String productLocation,
  ) async {
    String url = "${ApiUrl.basUrl}product/create";
    log("Url $url");
    try {
      final formData = FormData.fromMap({
        'productName': productName,
        'productPrice': productPrice,
        'productCategory': productCategory,
        'productDescription': productDescription,
        "productLocation": productLocation,
        if (document != null)
          'productImage': await MultipartFile.fromFile(
            document.path,
            filename: document.name,
          ),
      });
      final response = await dio.post(
        url,
        data: formData,
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 201) {
        return response;
      } else {
        return response;
      }
    } on DioException catch (e) {
      log("DioException: ${e.message}");
      rethrow;
    } catch (e) {
      log("General Exception: ${e.toString()}");
      throw Exception("General Error: ${e.toString()}");
    }
  }
}
