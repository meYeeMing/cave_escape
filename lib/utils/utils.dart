import 'package:cave_escape/screens/game_home_screen.dart';
import 'package:cave_escape/screens/game_play_screen.dart';
import 'package:cave_escape/screens/game_state_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'logger.dart';

class Utils {
  static void pageNavigation(
    BuildContext context,
    String navigatorDestination,
  ) {
    switch (navigatorDestination) {
      case 'newgame':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => GamePlayScreen()),
        );
        break;
      case 'gamestate':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => GameStateScreen()),
        );
        break;
      case 'gamehome':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => GameHomeScreen()),
        );
      default:
        logger.e('Unknown page: $navigatorDestination');
    }
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
  }
}
