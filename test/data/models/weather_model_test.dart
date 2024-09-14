import 'dart:convert';

import 'package:aes_room/data/models/weather_model.dart';
import 'package:aes_room/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';
import '../../mock_data/data_weather.dart';

void main() {
  final testWeatherModel = WeatherModel.fromJson(
    dataWeather,
  );

  test('should be a subclass of weather entity', () async {
    //assert
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test('should return a valid model from json', () async {
    //arrange
    final jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_weather_response.json'),
    ) as Map<String, dynamic>;

    //act
    final result = WeatherModel.fromJson(jsonMap);

    //assert
    expect(result, equals(testWeatherModel));
  });

  test(
    'should return a json map containing proper data',
    () async {
      // act
      final result = testWeatherModel.toJson();

      // assert
      final expectedJsonMap = {
        'weather': [
          {
            'main': 'Clear',
            'description': 'clear sky',
            'icon': '01n',
          }
        ],
        'main': {
          'temp': 292.87,
          'pressure': 1012,
          'humidity': 70,
        },
        'name': 'New York',
      };

      expect(result, equals(expectedJsonMap));
    },
  );
}
