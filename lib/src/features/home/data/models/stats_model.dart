import '../../domain/entities/stats_entity.dart';
import 'ability_model.dart';

class StatsModel {
  final int baseStat;
  final int effort;
  final AbilityModel stat;

  StatsModel({required this.baseStat, required this.effort, required this.stat});

  StatsModel copyWith({
    int? baseStat,
    int? effort,
    AbilityModel? stat,
  }) {
    return StatsModel(
      baseStat: baseStat ?? this.baseStat,
      effort: effort ?? this.effort,
      stat: stat ?? this.stat,
    );
  }

  factory StatsModel.fromJson(Map<String, dynamic> json) {
    return StatsModel(
      baseStat: json['base_stat'],
      effort: json['effort'],
      stat: AbilityModel.fromJson(json['stat']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'base_stat': baseStat,
      'effort': effort,
      'stat': stat.toJson(),
    };
  }

  StatsEntity toEntity() {
    return StatsEntity(baseStat: baseStat, effort: effort, stat: stat.toEntity());
  }
}