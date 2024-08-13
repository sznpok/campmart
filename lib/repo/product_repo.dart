import 'dart:developer';

import 'package:campmart/utils/constant.dart';
import 'package:dio/dio.dart';

class ProductRepo {
  Dio dio = Dio();
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    'Authorization': 'Bearer ${ApiToken.token}',
  };

  Future<Response> fetchProducts() async {
    String url = "employer/leave-type/all/";
    log("Url $url");

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
