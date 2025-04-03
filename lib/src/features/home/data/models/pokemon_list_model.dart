import '../../domain/entities/pokemon_list_entity.dart';
import 'pokemon_list_result_model.dart';

class PokemonListModel {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonListResultModel> results;

  PokemonListModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  PokemonListModel copyWith({
    int? count,
    String? next,
    String? previous,
    List<PokemonListResultModel>? results,
  }) {
    return PokemonListModel(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  factory PokemonListModel.fromJson(Map<String, dynamic> json) {
    return PokemonListModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((item) => PokemonListResultModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((item) => item.toJson()).toList(),
    };
  }

  PokemonListEntity toEntity() {
    return PokemonListEntity(
      count: count,
      next: next,
      previous: previous,
      results: results.map((item) => item.toEntity()).toList(),
    );
  }
}