import 'package:aes_room/data/models/weather_model.dart';
import 'package:aes_room/domain/entities/weather.dart';

final dataWeather = {
  'coord': {'lon': -74.006, 'lat': 40.7143},
  'weather': [
    {'id': 800, 'main': 'Clear', 'description': 'clear sky', 'icon': '01n'},
  ],
  'base': 'stations',
  'main': {'temp': 289.37, 'feels_like': 289.06, 'temp_min': 285.1, 'temp_max': 291.12, 'pressure': 1029, 'humidity': 77, 'sea_level': 1029, 'grnd_level': 1029},
  'visibility': 10000,
  'wind': {'speed': 2.57, 'deg': 20},
  'clouds': {'all': 0},
  'dt': 1725527879,
  'sys': {'type': 2, 'id': 2008776, 'country': 'US', 'sunrise': 1725532053, 'sunset': 1725578518},
  'timezone': -14400,
  'id': 5128581,
  'name': 'New York',
  'cod': 200,
};

const testWeatherEntity = WeatherEntity(
  base: 'stations',
  clouds: Clouds(all: 0),
  cod: 200,
  name: 'New York',
  id: 5128581,
  timezone: -14400,
  sys: Sys(
    type: 2,
    id: 2008776,
    country: 'US',
    sunrise: 1725532053,
    sunset: 1725578518,
  ),
  dt: 1725527879,
  wind: Wind(
    speed: 2.57,
    deg: 20,
  ),
  visibility: 10000,
  main: Main(
    temp: 289.37,
    feelsLike: 289.06,
    tempMin: 285.1,
    tempMax: 291.12,
    pressure: 1029,
    humidity: 77,
    seaLevel: 1029,
    grndLevel: 1029,
  ),
  weather: [
    Weather(
      icon: '01n',
      id: 800,
      main: 'Clear',
      description: 'clear sky',
    ),
  ],
  coord: Coord(
    lon: -74.006,
    lat: 40.7143,
  ),
);
