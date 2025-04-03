import 'abilities_entity.dart';
import 'ability_entity.dart';
import 'moves_entity.dart';
import 'sprites_entity.dart';
import 'stats_entity.dart';

class PokemonEntity {
  final List<AbilitiesEntity> abilities;
  final int height;
  final int id;
  final List<MovesEntity> moves;
  final String name;
  final AbilityEntity species;
  final SpritesEntity sprites;
  final List<StatsEntity> stats;
  final int weight;

  PokemonEntity({
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

  PokemonEntity copyWith({
    List<AbilitiesEntity>? abilities,
    int? height,
    int? id,
    List<MovesEntity>? moves,
    String? name,
    AbilityEntity? species,
    SpritesEntity? sprites,
    List<StatsEntity>? stats,
    int? weight,
  }) {
    return PokemonEntity(
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
}