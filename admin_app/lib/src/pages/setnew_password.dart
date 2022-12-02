import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/components/constants.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
// ignore: must_be_immutable
class SetNewPassword extends StatefulWidget {
  final Function backToLogin;
  UserController con;
  SetNewPassword({@required this.backToLogin, this.con});

  @override
  _SetNewPasswordState createState() => _SetNewPasswordState();
}


class _SetNewPasswordState extends StateMVC<SetNewPassword> {
  UserController _con;
  _SetNewPasswordState() : super(UserController()) {
    _con = controller;

  }
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
              key: _con.loginFormKey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(size.width > 670 ? 30 : 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Enter Your New Password',
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
                        onSaved: (input) => _con.userData.password = input,
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
                        height: 64,
                      ),
                      InkWell(
                        onTap: () {
                          _con.userData.email = widget.con.userData.email;
                          _con.updatePassword(_con.userData, widget.backToLogin);
                         // widget.backToLogin();
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
                              'UPDATE',
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
                              widget.backToLogin();
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
