import 'package:cave_escape/screens/game_home_screen.dart';
import 'package:cave_escape/utils/asset_loader.dart';
import 'package:flutter/material.dart';
import 'package:cave_escape/animations/Fade_out_background.dart';
import 'package:cave_escape/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;
  bool _fadeOut = false;

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
        debugPrint("Progress updated: $_progress");
      });
    });

    setState(() {
      _fadeOut = true; // Start fading out after loading assets
    });

    // After loading, navigate to main screen
    await Future.delayed(const Duration(milliseconds: 800));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => GameHomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FadeBackground(
            imagePath: 'assets/images/splash_image.webp',
            fadeOut: _fadeOut,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.1,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Game is Starting..",
                      style: TextStyle(fontFamily: 'Dirtyboy', fontSize: 60),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${(100 * _progress).toInt()}%',
                      style: TextStyle(fontFamily: 'Dirtyboy', fontSize: 35),
                    ),
                  ),
                  const SizedBox(height: 30),
                  LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: AppColors.stone,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.accentGold,
                    ),
                    minHeight: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
