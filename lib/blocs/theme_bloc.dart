import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/models/models.dart';

abstract class ThemeEvent extends Equatable {
  ThemeEvent([List pros = const []]) : super(pros);
}

class ThemeState extends Equatable {
  final ThemeData theme;
  final MaterialColor color;

  ThemeState({@required this.theme, @required this.color})
      : assert(theme != null),
        assert(color != null),
        super([theme, color]);
}

class WeatherChanged extends ThemeEvent {
  final WeatherCondition weatherCondition;

  WeatherChanged({@required this.weatherCondition})
      : assert(weatherCondition != null),
        super([weatherCondition]);
}

class ThemeBloc extends Bloc<WeatherChanged, ThemeState> {
  @override
  ThemeState get initialState =>
      ThemeState(theme: ThemeData.light(), color: Colors.blue);

  @override
  Stream<ThemeState> mapEventToState(
      ThemeState currentState, WeatherChanged event) async* {
    if (event is WeatherChanged) {
      _mapWeatherConditionToThemeData(event.weatherCondition);
    }
  }
}

ThemeState _mapWeatherConditionToThemeData(WeatherCondition weatherCondition) {
  ThemeState theme;
  switch (weatherCondition) {
    case WeatherCondition.snow:
    case WeatherCondition.sleet:
      theme = ThemeState(
          theme: ThemeData(primaryColor: Colors.greenAccent),
          color: Colors.green);
      break;
    case WeatherCondition.hail:
    case WeatherCondition.thunderstorm:
      theme = ThemeState(
          theme: ThemeData(primaryColor: Colors.lightGreen),
          color: Colors.lightGreen);
      break;
    case WeatherCondition.heavyRain:
    case WeatherCondition.lightRain:
      theme = ThemeState(
          theme: ThemeData(primaryColor: Colors.pinkAccent),
          color: Colors.pink);
      break;
    case WeatherCondition.showers:
      theme = ThemeState(
          theme: ThemeData(primaryColor: Colors.yellowAccent),
          color: Colors.yellow);
      break;
    case WeatherCondition.heavyCloud:
      theme = ThemeState(
          theme: ThemeData(primaryColor: Colors.pinkAccent),
          color: Colors.pink);
      break;
    case WeatherCondition.lightCloud:
      theme = ThemeState(
          theme: ThemeData(primaryColor: Colors.indigoAccent),
          color: Colors.indigo);
      break;
    case WeatherCondition.clear:
    case WeatherCondition.unknown:
      theme = ThemeState(theme: ThemeData.light(), color: Colors.blue);
      break;
  }
  return theme;
}
