import 'package:flutter_stater/core/error/failure.dart';
import 'package:flutter_stater/core/impl/result_response.dart';
import 'package:flutter_stater/domain/entities/weather.dart';
import 'package:flutter_stater/domain/usecases/get_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });

  const testWeatherDetail = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  test('should get current weather detail from the repository', () async {
    // arrange
    when(
      mockWeatherRepository.getCurrentWeather(testCityName),
    ).thenAnswer((_) async => ResultResponse.success(testWeatherDetail));

    // act
    final result = await getCurrentWeatherUseCase.execute(testCityName);

    // assert
    expect(result, ResultResponse<WeatherEntity, Failure>.success(testWeatherDetail));
  });
}
