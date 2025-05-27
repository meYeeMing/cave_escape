import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF1C1C1C); // Cave background
  static const rock = Color(0xFF2B2B2B); // Rock shade
  static const stone = Color(0xFF4E4A47); // Weathered stone
  static const parchment = Color(0xFFD1B48C); // Carving tone

  static const accentGold = Color(0xFF8A6E3C); // Carving highlight
  static const glowCyan = Color(0xFF00FFD1); // Glowing mushroom

  static const textLight = Color(0xFFF8F8F8); // Light text
  static const textHighlight = Color(0xFFFFD700); // Highlighted text
}

class AppStyles {
  static const TextStyle header1 = TextStyle(
    fontFamily: 'Dirtyboy',
    fontSize: 100,
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
    color: AppColors.textHighlight,
  );
}