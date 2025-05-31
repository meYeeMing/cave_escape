import 'dart:async';
import 'package:cave_escape/theme/app_styles.dart';
import 'package:cave_escape/utils/game_node_loader.dart';
import 'package:cave_escape/utils/utils.dart';
import 'package:cave_escape/widgets/choice_button.dart';
import 'package:flutter/material.dart';

class GamePlayScreen extends StatefulWidget {
  const GamePlayScreen({super.key});

  @override
  State<GamePlayScreen> createState() => _GamePlayScreen();
}

class _GamePlayScreen extends State<GamePlayScreen> {
  bool _showStartImage = true;
  Map<String, dynamic>? _nodeData;
  int? _currentNodeId;
  int? _gameId;

  final GameNodeLoader _gameNodeLoader = GameNodeLoader();

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _startGame() async {
    _gameId = await _gameNodeLoader.startGame(DateTime.now());
    if (!mounted) return;
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    _nodeData = await _gameNodeLoader.loadNode(0);
    if (!mounted) return;
    setState(() {
      _showStartImage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showStartImage) {
      return Scaffold(
        body: Center(
          child: Image.asset(
            'assets/images/game_start.webp',
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    if (_nodeData == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Center(
              child: Center(
                child: SizedBox(
                  width: 1000,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child:
                            _nodeData?['imageFile'] != null
                                ? Image.asset(
                                  _nodeData!['imageFile'],
                                  fit: BoxFit.cover,
                                )
                                : const SizedBox.shrink(),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.05,
                            bottom: MediaQuery.of(context).size.height * 0.1,
                            left: MediaQuery.of(context).size.width * 0.1,
                            right: MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 1000,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32.0,
                                  vertical: 16.0,
                                ),
                                color: AppColors.rock.withValues(alpha: 0.7),
                                child: Text(
                                  _nodeData?['text'] ?? '',
                                  style: AppStyles.nodeText,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 15),
                              ...?_nodeData?['choices']?.map<Widget>(
                                (choice) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 24.0,
                                  ),
                                  child: ChoiceButton(
                                    text: choice.text,
                                    onPressed: () async {
                                      _currentNodeId = _nodeData!['node'].id;
                                      _nodeData = await _gameNodeLoader
                                          .loadNode(choice.nextNodeId);
                                      if (_nodeData == null &&
                                          choice.nextNodeId == 9999) {
                                        await _gameNodeLoader.gameEndHandler(
                                          _currentNodeId!,
                                          _gameId!,
                                        );
                                        await Future.delayed(
                                          const Duration(milliseconds: 500),
                                        );
                                        Utils.pageNavigation(
                                          context,
                                          'gamehome',
                                        );
                                        return;
                                      }
                                      if (!mounted) return;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
