import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// A service class for handling HTTP requests using Dio.
class HttpService {
  HttpService();

  final Dio _dio = Dio();

  Future<Response?> get(String url) async {
    try {
      final Response response = await _dio.get(url);
      return response;

    } catch (exception) {
      if (kDebugMode) {
        print('HTTP GET request failed: $exception');
      }
      return null;
    }
  }
}