import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_tdd_app/domain/entities/weather.dart';
import 'package:weather_tdd_app/domain/use_cases/get_current_weather.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });

  const testWeatherDetail = WeatherEntity(
      cityName: 'muscat',
      main: 'clouds',
      description: 'good',
      iconCode: '02d',
      temperature: 302,
      pressure: 1024,
      humidity: 70);

  const cityName = 'cairo';

  test('should get current weather detail from the repository', () async {
    //arange
    when(mockWeatherRepository.getCurrentWeather(cityName))
        .thenAnswer((_) async => const Right(testWeatherDetail));
    //act
    final result = await getCurrentWeatherUseCase.execute(cityName);

    // assert
    expect(result, const Right(testWeatherDetail));
  });
}
