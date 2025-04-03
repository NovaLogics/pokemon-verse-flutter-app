class SpritesEntity {
  final String frontDefault;

  SpritesEntity({required this.frontDefault});

  SpritesEntity copyWith({
    String? frontDefault,
  }) {
    return SpritesEntity(
      frontDefault: frontDefault ?? this.frontDefault,
    );
  }
}