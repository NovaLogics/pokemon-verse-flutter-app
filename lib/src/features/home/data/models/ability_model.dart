import '../../domain/entities/ability_entity.dart';

class AbilityModel {
  final String name;
  final String url;

  AbilityModel({required this.name, required this.url});

  AbilityModel copyWith({
    String? name,
    String? url,
  }) {
    return AbilityModel(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  factory AbilityModel.fromJson(Map<String, dynamic> json) {
    return AbilityModel(
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

  AbilityEntity toEntity() {
    return AbilityEntity(name: name, url: url);
  }
}