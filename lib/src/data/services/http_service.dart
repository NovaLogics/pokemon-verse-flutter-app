import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HttpService {
  HttpService();

  final _dio = Dio();

  Future<Response?> get(String url) async {
    try {
      final response = await _dio.get(url);
      return response;
    } catch (e) {
      if (kDebugMode) print(e);
    }
    return null;
  }
}
