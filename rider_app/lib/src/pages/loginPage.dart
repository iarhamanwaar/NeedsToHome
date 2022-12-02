import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/user_controller.dart';
import 'Widget/bezierContainer.dart';
import '../repository/user_repository.dart' as userRepo;
import '../../generated/l10n.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends StateMVC<LoginPage> {
  UserController _con;
  _LoginPageState() : super(UserController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
    if (userRepo.currentUser.value.apiToken != null) {
      Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
    }
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20.0, bottom: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).login,
                    style: TextStyle(fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    S.of(context).welcome,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Image(
      image: AssetImage(
        "assets/img/logo.png",
      ),
      fit: BoxFit.cover,
      height: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _con.scaffoldKey,
      //resizeToAvoidBottomPadding: false,
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .24),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(height: height * .030),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Form(
                        key: _con.loginFormKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                onSaved: (input) => _con.user.email = input,
                                validator: (input) => !input.contains('@')
                                    ? S.of(context).should_be_valid_email
                                    : null,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Theme.of(context).dividerColor,
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: InputBorder.none,
                                    hintText: S.of(context).email,
                                    contentPadding: EdgeInsets.all(16.0),
                                    prefixIcon: Icon(
                                      Icons.perm_identity,
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(1),
                                    )),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                            SizedBox(height: 25.0),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                onSaved: (input) => _con.user.password = input,
                                validator: (input) => input.length < 3
                                    ? S
                                        .of(context)
                                        .should_be_more_than_3_characters
                                    : null,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Theme.of(context).dividerColor,
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17.0,
                                    ),
                                    border: InputBorder.none,
                                    hintText: S.of(context).password,
                                    contentPadding: EdgeInsets.all(16.0),
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(1),
                                    )),
                                obscureText: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * .099),
                    Container(
                      height: 50.0,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        onPressed: () {
                          // Navigator.of(context).pushNamed('/Otpverification');

                          _con.login();
                        },
                        shape: StadiumBorder(),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.secondary,
                                  Theme.of(context).colorScheme.secondary
                                ],
                                begin: Alignment(-2.0, -2.0),
                                end: Alignment(1.0, 1.0),
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 200.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(S.of(context).login,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .merge(TextStyle(
                                        color: Theme.of(context)
                                            .primaryColorLight))),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/ForgetPassword');
                      },
                      textColor: Theme.of(context).hintColor,
                      child: Text(S.of(context).forgot),
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/SignUp');
                      },
                      textColor: Theme.of(context).hintColor,
                      child: Text(S.of(context).if_you_dont_have_account),
                    ),

                    //  _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
