import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:handy/generated/l10n.dart';
import 'dart:async';

class Success extends StatefulWidget {
  @override
  SuccessState createState() => new SuccessState();
}

class SuccessState extends State<Success> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
    //loadMusic();
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.of(context).pushReplacementNamed('/Login');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 3.3),
              child: Text(
                S.of(context).thank_you,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            FlareActor("assets/img/SuccessCheck.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: "Untitled"),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.only(
                left: 40,
                right: 40,
              ),
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 2.7),
              child: Text(
                S.of(context).thank_you_for_your_registration,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
