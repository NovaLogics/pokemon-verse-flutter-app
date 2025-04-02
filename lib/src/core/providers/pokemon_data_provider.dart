import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemonverse/src/features/home/data/models/pokemon.dart';
import 'package:pokemonverse/src/core/services/http_service.dart';

/// A Riverpod provider that fetches Pokemon data from a given URL
final pokemonDataProvider = FutureProvider.family<Pokemon?, String>(
  (ref, String url) async {
    try {
      final httpService = GetIt.I<HttpService>();
      final Response? response = await httpService.get(url);

      if (response?.data == null) {
        _logDebug('No data received for URL: $url');
        return null;
      }

      return Pokemon.fromJson(response!.data!);
    } on DioException catch (dioError) {
      _logDebug('Dio error fetching Pokemon: ${dioError.message}');
      return null;
    } catch (e, stackTrace) {
      _logDebug('Unexpected error: $e\n$stackTrace');
      return null;
    }
  },
);

void _logDebug(String message) {
  if (kDebugMode) {
    debugPrint(message);
  }
}