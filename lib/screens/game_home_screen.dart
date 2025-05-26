import 'package:flutter/material.dart';

class GameHomeScreen extends StatelessWidget {
  const GameHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome to the Game',
          style: TextStyle(fontFamily: 'Dirtyboy', fontSize: 20),
        ),
      ),
    );
  }
}
