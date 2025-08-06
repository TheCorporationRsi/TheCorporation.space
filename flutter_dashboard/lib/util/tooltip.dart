import 'package:flutter/material.dart';
import 'package:flutter_dashboard/const/constant.dart';

class CustomTooltip extends StatelessWidget {
  final String message;
  final Color color;
  final TextStyle textStyle;
  final Widget child;

  const CustomTooltip({
    Key? key,
    required this.message,
    this.color = backgroundColor,
    this.textStyle = const TextStyle(color: Colors.white),
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: textStyle,
      child: child,
    );
  }
}
