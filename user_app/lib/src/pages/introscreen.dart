import 'package:flutter/material.dart';
import 'package:multisuperstore/src/elements/my_introview.dart';




class IntroScreen extends StatefulWidget {


  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {





  @override
  void initState() {
    super.initState();

  }

  goTONextPage(){

    Navigator.of(context).pushReplacementNamed('/Login');
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyIntroView(
        pages: <Widget>[
          Image.asset("assets/img/groceryintro2.png", fit: BoxFit.fill),
          Image.asset("assets/img/restaurant.png", fit: BoxFit.fill),
          Image.asset("assets/img/handyman2.png", fit: BoxFit.fill),
        ],
        onIntroCompleted: () {
        Navigator.of(context).pushReplacementNamed('/location');

         // Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
          //To the navigation stuff here
        },
      )
    );
  }
}
