import 'dart:math';
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/components/constants.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import '../../generated/l10n.dart';
// ignore: must_be_immutable
class ForgotPassword extends StatefulWidget {
  final Function onOTPSelected;
  final Function onLogInSelected;
  UserController con;
  ForgotPassword({@required this.onOTPSelected, this.onLogInSelected, this.con});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


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
            width:520,
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
                        'Forgot Password',
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
                        height: 64,
                      ),
                      InkWell(
                        onTap: () {
    if (widget.con.loginFormKey.currentState.validate()) {
      widget.con.loginFormKey.currentState.save();
      //
      var rng = new Random();

      String code = (rng.nextInt(9000) + 1000).toString();
      print('code');
      print(code);
      widget.con.otpNumber = code;
      reSetPassword(widget.con.userData.email, code);
      widget.onOTPSelected();
    }

                         // Navigator.of(context).push(MaterialPageRoute(builder: (context) => A4printer()));
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: kPrimaryColor.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'SEND OTP',
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


                      Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 8,
                        children: [

                          GestureDetector(
                            onTap: () {
                              widget.onLogInSelected();
                            },
                            child: Row(
                              mainAxisAlignment:MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).login,
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


                        ],
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
