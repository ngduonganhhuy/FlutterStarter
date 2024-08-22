import 'package:flutter_stater/data/data_sources/remote_data_source.dart';
import 'package:flutter_stater/domain/repositories/weather_repository.dart';
import 'package:flutter_stater/domain/usecases/get_current_weather.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeatherUseCase,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
