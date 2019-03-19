import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:weather/repositories/repositories.dart';
import 'package:weather/blocs/blocs.dart';
import 'package:weather/widget/widget.dart';

class WeatherPage extends StatefulWidget {
  final WeatherRepository weatherRepository;

  WeatherPage({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _WeatherState();
}

class _WeatherState extends State<WeatherPage> {
  WeatherBloc weatherBloc;
  Completer<void> refreshCompleter;

  @override
  void initState() {
    super.initState();
    refreshCompleter = Completer<void>();
    weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingPage()));
              }),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final city = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CityPage()));
                if (city != null) {
                  weatherBloc.dispatch(FetchWeather(city: city));
                }
              })
        ],
      ),
      body: Center(
        child: BlocBuilder(
          bloc: weatherBloc,
          builder: (_, WeatherState state) {
            if (state is WeatherEmty) {
              return Center(
                child: Text(
                  'Please Select a Location',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              );
            } else if (state is WeatherError) {
              return Center(
                child: Text(
                  'Something went wrong!',
                  style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              );
            } else if (state is WeatherLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WeatherLoader) {
              final weatherState = state.weather;
              final themeBloc = BlocProvider.of<ThemeBloc>(context);
              themeBloc.dispatch(
                  WeatherChanged(weatherCondition: weatherState.condition));
              refreshCompleter?.complete();
              refreshCompleter = Completer();
              return BlocBuilder(
                  bloc: themeBloc,
                  builder: (_, ThemeState state) {
                    print(state);
                    return GradientContainer(
                      color: state.color,
                      child: RefreshIndicator(
                        onRefresh: () {
                          weatherBloc.dispatch(
                              RefreshWeather(city: weatherState.location));
                          return refreshCompleter?.future;
                        },
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 100),
                              child: Center(
                                child:
                                    Location(location: weatherState.location),
                              ),
                            ),
                            Center(
                              child: LastUpdated(dateTime: weatherState.lastUpdated),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 50),
                              child: Center(
                                child: WeatherTemperature(
                                  weather: weatherState,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
