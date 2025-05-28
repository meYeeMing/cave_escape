import 'package:hive/hive.dart';
import 'story_choice_model.dart';

part 'story_node_model.g.dart';

@HiveType(typeId: 0)
class StoryNodeModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String text;

  @HiveField(2)
  int imageId;

  @HiveField(3)
  List<StoryChoiceModel> choices;

  @HiveField(4)
  bool isVictory;
  
  @HiveField(5)
  bool isGameOver;

  StoryNodeModel({
    required this.id,
    required this.text,
    required this.imageId,
    required this.choices,
    this.isVictory = false,
    this.isGameOver = false,
  });
}
