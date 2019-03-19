import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/blocs/blocs.dart';
import 'package:weather/widget/widget.dart';
import 'package:weather/repositories/repositories.dart';
import 'package:http/http.dart' as http;

class SimBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print(error);
  }
}

void main() {
  final WeatherRepository weatherRepository = WeatherRepository(
      weatherApiClient: WeatherApiClient(httpClient: http.Client()));
  BlocSupervisor().delegate = SimBlocDelegate();
  runApp(App(weatherRepository: weatherRepository));
}

class App extends StatefulWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeBloc themeBloc = ThemeBloc();
  SettingBloc settingBloc = SettingBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
        blocProviders: [
          BlocProvider<ThemeBloc>(bloc: themeBloc),
          BlocProvider<SettingBloc>(bloc: settingBloc),
        ],
        child: BlocBuilder(
          bloc: themeBloc,
          builder: (_, ThemeState themeState) {
            return MaterialApp(
                title: 'Weather', theme: themeState.theme, home: WeatherPage(weatherRepository: widget.weatherRepository));
          },
        ));
  }

  @override
  void dispose() {
    themeBloc.dispose();
    settingBloc.dispose();
    super.dispose();
  }
}
