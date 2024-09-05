extension BoolNullExt on bool? {
  bool get isTrue => this ?? false;
}

extension BoolExt on bool {}
