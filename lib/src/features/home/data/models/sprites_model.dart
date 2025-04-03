import '../../domain/entities/sprites_entity.dart';

class SpritesModel {
  final String frontDefault;

  SpritesModel({required this.frontDefault});

  SpritesModel copyWith({
    String? frontDefault,
  }) {
    return SpritesModel(
      frontDefault: frontDefault ?? this.frontDefault,
    );
  }

  factory SpritesModel.fromJson(Map<String, dynamic> json) {
    return SpritesModel(
      frontDefault: json['front_default'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'front_default': frontDefault,
    };
  }

  SpritesEntity toEntity() {
    return SpritesEntity(frontDefault: frontDefault);
  }
}