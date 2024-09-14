import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:aes_room/core/extensions/widget_extension.dart';

class ToastHelper {
  static void showToast(String msg, {Alignment? alignment}) {
    SmartDialog.showToast(
      msg,
      alignment: alignment,
      debounce: true,
      displayType: SmartToastType.last,
    );
  }

  static void showSuccessToast(String msg) {
    showCustomToast(
      alignment: Alignment.topCenter,
    );
  }

  static void showErrorToast(
    String msg, {
    Alignment? alignment,
  }) {
    showCustomToast(
      alignment: alignment ?? Alignment.bottomCenter,
    );
  }

  static void showCustomToast({
    Widget? customToast,
    Alignment? alignment,
    Duration? displayTime,
    void Function()? onClickToast,
  }) {
    SmartDialog.showToast(
      displayTime: displayTime,
      '',
      alignment: alignment,
      debounce: true,
      clickMaskDismiss: true,
      consumeEvent: true,
      builder: (context) =>
          customToast?.clickable(
            onClickToast != null
                ? () {
                    SmartDialog.dismiss<void>(status: SmartStatus.toast);
                    onClickToast.call();
                  }
                : null,
          ) ??
          const SizedBox(),
    );
  }
}
