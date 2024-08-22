import 'package:flutter_stater/domain/entities/weather.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.cityName,
    required super.main,
    required super.description,
    required super.iconCode,
    required super.temperature,
    required super.pressure,
    required super.humidity,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> map) {
    return WeatherModel(
      cityName: map['cityName'] as String,
      main: map['main'] as String,
      description: map['description'] as String,
      iconCode: map['iconCode'] as String,
      temperature: map['temperature'] as double,
      pressure: map['pressure'] as int,
      humidity: map['humidity'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'weather': [
          {
            'main': main,
            'description': description,
            'icon': iconCode,
          },
        ],
        'main': {
          'temp': temperature,
          'pressure': pressure,
          'humidity': humidity,
        },
        'name': cityName,
      };

  WeatherEntity toEntity() => WeatherEntity(
        cityName: cityName,
        main: main,
        description: description,
        iconCode: iconCode,
        temperature: temperature,
        pressure: pressure,
        humidity: humidity,
      );
}
