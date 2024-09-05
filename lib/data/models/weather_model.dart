import 'package:flutter_starter/core/utils/utils.dart';
import 'package:flutter_starter/domain/entities/weather.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    super.coord,
    super.weather,
    super.base,
    super.main,
    super.visibility,
    super.wind,
    super.clouds,
    super.dt,
    super.sys,
    super.timezone,
    super.id,
    super.name,
    super.cod,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        coord: Utils.jsonToModel(json['coord'], Coord.fromJson),
        weather: Utils.jsonToList(json['weather'], Weather.fromJson),
        base: json['base'] as String?,
        main: Utils.jsonToModel(json['main'], Main.fromJson),
        visibility: json['visibility'] as int?,
        wind: Utils.jsonToModel(json['wind'], Wind.fromJson),
        clouds: Utils.jsonToModel(json['clouds'], Clouds.fromJson),
        dt: json['dt'] as int?,
        sys: Utils.jsonToModel(json['sys'], Sys.fromJson),
        timezone: json['timezone'] as int?,
        id: json['id'] as int?,
        name: json['name'] as String?,
        cod: json['cod'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'coord': coord?.toJson(),
        'weather': weather
            ?.map(
              (e) => e.toJson(),
            )
            .toList(),
        'base': base,
        'main': main?.toJson(),
        'visibility': visibility,
        'wind': wind?.toJson(),
        'clouds': clouds?.toJson(),
        'dt': dt,
        'sys': sys?.toJson(),
        'timezone': timezone,
        'id': id,
        'name': name,
        'cod': cod,
      };
}
