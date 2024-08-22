import 'package:flutter/material.dart';

abstract class BasePage extends Widget {
  const BasePage({super.key});

  String get screenName;
}
