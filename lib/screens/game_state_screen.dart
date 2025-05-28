import 'package:cave_escape/models/game_state_model.dart';
import 'package:cave_escape/theme/app_styles.dart';
import 'package:cave_escape/utils/logger.dart';
import 'package:cave_escape/utils/utils.dart';
import 'package:cave_escape/widgets/choice_button.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class GameStateScreen extends StatefulWidget {
  const GameStateScreen({super.key});

  @override
  State<GameStateScreen> createState() => _GameStateScreenState();
}

class _GameStateScreenState extends State<GameStateScreen> {
  final Box<GameStateModel> gameStateBox = Hive.box<GameStateModel>(
    'gameStateBox',
  );

  @override
  void initState() {
    super.initState();
    logger.i('GameStateBox loaded successfully');
    if (gameStateBox.isEmpty) {
      logger.w('No game state found in the box.');
    } else {
      logger.i('GameState loaded: ${gameStateBox.length} entries');
    }
  }

  @override
  void dispose() {
    // Do not close the box here if you use it elsewhere in the app!
    super.dispose();
  }

  List sortGameState() {
    final gameStates = gameStateBox.values.toList();
    gameStates.sort((a, b) {
      if (a.win != b.win) {
        return b.win ? 1 : -1; // win=true first
      }
      return a.completionTimeInSeconds.compareTo(
        b.completionTimeInSeconds,
      );
    });
    return gameStates;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            // Title
            Center(
              child: Text(
                'Game State',
                style: AppStyles.header2,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Builder(
                builder: (context) {
                  final gameStates = sortGameState();

                  if (gameStates.isEmpty) {
                    return const Center(child: Text('No game state found.'));
                  }

                  return Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: SingleChildScrollView(
                        child: DataTable(
                          headingRowColor: WidgetStateProperty.all(
                            AppColors.rock.withValues(alpha: 0.7),
                          ),
                          columnSpacing: 60,
                          columns: const [
                            DataColumn(
                              label: Center(
                                child: Text(
                                  'Game #',
                                  style: AppStyles.tableHeader,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Center(
                                child: Text(
                                  'Win',
                                  style: AppStyles.tableHeader,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Center(
                                child: Text(
                                  'Completion Time',
                                  style: AppStyles.tableHeader,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Center(
                                child: Text(
                                  'Played At',
                                  style: AppStyles.tableHeader,
                                ),
                              ),
                            ),
                          ],
                          rows:
                              gameStates.map((gameState) {
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Center(
                                        child: Text(
                                          '${gameState.id + 1}',
                                          style: AppStyles.tableText,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          gameState.win ? 'Win' : 'Loss',
                                          style: AppStyles.tableText,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          '${gameState.completionTimeInSeconds} Seconds',
                                          style: AppStyles.tableText,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          Utils.formatDate(gameState.playedAt),
                                          style: AppStyles.tableText,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.05,
                ),
                child: ChoiceButton(
                  text: 'Back to Home',
                  onPressed: () => Utils.pageNavigation(context, 'gamehome'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
