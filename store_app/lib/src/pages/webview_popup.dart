import 'package:flutter/material.dart';


class EasyWeb extends StatefulWidget {
  @override
  _EasyWebState createState() => _EasyWebState();
}

class _EasyWebState extends State<EasyWeb> {
  String src = 'https://flutter.dev';

  bool open = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: IconButton(
            icon: Icon(Icons.backpack),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Stack(
          children: <Widget>[],
        ));
  }
}
