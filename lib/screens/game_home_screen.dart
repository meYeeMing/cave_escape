import 'package:cave_escape/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:cave_escape/theme/app_styles.dart';
import 'package:cave_escape/animations/fade_effect.dart';

class GameHomeScreen extends StatefulWidget {
  const GameHomeScreen({super.key});

  @override
  State<GameHomeScreen> createState() => _GameHomeScreenState();
}

class _GameHomeScreenState extends State<GameHomeScreen> {
  double _opacity = 0.0;
  bool _isHoveringStart = false;
  bool _isHoveringState = false;

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
            width: 1000,
            height: 1280,
            child: Stack(
              fit: StackFit.expand,
              children: [
                FadeEffect(
                  fadetype: FadeType.fadeOut,
                  fadeTrigger: true,
                  endOpacity: _opacity,
                  duration: const Duration(milliseconds: 500),
                  child: Image.asset(
                    'assets/images/game_home_screen.webp',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                    bottom: MediaQuery.of(context).size.height * 0.1,
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1,
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
                                fit: BoxFit.fill,
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
                      const SizedBox(width: 50, height: 600),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: MouseRegion(
                          onEnter:
                              (_) => setState(() => _isHoveringStart = true),
                          onExit:
                              (_) => setState(() => _isHoveringStart = false),
                          child: GestureDetector(
                            onTap: () => Utils.pageNavigation(context, 'newgame'),
                            child: Text(
                              'Start Game',
                              style: AppStyles.menuButtonText.copyWith(
                                color:
                                    _isHoveringStart
                                        ? AppColors.glowCyan
                                        : AppStyles.menuButtonText.color,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: MouseRegion(
                          onEnter:
                              (_) => setState(() => _isHoveringState = true),
                          onExit:
                              (_) => setState(() => _isHoveringState = false),
                          child: GestureDetector(
                            onTap: () => Utils.pageNavigation(context, 'gamestate'),
                            child: Text(
                              'Game State',
                              style: AppStyles.menuButtonText.copyWith(
                                color:
                                    _isHoveringState
                                        ? AppColors.glowCyan
                                        : AppStyles.menuButtonText.color,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
