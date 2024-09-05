import 'package:dio/dio.dart';
import 'package:flutter_starter/core/constants/api_urls.dart';
import 'package:flutter_starter/core/error/exception.dart';
import 'package:flutter_starter/data/data_sources/remote_data_source.dart';
import 'package:flutter_starter/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;
  late Dio dio;
  late DioAdapter dioAdapter;

  setUp(() {
    weatherRemoteDataSourceImpl = WeatherRemoteDataSourceImpl();
    dio = Dio(BaseOptions());
    dioAdapter = DioAdapter(dio: dio);
  });

  const testCityName = 'New York';

  group('get current weather', () {
    test('should return weather model when the response code is 200', () async {
      final path = ApiUrls.currentWeatherByName;
      dioAdapter.onGet(
        path,
        (server) => server.reply(
          200,
          {'message': 'Success!'},
          delay: const Duration(seconds: 1),
        ),
      );

      //act
      final result = await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

      //assert
      expect(result, isA<WeatherModel>());
    });

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        //arrange
        final path = ApiUrls.currentWeatherByName;
        dioAdapter.onGet(
          path,
          (server) => server.reply(
            404,
            {'message': 'Not found!'},
            delay: const Duration(seconds: 1),
          ),
        );
        //act
        final result = weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

        //assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
