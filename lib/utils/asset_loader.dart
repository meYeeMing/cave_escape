import 'dart:convert';
import 'package:cave_escape/models/story_choice_model.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import '../models/image.dart';
import '../models/game_state_model.dart';
import '../models/story_node_model.dart';

class AssetLoader {
  Future<void> loadAllAssets(Function(double) progressCallback) async {
    double progress = 0.0;
    int totalTasks = 3; // number of different asset types
    int completedTasks = 0;

    //load game image list
    final imageListJson = await rootBundle.loadString('assets/image_list.json');
    final imageJson = jsonDecode(imageListJson)['imageList'];
    final imageBox = await Hive.openBox<ImageMapping>('imageBox');
    for (var item in imageJson) {
      await imageBox.put(
        item['id'],
        ImageMapping(id: item['id'], imageFile: item['imageFile']),
      );
    }
    completedTasks++;
    progress = completedTasks / totalTasks;
    progressCallback(progress);

    //load story node
    final nodeString = await rootBundle.loadString('assets/story.json');
    final nodeJson = jsonDecode(nodeString)['nodes'];
    final nodeBox = await Hive.openBox<StoryNodeModel>('nodeBox');
    for (var nodeJson in nodeJson) {
      final node = _parseNode(nodeJson);
      await nodeBox.put(node.id, node);
    }

    final gameBox = await Hive.openBox<GameStateModel>('gameStateBox');
    bool hasData = gameBox.isNotEmpty;
    List<GameStateModel> allRecords = gameBox.values.toList();

    completedTasks++;
    progress = completedTasks / totalTasks;
    progressCallback(progress);
  }

  StoryChoiceModel _parseChoice(Map<String, dynamic> json) {
    return StoryChoiceModel(
      text: json['text'],
      nextNodeId: int.parse(json['nextNodeId'].toString()),
    );
  }

  StoryNodeModel _parseNode(Map<String, dynamic> json) {
    var choicesJson = json['choices'] as List<dynamic>;
    List<StoryChoiceModel> choices =
        choicesJson.map((e) => _parseChoice(e)).toList();

    return StoryNodeModel(
      id: json['id'],
      text: json['text'],
      imageId: int.parse(json['imageId'].toString()),
      choices: choices,
    );
  }
}
