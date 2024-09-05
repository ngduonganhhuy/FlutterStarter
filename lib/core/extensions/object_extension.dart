extension AddOperator<K, V> on Map<K, V> {
  Map<K, V> operator +(Map<K, V> other) => {...this}..addAll(other);
}

extension RemoveAll<E> on Iterable<E> {
  Iterable<E> operator -(Iterable<E> other) => where((element) => !other.contains(element));
}

extension Commons on dynamic {
  T? tryCast<T>({T? defaultValue}) {
    try {
      return this as T;
    } catch (_) {
      return defaultValue;
    }
  }
}

extension Unwrap<T> on Future<T?> {
  Future<T> unwrap() => then(
        (value) => value != null ? Future<T>.value(value) : Future.any([]),
      );
}

extension Filter<K, V> on Map<K, V> {
  Iterable<MapEntry<K, V>> filter(
    bool Function(MapEntry<K, V> entry) f,
  ) sync* {
    for (final entry in entries) {
      if (f(entry)) {
        yield entry;
      }
    }
  }
}
