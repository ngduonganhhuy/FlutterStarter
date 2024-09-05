import 'package:flutter/material.dart';
import 'package:flutter_starter/core/themes/app_text_styles.dart';

class MediumText extends StatelessWidget {
  const MediumText(this.text, {super.key, this.color, this.fontSize});
  final String text;
  final Color? color;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: appFont.size14(
        fontWeight: FontWeight.w500,
        color: color,
      ),
    );
  }
}
