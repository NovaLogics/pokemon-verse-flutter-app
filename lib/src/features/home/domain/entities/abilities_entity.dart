import 'ability_entity.dart';

class AbilitiesEntity {
  final AbilityEntity ability;
  final bool isHidden;
  final int slot;

  AbilitiesEntity({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  @override
  String toString() {
    return 'AbilitiesEntity(ability: $ability, isHidden: $isHidden, slot: $slot)';
  }
}