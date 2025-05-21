import 'package:hive/hive.dart';

part 'game_state_model.g.dart';

@HiveType(typeId: 2)
class GameStateModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  bool winLoss;

  @HiveField(2)
  final int completionTimeInSeconds;

  @HiveField(3)
  final int movesTaken;

  @HiveField(4)
  final DateTime playedAt;

  GameStateModel({
    required this.id,
    required this.winLoss,
    this.completionTimeInSeconds = 0,
    this.movesTaken = 0,
    required this.playedAt,
  });
}
