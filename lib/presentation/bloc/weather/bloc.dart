import 'package:bloc/bloc.dart';
import 'package:weather_tdd_app/domain/use_cases/get_current_weather.dart';
import 'package:rxdart/rxdart.dart';
import 'event.dart';
import 'state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  WeatherBloc(this._getCurrentWeatherUseCase) : super(Init()) {
    on<OnCityChanged>((event, emit) async {
      emit(WeatherLoading());
      final result = await _getCurrentWeatherUseCase.execute(event.cityName);

      result.fold(
        (failure) {
          emit(WeatherLoadFailue(failure.message));
        },
        (data) {
          emit(WeatherLoaded(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
