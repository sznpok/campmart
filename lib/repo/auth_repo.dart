import 'package:dio/dio.dart';

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
        'https://your-api-endpoint.com/register',
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
        'https://your-api-endpoint.com/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Handle successful response
        print('User logged in successfully');
        // Optionally return the response or token if needed
        return response.data;
      } else {
        // Handle error response
        throw Exception('Failed to log in');
      }
    } catch (e) {
      throw Exception('Error logging in: $e');
    }
  }
}
