import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/splash_screen_controller.dart';
import '../repository/user_repository.dart';


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
    loadData();
  }

  void loadData() {


    _con.progress.addListener(() {
      double progress = 0;

      _con.progress.value.values.forEach((_progress) {

        progress += _progress;

        print('loading');
        print(progress);
      });
        if (progress == 100) {
          if(!currentUser.value.firstLoad) {
            currentUser.value.firstLoad = true;
          }
          try {
            if (currentUser.value.apiToken == null) {
              Navigator.of(context).pushReplacementNamed('/Login');
            } else {
              if(firstLoad==false) {
                setState(() { firstLoad=true; });

                Navigator.of(context).pushReplacementNamed('/Pages', arguments: 1);
              }
            }
          } catch (e) {}
        }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              (Theme.of(context).brightness == Brightness.dark)?
        Image.asset(
          'assets/img/darklogo.png',
          width: 150,
          fit: BoxFit.cover,
        ):Image.asset(
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
