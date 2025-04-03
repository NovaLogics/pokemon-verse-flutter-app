import '../../domain/entities/moves_entity.dart';
import 'ability_model.dart';

class MovesModel {
  final AbilityModel move;

  MovesModel({required this.move});

  MovesModel copyWith({
    AbilityModel? move,
  }) {
    return MovesModel(
      move: move ?? this.move,
    );
  }

  factory MovesModel.fromJson(Map<String, dynamic> json) {
    return MovesModel(
      move: AbilityModel.fromJson(json['move']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'move': move.toJson(),
    };
  }

  MovesEntity toEntity() {
    return MovesEntity(move: move.toEntity());
  }
}