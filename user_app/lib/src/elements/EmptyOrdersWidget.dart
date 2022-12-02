import 'dart:async';
import 'package:flutter/material.dart';

class EmptyOrdersWidget extends StatefulWidget {
  EmptyOrdersWidget({
    Key key,
  }) : super(key: key);

  @override
  _EmptyOrdersWidgetState createState() => _EmptyOrdersWidgetState();
}

class _EmptyOrdersWidgetState extends State<EmptyOrdersWidget> {
  bool loading = true;

  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        loading
            ? SizedBox(
                height: 3,
                child: LinearProgressIndicator(
                  backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                ),
              )
            : SizedBox(),
        Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            height: MediaQuery.of(context).size.height / 5,
          ),
          Image(
            image: AssetImage(
              'assets/img/no_data_found.png',
            ),
            height: 200,
            width: 500,
          ),
        ])),
      ],
    );
  }
}
