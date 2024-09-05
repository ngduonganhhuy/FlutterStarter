import 'package:flutter/foundation.dart';
import 'package:flutter_starter/core/constants/api_urls.dart';
import 'package:flutter_starter/core/env/env.dart';
import 'package:flutter_starter/core/error/exception.dart';
import 'package:flutter_starter/core/error/failure.dart';
import 'package:flutter_starter/core/impl/result_response.dart';
import 'package:flutter_starter/core/services/api_service/api_service.dart';
import 'package:flutter_starter/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<ResultResponse<WeatherModel, Failure>> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  WeatherRemoteDataSourceImpl();

  @override
  Future<ResultResponse<WeatherModel, Failure>> getCurrentWeather(String cityName) async {
    final url = ApiUrls.currentWeatherByName;
    const desc = 'getCurrentWeather';
    final params = {
      'appid': Env.apiKey,
      'q': cityName,
    };
    final response = await ApiService.callRequest(RequestMethod.GET, url, desc, params: params);
    return compute(
      (message) {
        if (message == null) throw NullException();
        final resData = WeatherModel.fromJson(message as Map<String, dynamic>);
        return ResultResponse.success(resData);
      },
      response,
    );
  }
}
