import 'dart:io';

import 'package:flutter_starter/core/error/exception.dart';
import 'package:flutter_starter/core/error/failure.dart';
import 'package:flutter_starter/core/impl/result_response.dart';
import 'package:flutter_starter/data/models/weather_model.dart';
import 'package:flutter_starter/data/repositories/weather_repository_impl.dart';
import 'package:flutter_starter/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
      weatherRemoteDataSource: mockWeatherRemoteDataSource,
    );
  });

  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  group('get current weather', () {
    test(
      'should return current weather when a call to data source is successful',
      () async {
        // arrange
        when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName)).thenAnswer((_) async => ResultResponse.success(testWeatherModel));

        // act
        final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

        // assert
        expect(result, equals(ResultResponse<WeatherEntity, Failure>.success(testWeatherEntity)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName)).thenThrow(ServerException());

        // act
        final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

        // assert
        expect(result, equals(ResultResponse<String, Failure>.error(const ServerFailure('An error has occurred', 500))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName)).thenThrow(const SocketException('Failed to connect to the network'));

        // act
        final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

        // assert
        expect(result, equals(ResultResponse<String, Failure>.error(const ConnectionFailure('Failed to connect to the network', 503))));
      },
    );
  });
}
