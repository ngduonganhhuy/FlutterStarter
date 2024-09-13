import 'package:flutter_starter/data/data_sources/weather_remote_data_source.dart';
import 'package:flutter_starter/data/repositories/weather_repository.dart';
import 'package:flutter_starter/domain/usecases/get_current_weather.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeatherUseCase,
  ],
)
void main() {}
