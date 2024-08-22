import 'package:flutter_stater/core_bloc/theme/theme_bloc.dart';
import 'package:flutter_stater/data/data_sources/remote_data_source.dart';
import 'package:flutter_stater/data/repositories/weather_repository_impl.dart';
import 'package:flutter_stater/domain/repositories/weather_repository.dart';
import 'package:flutter_stater/domain/usecases/get_current_weather.dart';
import 'package:flutter_stater/presentation/bloc/weather/weather_bloc.dart';
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
