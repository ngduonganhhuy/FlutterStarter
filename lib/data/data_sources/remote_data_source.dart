import 'package:flutter/foundation.dart';
import 'package:flutter_stater/core/error/exception.dart';
import 'package:flutter_stater/core/error/failure.dart';
import 'package:flutter_stater/core/impl/result_response.dart';
import 'package:flutter_stater/core/services/api_service/api_service.dart';
import 'package:flutter_stater/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<ResultResponse<WeatherModel, Failure>> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  WeatherRemoteDataSourceImpl();

  @override
  Future<ResultResponse<WeatherModel, Failure>> getCurrentWeather(String cityName) async {
    const url = '';
    const desc = 'getAssetDetail';
    final response = await ApiService.callRequest(RequestMethod.GET, url, desc);
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
