import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemonverse/src/features/home/data/models/pokemon.dart';
import 'package:pokemonverse/src/core/services/http_service.dart';
import 'package:pokemonverse/src/features/home/presentation/controller/home_data_state.dart';

class HomeController extends StateNotifier<HomeDataState> {
  final HttpService _httpService = GetIt.instance.get<HttpService>();

  // Base URL and default query parameters for the Pokémon API
  static const String _baseUrl = "https://pokeapi.co/api/v2/pokemon";
  static const int _defaultLimit = 20;
  static const int _defaultOffset = 0;

  HomeController(super._state) {
    loadPokemons();
  }

  String _buildInitialUrl({
    int limit = _defaultLimit,
    int offset = _defaultOffset,
  }) {
    return "$_baseUrl?limit=$limit&offset=$offset";
  }

  // Loads Pokémon data from the API
  Future<void> loadPokemons() async {
    // Determine the URL: either initial query or the next URL from API response
    final String url =
        state.data == null ? _buildInitialUrl() : (state.data?.next ?? "");

    if (url.isEmpty) return;

    try {
      final Response? response = await _httpService.get(url);

      if (response != null && response.data != null) {
        final PokemonListData newData = PokemonListData.fromJson(response.data);

        // Update the state:
        state = state.copyWith(
          data:
              state.data == null
                  ? newData
                  : newData.copyWith(
                    results: [...?state.data?.results, ...?newData.results],
                  ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error loading Pokémon: $e");
      }
    }
  }
}
