import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemonverse/src/core/services/database_service.dart';

// Provider for managing the favorite Pokémon list
final favoritePokemonProvider = StateNotifierProvider<FavoritePokemonNotifier, List<String>>(
  (ref) => FavoritePokemonNotifier(),
);

class FavoritePokemonNotifier extends StateNotifier<List<String>> {
  final DatabaseService _databaseService = GetIt.instance.get<DatabaseService>();
  static const String _favoritePokemonListKey = "favorite_pokemon_list";

  FavoritePokemonNotifier() : super([]) {
    _loadFavorites(); 
  }

  Future<void> _loadFavorites() async {
    final List<String>? savedList = await _databaseService.getStringList(_favoritePokemonListKey);
    if (savedList != null) {
      state = savedList;
    }
  }

  void addFavoritePokemon(String pokemonUrl) {
    if (!state.contains(pokemonUrl)) {
      state = [...state, pokemonUrl];
      _saveFavorites();
    }
  }

  void removeFavoritePokemon(String pokemonUrl) {
    state = state.where((url) => url != pokemonUrl).toList();
    _saveFavorites();
  }

  void _saveFavorites() {
    _databaseService.saveStringList(_favoritePokemonListKey, state);
  }
}