import 'package:flutter_stater/core/error/failure.dart';
import 'package:flutter_stater/core/impl/result_response.dart';
import 'package:flutter_stater/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<ResultResponse<WeatherEntity, Failure>> getCurrentWeather(String cityName);
}
