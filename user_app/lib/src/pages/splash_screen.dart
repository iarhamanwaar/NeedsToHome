import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/src/repository/settings_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/user_repository.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends StateMVC<SplashScreen> {
  SplashScreenController _con;
  bool firstLoad = false;
  SplashScreenState() : super(SplashScreenController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    print('page test');
    loadData();
  }

  void loadData() {
    double progress = 0;

    _con.progress.addListener(() {
      _con.progress.value.values.forEach((_progress) {
        progress += _progress;
        print(progress);
      });
      if (progress == 100) {
        try {
          currentUser.value.firstLoad = true;

          if (currentUser.value.auth != false && currentUser.value.auth != null) {
            if (currentUser.value.latitude != 0.0 && currentUser.value.longitude != 0.0) {
              if (firstLoad == false) {
                setState(() {
                  firstLoad = true;
                });
                //Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
                if (setting.value.version == setting.value.appVersion) {
                  if (currentUser.value.locationType == 'manual') {
                    Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
                  } else {
                    Navigator.of(context).pushReplacementNamed('/location');
                  }
                } else {
                  Navigator.of(context).pushReplacementNamed('/force_update');
                }
              }
            } else {}
          } else {
            Navigator.of(context).pushReplacementNamed('/introscreen');
          }
        } catch (e) {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: 1 == 2
          ? Container(
              padding: EdgeInsets.only(
                top: 0,
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: FlareActor(
                      "assets/img/splash.flr",
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      animation: "bottomanimi",
                    ),
                  ),
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/img/logo.png',
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 50),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
