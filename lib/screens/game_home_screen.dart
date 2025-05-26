import 'package:flutter/material.dart';

class GameHomeScreen extends StatefulWidget {
  const GameHomeScreen({super.key});

  @override
  State<GameHomeScreen> createState() => _GameHomeScreenState();
}

class _GameHomeScreenState extends State<GameHomeScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Fade in after build
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    debugPrint('GameHomeScreen size: ${size.width} x ${size.height}');
    return Scaffold(
      body: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: 1024,
            height: 1536,
            child: Stack(
              fit: StackFit.expand,
              children: [
                AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeIn,
                  child: Image.asset(
                    'assets/images/game_home_screen.webp',
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Text(
                    'Welcome to the Game',
                    style: TextStyle(fontFamily: 'Dirtyboy', fontSize: 60),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
