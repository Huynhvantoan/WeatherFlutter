import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/blocs/blocs.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blocSetting = BlocProvider.of<SettingBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Setting'),),
      body: ListView(
        children: <Widget>[
          BlocBuilder(bloc: blocSetting, builder: (_, SettingsState state) {
            return ListTile(
              title: Text('Tempe'),
              isThreeLine: true,
              subtitle: Text('Use metric measurements for temperature units.'),
              trailing: Switch(
                  value: state.temperatureUnits == TemperatureUnits.celsius,
                  onChanged:(_) => blocSetting.dispatch(TemperatureUnitsToggled())),
            );
          })
        ],
      ),
    );
  }

}
