import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_tdd_app/core/constants/constants.dart';
import '../../core/error/exception.dart';
import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  WeatherRemoteDataSourceImpl({
    required this.client,
  });

  final http.Client client;

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));
    print(response.body);

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      print(response.body);
      throw ServerException();
    }
  }
}
