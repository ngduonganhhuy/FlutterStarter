import 'package:flutter_starter/core_bloc/theme/theme_bloc.dart';
import 'package:flutter_starter/data/data_sources/remote_data_source.dart';
import 'package:flutter_starter/data/repositories/weather_repository.dart';
import 'package:flutter_starter/domain/usecases/get_current_weather.dart';
import 'package:flutter_starter/presentation/bloc/weather/weather_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  // bloc
  locator
    ..registerFactory(() => WeatherBloc(locator()))
    ..registerFactory(ThemeBloc.new)

    // usecase
    ..registerLazySingleton(() => GetCurrentWeatherUseCase(locator()))

    // repository
    ..registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(
        weatherRemoteDataSource: locator(),
      ),
    )

    // data source
    ..registerLazySingleton<WeatherRemoteDataSource>(
      WeatherRemoteDataSourceImpl.new,
    );
}
