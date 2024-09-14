import 'package:aes_room/data/data_sources/weather_remote_data_source.dart';
import 'package:aes_room/data/repositories/weather_repository.dart';
import 'package:aes_room/domain/usecases/get_current_weather.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeatherUseCase,
  ],
)
void main() {}
