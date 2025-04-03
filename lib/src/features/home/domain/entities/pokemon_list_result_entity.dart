class PokemonListResultEntity {
  final String name;
  final String url;

  PokemonListResultEntity({required this.name, required this.url});

  PokemonListResultEntity copyWith({
    String? name,
    String? url,
  }) {
    return PokemonListResultEntity(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }
}