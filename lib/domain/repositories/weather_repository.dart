import 'package:flutter_starter/core/error/failure.dart';
import 'package:flutter_starter/core/impl/result_response.dart';
import 'package:flutter_starter/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<ResultResponse<WeatherEntity, Failure>> getCurrentWeather(String cityName);
}
