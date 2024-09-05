import 'package:flutter_starter/core/error/failure.dart';
import 'package:flutter_starter/core/impl/result_response.dart';
import 'package:flutter_starter/domain/entities/weather.dart';
import 'package:flutter_starter/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  GetCurrentWeatherUseCase(this.weatherRepository);

  final WeatherRepository weatherRepository;

  Future<ResultResponse<WeatherEntity, Failure>> execute(String cityName) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
