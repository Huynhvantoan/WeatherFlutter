import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/models/models.dart';
import 'package:weather/repositories/repositories.dart';

abstract class WeatherEvent extends Equatable {
  WeatherEvent([List pros = const []]) : super(pros);
}

class FetchWeather extends WeatherEvent {
  final String city;

  FetchWeather({@required this.city})
      : assert(city != null),
        super([city]);
}

class RefreshWeather extends WeatherEvent {
  final String city;

  RefreshWeather({@required this.city})
      : assert(city != null),
        super([city]);
}

abstract class WeatherState extends Equatable {
  WeatherState([List pros = const []]) : super(pros);
}

class WeatherEmty extends WeatherState {}

class WeatherError extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoader extends WeatherState {
  final Weather weather;

  WeatherLoader({@required this.weather})
      : assert(weather != null),
        super([weather]);
}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);

  @override
  WeatherState get initialState => WeatherEmty();

  @override
  Stream<WeatherState> mapEventToState(
      WeatherState currentState, WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoader(weather: weather);
      } catch (error) {
        yield WeatherError();
      }
    } else if (event is RefreshWeather) {
      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoader(weather: weather);
      } catch (error) {
        yield currentState;
      }
    }
  }
}
