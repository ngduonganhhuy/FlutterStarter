import 'package:aes_room/core/error/failure.dart';
import 'package:aes_room/core/impl/result_response.dart';
import 'package:aes_room/data/data_sources/weather_remote_data_source.dart';
import 'package:aes_room/data/models/weather_model.dart';

abstract class WeatherRepository {
  Future<ResultResponse<WeatherModel, Failure>> getCurrentWeather(String cityName);
}

class WeatherRepositoryImpl extends WeatherRepository {
  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  final WeatherRemoteDataSource weatherRemoteDataSource;

  @override
  Future<ResultResponse<WeatherModel, Failure>> getCurrentWeather(String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      return result;
    } catch (_) {
      rethrow;
    }
  }
}
