import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemonverse/src/core/services/http_service.dart';
import 'package:pokemonverse/src/features/home/data/models/pokemon_model.dart';

import '../../features/home/domain/entities/pokemon_entity.dart';

/// A Riverpod provider that fetches Pokemon data from a given URL
final pokemonDataProvider = FutureProvider.family<PokemonEntity?, String>(
  (ref, String url) async {
    try {
      final httpService = GetIt.I<HttpService>();
      final Response? response = await httpService.get(url);

      if (response?.data == null) {
        _logDebug('No data received for URL: $url');
        return null;
      }

      final pokemon = PokemonModel.fromJson(response!.data!);

      return pokemon.toEntity();
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