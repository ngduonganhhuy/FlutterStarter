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

class Coord {
  const Coord({this.lon, this.lat});
  final double? lon;
  final double? lat;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json['lon'] as double?,
        lat: json['lat'] as double?,
      );

  Map<String, dynamic> toJson() => {
        'lon': lon,
        'lat': lat,
      };
}

class Weather {
  const Weather({this.id, this.main, this.description, this.icon});
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json['id'] as int?,
        main: json['main'] as String?,
        description: json['description'] as String?,
        icon: json['icon'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'main': main,
        'description': description,
        'icon': icon,
      };
}

class Main {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;
  final int? seaLevel;
  final int? grndLevel;

  const Main({this.temp, this.feelsLike, this.tempMin, this.tempMax, this.pressure, this.humidity, this.seaLevel, this.grndLevel});

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json['temp'] as double?,
        feelsLike: json['feels_like'] as double?,
        tempMin: json['temp_min'] as double?,
        tempMax: json['temp_max'] as double?,
        pressure: json['pressure'] as int?,
        humidity: json['humidity'] as int?,
        seaLevel: json['sea_level'] as int?,
        grndLevel: json['grnd_level'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'humidity': humidity,
        'sea_level': seaLevel,
        'grnd_level': grndLevel,
      };
}

class Wind {
  final double? speed;
  final int? deg;

  const Wind({this.speed, this.deg});

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json['speed'] as double?,
        deg: json['deg'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'speed': speed,
        'deg': deg,
      };
}

class Clouds  {
  final int? all;

  const Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json['all'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'all': all,
      };
}

class Sys {
  final int? type;
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;

  const Sys({this.type, this.id, this.country, this.sunrise, this.sunset});

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        type: json['type'] as int?,
        id: json['id'] as int?,
        country: json['country'] as String?,
        sunrise: json['sunrise'] as int?,
        sunset: json['sunset'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'id': id,
        'country': country,
        'sunrise': sunrise,
        'sunset': sunset,
      };
}
