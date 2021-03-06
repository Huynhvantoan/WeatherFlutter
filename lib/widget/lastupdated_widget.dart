import 'package:flutter/material.dart';

class LastUpdated extends StatelessWidget {
  final DateTime dateTime;

  LastUpdated({Key key,@required this.dateTime})
      : assert(dateTime != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Update ${TimeOfDay.fromDateTime(dateTime).format(context)}',
      style: TextStyle(
          fontWeight: FontWeight.w200, color: Colors.white, fontSize: 20),
    );
  }
}
