import 'package:flutter/material.dart';
import 'package:aes_room/core/services/api_service/api_service.dart';
import 'package:aes_room/core/utils/storage_util.dart';

class LogoutHelper {
  static void handleLogout({BuildContext? context}) {
    StorageUtil.delete(StorageKey.USER_TOKEN);
    ApiService.clearToken();
  }

  static Future<void> doLogout(BuildContext? context) async {}
}
