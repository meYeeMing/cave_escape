import 'package:flutter/material.dart';

class GameStateScreen extends StatefulWidget {
  const GameStateScreen({super.key});

  @override
  State<GameStateScreen> createState() => _GameStateScreenState();
}

class _GameStateScreenState extends State<GameStateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Game Play Screen')));
  }
}
