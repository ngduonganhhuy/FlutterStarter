import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_starter/core/error/failure.dart';
import 'package:flutter_starter/core/impl/result_response.dart';
import 'package:flutter_starter/presentation/bloc/weather/weather_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../mock_data/data_weather.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
  });

  const testCityName = 'New York';

  test('initial state should be empty', () {
    expect(weatherBloc.state, WeatherEmpty());
  });

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully',
    build: () {
      when(
        mockGetCurrentWeatherUseCase.execute(testCityName),
      ).thenAnswer((_) async => ResultResponse.success(testWeatherEntity));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoaded(testWeatherEntity),
    ],
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoadFailure] when get data is unsuccessful',
    build: () {
      when(
        mockGetCurrentWeatherUseCase.execute(testCityName),
      ).thenAnswer((_) async => ResultResponse.error(const ServerFailure('Server failure', 500)));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoadFailue('Server failure'),
    ],
  );
}
