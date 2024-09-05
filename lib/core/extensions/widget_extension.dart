import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension WidgetHelpers on Widget {
  Widget get center => Center(child: this);

  Widget get sliverBox => SliverToBoxAdapter(child: this);

  //* ------------------  MARGIN  ------------------
  Widget marginAll(double margin) => Container(margin: REdgeInsets.all(margin), child: this);

  Widget marginSymmetric({double horizontal = 0.0, double vertical = 0.0}) => Container(
        margin: REdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );

  Widget marginOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Container(
        margin: REdgeInsets.only(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
        ),
        child: this,
      );

  Widget get marginZero => Container(margin: EdgeInsets.zero, child: this);

  //* ------------------  PADDING  ------------------
  Widget paddingAll(double padding) => RPadding(padding: EdgeInsets.all(padding), child: this);

  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) => RPadding(
        padding: REdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );

  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      RPadding(
        padding: REdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
        child: this,
      );

  Widget paddingFromLTRB(
    double left,
    double top,
    double right,
    double bottom,
  ) =>
      RPadding(
        padding: REdgeInsets.fromLTRB(left, top, right, bottom),
        child: this,
      );

  Widget get paddingZero => RPadding(padding: EdgeInsets.zero, child: this);

  //* ------------------  SCROLLVIEW  ------------------
  Widget get toScrollView => LayoutBuilder(
        builder: (_, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: this,
              ),
            ),
          );
        },
      );

  Widget get ctl => Align(alignment: Alignment.centerLeft, child: this);

  Widget clickable(VoidCallback? action, {bool opaque = true}) {
    if (action == null) {
      return this;
    }
    return GestureDetector(
      behavior: opaque ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
      onTap: action,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        opaque: opaque,
        child: this,
      ),
    );
  }
}
