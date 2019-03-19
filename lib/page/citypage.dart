import 'package:flutter/material.dart';

class CityPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CityState();
}

class _CityState extends State<CityPage> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search City'),
      ),
      body: Form(
          child: Row(
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: TextFormField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'City',
                hintText: 'Ho chi minh',
              ),
            ),
          )),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pop(context, textController.text);
              })
        ],
      )),
    );
  }
}
