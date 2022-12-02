import 'package:dotted_border/dotted_border.dart';
import 'package:handy/generated/l10n.dart';
import 'package:handy/src/models/zonelistmodel.dart';
import 'package:responsive_ui/responsive_ui.dart';
import '/src/controllers/user_controller.dart';
import '/src/models/category.dart';
import '/src/models/select_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import 'Widget/bezierContainer.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends StateMVC<Register> {
  int _currentStep = 0;
  int dropDownValue = 0;

  TextEditingController _controllerAddress1 = new TextEditingController();
  TextEditingController _controllerAddress2 = new TextEditingController();
  TextEditingController _controllerCity = new TextEditingController();
  TextEditingController _controllerState = new TextEditingController();
  TextEditingController _controllerZipcode = new TextEditingController();
  UserController _con;
  String _zone;

  _RegisterState() : super(UserController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();

    pickedDate = DateTime.now();
    _con.listenForCategory();
    _con.listenForZone();
    _con.registerData.gender = 'Male';
    _con.registerData.dob =
        "${pickedDate.year},${pickedDate.month}, ${pickedDate.day}";
  }

  DateTime pickedDate;
  AnimationController controller1;
  Animation<double> scaleAnimation;

  String _gender = 'Male';
  // ignore: non_constant_identifier_names
  void Imagepickerbottomsheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new ListTile(
                  leading: new Icon(Icons.camera),
                  title: new Text(S.of(context).camera),
                  onTap: () => getImage(),
                ),
                /** new ListTile(
                  leading: new Icon(Icons.image),
                  title: new Text('Gallery'),
                  onTap: () => getImagegaller(),
                ),*/
              ],
            ),
          );
        });
  }

  int selectedRadio;
  File _image;
  int currStep = 0;
  final picker = ImagePicker();

  Future getImage() async {
    try {
      final pickedFile = await picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 480,
          maxWidth: 640,
          imageQuality: 50);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          Navigator.of(context).pop();
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      print(e.code);
    }
  }

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromGallery() async {
    await ImagePicker().pickImage(source: ImageSource.gallery);
    /** setState(() {
      _image = File(image.path);
    }); */
  }

  _pickDate() async {
    Theme.of(context).copyWith(
      primaryColor: Colors.amber,
    );
    DateTime date = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 70),
        lastDate: DateTime(DateTime.now().year + 1),
        initialDate: pickedDate,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Theme.of(context).colorScheme.secondary,
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              colorScheme: ColorScheme.light(primary: Theme.of(context).colorScheme.secondary).copyWith(secondary: Theme.of(context).colorScheme.secondary),
            ),
            child: child,
          );
        });
    if (date != null)
      setState(() {
        pickedDate = date;
        _con.registerData.dob =
            "${pickedDate.year},${pickedDate.month}, ${pickedDate.day}";
      });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _con.scaffoldKey,
      body: Theme(
        data: ThemeData(
            primaryColor: Theme.of(context).colorScheme.secondary,
            // ignore: deprecated_member_use
            buttonColor: Theme.of(context).accentColor,
            canvasColor: Theme.of(context).primaryColor),
        child: Container(
          height: height,
          child: Stack(children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child:  BezierContainer()
            ),

            SizedBox(height: MediaQuery.of(context).size.height * .15),
            SafeArea(
              child: Container(
                width:
                    double.infinity, //To make it use as much space as it wants
                height: MediaQuery.of(context).size.height,
                child: Column(children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    title: Text(S.of(context).register,
                        style: Theme.of(context).textTheme.headline4),
                    leading: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.02,
                          bottom: MediaQuery.of(context).size.height * 0.09),
                      child: Container()),
                  Expanded(
                    child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Stepper(
                        type: StepperType.vertical,
                        currentStep: _currentStep,
                        onStepTapped: (int step) =>
                            setState(() => _currentStep = step),
                        onStepContinue: _currentStep < 5
                            ? () => setState(() {
                                  if (_currentStep < 4) {
                                    if (_con.formKeys[_currentStep].currentState
                                        .validate()) {
                                      _con.formKeys[_currentStep].currentState
                                          .save();

                                      if (_currentStep == 1) {
                                       // _con.getLatLong(widget);
                                      }

                                      if (_currentStep == 3) {
                                        if (_image != null) {
                                          _currentStep += 1;
                                          print(_currentStep);
                                        } else {
                                          // ignore: deprecated_member_use
                                          _con.scaffoldKey?.currentState?.showSnackBar(SnackBar(
                                            content: Text(
                                                S.of(context).upload_your_pic),
                                          ));
                                        }
                                      } else {
                                        _currentStep += 1;
                                      }
                                    }
                                  } else {
                                    if (_con.categoryList.length == 0) {
                                      // ignore: deprecated_member_use
                                      _con.scaffoldKey?.currentState?.showSnackBar(SnackBar(
                                        content: Text(
                                            'S.of(context).add_your_category'),
                                      ));
                                    } else {
                                     // _con.register(_image);
                                    }
                                  }

                                  //print(_con.registerData.toMap());
                                })
                            : null,
                        onStepCancel: _currentStep > 0
                            ? () => setState(() => _currentStep -= 1)
                            : null,
                        controlsBuilder: (BuildContext context, ControlsDetails controls, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                          return Container(
                            height: 70,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _currentStep == 0
                                    ? Text("")
                                // ignore: deprecated_member_use
                                    : RaisedButton(
                                  onPressed: onStepCancel,
                                  textColor: Colors.white,
                                  textTheme: ButtonTextTheme.normal,
                                  child: Row(children: <Widget>[
                                    const Icon(Icons.chevron_left),
                                    Text(S.of(context).prev)
                                  ]),
                                ),
                                // ignore: deprecated_member_use
                                RaisedButton(
                                  onPressed: onStepContinue,
                                  textColor: Colors.white,
                                  textTheme: ButtonTextTheme.normal,
                                  child: Row(children: <Widget>[
                                    _currentStep >= 4
                                        ? Icon(Icons.done)
                                        : Icon(Icons.chevron_right),
                                    _currentStep >= 4
                                        ? Text(S.of(context).done)
                                        : Text(S.of(context).next),
                                  ]),
                                ),
                              ],
                            ),
                          );
                        },
                        steps: <Step>[
                          Step(
                            title: Text(
                              S.of(context).general,
                            ),
                            content: Form(
                              key: _con.formKeys[0],
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                      textAlign: TextAlign.left,
                                      onSaved: (input) =>
                                          _con.registerData.firstname = input,
                                      validator: (input) => input.length < 3
                                          ? S
                                              .of(context)
                                              .should_be_more_than_3_characters
                                          : null,
                                      autocorrect: true,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: S.of(context).first_name,
                                        hintStyle:
                                            Theme.of(context).textTheme.caption,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey[300],
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Theme.of(context).colorScheme.secondary,
                                            width: 1.0,
                                          ),
                                        ),
                                      )),
                                  SizedBox(height: 5),
                                  Container(
                                      width: double.infinity,
                                      height: 70,
                                      child: TextFormField(
                                          textAlign: TextAlign.left,
                                          autocorrect: true,
                                          onSaved: (input) => _con
                                              .registerData.lastname = input,
                                          validator: (input) => input.length < 3
                                              ? S
                                                  .of(context)
                                                  .should_be_more_than_3_characters
                                              : null,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            hintText: S.of(context).last_name,
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .caption,
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey[300],
                                                width: 1.0,
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme.secondary,
                                                width: 1.0,
                                              ),
                                            ),
                                          ))),
                                  SizedBox(height: 5),
                                  Container(
                                    width: double.infinity,
                                    height: 70,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "DOB",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          InkWell(
                                            onTap: _pickDate,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${pickedDate.year},${pickedDate.month}, ${pickedDate.day}",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Icon(Icons.arrow_drop_down)
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 0, right: 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    //                    <--- top side
                                                    color: Colors.grey[300],
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.of(context).gender,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ]),
                                  Container(
                                    width: double.infinity,
                                    child: DropdownButton(
                                        value: _gender,
                                        isExpanded: true,
                                        focusColor:
                                            Theme.of(context).colorScheme.secondary,
                                        underline: Container(
                                          color: Colors.grey[300],
                                          height: 1.0,
                                        ),
                                        items: [
                                          DropdownMenuItem(
                                            child: Text(S.of(context).male),
                                            value: 'Male',
                                          ),
                                          DropdownMenuItem(
                                            child: Text(S.of(context).female),
                                            value: 'Female',
                                          ),
                                          DropdownMenuItem(
                                              child: Text(
                                                  S.of(context).transgender),
                                              value: 'Transgender'),
                                          DropdownMenuItem(
                                              child: Text(
                                                  S.of(context).transgender),
                                              value: 'Others')
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _gender = value;
                                            _con.registerData.gender = value;
                                            print(_con.registerData.lastname);
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            isActive: _currentStep >= 0,
                            state: _currentStep >= 0
                                ? StepState.complete
                                : StepState.disabled,
                          ),
                          Step(
                            title: Text(
                              S.of(context).address,
                            ),
                            content: Form(
                              key: _con.formKeys[1],
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 20),
                                    Container(
                                        child: Div(
                                            colS: 12,
                                            colM: 12,
                                            colL: 5,
                                            child: Container(
                                              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width > 1024 ? 30 : 0),
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                Text('select your zone', style: Theme.of(context).textTheme.subtitle1),
                                                Container(
                                                  width: double.infinity,
                                                  child: DropdownButtonFormField(
                                                      value: _zone,
                                                      isExpanded: true,
                                                      validator: (input) => input.length < 1 ? 'please select your zone' : null,
                                                      focusColor: Theme.of(context).colorScheme.secondary,
                                                      items: _con.zoneList.map((ZoneListModel map) {
                                                        return new DropdownMenuItem(
                                                          value: map.zoneId,
                                                          child: new Text(map.title, style: new TextStyle(color: Colors.black)),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _zone = value;
                                                        });
                                                        _con.registerData.zoneId = _zone;
                                                        //_con.basicInformationData.zoneId = _zone;
                                                      }),
                                                ),
                                              ]),
                                            ))),
                                    SizedBox(height: 5,),
                                    Container(
                                        width: double.infinity,
                                        height: 70,
                                        child: TextFormField(
                                            controller: _controllerAddress1,
                                            textAlign: TextAlign.left,
                                            onSaved: (input) => _con
                                                .registerData.address1 = input,
                                            validator: (input) => input.length <
                                                    1
                                                ? S
                                                    .of(context)
                                                    .please_enter_your_address
                                                : null,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              hintText: S.of(context).address_1,
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 1.0,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme.secondary,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ))),
                                    SizedBox(height: 5),
                                    Container(
                                        width: double.infinity,
                                        height: 70,
                                        child: TextFormField(
                                            controller: _controllerAddress2,
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            onSaved: (input) => _con
                                                .registerData.address2 = input,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              hintText: S.of(context).address_2,
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 1.0,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme.secondary,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ))),
                                    SizedBox(height: 5),
                                    Container(
                                        width: double.infinity,
                                        height: 70,
                                        child: TextFormField(
                                            controller: _controllerCity,
                                            onSaved: (input) =>
                                                _con.registerData.city = input,
                                            validator: (input) =>
                                                input.length < 3
                                                    ? S
                                                        .of(context)
                                                        .please_enter_your_city
                                                    : null,
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              hintText: S.of(context).city,
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 1.0,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme.secondary,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ))),
                                    SizedBox(height: 5),
                                    Container(
                                        width: double.infinity,
                                        height: 70,
                                        child: TextFormField(
                                            controller: _controllerState,
                                            onSaved: (input) =>
                                                _con.registerData.state = input,
                                            validator: (input) =>
                                                input.length < 3
                                                    ? S
                                                        .of(context)
                                                        .please_enter_your_state
                                                    : null,
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              hintText: S.of(context).state,
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 2.0,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme.secondary,
                                                  width: 2.0,
                                                ),
                                              ),
                                            ))),
                                    SizedBox(height: 5),
                                    Container(
                                        width: double.infinity,
                                        height: 70,
                                        child: TextFormField(
                                            controller: _controllerZipcode,
                                            onSaved: (input) => _con
                                                .registerData
                                                .zipcode = input,

                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            decoration: InputDecoration(
                                              hintText: S.of(context).zipcode,
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 2.0,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme.secondary,
                                                  width: 2.0,
                                                ),
                                              ),
                                            ))),
                                    SizedBox(height: 5),
                                    InkWell(
                                      onTap: () async {

                                  /*   LocationResult result =
                                            await showLocationPicker(
                                          context,
                                                setting.value.googleMapsKey,
                                          initialCenter:
                                              LatLng(31.1975844, 29.9598339),
                                          automaticallyAnimateToCurrentLocation:
                                              true,
                                          myLocationButtonEnabled: true,
                                          layersButtonEnabled: true,
                                          resultCardAlignment:
                                              Alignment.bottomCenter,
                                        );

                                        var addresses = await locationFromAddress(
                                                result.address);
                                        var first = addresses.first;
                                        _controllerAddress1.text =
                                            '${first.thoroughfare}';
                                        _controllerAddress2.text =
                                            first.subLocality;
                                        _controllerCity.text = first.locality;
                                        _controllerState.text = first.adminArea;
                                        _controllerZipcode.text =
                                            first.postalCode; */

                                        // Navigator.of(widget.scaffoldKey.currentContext).pop();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              S
                                                  .of(context)
                                                  .get_address_from_map,
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16)),
                                          SizedBox(width: 10),
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.blue,
                                          )
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                            isActive: _currentStep >= 1,
                            state: _currentStep >= 1
                                ? StepState.complete
                                : StepState.disabled,
                          ),
                          Step(
                            title: Text(
                              S.of(context).register,
                            ),
                            content: Form(
                              key: _con.formKeys[2],
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 20),
                                    Container(
                                        width: double.infinity,
                                        height: 70,
                                        child: TextFormField(
                                            onSaved: (input) =>
                                                _con.registerData.email = input,
                                            validator: (input) =>
                                                !input.contains('@')
                                                    ? S
                                                        .of(context)
                                                        .should_be_valid_email
                                                    : null,
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              hintText:
                                                  S.of(context).email_address,
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 1.0,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme.secondary,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ))),
                                    SizedBox(height: 5),
                                    Container(
                                        width: double.infinity,
                                        height: 70,
                                        child: TextFormField(
                                            onSaved: (input) => _con
                                                .registerData
                                                .mobile = int.parse(input),
                                            validator: (input) =>
                                                input.length < 3
                                                    ? S
                                                        .of(context)
                                                        .not_a_valid_number
                                                    : null,
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            decoration: InputDecoration(
                                              hintText:
                                                  S.of(context).mobile_number,
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 1.0,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme.secondary,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ))),
                                    SizedBox(height: 5),
                                    Container(
                                        width: double.infinity,
                                        height: 70,
                                        child: TextFormField(
                                            onSaved: (input) => _con
                                                .registerData.password = input,
                                            validator: (input) => input.length <
                                                    3
                                                ? S
                                                    .of(context)
                                                    .should_be_more_than_3_characters
                                                : null,
                                            textAlign: TextAlign.left,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              hintText: S.of(context).password,
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 1.0,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme.secondary,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ))),
                                  ]),
                            ),
                            isActive: _currentStep >= 2,
                            state: _currentStep >= 2
                                ? StepState.complete
                                : StepState.disabled,
                          ),
                          Step(
                            title: Text(
                              S.of(context).profile,
                            ),
                            content: Form(
                              key: _con.formKeys[3],
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 20),
                                    GestureDetector(
                                      onTap: () {
                                        Imagepickerbottomsheet();
                                      },
                                      child: Container(
                                        child: Card(
                                          child: new CircleAvatar(
                                            backgroundImage: _image == null
                                                ? new AssetImage(
                                                    'assets/img/userImage.png')
                                                : FileImage(_image),
                                            radius: 40.0,
                                          ),
                                          elevation: 5.0,
                                          shape: CircleBorder(),
                                          clipBehavior: Clip.antiAlias,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        width: double.infinity,
                                        height: 70,
                                        child: TextFormField(
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            onSaved: (input) => _con
                                                .registerData.workexp = input,
                                            validator: (input) => input.length <
                                                    1
                                                ? S
                                                    .of(context)
                                                    .please_enter_your_experience
                                                : null,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              hintText:
                                                  S.of(context).work_experience,
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 2.0,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme.secondary,
                                                  width: 2.0,
                                                ),
                                              ),
                                            ))),
                                    SizedBox(height: 5),
                                    Container(
                                        width: double.infinity,
                                        height: 70,
                                        child: TextFormField(
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            onSaved: (input) => _con
                                                .registerData.aboutyou = input,
                                            validator: (input) =>
                                                input.length < 1
                                                    ? S
                                                        .of(context)
                                                        .please_enter_about_you
                                                    : null,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              hintText: S.of(context).about,
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 2.0,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme.secondary,
                                                  width: 2.0,
                                                ),
                                              ),
                                            ))),
                                  ]),
                            ),
                            isActive: _currentStep >= 3,
                            state: _currentStep >= 3
                                ? StepState.complete
                                : StepState.disabled,
                          ),
                          Step(
                            title: Text(
                              S.of(context).category,
                            ),
                            content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 20),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 0),
                                    height: 230,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _con.categoryList.length,
                                        itemBuilder: (context, index) {
                                          Category _categoryData = _con
                                              .categoryList
                                              .elementAt(index);
                                          return Row(
                                            children: <Widget>[
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 0, bottom: 10),
                                                      child: Text(
                                                        _categoryData
                                                            .categoryName,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6,
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.50,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              5,
                                                      margin: EdgeInsets.only(
                                                          bottom: 6),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Theme.of(
                                                                      context)
                                                                  .focusColor
                                                                  .withOpacity(
                                                                      0.05),
                                                              offset:
                                                                  Offset(0, 5),
                                                              blurRadius: 1)
                                                        ],
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10.0),
                                                            child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            'S.cat',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.w600)),
                                                                        SizedBox(
                                                                          width:
                                                                              2.0,
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            _categoryData.subcategoryName,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            maxLines:
                                                                                1,
                                                                            style:
                                                                                Theme.of(context).textTheme.caption,
                                                                          ),
                                                                        ),
                                                                      ]),
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            S.of(context).experience,
                                                                            style: TextStyle(fontWeight: FontWeight.w600)),
                                                                        SizedBox(
                                                                          width:
                                                                              2.0,
                                                                        ),
                                                                        Text(
                                                                          _categoryData
                                                                              .experience
                                                                              .toString(),
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .caption,
                                                                        ),
                                                                      ]),
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            S.of(context).price_per_hour,
                                                                            style: TextStyle(fontWeight: FontWeight.w600)),
                                                                        SizedBox(
                                                                          width:
                                                                              2.0,
                                                                        ),
                                                                        Text(
                                                                          _categoryData
                                                                              .chargePreHrs
                                                                              .toString(),
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .caption,
                                                                        ),
                                                                      ]),
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            S.of(context).quick_pitch,
                                                                            style: TextStyle(fontWeight: FontWeight.w600)),
                                                                        SizedBox(
                                                                          width:
                                                                              2.0,
                                                                        ),
                                                                        Text(
                                                                          _categoryData
                                                                              .quickPitch
                                                                              .toString(),
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .caption,
                                                                        ),
                                                                      ]),
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        IconButton(
                                                                          icon:
                                                                              new Icon(Icons.close),
                                                                          highlightColor:
                                                                              Colors.pink,
                                                                          onPressed:
                                                                              () {
                                                                            _con.popCategory(_categoryData);
                                                                          },
                                                                        ),
                                                                      ]),
                                                                ]),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ]),
                                              SizedBox(
                                                width: 15,
                                              )
                                            ],
                                          );
                                        }),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Center(
                                        child: Container(
                                          height: 130,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: DottedBorder(
                                              dashPattern: [8, 4],
                                              color: Colors.grey,
                                              strokeWidth: 1,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Center(
                                                    child: Column(children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          _con.categoryDropdown
                                                              .forEach(
                                                                  (element) {
                                                            print(element
                                                                .toMap());
                                                          });
                                                          categoryPopup(
                                                              context, _con);
                                                        },
                                                        child: Icon(
                                                            Icons.add_circle,
                                                            size: 40,
                                                            color: Colors.blue),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                          S
                                                              .of(context)
                                                              .add_category,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ))
                                                    ]),
                                                  ))),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ]),
                            isActive: _currentStep >= 4,
                            state: _currentStep >= 5
                                ? StepState.complete
                                : StepState.disabled,
                          ),
                        ],
                      );
                    }),
                  )
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

void categoryPopup(context, con) {
  showDialog(
      context: context, builder: (context) => CategoryDetailsPopup(con: con));
}

// ignore: must_be_immutable
class CategoryDetailsPopup extends StatefulWidget {
  CategoryDetailsPopup({Key key, this.con}) : super(key: key);
  @override
  _CategoryDetailsPopupState createState() => _CategoryDetailsPopupState();
  UserController con;
}

class _CategoryDetailsPopupState extends State<CategoryDetailsPopup> {
  int dropDownValue = 0;
  String _value;
  String _subValue;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
      insetPadding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.09,
        left: MediaQuery.of(context).size.width * 0.09,
        right: MediaQuery.of(context).size.width * 0.09,
        bottom: MediaQuery.of(context).size.width * 0.09,
      ),
    );
  }

  _buildChild(BuildContext context) => SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  S.of(context).add_category,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: widget.con.categoryFormKey,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Column(children: [
                    Container(
                      width: double.infinity,
                      child: DropdownButton(
                          value: _value, //
                          isExpanded: true,
                          focusColor: Theme.of(context).colorScheme.secondary,
                          underline: Container(
                            color: Colors.grey[300],
                            height: 0.8,
                          ),
                          items: widget.con.categoryDropdown
                              .map((SelectDropdown map) {
                            return new DropdownMenuItem(
                              value: map.id,
                              child: new Text(map.name,
                                  style: new TextStyle(color: Colors.black)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _value = value;

                              widget.con.category.categoryId = value;
                              _subValue = null;
                              widget.con.categoryDropdown.forEach((element) {
                                if (element.id == value) {
                                  widget.con.category.categoryName =
                                      element.name;
                                }
                              });
                              _getCitiesList(value);
                            });
                          }),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: DropdownButton(
                          value: _subValue,
                          isExpanded: true,
                          focusColor: Theme.of(context).colorScheme.secondary,
                          underline: Container(
                            color: Colors.grey[300],
                            height: 1.0,
                          ),
                          items: subList?.map((item) {
                                return new DropdownMenuItem(
                                  value: item['id'].toString(),
                                  child: new Text(item['name'],
                                      style:
                                          new TextStyle(color: Colors.black)),
                                );
                              })?.toList() ??
                              [],
                          onChanged: (value) {
                            setState(() {
                              _subValue = value;
                              widget.con.category.subcategoryId = value;
                              subList.forEach((element) {
                                if (element['id'] == value) {
                                  widget.con.category.subcategoryName =
                                      element['name'];
                                }
                              });
                            });
                          }),
                    ),
                    SizedBox(height: 15),
                    Container(
                        width: double.infinity,
                        height: 70,
                        child: TextFormField(
                            textAlign: TextAlign.left,
                            autocorrect: true,
                            onSaved: (input) => widget.con.category.experience =
                                int.parse(input),
                            validator: (input) => input.length < 1
                                ? S.of(context).please_enter_your_experience
                                : null,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: S.of(context).experience,
                              hintStyle: Theme.of(context).textTheme.caption,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300],
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                  width: 1.0,
                                ),
                              ),
                            ))),
                    Container(
                        width: double.infinity,
                        height: 70,
                        child: TextFormField(
                            textAlign: TextAlign.left,
                            autocorrect: true,
                            keyboardType: TextInputType.number,
                            onSaved: (input) => widget
                                .con.category.chargePreHrs = int.parse(input),
                            validator: (input) => input.length < 1
                                ? S.of(context).please_enter_your_price
                                : null,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              hintText: S.of(context).price_per_hour,
                              hintStyle: Theme.of(context).textTheme.caption,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300],
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                  width: 1.0,
                                ),
                              ),
                            ))),
                    Container(
                        width: double.infinity,
                        height: 70,
                        child: TextFormField(
                            textAlign: TextAlign.left,
                            autocorrect: true,
                            onSaved: (input) => widget.con.category.quickPitch =
                                int.parse(input),
                            validator: (input) => input.length < 1
                                ? S.of(context).please_enter_your_quick_pitch
                                : null,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: S.of(context).quick_pitch,
                              hintStyle: Theme.of(context).textTheme.caption,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300],
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                  width: 1.0,
                                ),
                              ),
                            ))),
                    SizedBox(height: 20),
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () {
                        widget.con.pushCategory();
                      },
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 70),
                      color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                      shape: StadiumBorder(),
                      child: Text(
                        S.of(context).done,
                        style: Theme.of(context).textTheme.headline6.merge(
                            TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor)),
                      ),
                    ),
                    SizedBox(height: 20),
                  ]),
                ),
              ),
            ],
          ),
        ),
      );
  List subList;
  Future<String> _getCitiesList(value) async {
    print(
        '${GlobalConfiguration().getValue('api_base_url')}Api_provider/subcategories/$value');
    await http.post(
        Uri.parse('${GlobalConfiguration().getValue('api_base_url')}Api_provider/subcategories/$value'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          "api_key": '25d55ad283aa400af464c76d713c07ad',
          "state_id": value,
        }).then((response) {
      var data = json.decode(response.body);
      setState(() {
        print('load sub');
        print(data['data']);
        subList = data['data'];
      });
    });
    return 'true';
  }
}
