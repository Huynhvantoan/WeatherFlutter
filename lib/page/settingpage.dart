import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingState();
}

class _SettingState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Setting',
            style: TextStyle(color: Colors.blue, fontSize: 30),
          ),
          FloatingActionButton(onPressed: () {
            Navigator.pop(context);
          })
        ],
      ),
    );
  }
}
