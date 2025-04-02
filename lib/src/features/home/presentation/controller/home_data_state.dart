import 'package:pokemonverse/src/features/home/data/models/pokemon.dart';

class HomeDataState {
  final PokemonListData? data;

  HomeDataState({required this.data});

  HomeDataState.initial() : data = null;

  HomeDataState copyWith({PokemonListData? data}) {
    return HomeDataState(data: data ?? this.data);
  }
}
