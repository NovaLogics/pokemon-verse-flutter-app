import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemonverse/src/core/services/database_service.dart';

final favoritePokemonProvider = StateNotifierProvider<FavoritePokemonProvider, List<String>>(
  (ref) => FavoritePokemonProvider([]),
);

class FavoritePokemonProvider extends StateNotifier<List<String>> {
  final DatabaseService _databaseService = GetIt.instance.get<DatabaseService>();

  String FAVOURITE_POKEMON_LIST_KEY = "FAVOURITE_POKEMON_LIST_KEY";
  
  FavoritePokemonProvider(super._state) {
    _setup();
  }

  Future<void> _setup() async {
    List<String>? list = await _databaseService.getList(FAVOURITE_POKEMON_LIST_KEY);
    state = list ?? [];
  }

  void addFavoritePokemon(String url){
    state = [...state, url];
    _databaseService.saveList(FAVOURITE_POKEMON_LIST_KEY, state);
  }

  void removeFavoritePokemon(String url){
    state = state.where((element) => element != url).toList();
      _databaseService.saveList(FAVOURITE_POKEMON_LIST_KEY, state);
  }
}
