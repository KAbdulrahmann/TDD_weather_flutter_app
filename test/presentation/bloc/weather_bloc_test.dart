import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:weather_tdd_app/core/error/failure.dart';
import 'package:weather_tdd_app/domain/entities/weather.dart';
import 'package:weather_tdd_app/presentation/bloc/weather/bloc.dart';
import 'package:weather_tdd_app/presentation/bloc/weather/event.dart';
import 'package:weather_tdd_app/presentation/bloc/weather/state.dart';
import 'package:bloc_test/bloc_test.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUpAll(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
  });

  const testWeather = WeatherEntity(
      cityName: 'cityName',
      main: 'main',
      description: 'description',
      iconCode: 'iconCode',
      temperature: 40,
      pressure: 20,
      humidity: 20);

  const testCityName = 'cityName';

  test('initial state should be empty', () {
    expect(weatherBloc.state, equals(Init()));
  });

  blocTest<WeatherBloc, WeatherState>(
    'should emit [weatherLoading , weatherLoaded] when data is gotten',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName))
          .thenAnswer((_) async => const Right(testWeather));
      return weatherBloc;
    },
    act: (WeatherBloc bloc) => bloc.add(OnCityChanged(testCityName)),
    wait: Duration(milliseconds: 500),
    expect: () => <WeatherState>[WeatherLoading(), WeatherLoaded(testWeather)],
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emit [weatherLoading , weatherFailure] when data is gotten',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName))
          .thenAnswer((_) async => Left(ServerFailure('server failure')));
      return weatherBloc;
    },
    act: (WeatherBloc bloc) => bloc.add(OnCityChanged(testCityName)),
    wait: Duration(milliseconds: 500),
    expect: () =>
        <WeatherState>[WeatherLoading(), WeatherLoadFailue('server failure')],
  );
}
