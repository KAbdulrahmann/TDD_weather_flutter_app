import 'package:get_it/get_it.dart';
import 'package:weather_tdd_app/data/repositories/weather_repo_impl.dart';
import 'package:weather_tdd_app/domain/repositories/weather_repository.dart';
import 'package:weather_tdd_app/domain/use_cases/get_current_weather.dart';
import 'package:weather_tdd_app/presentation/bloc/weather/bloc.dart';
import 'package:http/http.dart' as http;
import '../data/data_sources/remote_data_source.dart';

final locator = GetIt.instance;

void setupLocator() {
  /// bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  /// usecase
  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));

  /// repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(weatherRemoteDataSource: locator()),
  );

  /// data source
  locator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(client: locator()),
  );

  /// client
  locator.registerLazySingleton(() => http.Client());
}
