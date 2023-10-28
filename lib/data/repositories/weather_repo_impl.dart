import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather_tdd_app/core/error/exception.dart';
import 'package:weather_tdd_app/core/error/failure.dart';
import 'package:weather_tdd_app/data/data_sources/remote_data_source.dart';
import 'package:weather_tdd_app/domain/entities/weather.dart';
import 'package:weather_tdd_app/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  WeatherRepositoryImpl({
    required this.weatherRemoteDataSource,
  });

  final WeatherRemoteDataSource weatherRemoteDataSource;

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEnitiy());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred !'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
