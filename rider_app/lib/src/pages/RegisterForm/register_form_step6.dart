import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../generated/l10n.dart';
import '../../controllers/user_controller.dart';
import '../../models/register.dart';

// ignore: must_be_immutable
class RegisterFormStep6 extends StatefulWidget {
  RegisterFormStep6({Key key, this.registerData, this.image, this.proofImage}) : super(key: key);
  File image;
  File proofImage;
  RegisterModel registerData;

  @override
  _RegisterFormStep6State createState() => _RegisterFormStep6State();
}

class _RegisterFormStep6State extends StateMVC<RegisterFormStep6> {
  UserController _con;

  _RegisterFormStep6State() : super(UserController()) {
    _con = controller;
  }

  String selectedRadio;
  String _drivingMode;

  @override
  void initState() {
    super.initState();
  }

  setSelectedRadio(String val) {
    widget.registerData.vehicleType = val;
    setState(() {
      _drivingMode = val;
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    var color = Colors.grey[300];
    return Scaffold(
      key: _con.scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              //color: Theme.of(context).primaryColorDark,
              image: DecorationImage(
                  image: AssetImage(
                    'assets/img/background_image.jpg',
                  ),
                  fit: BoxFit.fill)),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.8),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        S.of(context).vehicle_details,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .merge(TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              spreadRadius: 15),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Form(
                      key: _con.formKeys[5],
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: 10,
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: Text(
                                          'Select Your Vehicle Type',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(top: 20, bottom: 15),
                                    child: InkWell(
                                      onTap: () {
                                        setSelectedRadio('Bike');
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              top: 10,
                                              right: 10,
                                              bottom: 10,
                                              left: 10),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Theme.of(context)
                                                      .dividerColor
                                                      .withOpacity(0.2),
                                                  blurRadius: 1,
                                                  spreadRadius: 1,
                                                ),
                                              ]),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: Radio(
                                                    value: 'Bike',
                                                    groupValue: selectedRadio,
                                                    activeColor: Colors.blue,
                                                    onChanged: (val) {
                                                      setSelectedRadio(val);
                                                    }),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    right: 0,
                                                  ),
                                                  height: 60,
                                                  width: 60,
                                                  child: Card(
                                                    child: new CircleAvatar(
                                                      backgroundImage: AssetImage(
                                                          'assets/img/bike.png'),
                                                      radius: 80.0,
                                                    ),
                                                    elevation: 2.0,
                                                    shape: CircleBorder(),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('Bike',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline1),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                  Container(
                                    child: InkWell(
                                      onTap: () {
                                        setSelectedRadio('Cycle');
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              top: 10,
                                              left: 10,
                                              right: 10,
                                              bottom: 10),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Theme.of(context)
                                                      .dividerColor
                                                      .withOpacity(0.2),
                                                  blurRadius: 1,
                                                  spreadRadius: 1,
                                                ),
                                              ]),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: Radio(
                                                    value: 'Cycle',
                                                    groupValue: selectedRadio,
                                                    activeColor: Colors.blue,
                                                    onChanged: (val) {
                                                      setSelectedRadio(val);
                                                    }),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    right: 0,
                                                  ),
                                                  height: 60,
                                                  width: 60,
                                                  child: Card(
                                                    child: new CircleAvatar(
                                                      backgroundImage: AssetImage(
                                                          'assets/img/cycle.png'),
                                                      radius: 80.0,
                                                    ),
                                                    elevation: 2.0,
                                                    shape: CircleBorder(),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('Cycle',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline1),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                ])),
                            _drivingMode == 'Bike'
                                ? Container(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    width: double.infinity,
                                    child: TextFormField(
                                        textAlign: TextAlign.left,
                                        autocorrect: true,
                                        keyboardType: TextInputType.text,
                                        onSaved: (input) => widget
                                            .registerData.licenseno = input,
                                        validator: (input) => input.length < 1
                                            ? S.of(context).driving_licence
                                            : null,
                                        decoration: InputDecoration(
                                          labelText:
                                              S.of(context).driving_licence,
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              .merge(TextStyle(
                                                  color: Theme.of(context)
                                                      .hintColor)),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: color,
                                              width: 1.0,
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              width: 1.0,
                                            ),
                                          ),
                                        )),
                                  )
                                : Container(),
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              width: double.infinity,
                              child: TextFormField(
                                  textAlign: TextAlign.left,
                                  autocorrect: true,
                                  keyboardType: TextInputType.text,
                                  onSaved: (input) =>
                                      widget.registerData.model = input,
                                  validator: (input) => input.length < 1
                                      ? 'Please enter your Vehicle Licence'
                                      : null,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).vehicle_model,
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .merge(TextStyle(
                                            color:
                                                Theme.of(context).hintColor)),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: color,
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        width: 1.0,
                                      ),
                                    ),
                                  )),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              width: double.infinity,
                              child: TextFormField(
                                  textAlign: TextAlign.left,
                                  autocorrect: true,
                                  keyboardType: TextInputType.text,
                                  onSaved: (input) =>
                                      widget.registerData.color = input,
                                  validator: (input) => input.length < 1
                                      ? 'Please enter your Vehicle Color'
                                      : null,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).vehicle_color,
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .merge(TextStyle(
                                            color:
                                                Theme.of(context).hintColor)),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: color,
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        width: 1.0,
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      width: double.infinity,
                      height: 70,
                      color: Theme.of(context).primaryColor,
                      child: Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          child: MaterialButton(
                              onPressed: () {
                                if (_con.formKeys[5].currentState.validate()) {
                                  if (widget.registerData.vehicleType != '' &&
                                      widget.registerData.vehicleType != null) {
                                    _con.formKeys[5].currentState.save();
                                    _con.register(
                                        widget.image,
                                        widget.proofImage,
                                        widget.registerData);
                                  } else {
                                    // ignore: deprecated_member_use
                                    _con.scaffoldKey?.currentState?.showSnackBar(SnackBar(
                                      content: Text('Please select your vehicle type'),
                                    ));
                                  }
                                }
                              },
                              color: Theme.of(context).colorScheme.secondary,
                              child: Text(
                                S.of(context).submit,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .merge(TextStyle(
                                        color: Theme.of(context)
                                            .primaryColorLight)),
                              )))),
                ),
              ],
            ),
          )),
    );
  }
}
