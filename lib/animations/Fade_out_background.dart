import 'package:flutter/material.dart';

class FadeBackground extends StatelessWidget {
  final String imagePath;
  final bool fadeOut;

  const FadeBackground({
    required this.imagePath,
    required this.fadeOut,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: fadeOut ? 0.0 : 0.8,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}