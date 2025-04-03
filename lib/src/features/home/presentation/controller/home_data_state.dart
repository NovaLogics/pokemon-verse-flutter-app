import '../../domain/entities/pokemon_list_entity.dart';

class HomeDataState {
  final PokemonListEntity? data;

  HomeDataState({required this.data});

  HomeDataState.initial() : data = null;

  HomeDataState copyWith({PokemonListEntity? data}) {
    return HomeDataState(data: data ?? this.data);
  }
}
