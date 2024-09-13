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
      style: appFont.useFont(
        fontWeight: FontWeight.w500,
        color: color,
        fontSize: fontSize,
      ),
    );
  }
}

class RegularText extends StatelessWidget {
  const RegularText(this.text, {super.key, this.color, this.fontSize});
  final String text;
  final Color? color;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: appFont.useFont(
        fontWeight: FontWeight.w400,
        color: color,
        fontSize: fontSize,
      ),
    );
  }
}

class SemiBoldText extends StatelessWidget {
  const SemiBoldText(this.text, {super.key, this.color, this.fontSize});
  final String text;
  final Color? color;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: appFont.useFont(
        fontWeight: FontWeight.w600,
        color: color,
        fontSize: fontSize,
      ),
    );
  }
}

class BoldText extends StatelessWidget {
  const BoldText(this.text, {super.key, this.color, this.fontSize});
  final String text;
  final Color? color;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: appFont.useFont(
        fontWeight: FontWeight.bold,
        color: color,
        fontSize: fontSize,
      ),
    );
  }
}
