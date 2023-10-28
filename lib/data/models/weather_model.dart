import 'dart:convert';

import '../../domain/entities/weather.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel(
      {required String cityName,
      required String main,
      required String description,
      required String iconCode,
      required double temperature,
      required int pressure,
      required int humidity})
      : super(
            cityName: cityName,
            description: description,
            humidity: humidity,
            iconCode: iconCode,
            main: main,
            pressure: pressure,
            temperature: temperature);

  factory WeatherModel.fromJson(dynamic json) {
    return WeatherModel(
        cityName: json['name'],
        main: json['weather'][0]['main'],
        description: json['weather'][0]['description'],
        iconCode: json['weather'][0]['icon'],
        temperature: json['main']['temp'],
        pressure: json['main']['pressure'],
        humidity: json['main']['humidity']);
  }

  Map<String, dynamic> tojson() {
    return {
      'weather': [
        {
          'main': main,
          'description': description,
          'icon': iconCode,
        }
      ],
      'main': [
        {
          'temp': temperature,
          'pressure': pressure,
          'humidity': humidity,
        }
      ],
      'name': cityName
    };
  }

  WeatherEntity toEnitiy() => WeatherEntity(
      cityName: cityName,
      main: main,
      description: description,
      iconCode: iconCode,
      temperature: temperature,
      pressure: pressure,
      humidity: humidity);
}

/// temp : 298.48
/// feels_like : 298.74
/// temp_min : 297.56
/// temp_max : 300.05
/// pressure : 1015
/// humidity : 64
/// sea_level : 1015
/// grnd_level : 933

Main mainFromJson(String str) => Main.fromJson(json.decode(str));

String mainToJson(Main data) => json.encode(data.toJson());

class Main {
  Main({
    num? temp,
    num? feelsLike,
    num? tempMin,
    num? tempMax,
    num? pressure,
    num? humidity,
    num? seaLevel,
    num? grndLevel,
  }) {
    _temp = temp;
    _feelsLike = feelsLike;
    _tempMin = tempMin;
    _tempMax = tempMax;
    _pressure = pressure;
    _humidity = humidity;
    _seaLevel = seaLevel;
    _grndLevel = grndLevel;
  }

  Main.fromJson(dynamic json) {
    _temp = json['temp'];
    _feelsLike = json['feels_like'];
    _tempMin = json['temp_min'];
    _tempMax = json['temp_max'];
    _pressure = json['pressure'];
    _humidity = json['humidity'];
    _seaLevel = json['sea_level'];
    _grndLevel = json['grnd_level'];
  }

  num? _temp;
  num? _feelsLike;
  num? _tempMin;
  num? _tempMax;
  num? _pressure;
  num? _humidity;
  num? _seaLevel;
  num? _grndLevel;

  Main copyWith({
    num? temp,
    num? feelsLike,
    num? tempMin,
    num? tempMax,
    num? pressure,
    num? humidity,
    num? seaLevel,
    num? grndLevel,
  }) =>
      Main(
        temp: temp ?? _temp,
        feelsLike: feelsLike ?? _feelsLike,
        tempMin: tempMin ?? _tempMin,
        tempMax: tempMax ?? _tempMax,
        pressure: pressure ?? _pressure,
        humidity: humidity ?? _humidity,
        seaLevel: seaLevel ?? _seaLevel,
        grndLevel: grndLevel ?? _grndLevel,
      );

  num? get temp => _temp;

  num? get feelsLike => _feelsLike;

  num? get tempMin => _tempMin;

  num? get tempMax => _tempMax;

  num? get pressure => _pressure;

  num? get humidity => _humidity;

  num? get seaLevel => _seaLevel;

  num? get grndLevel => _grndLevel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['temp'] = _temp;
    map['feels_like'] = _feelsLike;
    map['temp_min'] = _tempMin;
    map['temp_max'] = _tempMax;
    map['pressure'] = _pressure;
    map['humidity'] = _humidity;
    map['sea_level'] = _seaLevel;
    map['grnd_level'] = _grndLevel;
    return map;
  }
}

/// id : 501
/// main : "Rain"
/// description : "moderate rain"
/// icon : "10d"

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
  Weather({
    num? id,
    String? main,
    String? description,
    String? icon,
  }) {
    _id = id;
    _main = main;
    _description = description;
    _icon = icon;
  }

  Weather.fromJson(dynamic json) {
    _id = json['id'];
    _main = json['main'];
    _description = json['description'];
    _icon = json['icon'];
  }

  num? _id;
  String? _main;
  String? _description;
  String? _icon;

  Weather copyWith({
    num? id,
    String? main,
    String? description,
    String? icon,
  }) =>
      Weather(
        id: id ?? _id,
        main: main ?? _main,
        description: description ?? _description,
        icon: icon ?? _icon,
      );

  num? get id => _id;

  String? get main => _main;

  String? get description => _description;

  String? get icon => _icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['main'] = _main;
    map['description'] = _description;
    map['icon'] = _icon;
    return map;
  }
}
