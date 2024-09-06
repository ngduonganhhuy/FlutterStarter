part of 'alert_dialogs.dart';

Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  required String defaultActionText,
  String? content,
  String? cancelActionText,
}) async {
  if (kIsWeb || !Platform.isIOS) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: content != null ? Text(content) : null,
        actions: <Widget>[
          if (cancelActionText != null)
            TextButton(
              child: Text(cancelActionText),
              onPressed: () => NavigatorService.goBack(context, false),
            ),
          TextButton(
            child: Text(defaultActionText),
            onPressed: () => NavigatorService.goBack(context, true),
          ),
        ],
      ),
    );
  }
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: content != null ? Text(content) : null,
      actions: <Widget>[
        if (cancelActionText != null)
          CupertinoDialogAction(
            child: Text(cancelActionText),
            onPressed: () => NavigatorService.goBack(context, false),
          ),
        CupertinoDialogAction(
          child: Text(defaultActionText),
          onPressed: () => NavigatorService.goBack(context, true),
        ),
      ],
    ),
  );
}
