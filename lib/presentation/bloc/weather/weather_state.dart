part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

final class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  const WeatherLoaded(this.result);
  final WeatherEntity? result;

  @override
  List<Object?> get props => [result];
}

final class WeatherLoadFailue extends WeatherState {
  const WeatherLoadFailue(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
