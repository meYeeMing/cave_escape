import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF1C1C1C);
  static const rock = Color(0xFF2B2B2B);
  static const stone = Color(0xFF4E4A47);
  static const parchment = Color(0xFFD1B48C);
  static const brigterParchment = Color(0xFFE3C9A0);
  static const neutralGrey = Color(0xFFA5A5A5);

  static const accentGold = Color(0xFF8A6E3C);
  static const interactiveGold = Color(0xFFC79F4F);
  static const glowCyan = Color(0xFF00FFD1);

  static const textLight = Color(0xFFF8F8F8);
  static const textHighlight = Color(0xFFFFD700);
}

class AppStyles {
  static const TextStyle header1 = TextStyle(
    fontFamily: 'Dirtyboy',
    fontSize: 80,
    color: AppColors.accentGold,
  );
  static const TextStyle header2 = TextStyle(
    fontFamily: 'Dirtyboy',
    fontSize: 60,
    color: AppColors.accentGold,
  );
  static const TextStyle header3 = TextStyle(
    fontFamily: 'Dirtyboy',
    fontSize: 45,
    color: AppColors.accentGold,
  );

  static const TextStyle subTitle = TextStyle(
    fontFamily: 'Cavestone',
    fontSize: 20,
    color: AppColors.parchment,
  );
  static const TextStyle subtleEmphasis = TextStyle(
    fontFamily: 'Cavestone',
    fontSize: 18,
    color: AppColors.interactiveGold,
  );

  static const TextStyle menuButtonText = TextStyle(
    fontFamily: 'Dirtyboy',
    fontSize: 45,
    color: AppColors.accentGold,
  );
  static const TextStyle nodeText = TextStyle(
    fontFamily: 'Cavestone',
    fontSize: 32,
    color: AppColors.interactiveGold,
  );
  static const TextStyle buttonText = TextStyle(
    fontFamily: 'Cavestone',
    fontSize: 28,
    color: AppColors.accentGold,
  );
}
