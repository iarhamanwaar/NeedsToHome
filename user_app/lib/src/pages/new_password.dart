import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import '../Widget/bezierContainer.dart';
import '../Animation/FadeAnimation.dart';
// ignore: must_be_immutable
class NewPasswordWidget extends StatefulWidget {
  String email;
  NewPasswordWidget({Key key, this.email}) : super(key: key);
  @override
  _NewPasswordWidgetState createState() => _NewPasswordWidgetState();
}

class _NewPasswordWidgetState extends StateMVC<NewPasswordWidget> {
  UserController _con;
  _NewPasswordWidgetState() : super(UserController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _title() {
    return Image(
      image: AssetImage("assets/img/logo.png"),
      fit: BoxFit.cover,
      height: 100,
      width: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _con.scaffoldKey,
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(top: 40, left: 0, child: _backButton()),
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(key: null,),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .21),
                    _title(),
                    SizedBox(height: height * .010),
                    Container(
                      child: Form(
                        key: _con.loginFormKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 70,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                onSaved: (input) => _con.register_data.password = input,
                                validator: (input) => input.length < 3 ? S.of(context).should_be_more_than_3_characters : null,
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText:S.of(context).password,
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
                                  )
                              ),
                            ),
                            SizedBox(height: 45.0),
                            _submitButton(_con.register_data.email_id),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  FadeAnimation(
                      0.01,
                      Text(
                        'New Password',
                        style: Theme.of(context).textTheme.headline3.merge(TextStyle(color: Colors.black)),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _submitButton(email) {
    return Container(
      height: 50.0,
      // ignore: deprecated_member_use
      child: RaisedButton(
        onPressed: () {
          _con.register_data.email_id = widget.email;
          _con.updatePassword(_con.register_data);
        },
        shape: StadiumBorder(),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Theme.of(context).colorScheme.secondary, Theme.of(context).colorScheme.secondary],
                begin: Alignment(-2.0, -2.0),
                end: Alignment(1.0, 1.0),
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text('Update',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6.merge(
                      TextStyle(color: Theme.of(context).primaryColorLight),
                    )),
          ),
        ),
      ),
    );
  }
}
