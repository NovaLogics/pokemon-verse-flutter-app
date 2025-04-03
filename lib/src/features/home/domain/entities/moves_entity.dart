import 'ability_entity.dart';

class MovesEntity {
  final AbilityEntity move;

  MovesEntity({required this.move});

  MovesEntity copyWith({
    AbilityEntity? move,
  }) {
    return MovesEntity(
      move: move ?? this.move,
    );
  }
}