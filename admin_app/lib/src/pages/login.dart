import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/components/constants.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import '../../generated/l10n.dart';
// ignore: must_be_immutable
class LogIn extends StatefulWidget {
  final Function onSignUpSelected;
  final Function onForgot;
  UserController con;
  LogIn({@required this.onSignUpSelected, this.con,this.onForgot});

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(17),
      child: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: size.height *
                (size.height > 770
                    ? 0.7
                    : size.height > 670
                        ? 0.8
                        : 0.9),
            width: 520,
            color: Theme.of(context).primaryColor,
            child: Form(
              key: widget.con.loginFormKey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(size.width > 670 ? 30 : 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).login,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 30,
                        child: Divider(
                          color: kPrimaryColor,
                          thickness: 2,
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      TextFormField(
                        onSaved: (input) => widget.con.userData.email = input,
                        validator: (input) => !input.contains('@') ? S.of(context).should_be_valid_email : null,
                        decoration: InputDecoration(
                          hintText: S.of(context).email,
                          labelText: S.of(context).email,
                          suffixIcon: Icon(
                            Icons.mail_outline,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      TextFormField(
                        onSaved: (input) => widget.con.userData.password = input,
                        validator: (input) =>  input.length<= 1 ? 'Invalid Password' : null,
                        decoration: InputDecoration(
                          hintText: S.of(context).password,
                          labelText: S.of(context).password,
                          suffixIcon: Icon(
                            Icons.lock_outline,
                          ),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),


                      GestureDetector(
                        onTap: () {
                          widget.onForgot();
                        },
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.end,
                          children: [
                            Text(
                              'Forgot Password',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 64,
                      ),
                      InkWell(
                        onTap: () {
                         widget.con.login();

                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).primaryColorDark.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              S.of(context).login,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),



                    ],
                  ),
                ),
              ),
            ),
            ),
          ),
        ),
      ),
    );
  }
}
