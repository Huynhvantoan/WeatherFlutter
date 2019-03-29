import 'package:flutter/material.dart';
import 'package:weather/blocs/blocs.dart';

class TemperatureWeather extends StatelessWidget {
  final double temperature;
  final double low;
  final double high;
  final TemperatureUnits temperatureUnits;

  const TemperatureWeather(
      {Key key, this.temperature, this.low, this.high, this.temperatureUnits})
      : assert(temperature != null &&
      low != null &&
      high != null &&
      temperatureUnits != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(right: 10), child: Text('${_formattedTemperature(temperature)}°', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),),
        Column(
          children: <Widget>[
            Text('Max: ${_formattedTemperature(high)}°',
              style: TextStyle(color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w100),),
            Text('Min: ${_formattedTemperature(low)}°',
              style: TextStyle(color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w100),)
          ],
        )
      ],
    );
  }

  int _toFahrenheit(double celsius) => ((celsius * 9 / 5) + 32).round();

  int _formattedTemperature(double t) => temperatureUnits == TemperatureUnits.fahrenheit? _toFahrenheit(t): t.round();
}

