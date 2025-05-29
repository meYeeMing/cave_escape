import 'package:cave_escape/theme/app_styles.dart';
import 'package:cave_escape/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:cave_escape/models/game_state_model.dart';

class GameStateTable extends StatelessWidget {
  final List<GameStateModel> gameStates;

  const GameStateTable({super.key, required this.gameStates});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: SingleChildScrollView(
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(
              AppColors.rock.withAlpha(180),
            ),
            columnSpacing: 60,
            columns: const [
              DataColumn(
                label: Center(
                  child: Text('Game #', style: AppStyles.tableHeader),
                ),
              ),
              DataColumn(
                label: Center(child: Text('Win', style: AppStyles.tableHeader)),
              ),
              DataColumn(
                label: Center(
                  child: Text('Completion Time', style: AppStyles.tableHeader),
                ),
              ),
              DataColumn(
                label: Center(
                  child: Text('Played At', style: AppStyles.tableHeader),
                ),
              ),
            ],
            rows:
                gameStates
                    .map((gameState) => _buildDataRow(gameState))
                    .toList(),
          ),
        ),
      ),
    );
  }
  DataRow _buildDataRow(GameStateModel gameState) {
    return DataRow(
      cells: [
        DataCell(
          Center(
            child: Text('${gameState.id + 1}', style: AppStyles.tableText),
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
  }
}
