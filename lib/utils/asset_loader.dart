import 'dart:convert';
import 'package:cave_escape/models/game_state_model.dart';
import 'package:cave_escape/models/story_choice_model.dart';
import 'package:cave_escape/utils/logger.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import '../models/image.dart';
import '../models/story_node_model.dart';

class AssetLoader {
  final List<void Function(double)> progressCallbacks = [];
  static String? cachedCaveSoundPath;
  final Box<StoryNodeModel> nodeBox = Hive.box<StoryNodeModel>('nodeBox');
  final Box<ImageMapping> imageBox = Hive.box<ImageMapping>('imageBox');
  final Box<GameStateModel> gameStateBox = Hive.box<GameStateModel>(
    'gameStateBox',
  );

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

    _totalTasks = 28;
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
    ); 
    _updateProgress();

    //load game image list
    logger.i('load image');
    final imageListJson = await rootBundle.loadString('assets/image_list.json');
    final imageJson = jsonDecode(imageListJson)['imageList'];
    _updateProgress();
    for (var item in imageJson) {
      await imageBox.put(
        item['id'],
        ImageMapping(id: item['id'], imageFile: item['imageFile']),
      );
    }

    _updateProgress();

    //load story node
    logger.i('load story node');
    final nodeString = await rootBundle.loadString('assets/story.json');
    final nodeJson = jsonDecode(nodeString)['nodes'];
    _updateProgress();
    for (var nodeJson in nodeJson) {
      final node = _parseNode(nodeJson);
      await nodeBox.put(node.id, node);
      _updateProgress();
    }
    
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
