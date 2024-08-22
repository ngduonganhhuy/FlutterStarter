extension BoolNullExt on bool? {
  bool get isTrue => this ?? false;
}
