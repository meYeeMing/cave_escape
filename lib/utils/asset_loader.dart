import 'dart:convert';
import 'package:cave_escape/models/story_choice_model.dart';
import 'package:cave_escape/utils/logger.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import '../models/image.dart';
import '../models/game_state_model.dart';
import '../models/story_node_model.dart';

class AssetLoader {
  final List<void Function(double)> progressCallbacks = [];
  static String? cachedCaveSoundPath;

  void addProgressCallback(void Function(double) callback) {
    progressCallbacks.add(callback);
  }

  late double _progress;
  late int _completedTasks;
  late int _totalTasks;

  void _updateProgress() {
    _completedTasks++;
    _progress = _completedTasks / _totalTasks;
    for (var callback in progressCallbacks) {
      callback(_progress);
    }
  }

  Future<void> loadAllAssets([void Function(double)? onProgress]) async {
    if (onProgress != null) addProgressCallback(onProgress);

    _totalTasks = 10;
    _progress = 0.0;
    _completedTasks = 0;

    // Preload splash image
    await rootBundle.load('assets/images/splash_image.webp');
    _updateProgress();

    // Preload game home screen image
    await rootBundle.load('assets/images/game_home_screen.webp');
    _updateProgress();

    // Preload logo image
    await rootBundle.load(
      'assets/images/game_logo.webp',
    ); // Change path if needed
    _updateProgress();

    //load game image list
    logger.i('load image to hive');
    final imageListJson = await rootBundle.loadString('assets/image_list.json');
    final imageJson = jsonDecode(imageListJson)['imageList'];
    _updateProgress();
    final imageBox = await Hive.openBox<ImageMapping>('imageBox');
    _updateProgress();
    for (var item in imageJson) {
      await imageBox.put(
        item['id'],
        ImageMapping(id: item['id'], imageFile: item['imageFile']),
      );
    }

    _updateProgress();

    //load story node
    logger.i('load story node to hive');
    final nodeString = await rootBundle.loadString('assets/story.json');
    final nodeJson = jsonDecode(nodeString)['nodes'];
    _updateProgress();
    final nodeBox = await Hive.openBox<StoryNodeModel>('nodeBox');
    _updateProgress();
    //total 23 nodes
    for (var nodeJson in nodeJson) {
      final node = _parseNode(nodeJson);
      await nodeBox.put(node.id, node);
    }
    _updateProgress();

    logger.i('check any game state in hive.');
    final gameBox = await Hive.openBox<GameStateModel>('gameStateBox');
    bool hasData = gameBox.isNotEmpty;
    List<GameStateModel> allRecords = gameBox.values.toList();

    _updateProgress();
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
      id: json['nodeId'],
      text: json['text'],
      imageId: int.parse(json['imageId'].toString()),
      choices: choices,
      isGameOver: json['isGameOver'] ?? false,
      isVictory: json['isVictory'] ?? false,
    );
  }
}
