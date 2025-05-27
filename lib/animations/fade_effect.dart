import 'package:flutter/material.dart';

enum FadeType { fadeIn, fadeOut, fadeInOut }

class FadeEffect extends StatelessWidget {
  final Widget child;
  final FadeType fadetype;
  final bool fadeTrigger;
  final Duration duration;
  final double endOpacity;

  const FadeEffect({
    super.key,
    required this.child,
    required this.fadetype,
    this.fadeTrigger =true,
    this.duration = const Duration(milliseconds: 800),
    this.endOpacity = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    double opacity;
    Cubic curve;
    switch (fadetype) {
      case FadeType.fadeIn:
        opacity = fadeTrigger ? 1.0 : endOpacity;
        curve = Curves.easeIn;
        break;
      case FadeType.fadeOut:
        opacity = fadeTrigger ? endOpacity : 1.0;
        curve = Curves.easeOut;
        break;
      case FadeType.fadeInOut:
        opacity = fadeTrigger ? endOpacity : 1.0;
        curve = Curves.easeInOut;
        break;
    }
    return AnimatedOpacity(
      opacity: opacity,
      duration: duration,
      curve: curve,
      child: child,
    );
  }
}