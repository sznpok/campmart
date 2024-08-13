import 'dart:developer';

import 'package:dio/dio.dart';

import '../utils/constant.dart';
import '../utils/custom_storage.dart';

class AuthRepo {
  final Dio _dio = Dio();

  Future<void> registerUser({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiUrl.basUrl}users/signup',
        // replace with your actual endpoint
        data: {
          'name': name,
          'username': username,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Handle successful response
        print('User registered successfully');
      } else {
        // Handle error response
        throw Exception('Failed to register user');
      }
    } catch (e) {
      throw Exception('Error registering user: $e');
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiUrl.basUrl}users/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        log("Login successful");
        ApiToken.token = response.data['token'];
        writeTokenAccess(ApiToken.token);
        return response.data;
      } else if (response.statusCode == 400) {
        log("Login failed ${response.data['errors']}");
        return response.data['errors'];
      } else {
        throw response.data['errors'];
      }
    } catch (e) {
      throw Exception('Error logging in: $e');
    }
  }
}
