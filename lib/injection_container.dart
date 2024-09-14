import 'package:aes_room/core_bloc/theme/theme_bloc.dart';
import 'package:aes_room/data/data_sources/weather_remote_data_source.dart';
import 'package:aes_room/data/repositories/weather_repository.dart';
import 'package:aes_room/domain/usecases/get_current_weather.dart';
import 'package:aes_room/presentation/bloc/weather/weather_bloc.dart';
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
