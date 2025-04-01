import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemonverse/src/data/models/page_data.dart';
import 'package:pokemonverse/src/data/models/pokemon.dart';
import 'package:pokemonverse/src/data/services/http_service.dart';

class HomeController extends StateNotifier<HomePageData> {
  final GetIt _getIt = GetIt.instance;

  late HttpService _httpService;

  HomeController(super._state) {
    _httpService = _getIt.get<HttpService>();
    loadPokemons();
  }

  Future<void> loadPokemons() async {
    if (state.data == null) {
      Response? response = await _httpService.get(
        "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0",
      );

      if (response != null && response.data != null) {
        PokemonListData data = PokemonListData.fromJson(response.data);
        state = state.copyWith(data: data);
      }
    } else {
      if (state.data?.next != null) {
        Response? response = await _httpService.get(state.data!.next!);

        if (response != null && response.data != null) {
          PokemonListData data = PokemonListData.fromJson(response.data);
          state = state.copyWith(
            data: data.copyWith(
              results: [...?state.data?.results, ...?data.results],
            ),
          );
        }
      }
    }
  }
}
