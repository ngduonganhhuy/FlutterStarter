import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class PathHelper {
  static Directory applicationDocumentDirectory = Directory('');
  static String applicationDocumentPath = '';
  static Directory storeDownloadFilesDirectory = Directory('');
  static String storeDownloadFilesPath = '';

  static Future<void> init() async {
    final packageInfo = await PackageInfo.fromPlatform();
    applicationDocumentDirectory = await getApplicationDocumentsDirectory();
    applicationDocumentPath = applicationDocumentDirectory.absolute.path;
    storeDownloadFilesDirectory = applicationDocumentDirectory;
    storeDownloadFilesPath = storeDownloadFilesDirectory.absolute.path;
    if (Platform.isAndroid) {
      storeDownloadFilesPath = '/storage/emulated/0/Download/${packageInfo.appName}';
    }
  }
}
