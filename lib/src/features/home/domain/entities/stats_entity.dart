import 'ability_entity.dart';

class StatsEntity {
  final int baseStat;
  final int effort;
  final AbilityEntity stat;

  StatsEntity({required this.baseStat, required this.effort, required this.stat});

  StatsEntity copyWith({
    int? baseStat,
    int? effort,
    AbilityEntity? stat,
  }) {
    return StatsEntity(
      baseStat: baseStat ?? this.baseStat,
      effort: effort ?? this.effort,
      stat: stat ?? this.stat,
    );
  }
}