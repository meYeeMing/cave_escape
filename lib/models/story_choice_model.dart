import 'package:hive/hive.dart';

part 'story_choice_model.g.dart';

@HiveType(typeId: 1)
class StoryChoiceModel {
  @HiveField(0)
  final String text;

  @HiveField(1)
  final int nextNodeId;

  StoryChoiceModel({required this.text, required this.nextNodeId});
}
