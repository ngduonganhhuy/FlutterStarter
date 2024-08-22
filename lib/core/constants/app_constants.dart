import 'package:collection/collection.dart';

class AppConstants {
  static Map<String, dynamic> _config = {};

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = Config.devConstants;
      case Environment.PRODUCT:
        _config = Config.productConstants;
    }
  }

  static void setEnvironmentFronString(String? envStr) {
    final f = Environment.values.firstWhereOrNull((e) => e.toString() == envStr);
    if (f == null) {
      throw ArgumentError('Enviroment not exits');
    }
    setEnvironment(f);
  }

  static String? getEnvironment() => switch (_config[Config.TYPE]) {
        Environment.DEV => Environment.DEV.toKeyUnique(),
        Environment.PRODUCT => Environment.PRODUCT.toKeyUnique(),
        _ => null,
      };
  static bool get isDev => getEnvironment() == Environment.DEV.toKeyUnique();
  static bool get isProduction => getEnvironment() == Environment.PRODUCT.toKeyUnique();

  static String get baseUrl {
    return _config[Config.BASE_URL] as String;
  }
}

class Config {
  static const BASE_URL = 'BASE_URL';
  static const TYPE = 'TYPE';

  static Map<String, dynamic> devConstants = {
    BASE_URL: 'https://api.sandboxes.xyz/',
  };

  static Map<String, dynamic> productConstants = {
    BASE_URL: 'https://api.danet.vn/',
  };
}

enum Environment {
  DEV,
  PRODUCT;

  String toKeyUnique() => switch (this) { DEV => 'DEV', PRODUCT => 'PRODUCT' };
}
