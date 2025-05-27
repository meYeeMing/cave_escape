import 'package:flutter/material.dart';
import 'package:cave_escape/theme/app_styles.dart';

class SplashWelcomeMessage extends StatelessWidget {
  const SplashWelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Welcome to Cave Escape',
              style: AppStyles.header1,
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'A sudden fall, and then the chilling reality sets in: you\'ve plunged into a treacherous, pitch-black cave.',
                    style: AppStyles.subTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'The air is heavy, and unseen dangers lurk in every shadow. Your survival depends entirely on your wit and courage.',
                    style: AppStyles.subTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'You must carefully explore this unforgiving abyss, making critical choices that will either lead you to salvation or seal your fate. The cave holds no mercy for the unprepared.\n',
                    style: AppStyles.subTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Are you ready to face the darkness and fight for your escape?',
                    style: AppStyles.subTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '\n\n\nTo ensure you experience every detail of this perilous journey, we recommend playing at browser\'s screen resolution to 1000 x 1280. ',
                    style: AppStyles.subtleEmphasis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
