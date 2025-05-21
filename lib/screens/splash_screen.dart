import 'package:cave_escape/screens/game_home_screen.dart';
import 'package:cave_escape/utils/asset_loader.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _loadAssets();
  }

  Future<void> _loadAssets() async {
    final loader = AssetLoader();

    await loader.loadAllAssets((double progress) {
      setState(() {
        _progress = progress;
      });
    });

    // After loading, navigate to main screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => GameHomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Loading... ${(100 * _progress).toInt()}%"),
            const SizedBox(height: 20),
            LinearProgressIndicator(value: _progress),
          ],
        ),
      ),
    );
  }
}
