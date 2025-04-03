import '../../domain/entities/pokemon_list_result_entity.dart';

class PokemonListResultModel {
  final String name;
  final String url;

  PokemonListResultModel({required this.name, required this.url});

  PokemonListResultModel copyWith({
    String? name,
    String? url,
  }) {
    return PokemonListResultModel(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  factory PokemonListResultModel.fromJson(Map<String, dynamic> json) {
    return PokemonListResultModel(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }

  PokemonListResultEntity toEntity() {
    return PokemonListResultEntity(name: name, url: url);
  }
}