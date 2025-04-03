import '../../domain/entities/pokemon_entity.dart';
import 'abilities_model.dart';
import 'ability_model.dart';
import 'moves_model.dart';
import 'sprites_model.dart';
import 'stats_model.dart';


class PokemonModel {
  final List<AbilitiesModel> abilities;
  final int height;
  final int id;
  final List<MovesModel> moves;
  final String name;
  final AbilityModel species;
  final SpritesModel sprites;
  final List<StatsModel> stats;
  final int weight;

  PokemonModel({
    required this.abilities,
    required this.height,
    required this.id,
    required this.moves,
    required this.name,
    required this.species,
    required this.sprites,
    required this.stats,
    required this.weight,
  });

  PokemonModel copyWith({
    List<AbilitiesModel>? abilities,
    int? height,
    int? id,
    List<MovesModel>? moves,
    String? name,
    AbilityModel? species,
    SpritesModel? sprites,
    List<StatsModel>? stats,
    int? weight,
  }) {
    return PokemonModel(
      abilities: abilities ?? this.abilities,
      height: height ?? this.height,
      id: id ?? this.id,
      moves: moves ?? this.moves,
      name: name ?? this.name,
      species: species ?? this.species,
      sprites: sprites ?? this.sprites,
      stats: stats ?? this.stats,
      weight: weight ?? this.weight,
    );
  }

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      abilities: (json['abilities'] as List)
          .map((item) => AbilitiesModel.fromJson(item))
          .toList(),
      height: json['height'],
      id: json['id'],
      moves: (json['moves'] as List)
          .map((item) => MovesModel.fromJson(item))
          .toList(),
      name: json['name'],
      species: AbilityModel.fromJson(json['species']),
      sprites: SpritesModel.fromJson(json['sprites']),
      stats: (json['stats'] as List)
          .map((item) => StatsModel.fromJson(item))
          .toList(),
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'abilities': abilities.map((item) => item.toJson()).toList(),
      'height': height,
      'id': id,
      'moves': moves.map((item) => item.toJson()).toList(),
      'name': name,
      'species': species.toJson(),
      'sprites': sprites.toJson(),
      'stats': stats.map((item) => item.toJson()).toList(),
      'weight': weight,
    };
  }

  PokemonEntity toEntity() {
    return PokemonEntity(
      abilities: abilities.map((item) => item.toEntity()).toList(),
      height: height,
      id: id,
      moves: moves.map((item) => item.toEntity()).toList(),
      name: name,
      species: species.toEntity(),
      sprites: sprites.toEntity(),
      stats: stats.map((item) => item.toEntity()).toList(),
      weight: weight,
    );
  }
}