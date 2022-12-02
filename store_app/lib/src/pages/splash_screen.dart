
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends StateMVC<SplashScreen> {


  @override
  void initState() {
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  Container(
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
                    ) :Image.asset(
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
