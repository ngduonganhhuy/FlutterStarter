import 'package:flutter_stater/core/error/failure.dart';
import 'package:flutter_stater/core/impl/result_response.dart';
import 'package:flutter_stater/data/data_sources/remote_data_source.dart';
import 'package:flutter_stater/data/models/weather_model.dart';
import 'package:flutter_stater/domain/repositories/weather_repository.dart';

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
