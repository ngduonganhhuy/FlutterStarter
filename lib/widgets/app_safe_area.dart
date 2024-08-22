import 'package:flutter/cupertino.dart';

class AppSafeArea extends StatelessWidget {
  const AppSafeArea({required this.child, super.key, this.color, this.top, this.bottom});
  final Color? color;
  final bool? top;
  final bool? bottom;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: SafeArea(
        top: top ?? true,
        bottom: bottom ?? true,
        child: child,
      ),
    );
  }
}
