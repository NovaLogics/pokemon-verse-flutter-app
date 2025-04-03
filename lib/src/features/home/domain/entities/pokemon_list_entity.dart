import 'pokemon_list_result_entity.dart';

class PokemonListEntity {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonListResultEntity> results;

  PokemonListEntity({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  PokemonListEntity copyWith({
    int? count,
    String? next,
    String? previous,
    List<PokemonListResultEntity>? results,
  }) {
    return PokemonListEntity(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}