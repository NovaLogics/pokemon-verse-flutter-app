import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemonverse/src/features/home/data/models/pokemon.dart';
import 'package:pokemonverse/src/core/services/http_service.dart';

final pokemonDataProvider = FutureProvider.family<Pokemon?, String>((
  ref,
  url,
) async {
  HttpService _httpService = GetIt.instance.get<HttpService>();
  Response? response = await _httpService.get(url);

  if (response != null && response.data != null) {
    return Pokemon.fromJson(response.data!);
  }
  return null;
});
