import 'package:cave_escape/theme/app_styles.dart';
import 'package:cave_escape/utils/utils.dart';
import 'package:flutter/material.dart';

class MenuText extends StatefulWidget {
  final String text;
  final String navigatorDestination;

  const MenuText({
    Key? key,
    required this.text,
    required this.navigatorDestination,
  }) : super(key: key);

  @override
  _MenuTextState createState() => _MenuTextState();
}

class _MenuTextState extends State<MenuText> {
  bool _isHovering = false;


  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering = false;
        });
      },
      child: GestureDetector(
        onTap: () => Utils.pageNavigation(context, widget.navigatorDestination),
        child: Text(
          widget.text,
          style: AppStyles.menuButtonText.copyWith(
            color:
                _isHovering
                    ? AppColors.glowCyan
                    : AppStyles.menuButtonText.color,
          ),
        ),
      ),
    );
  }
}
