class AbilityEntity {
  final String name;
  final String url;

  AbilityEntity({required this.name, required this.url});

  AbilityEntity copyWith({
    String? name,
    String? url,
  }) {
    return AbilityEntity(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }
}