import 'package:flutter/material.dart';
import 'package:weather/models/models.dart';
import 'package:weather/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/widget/widget.dart';

class WeatherTemperature extends StatelessWidget {
  final Weather weather;

  WeatherTemperature({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: WeatherConditions(weatherCondition: weather.condition,),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: BlocBuilder(
                bloc: BlocProvider.of<SettingBloc>(context),
                builder: (_, SettingsState state) {
                  return TemperatureWeather(
                    temperature: weather.temp,
                    high: weather.maxTemp,
                    low: weather.minTemp,
                    temperatureUnits: state.temperatureUnits,
                  );
                },
              ),
            )
          ],
        ),
        Center(
          child: Text(
            weather.formattedCondition,
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w200, color: Colors.white),
          ),
        )
      ],
    );
  }
}
