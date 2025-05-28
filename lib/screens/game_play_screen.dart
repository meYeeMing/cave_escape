import 'dart:async';
import 'package:cave_escape/screens/game_home_screen.dart';
import 'package:cave_escape/theme/app_styles.dart';
import 'package:cave_escape/utils/game_node_loader.dart';
import 'package:cave_escape/widgets/choice_button.dart';
import 'package:flutter/material.dart';

class GamePlayScreen extends StatefulWidget {
  const GamePlayScreen({super.key});

  @override
  State<GamePlayScreen> createState() => _GamePlayScreen();
}

class _GamePlayScreen extends State<GamePlayScreen> {
  bool _showStartImage = true;
  final GameNodeLoader _gameNodeLoader = GameNodeLoader();
  Map<String, dynamic>? _nodeData;
  int? _currentNodeId;
  int? _gameId;

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
    await Future.delayed(const Duration(seconds: 1));
    _nodeData = await _gameNodeLoader.loadNode(0);
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
              child: FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  width: 1000,
                  height: 1280,
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
                            bottom: 100.0,
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
                                color: AppColors.rock.withOpacity(0.7),
                                child: Text(
                                  _nodeData?['text'] ?? '',
                                  style: AppStyles.nodeText,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 24),
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
                                          _gameId!
                                        );
                                        await Future.delayed(
                                          const Duration(seconds: 1),
                                        );
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => GameHomeScreen(),
                                          ),
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
