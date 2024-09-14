import 'package:aes_room/core/error/failure.dart';
import 'package:aes_room/core/impl/result_response.dart';
import 'package:aes_room/domain/entities/weather.dart';
import 'package:aes_room/domain/usecases/get_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../mock_data/data_weather.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });

  const testCityName = 'New York';

  test('should get current weather detail from the repository', () async {
    // arrange
    when(
      mockWeatherRepository.getCurrentWeather(testCityName),
    ).thenAnswer((_) async => ResultResponse.success(testWeatherEntity));

    // act
    final result = await getCurrentWeatherUseCase.execute(testCityName);

    // assert
    expect(result, ResultResponse<WeatherEntity, Failure>.success(testWeatherEntity));
  });
}
