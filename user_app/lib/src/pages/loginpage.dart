import 'package:flutter/material.dart';
import 'package:multisuperstore/src/repository/settings_repository.dart';
import '../../generated/l10n.dart';
import 'package:multisuperstore/src/controllers/user_controller.dart';
import 'dart:math';

import 'package:mvc_pattern/mvc_pattern.dart';
class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends StateMVC<LoginPage>  with SingleTickerProviderStateMixin {

  UserController _con;
  _LoginPageState() : super(UserController()) {
    _con = controller;
  }
  AnimationController animationController;
  void initState() {
    super.initState();

    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 10),
    );

    animationController.repeat();
  }
  @override
  void dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _con.scaffoldKeyState,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/loginbg1.jpg'), fit: BoxFit.cover)),
          ),

          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Color(0xff161d27).withOpacity(0.9),
                  Color(0xff161d27),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          Positioned(
            top: 50.0,
            right: size.width * -0.24,
            child:Container(
              alignment: Alignment.center,
              child: AnimatedBuilder(
                animation: animationController,
                child: Container(
                  child: Image(
                    image: AssetImage('assets/img/plate-food2.png'),

                    height:size.width * 0.5,
                    fit: BoxFit.fill,

                  ),
                ),
                builder: (BuildContext context, Widget _widget) {
                  return Transform.rotate(
                    angle: animationController.value * 2 * pi,
                    child: _widget,
                  );
                },
              ),


            ),
          ),
    Form(
    key: _con.loginFormKey,
       child:   Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  S.of(context).welcome,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "to ${setting.value.appName}, let's Login in",
                    style:Theme.of(context).textTheme.headline1.merge(TextStyle(color:Colors.grey))
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    margin: EdgeInsets.only(left: 40, right: 40),
                    width: double.infinity,
                    child: TextFormField(
                        textAlign: TextAlign.left,
                        autocorrect: true,
                        onSaved: (input) => _con.user.email = input,
                        validator: (input) => !input.contains('@') ? S.of(context).should_be_valid_email : null,
                        style: Theme.of(context).textTheme.headline3.merge(TextStyle(color:Theme.of(context).primaryColorLight)),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: S.of(context).email,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .headline1
                              .merge(TextStyle(color: Colors.grey)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColorDark,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColorDark,
                              width: 1.0,
                            ),
                          ),
                        ))),
                SizedBox(height:3),
                Container(
                    margin: EdgeInsets.only(left: 40, right: 40),
                    width: double.infinity,
                    child: TextFormField(
                        textAlign: TextAlign.left,
                        autocorrect: true,

                        onSaved: (input) => _con.user.password = input,
                        validator: (input) => input.length < 3 ? S.of(context).should_be_more_than_3_characters : null,
                        style: Theme.of(context).textTheme.headline3.merge(TextStyle(color:Theme.of(context).primaryColorLight)),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: S.of(context).password,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .headline1
                              .merge(TextStyle(color: Colors.grey)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColorDark,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColorDark,
                              width: 1.0,
                            ),
                          ),
                        ))),

                SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed('/ForgetPassword');
                  },
                  child:Text(
                      S.of(context).forget_password,
                      style:Theme.of(context).textTheme.subtitle2.merge(TextStyle(color: Theme.of(context).primaryColorLight, fontWeight: FontWeight.bold))
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 45,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    onPressed: () {
                      _con.login();
                    },
                    color: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                        S.of(context).login,
                        style:Theme.of(context).textTheme.headline1.merge(TextStyle(color:Theme.of(context).primaryColorLight,fontWeight: FontWeight.bold,))

                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text(
                      "It's your first time here?",
                      style: TextStyle(color: Theme.of(context).primaryColorLight),
                    ),
                    SizedBox(
                      width: 8,
                    ),InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed('/register');
                        },
                        child:Text(
                          "Sign up",
                          style:
                          TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold),
                        )
                    ),

                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
    ),
        ],
      ),
    );
  }


}
