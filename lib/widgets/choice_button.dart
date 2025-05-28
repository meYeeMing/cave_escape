import 'package:cave_escape/theme/app_styles.dart';
import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ChoiceButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.hovered)) {
              return AppColors.stone.withValues(alpha: 0.85);
            }
            return AppColors.stone;
          }),
          foregroundColor: WidgetStateProperty.all(AppColors.accentGold),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 18.0, horizontal: 24.0),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(
                color: Color.fromARGB(255, 34, 33, 33),
                width: 1.5,
              ),
            ),
          ),
          elevation: WidgetStateProperty.all(4),
          textStyle: WidgetStateProperty.all(AppStyles.buttonText),
          overlayColor: WidgetStateProperty.all(
            AppColors.accentGold.withAlpha(15),
          ),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
