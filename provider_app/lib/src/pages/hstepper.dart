import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:handy/generated/l10n.dart';
import '/src/controllers/user_controller.dart';
import '/src/models/category.dart';
import '/src/models/select_dropdown.dart';
import 'package:fa_stepper/fa_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;

List<GlobalKey<FormState>> formKeys = [
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>()
];

class Hstepper extends StatefulWidget {
  @override
  _HstepperState createState() => _HstepperState();
}

class _HstepperState extends StateMVC<Hstepper> {
  int _currentStep = 0;
  UserController _con;
  static var _focusNode = FocusNode();

  _HstepperState() : super(UserController()) {
    _con = controller;
  }

  FAStepperType _stepperType = FAStepperType.vertical;

  @override
  void initState() {
    setState(() => FAStepperType.vertical);
    _focusNode.addListener(() {
      setState(() {});
      print('Has focus: $_focusNode.hasFocus');
    });
    super.initState();
    pickedDate = DateTime.now();
    _con.listenForCategory();
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
                new ListTile(
                  leading: new Icon(Icons.image),
                  title: new Text('Gallery'),
                  onTap: () => getImagegaller(),
                ),
              ],
            ),
          );
        });
  }

  int dropDownValue = 0;
  int selectedRadio;
  File _image;
  int currStep = 0;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImagegaller() async {
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

  _pickDate() async {
    Theme.of(context).copyWith(
      primaryColor: Colors.amber,
    );
    DateTime date = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDate: pickedDate,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF37dc15),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              colorScheme: ColorScheme.light(primary: const Color(0xFF37dc15)).copyWith(secondary: const Color(0xFF37dc15)),
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

  List<FAStep> steps = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).registration),
      ),
      body: Theme(
        data: ThemeData(primaryColor: Theme.of(context).colorScheme.secondary),
        child: Container(
          child: FAStepper(
            // titleHeight: 120.0,
            stepNumberColor: Colors.grey,
            // titleIconArrange: FAStepperTitleIconArrange.column,
            physics: ClampingScrollPhysics(),
            steps: steps = [
              FAStep(
                title: Text(S.of(context).general),
                isActive: true,
                state: FAStepstate.complete,
                content: Form(
                  key: formKeys[0],
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          textAlign: TextAlign.left,
                          onSaved: (input) =>
                              _con.registerData.firstname = input,
                          validator: (input) => input.length < 3
                              ? S.of(context).should_be_more_than_3_characters
                              : null,
                          autocorrect: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: S.of(context).first_name,
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
                          )),
                      SizedBox(height: 5),
                      Container(
                          width: double.infinity,
                          height: 70,
                          child: TextFormField(
                              textAlign: TextAlign.left,
                              autocorrect: true,
                              onSaved: (input) =>
                                  _con.registerData.lastname = input,
                              validator: (input) => input.length < 3
                                  ? S
                                      .of(context)
                                      .should_be_more_than_3_characters
                                  : null,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: S.of(context).last_name,
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
                      SizedBox(height: 5),
                      Container(
                        width: double.infinity,
                        height: 70,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                      MainAxisAlignment.spaceBetween,
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
                                padding: EdgeInsets.only(left: 0, right: 0),
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
                      Text(
                        S.of(context).gender,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[500],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: DropdownButton(
                            value: _gender,
                            isExpanded: true,
                            focusColor: Theme.of(context).colorScheme.secondary,
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
                                  child: Text(S.of(context).transgender),
                                  value: 'Transgender'),
                              DropdownMenuItem(
                                  child: Text(S.of(context).others),
                                  value: 'Others')
                            ],
                            onChanged: (value) {
                              setState(() {
                                //  _value = value;
                                _con.registerData.gender = value;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              FAStep(
                  title: Text(S.of(context).address),
                  // Column(
                  //   children: <Widget>[
                  //     Icon(
                  //       Icons.mail,
                  //       color: Colors.red,
                  //       size: 24.0,
                  //     ),
                  //     Text('Email'),
                  //   ],
                  // ),
                  isActive: true,
                  state: FAStepstate.complete,
                  content: Form(
                    key: formKeys[1],
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            S.of(context).create_your_account_to_continue,
                            style: Theme.of(context).textTheme.caption,
                          ),
                          SizedBox(height: 20),
                          Container(
                              width: double.infinity,
                              height: 70,
                              child: TextFormField(
                                  textAlign: TextAlign.left,
                                  onSaved: (input) =>
                                      _con.registerData.address1 = input,
                                  validator: (input) => input.length < 1
                                      ? S.of(context).please_enter_your_address
                                      : null,
                                  autocorrect: true,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: '${S.of(context).address} 1',
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
                                        color: Theme.of(context).colorScheme.secondary,
                                        width: 1.0,
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
                                  onSaved: (input) =>
                                      _con.registerData.address2 = input,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: '${S.of(context).address} 2',
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
                                        color: Theme.of(context).colorScheme.secondary,
                                        width: 1.0,
                                      ),
                                    ),
                                  ))),
                          SizedBox(height: 5),
                          Container(
                              width: double.infinity,
                              height: 70,
                              child: TextFormField(
                                  onSaved: (input) =>
                                      _con.registerData.city = input,
                                  validator: (input) => input.length < 3
                                      ? S.of(context).please_enter_your_city
                                      : null,
                                  textAlign: TextAlign.left,
                                  autocorrect: true,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: S.of(context).city,
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
                                        color: Theme.of(context).colorScheme.secondary,
                                        width: 1.0,
                                      ),
                                    ),
                                  ))),
                          SizedBox(height: 5),
                          Container(
                              width: double.infinity,
                              height: 70,
                              child: TextFormField(
                                  onSaved: (input) =>
                                      _con.registerData.state = input,
                                  validator: (input) => input.length < 3
                                      ? S.of(context).please_enter_your_state
                                      : null,
                                  textAlign: TextAlign.left,
                                  autocorrect: true,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: S.of(context).state,
                                    hintStyle:
                                        Theme.of(context).textTheme.caption,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey[300],
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).colorScheme.secondary,
                                        width: 2.0,
                                      ),
                                    ),
                                  ))),
                          SizedBox(height: 5),
                          Container(
                              width: double.infinity,
                              height: 70,
                              child: TextFormField(
                                  onSaved: (input) => _con
                                      .registerData.zipcode = input,
                                  validator: (input) => input.length < 3
                                      ? S.of(context).please_enter_your_pincode
                                      : null,
                                  textAlign: TextAlign.left,
                                  autocorrect: true,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    hintText: S.of(context).zipcode,
                                    hintStyle:
                                        Theme.of(context).textTheme.caption,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey[300],
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).colorScheme.secondary,
                                        width: 2.0,
                                      ),
                                    ),
                                  ))),
                          SizedBox(height: 5),
                          InkWell(
                            onTap: () async {
                             /* LocationResult result = await showLocationPicker(
                                context,
                                'AIzaSyAT07iMlfZ9bJt1gmGj9KhJDLFY8srI6dA',
                                initialCenter: LatLng(31.1975844, 29.9598339),
                                automaticallyAnimateToCurrentLocation: true,
                                myLocationButtonEnabled: true,
                                layersButtonEnabled: true,
                                resultCardAlignment: Alignment.bottomCenter,
                              );

                              print("result = $result"); */
                              // Navigator.of(widget.scaffoldKey.currentContext).pop();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(S.of(context).get_address_from_map,
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
                  )),
              FAStep(
                title: Text(S.of(context).register),
                isActive: true,
                state: FAStepstate.complete,
                content: Form(
                  key: formKeys[2],
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          S.of(context).create_your_account_to_continue,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(height: 20),
                        Container(
                            width: double.infinity,
                            height: 70,
                            child: TextFormField(
                                onSaved: (input) =>
                                    _con.registerData.email = input,
                                validator: (input) => !input.contains('@')
                                    ? S.of(context).should_be_valid_email
                                    : null,
                                textAlign: TextAlign.left,
                                autocorrect: true,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: S.of(context).email_address,
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
                                      color: Theme.of(context).colorScheme.secondary,
                                      width: 1.0,
                                    ),
                                  ),
                                ))),
                        SizedBox(height: 5),
                        Container(
                            width: double.infinity,
                            height: 70,
                            child: TextFormField(
                                onSaved: (input) =>
                                    _con.registerData.mobile = int.parse(input),
                                validator: (input) => input.length < 3
                                    ? S.of(context).not_a_valid_number
                                    : null,
                                textAlign: TextAlign.left,
                                autocorrect: true,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: S.of(context).mobile_number,
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
                                      color: Theme.of(context).colorScheme.secondary,
                                      width: 1.0,
                                    ),
                                  ),
                                ))),
                        SizedBox(height: 5),
                        Container(
                            width: double.infinity,
                            height: 70,
                            child: TextFormField(
                                onSaved: (input) =>
                                    _con.registerData.password = input,
                                textAlign: TextAlign.left,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: S.of(context).password,
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
                                      color: Theme.of(context).colorScheme.secondary,
                                      width: 1.0,
                                    ),
                                  ),
                                ))),
                        SizedBox(height: 5),
                        Container(
                            width: double.infinity,
                            height: 70,
                            child: TextFormField(
                                onSaved: (input) =>
                                    _con.registerData.password = input,
                                textAlign: TextAlign.left,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: S.of(context).confirm_password,
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
                                      color: Theme.of(context).colorScheme.secondary,
                                      width: 1.0,
                                    ),
                                  ),
                                ))),
                      ]),
                ),
              ),
              FAStep(
                title: Text(S.of(context).profile),
                isActive: true,
                state: FAStepstate.complete,
                content: Form(
                  key: formKeys[3],
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          S.of(context).create_your_account_to_continue,
                          style: Theme.of(context).textTheme.caption,
                        ),
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
                                        'assets/img/userImage6.jpeg')
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
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: S.of(context).work_experience,
                                  hintStyle:
                                      Theme.of(context).textTheme.caption,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey[300],
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).colorScheme.secondary,
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
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: S.of(context).about_you,
                                  hintStyle:
                                      Theme.of(context).textTheme.caption,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey[300],
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).colorScheme.secondary,
                                      width: 2.0,
                                    ),
                                  ),
                                ))),
                      ]),
                ),
              ),
              FAStep(
                  title: Text(S.of(context).category),
                  isActive: true,
                  state: FAStepstate.complete,
                  content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(S.of(context).hello,
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w400)),
                        Text(
                          S.of(context).create_your_account_to_continue,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          height: 230,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _con.categoryList.length,
                              itemBuilder: (context, index) {
                                Category _categoryData =
                                    _con.categoryList.elementAt(index);
                                return Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 0, bottom: 10),
                                              child: Text(
                                                _categoryData.categoryName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4,
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.50,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5,
                                              margin:
                                                  EdgeInsets.only(bottom: 6),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Theme.of(context)
                                                          .focusColor
                                                          .withOpacity(0.05),
                                                      offset: Offset(0, 5),
                                                      blurRadius: 1)
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
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
                                                                Text('S.cat',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                                SizedBox(
                                                                  width: 2.0,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    _categoryData
                                                                        .subcategoryName,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 1,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .caption,
                                                                  ),
                                                                ),
                                                              ]),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    S
                                                                        .of(
                                                                            context)
                                                                        .experience,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                                SizedBox(
                                                                  width: 2.0,
                                                                ),
                                                                Text(
                                                                  _categoryData
                                                                      .experience
                                                                      .toString(),
                                                                  style: Theme.of(
                                                                          context)
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
                                                                    S
                                                                        .of(
                                                                            context)
                                                                        .price_per_hour,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                                SizedBox(
                                                                  width: 2.0,
                                                                ),
                                                                Text(
                                                                  _categoryData
                                                                      .chargePreHrs
                                                                      .toString(),
                                                                  style: Theme.of(
                                                                          context)
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
                                                                    S
                                                                        .of(
                                                                            context)
                                                                        .quick_pitch,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                                SizedBox(
                                                                  width: 2.0,
                                                                ),
                                                                Text(
                                                                  _categoryData
                                                                      .quickPitch
                                                                      .toString(),
                                                                  style: Theme.of(
                                                                          context)
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
                                                                  icon: new Icon(
                                                                      Icons
                                                                          .close),
                                                                  highlightColor:
                                                                      Colors
                                                                          .pink,
                                                                  onPressed:
                                                                      () {
                                                                    _con.popCategory(
                                                                        _categoryData);
                                                                  },
                                                                ),
                                                              ]),
                                                        ]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    )
                                  ],
                                );
                              }),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Center(
                              child: Container(
                                height: 130,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: DottedBorder(
                                    dashPattern: [8, 4],
                                    color: Colors.grey,
                                    strokeWidth: 1,
                                    child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Center(
                                          child: Column(children: [
                                            GestureDetector(
                                              onTap: () {
                                                categoryPopup(context, _con);
                                              },
                                              child: Icon(Icons.add_circle,
                                                  size: 40, color: Colors.blue),
                                            ),
                                            SizedBox(height: 10),
                                            Text(S.of(context).add_category,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500,
                                                ))
                                          ]),
                                        ))),
                              ),
                            ),
                          ),
                        ]),
                      ])),
            ],
            type: _stepperType,

            currentStep: this.currStep,
            onStepTapped: (step) {
              setState(() {
                this._currentStep = step;
              });
              print('onStepTapped :' + step.toString());
            },
            onStepContinue: () {
              setState(() {
                if (formKeys[currStep].currentState.validate()) {
                  if (currStep < steps.length - 1) {
                    currStep = currStep + 1;
                  } else {
                    currStep = 0;
                  }
                }
                // else {
                // Scaffold
                //     .of(context)
                //     .showSnackBar( SnackBar(content:  Text('$currStep')));

                // if (currStep == 1) {
                //   print('First Step');
                //   print('object' + FocusScope.of(context).toStringDeep());
                // }

                // }
              });
              print('onStepContinue :' + _currentStep.toString());
            },
            onStepCancel: () {
              setState(() {
                if (currStep > 0) {
                  currStep = currStep - 1;
                } else {
                  currStep = 0;
                }
              });
            },
          ),
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
                          value: _value,
                          //
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
                        Navigator.pop(context);
                      },
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 100),
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
    await http.post(
        Uri.parse('http://192.168.1.8/jps_masteradmin/index.php/Api_provider/subcategories/$value'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          "api_key": '25d55ad283aa400af464c76d713c07ad',
          "state_id": value,
        }).then((response) {
      var data = json.decode(response.body);
      setState(() {
        subList = data['data'];
      });
    });
    return 'true';
  }
}
