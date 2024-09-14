import 'package:equatable/equatable.dart';
import 'package:aes_room/data/models/weather_model.dart';

class WeatherEntity extends Equatable {
  const WeatherEntity({this.coord, this.weather, this.base, this.main, this.visibility, this.wind, this.clouds, this.dt, this.sys, this.timezone, this.id, this.name, this.cod});

  final Coord? coord;
  final List<Weather>? weather;
  final String? base;
  final Main? main;
  final int? visibility;
  final Wind? wind;
  final Clouds? clouds;
  final int? dt;
  final Sys? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  @override
  List<Object?> get props => [coord, weather, base, main, visibility, wind, clouds, dt, sys, timezone, id, name, cod];
}
