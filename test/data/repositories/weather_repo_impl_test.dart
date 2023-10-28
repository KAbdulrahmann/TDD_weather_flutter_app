import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:weather_tdd_app/core/error/exception.dart';
import 'package:weather_tdd_app/core/error/failure.dart';
import 'package:weather_tdd_app/data/models/weather_model.dart';
import 'package:weather_tdd_app/data/repositories/weather_repo_impl.dart';
import 'package:weather_tdd_app/domain/entities/weather.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUpAll(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
        weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
      cityName: 'cityName',
      main: 'main',
      description: 'description',
      iconCode: 'iconCode',
      temperature: 40,
      pressure: 40,
      humidity: 40);
  const testWeatherEntity = WeatherEntity(
      cityName: 'cityName',
      main: 'main',
      description: 'description',
      iconCode: 'iconCode',
      temperature: 40,
      pressure: 40,
      humidity: 40);

  group('get current weather', () {
    test('return successful with api test', () async {
      // arange
      when(mockWeatherRemoteDataSource.getCurrentWeather('cityName'))
          .thenAnswer((_) async => testWeatherModel);
      // act
      final result = await weatherRepositoryImpl.getCurrentWeather('cityName');
      // assert
      expect(result, equals(const Right(testWeatherEntity)));
    });

    test('return server failure when a call to data source is unsuccessful',
        () async {
      // arange
      when(mockWeatherRemoteDataSource.getCurrentWeather('cityName'))
          .thenThrow(ServerException());
      // act
      final result = await weatherRepositoryImpl.getCurrentWeather('cityName');
      // assert
      expect(
          result, equals(const Left(ServerFailure('An error has occurred !'))));
    });

    test('return connection failure when the device has no network', () async {
      // arange
      when(mockWeatherRemoteDataSource.getCurrentWeather('cityName'))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await weatherRepositoryImpl.getCurrentWeather('cityName');
      // assert
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
