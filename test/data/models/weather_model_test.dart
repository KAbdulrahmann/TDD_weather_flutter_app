import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_tdd_app/data/models/weather_model.dart';
import 'package:weather_tdd_app/domain/entities/weather.dart';
import '../../helpers/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'Zocca',
    main: 'Rain',
    description: 'moderate rain',
    iconCode: '10d',
    temperature: 298.48,
    pressure: 1015,
    humidity: 64,
  );

  test('should be a subclass of weather entity', () async {
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test('should be a subclass of weather entity', () async {
    //arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helpers/dummy_data/dummy_weather_response.json'));
    //act
    final result = WeatherModel.fromJson(jsonMap);

    //assert
    expect(result, equals(testWeatherModel));
  });

  test('should return a json map containing proper data', () async {
    // act
    final result = testWeatherModel.tojson();

    // assert
    final expectedJsonMap = {
      'weather': [
        {
          'main': 'Rain',
          'description': 'moderate rain',
          'icon': '10d',
        }
      ],
      'main': [
        {
          'temp': 298.48,
          'pressure': 1015,
          'humidity': 64,
        }
      ],
      'name': 'Zocca'
    };

    expect(result, equals(expectedJsonMap));
  });
}
