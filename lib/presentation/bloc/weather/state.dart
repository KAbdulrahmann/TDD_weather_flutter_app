import 'package:equatable/equatable.dart';
import 'package:weather_tdd_app/domain/entities/weather.dart';

abstract class WeatherState extends Equatable {
  WeatherState();

  @override
  List<Object> get props => [];
}

class Init extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherEntity result;

  WeatherLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class WeatherLoadFailue extends WeatherState {
  final String message;

  WeatherLoadFailue(this.message);

  @override
  List<Object> get props => [message];
}
