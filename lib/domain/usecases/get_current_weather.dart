import 'package:aes_room/core/error/failure.dart';
import 'package:aes_room/core/impl/result_response.dart';
import 'package:aes_room/data/repositories/weather_repository.dart';
import 'package:aes_room/domain/entities/weather.dart';

class GetCurrentWeatherUseCase {
  GetCurrentWeatherUseCase(this.weatherRepository);

  final WeatherRepository weatherRepository;

  Future<ResultResponse<WeatherEntity, Failure>> execute(String cityName) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
