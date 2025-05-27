import 'package:cave_escape/screens/game_home_screen.dart';
import 'package:cave_escape/utils/asset_loader.dart';
import 'package:cave_escape/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:cave_escape/animations/fade_effect.dart';
import 'package:cave_escape/theme/app_styles.dart';
import 'package:cave_escape/widgets/splash_welcome_message.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;
  bool _fadeOut = false;
  bool _showWelcome = false;
  bool _fadeOutWelcome = false;

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
        if (_progress == 1.0) {
          _fadeOut = true;
        }
      });
    });
    await Future.delayed(const Duration(milliseconds: 1000));

    setState(() {
      _showWelcome = true;
    });
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      _fadeOutWelcome = true; // Make sure fade out is not triggered yet
    });
    await Future.delayed(const Duration(seconds: 3));
    logger.i('All assets loaded successfully! Navigateing to GameHomeScreen...');
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
          FadeEffect(
            fadetype: FadeType.fadeInOut,
            duration: const Duration(milliseconds: 11000),
            fadeTrigger: _fadeOut,
            child: Image.asset(
              'assets/images/splash_image.webp',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: FadeEffect(
              fadetype: FadeType.fadeInOut,
              fadeTrigger: _fadeOut,
              duration: const Duration(milliseconds: 1000),
              endOpacity: 0.0,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.1,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 300,
                            height: 250,
                            child: Image.asset(
                              'assets/images/game_logo.webp',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            "Text Adventure",
                            style: AppStyles.header3,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Game is Starting..",
                            style: AppStyles.header2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${(100 * _progress).toInt()}%',
                            style: AppStyles.header3,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 30),
                        LinearProgressIndicator(
                          value: _progress,
                          backgroundColor: AppColors.stone,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.parchment,
                          ),
                          minHeight: 20.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_showWelcome)
            FadeEffect(
              fadetype: FadeType.fadeInOut,
              fadeTrigger: _fadeOutWelcome,
              endOpacity: 0.0,
              duration: const Duration(milliseconds: 3000),
              child: const SplashWelcomeMessage(),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
