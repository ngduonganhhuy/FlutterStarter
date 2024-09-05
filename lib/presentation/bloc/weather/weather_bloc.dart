import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_starter/core/error/exception.dart';
import 'package:flutter_starter/core/impl/result_response.dart';
import 'package:flutter_starter/domain/entities/weather.dart';
import 'package:flutter_starter/domain/usecases/get_current_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this._getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<OnCityChanged>((event, emit) async {
      emit(WeatherLoading());
      final result = await _getCurrentWeatherUseCase.execute(event.cityName);
      if (result.isTrue) {
        emit(WeatherLoaded(result.data));
      } else {
        emit(WeatherLoadFailue(result.error?.message ?? ApiErrorMessage.APP_BLOC_ERROR));
      }
    });
  }
  late final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
}
