import '../../domain/entities/abilities_entity.dart';
import 'ability_model.dart';

class AbilitiesModel {
  final AbilityModel ability;
  final bool isHidden;
  final int slot;

  AbilitiesModel({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  AbilitiesModel copyWith({
    AbilityModel? ability,
    bool? isHidden,
    int? slot,
  }) {
    return AbilitiesModel(
      ability: ability ?? this.ability,
      isHidden: isHidden ?? this.isHidden,
      slot: slot ?? this.slot,
    );
  }

  factory AbilitiesModel.fromJson(Map<String, dynamic> json) {
    return AbilitiesModel(
      ability: AbilityModel.fromJson(json['ability']),
      isHidden: json['is_hidden'],
      slot: json['slot'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ability': ability.toJson(),
      'is_hidden': isHidden,
      'slot': slot,
    };
  }

  AbilitiesEntity toEntity() {
    return AbilitiesEntity(
      ability: ability.toEntity(),
      isHidden: isHidden,
      slot: slot,
    );
  }
}