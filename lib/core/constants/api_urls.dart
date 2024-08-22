import 'package:flutter_stater/core/env/env.dart';

class ApiUrls {
  static String currentWeatherByName(String city) => '${Env.baseUrl}/weather?q=$city&appid=${Env.apiKey}';
}
