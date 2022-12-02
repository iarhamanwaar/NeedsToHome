import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/components/constants.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:login_and_signup_web/src/pages/setnew_password.dart';
import 'package:login_and_signup_web/src/pages/splash_screen.dart';
import 'package:login_and_signup_web/src/repository/settings_repository.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vrouter/vrouter.dart';
import 'forgot_password.dart';
import 'login.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

import 'otp_page.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateMVC<HomePage> {
  Option selectedOption = Option.LogIn;
  UserController _con;
  _HomePageState() : super(UserController()) {
    _con = controller;
  }
  bool pageLoader = true;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();

      WidgetsBinding.instance.addPostFrameCallback((_) =>
          afterFirstLayout(context));


    Timer(Duration(seconds: 5), () {
      setState(() { pageLoader = false; });
    });
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;



    return Scaffold(
      key: _con.scaffoldKeyState,
      body: pageLoader?SplashScreen():Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Row(
              children: [
                Container(height: double.infinity, width: size.width / 2, color: Theme.of(context).primaryColorDark),
                Container(height: double.infinity, width: size.width / 2, color: Theme.of(context).primaryColor,),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  S.of(context).welcome,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).lets_kick_now,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      S.of(context).its_easy_and_take_less_than_30_seconds,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      setting.value.appName ,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Icon(
                  Icons.menu,
                  color: Theme.of(context).primaryColorDark,
                  size: 28,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.copyright,
                      color: Colors.grey,
                      size: 24,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '${S.of(context).copyright}  2022',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),

              //Animation 1
              //transitionBuilder: (widget, animation) => RotationTransition(
              //  turns: animation,
              //  child: widget,
              //),
              //switchOutCurve: Curves.easeInOutCubic,
              //switchInCurve: Curves.fastLinearToSlowEaseIn,

              //Animation 2
              transitionBuilder: (widget, animation) => ScaleTransition(child: widget, scale: animation),

              child: selectedOption == Option.LogIn
                  ?  LogIn(
                onSignUpSelected: () {
                  setState(() {
                    selectedOption = Option.SignUp;
                  });
                },
                onForgot: () {
                  setState(() {
                    selectedOption = Option.forgot;
                  });
                },
                con: _con,
              )
                  :  selectedOption == Option.forgot ?ForgotPassword(
                onLogInSelected: () {
                  setState(() {
                    selectedOption = Option.LogIn;
                  });

                },
                onOTPSelected: () {
                  setState(() {
                    selectedOption = Option.otp;
                  });

                },
                con: _con,
              ):selectedOption == Option.otp ? OtpPage(
                onLogInSelected: () {
                  setState(() {
                    selectedOption = Option.LogIn;
                  });

                },
                onNewSelected: () {
                  setState(() {
                    selectedOption = Option.newPassword;
                  });

                },
                con: _con,
              ):selectedOption == Option.newPassword ?
              SetNewPassword(
                backToLogin: () {
                  setState(() {
                    selectedOption = Option.LogIn;
                  });

                },
                con: _con,
              ):Container()

            )],
        ),
      ),
    );


  }

  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout

    if(currentUser.value.auth==true) {
      // ignore: deprecated_member_use
      VRouter.of(context).pushReplacement('/dashboard');
    }
  }
}
