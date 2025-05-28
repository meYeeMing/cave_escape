import 'package:cave_escape/models/game_state_model.dart';
import 'package:cave_escape/screens/game_home_screen.dart';
import 'package:cave_escape/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class GameStateScreen extends StatefulWidget {
  const GameStateScreen({super.key});

  @override
  State<GameStateScreen> createState() => _GameStateScreenState();
}

class _GameStateScreenState extends State<GameStateScreen> {
  late Future<Box<GameStateModel>> _gameBox;

  @override
  void initState() {
    super.initState();
    _gameBox = Hive.openBox<GameStateModel>('gameStateBox');
    _gameBox.then((box) {
      logger.i('GameStateBox loaded successfully');
      if (box.isEmpty) {
        logger.w('No game state found in the box.');
      } else {
        logger.i('GameState loaded: ${box.length} entries');
      }
    });
  }

  @override
  void dispose() {
    _gameBox.then((box) => box.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game State')),
      body: Stack(
        children: [
          FutureBuilder<Box<GameStateModel>>(
            future: _gameBox,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No data found.'));
              }

              final box = snapshot.data!;
              final gameStates = box.values.toList();

              if (gameStates.isEmpty) {
                return const Center(child: Text('No game state found.'));
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('GameState')),
                    DataColumn(label: Text('Win')),
                    DataColumn(label: Text('Completion Time')),
                    DataColumn(label: Text('Moves Taken')),
                    DataColumn(label: Text('Played At')),
                  ],
                  rows: gameStates.map((gameState) {
                    return DataRow(
                      cells: [
                        DataCell(Text('${gameState.id}')),
                        DataCell(Text('${gameState.win}')),
                        DataCell(Text('${gameState.completionTimeInSeconds}')),
                        DataCell(Text('${gameState.movesTaken}')),
                        DataCell(Text('${gameState.playedAt}')),
                      ],
                    );
                  }).toList(),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.05,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => GameHomeScreen()),
                    (route) => false,
                  );
                },
                child: Text(
                  'Back to Home',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}