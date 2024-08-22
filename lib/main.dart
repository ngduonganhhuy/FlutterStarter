import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_stater/core/utils/storage_util.dart';
import 'package:flutter_stater/root/app/root.dart';
import 'package:flutter_stater/root/bootstrap.dart';

Future<void> mainDelegate() async {
  //TODO if true, just remove this comment
  debugRepaintRainbowEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await StorageUtil.initPreferences();
  await bootstrap(() => const Root());
}
