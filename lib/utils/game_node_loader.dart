import 'package:cave_escape/models/game_state_model.dart';
import 'package:cave_escape/models/story_node_model.dart';
import 'package:cave_escape/screens/game_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/image.dart';
import 'logger.dart';

class GameNodeLoader {
  Future<Map<String, dynamic>?> loadNode(int nodeId) async {
    final nodeBox = await Hive.openBox<StoryNodeModel>('nodeBox');
    if (nodeId == 9999) {
      logger.i('Game ended with node ID: $nodeId');
      return null;
    }
    final node = nodeBox.get(nodeId);
    if (node == null) {
      return null;
    }
    final imageFile =
        node.imageId != null ? await getImagePath(node.imageId) : null;
    final nodeText = node.text;
    logger.d(
      'node: $node, text: $nodeText, imageFile: $imageFile, choices: ${node.choices}',
    );
    return {
      'node': node,
      'text': nodeText,
      'imageFile': imageFile,
      'choices': node.choices,
    };
  }

  Future<String> getImagePath(int imageId) async {
    final imageBox = await Hive.openBox<ImageMapping>('imageBox');
    final imageMapping = imageBox.get(imageId);
    if (imageMapping != null) {
      return 'assets/images/${imageMapping.imageFile}';
    } else {
      logger.e(Exception('Image not found for ID: $imageId'));
      return 'assets/images/ImageNotFound.webp';
    }
  }

  /// Loads the next node based on the selected choice's nextNodeId.
  Future<Map<String, dynamic>?> onChoiceSelect(
    int nextNodeId,
    BuildContext context,
  ) async {
    return await loadNode(nextNodeId);
  }

  Future<void> gameEndHandler(int nodeId, int gameId) async {
    final nodeBox = await Hive.openBox<StoryNodeModel>('nodeBox');
    final gameBox = await Hive.openBox<GameStateModel>('gameStateBox');
    GameStateModel? gameState;
    if (gameId == 0) {
      logger.e('Game ID is 0, The game encounter erro');
      return;
    } else {
      gameState = gameBox.get(gameId);
      if (gameState == null) {
        logger.e('Game with ID $gameId not found');
        return;
      }
      gameState.completionTimeInSeconds =
          DateTime.now().difference(gameState.playedAt).inSeconds;
    }
    final node = nodeBox.get(nodeId);
    if (node == null) {
      logger.e('Node with ID $nodeId not found');
      return;
    } else {
      if (node.isVictory) {
        gameState!.win = true;
        logger.i('Game ended with victory at node: $nodeId');
      } else {
        gameState!.win = false;
        logger.i('Game ended with defeat at node: $nodeId');
      }
    }
    logger.i(
      'Game with ID $gameId ended with state: ${gameState.completionTimeInSeconds}',
    );
    logger.i('Saving game state to game Id :${gameId}');
    await gameBox.put(gameId, gameState);
  }

  Future<int> startGame(DateTime startTime) async {
    final gameBox = await Hive.openBox<GameStateModel>('gameStateBox');
    final gameId = gameBox.length + 1;
    final gameState = GameStateModel(id: gameId, playedAt: startTime);
    await gameBox.put(gameId, gameState);
    logger.i('Game started with ID: $gameId at $startTime');
    return gameId;
  }
}
