import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/models/zonelistmodel.dart';
import 'package:login_and_signup_web/src/repository/product_repository.dart';
import 'package:login_and_signup_web/src/repository/settings_repository.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'SettingsPopUPWidget.dart';

class VendorRegisterForm extends StatefulWidget {
  const VendorRegisterForm({Key key}) : super(key: key);

  @override
  _VendorRegisterFormState createState() => _VendorRegisterFormState();
}

class _VendorRegisterFormState extends StateMVC<VendorRegisterForm> with SingleTickerProviderStateMixin {
  UserController _con;

  _VendorRegisterFormState() : super(UserController()) {
    _con = controller;
  }

  List<DropDownModel> dropDownList = <DropDownModel>[];

  Future<void> listenForDropdown(table, select, column, para1) async {
    dropDownList.clear();
    final Stream<DropDownModel> stream = await getDropdownDataSC(table, select, column, para1);

    stream.listen((DropDownModel _list) {
      setState(() => dropDownList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  TabController _tabController;
  TextEditingController timeinput = TextEditingController();
  TextEditingController closetime = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();
  GlobalKey<FormState> formkey;
  GlobalKey<FormState> formkey1;
  String _type;
  String _zone;
  bool isSwitched = false;
  bool isMap = false;
  double lat = 12.9557616;
  double long = 77.7568832;
  List choice = ['yes', 'no'];
  String selectedRadio;
  String selectedchoice;
  List<LatLng> polyLines = <LatLng>[];

  getPoints(id) {
    try {
      /**  _con.zoneList.forEach((element) {
          if(element.zoneId==id){
          element.position.forEach((element1) {

          var parts = element1.split(' ');
          var latitude = parts[0].trim();
          var longitude = parts[1].trim();
          LatLng _driver = LatLng(latitude, longitude);

          polyLines.add(_driver);

          });
          }
          }); */
      print('error1');

      return [
        LatLng(13.494231, 80.177112),
        LatLng(13.46218, 79.452014),
        LatLng(13.144108, 79.116931),
        LatLng(12.889888, 79.171863),
        LatLng(12.772056, 79.421802),
        LatLng(12.683646, 79.80907),
        LatLng(12.705081, 80.23479),
        LatLng(13.026396, 80.278735),
        LatLng(13.205616, 80.319934),
        LatLng(13.349967, 80.3474),
      ];
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
    }
  }

  _selectTime(type) async {
    TimeOfDay selectedTime =
    TimeOfDay(hour: int.parse(DateFormat('kk').format(DateTime.now())), minute: int.parse(DateFormat('mm').format(DateTime.now())));
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Theme.of(context).colorScheme.secondary,
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), colorScheme: ColorScheme.light(primary: Theme.of(context).colorScheme.secondary).copyWith(secondary: Theme.of(context).colorScheme.secondary),
            ),
            child: child,
          );
        });
    if (picked != null)
      setState(() {
        selectedTime = picked;

        if (type == 'open') {
          _con.basicInformationData.openingTime = picked.format(context);
          timeinput.text = picked.format(context);
        } else {
          _con.basicInformationData.closingTime = picked.format(context);
          closetime.text = picked.format(context);
        }

        /**_setTime = timePicker.formatDate(
            DateTime(year, month, day, selectedTime.hour, selectedTime.minute), [timePicker.hh, ':', timePicker.nn, " ", timePicker.am]).toString();
         */
      });
  }

  setSelectedRadio(String val) {
    setState(() {
      selectedRadio = val;
      _con.basicInformationData.business = val;
    });
  }

  bool ratingOne = false;
  bool status = false;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
    _con.getSingleStatus();
    selectedRadio = 'Government Reg. Company';
    _con.basicInformationData.business = 'Government Reg. Company';
    formkey = new GlobalKey<FormState>();
    formkey1 = new GlobalKey<FormState>();
    //_con.getSingleValue();
    _con.listenForZone();
    listenForDropdown('shop_focus', 'title', 'status', 'success');
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    timeinput.text = '';
    closetime.text = '';
  }

  int checkedItem = 0;

  Widget checkbox(String title, bool boolValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title),
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            /// manage the state of each value
            setState(() {
              switch (title) {
                case "MON":
                  _con.basicInformationData.holidays.monVal = value;
                  break;
                case "TUE":
                  _con.basicInformationData.holidays.tueVal = value;
                  break;
                case "WED":
                  _con.basicInformationData.holidays.wedVal = value;
                  break;
                case "THU":
                  _con.basicInformationData.holidays.thurVal = value;
                  break;
                case "FRI":
                  _con.basicInformationData.holidays.friVal = value;
                  break;
                case "SAT":
                  _con.basicInformationData.holidays.satVal = value;
                  break;
                case "SUN":
                  _con.basicInformationData.holidays.sunVal = value;
                  break;
              }
            });
          },
        )
      ],
    );
  }

  bool state = true;
  String _value;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.1,
        left: MediaQuery.of(context).size.width * 0.09,
        right: MediaQuery.of(context).size.width * 0.09,
        bottom: MediaQuery.of(context).size.height * 0.05,
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Theme.of(context).primaryColor,
            child: Container(
                child: Container(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                    child: Column(children: [
                      Row(
                    mainAxisAlignment:MainAxisAlignment.end,
                          children:[
                          IconButton(
                            onPressed:(){
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close),

                          )
                      ]
                      ),
                      Container(
                        width: double.infinity,
                        height: 45,
                        child: TabBar(
                          controller: _tabController,
                          onTap: (_) {
                            _tabController.index = _tabController.previousIndex;
                          },
                          // give the indicator a decoration (color and border radius)
                          indicatorWeight: 2.0,
                          isScrollable: true,
                          indicatorColor: Color(0xFF5e078e),
                          unselectedLabelColor: Colors.grey,

                          labelColor: Colors.teal,

                          tabs: [
                            // first tab [you can add an icon using the icon property]
                            Tab(
                                child: Container(
                                  child: Text(S.of(context).register, style: TextStyle(fontWeight: FontWeight.w600)),
                                )),
                            Tab(
                                child: Container(
                                  child: Text(S.of(context).basic_information, style: TextStyle(fontWeight: FontWeight.w600)),
                                )),

                            // second tab [you can add an icon using the icon property]
                            Tab(
                                child: Container(
                                  child: Text(S.of(context).seller_kyc, style: TextStyle(fontWeight: FontWeight.w600)),
                                )),
                            Tab(
                                child: Container(
                                  child: Text(S.of(context).settings_and_agreement, style: TextStyle(fontWeight: FontWeight.w600)),
                                )),

                            // second tab [you can add an icon using the icon property]
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: [
                            Container(
                                child:Scrollbar(
                                    isAlwaysShown:true,
                                    child:SingleChildScrollView(
                                        child:Column(
                                            children:[
                                              Wrap(children:[
                                                Div(
                                                    colS:12,
                                                    colM:12,
                                                    colL:12,
                                                    child:Column(children:[
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 20,
                                                            left: MediaQuery.of(context).size.width > 769 ? 20 : 10,
                                                            right: MediaQuery.of(context).size.width > 769 ? 20 : 10),
                                                        child: Text(
                                                          'Register',
                                                          style: MediaQuery.of(context).size.width > 769
                                                              ? Theme.of(context).textTheme.headline4
                                                              : Theme.of(context).textTheme.headline1,
                                                        ),
                                                      ),

                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: MediaQuery.of(context).size.width > 769 ? 20 : 10,
                                                            right: MediaQuery.of(context).size.width > 769 ? 30 : 0,
                                                            bottom: 20),
                                                        child: Wrap(runSpacing: 10, children: [
                                                          Container(
                                                              child: Div(
                                                                  colS: 12,
                                                                  colM: 12,
                                                                  colL: 6,
                                                                  child: Container(
                                                                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width > 1024 ? 30 : 0),
                                                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                      Container(
                                                                        width: double.infinity,
                                                                        child: TextFormField(
                                                                          onChanged: (input) =>
                                                                          _con.registerData.name = input,
                                                                          validator: (input) => input.length < 1 ? 'Please enter your Shop name' : null,
                                                                          decoration: InputDecoration(
                                                                            hintText: S.of(context).shop_name,
                                                                            labelText: S.of(context).shop_name,
                                                                            suffixIcon: Icon(
                                                                              Icons.store_mall_directory_rounded,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                          padding:EdgeInsets.only(top:10),
                                                                        width: double.infinity,
                                                                        child: DropdownButton(
                                                                            value: _value,
                                                                            isExpanded: true,
                                                                            focusColor: Theme.of(context).colorScheme.secondary,
                                                                            underline: Container(
                                                                              color: Colors.grey[300],
                                                                              height: 0.8,
                                                                            ),
                                                                            items: dropDownList.map((DropDownModel map) {
                                                                              return new DropdownMenuItem(
                                                                                value: map.id,
                                                                                child: new Text(map.name, style: new TextStyle(color: Colors.black)),
                                                                              );
                                                                            }).toList(),
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                //  _con.subcategoryData.categoryId = value;
                                                                                _con.registerData.shopTypeId = value;
                                                                                _value = value;
                                                                              });
                                                                            }),
                                                                      ),
                                                                      Container(
                                                                        width: double.infinity,
                                                                        child: TextFormField(
                                                                          obscureText: true,
                                                                          onChanged: (input) => _con.registerData.password = input,
                                                                          validator: (input) =>
                                                                          input.length < 3 ? 'should be more than 3 characters' : null,
                                                                          decoration: InputDecoration(
                                                                            hintText: S.of(context).password,
                                                                            labelText: S.of(context).password,
                                                                            suffixIcon: Icon(
                                                                              Icons.lock_outline,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ]),
                                                                  ))),
                                                          Container(
                                                            child: Div(
                                                                colS: 12,
                                                                colM: 12,
                                                                colL: 6,
                                                                child: Container(
                                                                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width > 1024 ? 10 : 0),
                                                                    child: Column(children: [
                                                                      Container(
                                                                        width: double.infinity,
                                                                        child: TextFormField(
                                                                          onChanged: (input) => _con.registerData.emailId = input,
                                                                          keyboardType: TextInputType.emailAddress,
                                                                          validator: (input) => !input.contains('@') ? 'Should be valid email' : null,
                                                                          decoration: InputDecoration(
                                                                            hintText: S.of(context).email,
                                                                            labelText: S.of(context).email,
                                                                            suffixIcon: Icon(
                                                                              Icons.mail_outline,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: double.infinity,
                                                                        child: TextFormField(
                                                                          onChanged: (input) => _con.registerData.phone = input,
                                                                          validator: (input) => input.length <= 0 ? 'Invalid mobile number' : null,
                                                                          decoration: InputDecoration(
                                                                            hintText: S.of(context).phone,
                                                                            labelText: S.of(context).phone,
                                                                            suffixIcon: Icon(
                                                                              Icons.phone,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ]))),
                                                          ),
                                                         
                                                        ]),
                                                      ),





                                                      
                                                    ])
                                                )
                                              ])
                                            ]
                                        )
                                    )
                                )
                            ),
                            Form(
                              key: _con.loginFormKey,
                              child: Container(
                                  child: Scrollbar(
                                      isAlwaysShown: true,
                                      child: SingleChildScrollView(
                                          child: Column(children: [
                                            Wrap(children: [
                                              Div(
                                                  colS: 12,
                                                  colM: 12,
                                                  colL: 12,
                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [


                                                    SizedBox(height: 20),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 20,
                                                          left: MediaQuery.of(context).size.width > 769 ? 20 : 10,
                                                          right: MediaQuery.of(context).size.width > 769 ? 20 : 10),
                                                      child: Text(
                                                        S.of(context).basic_description,
                                                        style: MediaQuery.of(context).size.width > 769
                                                            ? Theme.of(context).textTheme.headline4
                                                            : Theme.of(context).textTheme.headline1,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: MediaQuery.of(context).size.width > 769 ? 20 : 10,
                                                          right: MediaQuery.of(context).size.width > 769 ? 30 : 0,
                                                          bottom: 20),
                                                      child: Wrap(runSpacing: 10, children: [
                                                        Container(
                                                            child: Div(
                                                                colS: 12,
                                                                colM: 12,
                                                                colL: 5,
                                                                child: Container(
                                                                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width > 1024 ? 30 : 0),
                                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                    Container(
                                                                      width: double.infinity,
                                                                      child: TextFormField(
                                                                          textAlign: TextAlign.left,
                                                                          autocorrect: true,
                                                                          onSaved: (input) => _con.basicInformationData.id = input,
                                                                          validator: (input) => input.length < 1 ? 'please enter the Store' : null,
                                                                          initialValue: currentUser.value.id,
                                                                          enabled: false,
                                                                          keyboardType: TextInputType.number,
                                                                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                                                          decoration: InputDecoration(
                                                                            labelText: S.of(context).store_id,
                                                                            labelStyle: Theme.of(context)
                                                                                .textTheme
                                                                                .bodyText2
                                                                                .merge(TextStyle(color: Colors.grey)),
                                                                            enabledBorder: UnderlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Colors.grey,
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
                                                                    ),
                                                                    SizedBox(height: 10),
                                                                    Container(
                                                                      width: double.infinity,
                                                                      child: TextFormField(
                                                                          textAlign: TextAlign.left,
                                                                          autocorrect: true,
                                                                          onSaved: (input) => _con.basicInformationData.companyLegalName = input,
                                                                          validator: (input) => input.length < 1 ? 'please enter the Legal Name' : null,
                                                                          keyboardType: TextInputType.text,
                                                                          decoration: InputDecoration(
                                                                            labelText: S.of(context).company_legal_name,
                                                                            labelStyle: Theme.of(context)
                                                                                .textTheme
                                                                                .bodyText2
                                                                                .merge(TextStyle(color: Colors.grey)),
                                                                            suffixIcon: Tooltip(
                                                                                message: "Your legal name which mentioned in Bill or in Address Proof.",
                                                                                child: Icon(Icons.help, color: Colors.grey)),
                                                                            enabledBorder: UnderlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Colors.grey,
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
                                                                    ),
                                                                    SizedBox(height: 10),
                                                                    Container(
                                                                        width: double.infinity,
                                                                        child: TextFormField(
                                                                            textAlign: TextAlign.left,
                                                                            autocorrect: true,
                                                                            onSaved: (input) => _con.basicInformationData.mobile = input,
                                                                            validator: (input) => input.length < 1 ? 'please enter Your Mobile' : null,
                                                                            keyboardType: TextInputType.text,
                                                                            decoration: InputDecoration(
                                                                              labelText: S.of(context).mobile,
                                                                              labelStyle: Theme.of(context)
                                                                                  .textTheme
                                                                                  .bodyText2
                                                                                  .merge(TextStyle(color: Colors.grey)),
                                                                              //suffixIcon: Tooltip(message: "Enter Your Store Name", child: Icon(Icons.help, color: Colors.grey)),
                                                                              enabledBorder: UnderlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.grey,
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
                                                                    SizedBox(height: 10),
                                                                    Container(
                                                                        width: double.infinity,
                                                                        child: TextFormField(
                                                                            textAlign: TextAlign.left,
                                                                            autocorrect: true,
                                                                            onSaved: (input) => _con.basicInformationData.alterMobile = input,
                                                                            validator: (input) =>
                                                                            input.length < 1 ? 'please enter Your alter mobile' : null,
                                                                            keyboardType: TextInputType.text,
                                                                            decoration: InputDecoration(
                                                                              labelText: S.of(context).alter_mobile,
                                                                              labelStyle: Theme.of(context)
                                                                                  .textTheme
                                                                                  .bodyText2
                                                                                  .merge(TextStyle(color: Colors.grey)),
                                                                              //suffixIcon: Tooltip(message: "Enter Your Store Name", child: Icon(Icons.help, color: Colors.grey)),
                                                                              enabledBorder: UnderlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.grey,
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
                                                                      padding: EdgeInsets.only(top: 15, bottom: 10),
                                                                      width: MediaQuery.of(context).size.width > 769
                                                                          ? MediaQuery.of(context).size.width * 0.3
                                                                          : double.infinity,
                                                                      child: Text(
                                                                          'Enter the mail id for Order notifications & Newsletters and Offers from ${setting.value.appName}'),
                                                                    ),
                                                                    Container(
                                                                        width: double.infinity,
                                                                        child: TextFormField(
                                                                            textAlign: TextAlign.left,
                                                                            autocorrect: true,
                                                                            enabled: false,
                                                                            onSaved: (input) => _con.basicInformationData.email = input,
                                                                            initialValue: currentUser.value.email,
                                                                            keyboardType: TextInputType.emailAddress,
                                                                            decoration: InputDecoration(
                                                                              labelText: S.of(context).email,
                                                                              labelStyle: Theme.of(context)
                                                                                  .textTheme
                                                                                  .bodyText2
                                                                                  .merge(TextStyle(color: Colors.grey)),
                                                                              // suffixIcon: Tooltip(message: "Enter Your Store Name", child: Icon(Icons.help, color: Colors.grey)),
                                                                              enabledBorder: UnderlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.grey,
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
                                                                ))),
                                                        Container(
                                                          child: Div(
                                                              colS: 12,
                                                              colM: 12,
                                                              colL: 5,
                                                              child: Container(
                                                                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width > 1024 ? 10 : 0),
                                                                  child: Column(children: [
                                                                    Container(
                                                                      width: double.infinity,
                                                                      child: TextFormField(
                                                                          textAlign: TextAlign.left,
                                                                          autocorrect: true,
                                                                          //initialValue: currentUser.value.shopName,
                                                                          onSaved: (input) => _con.basicInformationData.storeName = input,
                                                                          validator: (input) => input.length < 1 ? 'please enter the Store Name' : null,
                                                                          keyboardType: TextInputType.text,
                                                                          decoration: InputDecoration(
                                                                            labelText: S.of(context).online_store_name,
                                                                            labelStyle: Theme.of(context)
                                                                                .textTheme
                                                                                .bodyText2
                                                                                .merge(TextStyle(color: Colors.grey)),
                                                                            suffixIcon: Tooltip(
                                                                                message:
                                                                                "Your store name in ${setting.value.appName} .For Example : XYZ Textiles(Note : Name displayed as Store name in ${setting.value.appName})",
                                                                                child: Icon(Icons.help, color: Colors.grey)),
                                                                            enabledBorder: UnderlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Colors.grey,
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
                                                                    ),
                                                                    SizedBox(height: 10),
                                                                    Container(
                                                                      width: double.infinity,
                                                                      child: TextFormField(
                                                                          textAlign: TextAlign.left,
                                                                          autocorrect: true,
                                                                          onSaved: (input) => _con.basicInformationData.subtitle = input,
                                                                          validator: (input) =>
                                                                          input.length < 1 ? 'please enter the subtitle of the store' : null,
                                                                          keyboardType: TextInputType.text,
                                                                          decoration: InputDecoration(
                                                                            labelText: S.of(context).enter_the_subtitle,
                                                                            labelStyle: Theme.of(context)
                                                                                .textTheme
                                                                                .bodyText2
                                                                                .merge(TextStyle(color: Colors.grey)),
                                                                            // suffixIcon: Tooltip(message: "Enter Your Store Name", child: Icon(Icons.help, color: Colors.grey)),
                                                                            enabledBorder: UnderlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Colors.grey,
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
                                                                    ),
                                                                    SizedBox(height: MediaQuery.of(context).size.width > 769 ? 10 : 0),
                                                                    Container(
                                                                      width: double.infinity,
                                                                      padding: EdgeInsets.only(top: 30),
                                                                      child: Wrap(
                                                                        children: [
                                                                          Wrap(
                                                                            alignment: WrapAlignment.start,
                                                                            crossAxisAlignment: WrapCrossAlignment.start,
                                                                            children: [
                                                                              Radio(
                                                                                  value: 'Government Reg. Company',
                                                                                  groupValue: selectedRadio,
                                                                                  activeColor: Colors.blue,
                                                                                  onChanged: (val) {
                                                                                    print("Radio $val");
                                                                                    setSelectedRadio(val);
                                                                                  }),
                                                                              Padding(
                                                                                padding: EdgeInsets.only(
                                                                                    top: MediaQuery.of(context).size.width > 769 ? 5 : 15),
                                                                                child: Text(
                                                                                  S.of(context).government_reg_company,
                                                                                  style: Theme.of(context).textTheme.bodyText1,
                                                                                ),
                                                                              ),
                                                                              Radio(
                                                                                  value: 'Startup',
                                                                                  groupValue: selectedRadio,
                                                                                  activeColor: Colors.blue,
                                                                                  onChanged: (val) {
                                                                                    print("Radio $val");
                                                                                    setSelectedRadio(val);
                                                                                  }),
                                                                              Padding(
                                                                                padding: EdgeInsets.only(
                                                                                    top: MediaQuery.of(context).size.width > 769 ? 5 : 15),
                                                                                child: Text(
                                                                                  S.of(context).startup,
                                                                                  style: Theme.of(context).textTheme.bodyText1,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: 10),
                                                                    Container(
                                                                      width: double.infinity,
                                                                      margin: EdgeInsets.only(
                                                                        top: MediaQuery.of(context).size.width > 769 ? 25 : 0,
                                                                      ),
                                                                      child: Column(
                                                                        children: [
                                                                          Text(
                                                                            S.of(context).upload_logo,
                                                                            style: Theme.of(context).textTheme.bodyText1,
                                                                          ),
                                                                          SizedBox(
                                                                            height: 10,
                                                                          ),
                                                                          Container(
                                                                            margin: EdgeInsets.only(
                                                                                top: MediaQuery.of(context).size.width > 769 ? 20 : 10,
                                                                                left: MediaQuery.of(context).size.width > 769 ? 20 : 10,
                                                                                right: MediaQuery.of(context).size.width > 769 ? 0 : 10),
                                                                            width: MediaQuery.of(context).size.width > 769
                                                                                ? MediaQuery.of(context).size.width * 0.12
                                                                                : double.infinity,
                                                                            height: MediaQuery.of(context).size.width > 769
                                                                                ? MediaQuery.of(context).size.width * 0.1
                                                                                : 200,
                                                                            child: GestureDetector(
                                                                              onTap: () {
                                                                                imagePickerBottomsheet();
                                                                              },
                                                                              child: _image == null
                                                                                  ? Image(
                                                                                image: AssetImage('assets/img/category_15.jpg'),
                                                                                height: double.infinity,
                                                                                width: double.infinity,
                                                                                fit: BoxFit.fill,
                                                                              )
                                                                                  : GetPlatform.isWeb?Image.network(_image.path):Image.file(_image),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ]))),
                                                        ),
                                                        MediaQuery.of(context).size.width > 769
                                                            ? Div(
                                                          colS: 12,
                                                          colM: 12,
                                                          colL: 2,
                                                          child: Column(children: [
                                                            Container(
                                                                padding:
                                                                EdgeInsets.only(left: 0, top: MediaQuery.of(context).size.width > 769 ? 0 : 20),
                                                                width: double.infinity,
                                                                height: MediaQuery.of(context).size.width > 769
                                                                    ? MediaQuery.of(context).size.height * 0.5
                                                                    : 200,
                                                                child: Image(
                                                                  image: AssetImage('assets/img/loader.gif'),
                                                                  height: double.infinity,
                                                                  width: double.infinity,
                                                                  fit: BoxFit.fitHeight,
                                                                )),
                                                            Container(
                                                                child: Text(S.of(context).your_currently_registered_shop,
                                                                    style: TextStyle(color: Colors.green, fontSize: 10))),
                                                            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                              Text('',
                                                                  style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold))
                                                            ])
                                                          ]),
                                                        )
                                                            : Container()
                                                      ]),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: MediaQuery.of(context).size.width > 769 ? 20 : 0,
                                                          left: MediaQuery.of(context).size.width > 769 ? 20 : 10,
                                                          right: MediaQuery.of(context).size.width > 769 ? 20 : 10),
                                                      child: Text(
                                                        S.of(context).shop_location,
                                                        style: MediaQuery.of(context).size.width > 769
                                                            ? Theme.of(context).textTheme.headline4
                                                            : Theme.of(context).textTheme.headline1,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: MediaQuery.of(context).size.width > 769 ? 20 : 10,
                                                          right: MediaQuery.of(context).size.width > 769 ? 30 : 0,
                                                          bottom: MediaQuery.of(context).size.width > 769 ? 20 : 0),
                                                      child: Wrap(runSpacing: 10, children: [
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
                                                                            _con.basicInformationData.zoneId = _zone;
                                                                          }),
                                                                    ),
                                                                  ]),
                                                                ))),
                                                      ]),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: MediaQuery.of(context).size.width > 769 ? 20 : 10,
                                                          right: MediaQuery.of(context).size.width > 769 ? 30 : 0,
                                                          bottom: MediaQuery.of(context).size.width > 769 ? 20 : 0),
                                                      child: Wrap(runSpacing: 10, children: [
                                                        Container(
                                                            child: Div(
                                                                colS: 12,
                                                                colM: 12,
                                                                colL: 12,
                                                                child: Container(
                                                                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width > 1024 ? 30 : 0),
                                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                    SizedBox(height: 10),
                                                                    /* Container(
                                                                        height: 400,
                                                                        width: double.infinity,
                                                                        child: GoogleMap(
                                                                          myLocationEnabled: true,
                                                                          initialCameraPosition: CameraPosition(
                                                                            target: LatLng(13.494231, 80.177112),
                                                                            zoom: 12.99,
                                                                          ),
                                                                          polygons: Set<Polygon>.of(<Polygon>[
                                                                            Polygon(
                                                                                polygonId: PolygonId('area'),
                                                                                points: getPoints(71),
                                                                                geodesic: true,
                                                                                strokeColor: Colors.red,
                                                                                strokeWidth: 2,
                                                                                fillColor: Colors.redAccent.withOpacity(0.5),
                                                                                visible: true),
                                                                          ]),
                                                                        )) */
                                                                  ]),
                                                                ))),
                                                      ]),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: MediaQuery.of(context).size.width > 769 ? 20 : 10,
                                                          right: MediaQuery.of(context).size.width > 769 ? 30 : 0,
                                                          bottom: MediaQuery.of(context).size.width > 769 ? 20 : 0),
                                                      child: Wrap(runSpacing: 10, children: [
                                                        Container(
                                                            child: Div(
                                                                colS: 12,
                                                                colM: 12,
                                                                colL: 5,
                                                                child: Container(
                                                                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width > 1024 ? 30 : 0),
                                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                    Container(
                                                                      width: double.infinity,
                                                                      child: TextFormField(
                                                                          textAlign: TextAlign.left,
                                                                          autocorrect: true,
                                                                          validator: (input) => input.length < 1 ? 'please enter Your name' : null,
                                                                          onSaved: (input) => _con.basicInformationData.ownerName = input,
                                                                          keyboardType: TextInputType.text,
                                                                          //inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                                                          decoration: InputDecoration(
                                                                            labelText: S.of(context).enter_your_name,
                                                                            labelStyle: Theme.of(context)
                                                                                .textTheme
                                                                                .bodyText2
                                                                                .merge(TextStyle(color: Colors.grey)),
                                                                            suffixIcon: Tooltip(
                                                                                message:
                                                                                "Give us the Name of the Owner or Managing Director or Admin of your company.",
                                                                                child: Icon(Icons.help, color: Colors.grey)),
                                                                            enabledBorder: UnderlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Colors.grey,
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
                                                                    ),
                                                                    SizedBox(height: 10),
                                                                    Container(
                                                                      width: double.infinity,
                                                                      child: TextFormField(
                                                                          textAlign: TextAlign.left,
                                                                          onSaved: (input) => _con.basicInformationData.pinCode = input,
                                                                          autocorrect: true,
                                                                          keyboardType: TextInputType.number,
                                                                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                                                          decoration: InputDecoration(
                                                                            labelText: S.of(context).zipcode,
                                                                            labelStyle: Theme.of(context)
                                                                                .textTheme
                                                                                .bodyText2
                                                                                .merge(TextStyle(color: Colors.grey)),
                                                                            //suffixIcon: Tooltip(message: "Enter Your Store Name", child: Icon(Icons.help, color: Colors.grey)),
                                                                            enabledBorder: UnderlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Colors.grey,
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
                                                                    ),
                                                                    SizedBox(height: 10),
                                                                    Container(
                                                                      width: double.infinity,
                                                                      child: TextFormField(
                                                                          textAlign: TextAlign.left,
                                                                          autocorrect: true,
                                                                          controller: latitude,
                                                                          onSaved: (input) => _con.basicInformationData.latitude = input,
                                                                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                                          validator: (input) => input.length < 1 ? 'please enter Latitude' : null,
                                                                          inputFormatters: [
                                                                            FilteringTextInputFormatter.allow(
                                                                                RegExp(r'^(\d+)?\.?\d{0,20}')
                                                                            ),
                                                                          ],
                                                                          // inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                                                          decoration: InputDecoration(
                                                                            labelText: S.of(context).latitude,
                                                                            labelStyle: Theme.of(context)
                                                                                .textTheme
                                                                                .bodyText2
                                                                                .merge(TextStyle(color: Colors.grey)),
                                                                            // suffixIcon: Tooltip(message: "Enter Your Store Name", child: Icon(Icons.help, color: Colors.grey)),
                                                                            enabledBorder: UnderlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Colors.grey,
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
                                                                    ),
                                                                    SizedBox(height: 10),
                                                                  ]),
                                                                ))),
                                                        Container(
                                                            child: Div(
                                                                colS: 12,
                                                                colM: 12,
                                                                colL: 5,
                                                                child: Container(
                                                                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width > 1024 ? 10 : 0),
                                                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                      Container(
                                                                        child: TextFormField(
                                                                            textAlign: TextAlign.left,
                                                                            autocorrect: true,
                                                                            onSaved: (input) => _con.basicInformationData.pickupAddress = input,
                                                                            validator: (input) =>
                                                                            input.length < 1 ? 'please enter the PickUp Address' : null,
                                                                            keyboardType: TextInputType.text,
                                                                            decoration: InputDecoration(
                                                                              labelText: S.of(context).address,
                                                                              labelStyle: Theme.of(context)
                                                                                  .textTheme
                                                                                  .bodyText2
                                                                                  .merge(TextStyle(color: Colors.grey)),
                                                                              suffixIcon: Tooltip(
                                                                                  message:
                                                                                  "Give us the exact address for Pickup/Dispatch of your Product for Shipping",
                                                                                  child: Icon(Icons.help, color: Colors.grey)),
                                                                              enabledBorder: UnderlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.grey,
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
                                                                      ),
                                                                      SizedBox(height: 10),
                                                                      Container(
                                                                        child: TextFormField(
                                                                            textAlign: TextAlign.left,
                                                                            autocorrect: true,
                                                                            onSaved: (input) => _con.basicInformationData.landmark = input,
                                                                            validator: (input) => input.length < 1 ? 'please enter Your landmark' : null,
                                                                            keyboardType: TextInputType.text,
                                                                            decoration: InputDecoration(
                                                                              labelText: S.of(context).landmark,
                                                                              labelStyle: Theme.of(context)
                                                                                  .textTheme
                                                                                  .bodyText2
                                                                                  .merge(TextStyle(color: Colors.grey)),
                                                                              //   suffixIcon: Tooltip(message: "Enter Your Store Name", child: Icon(Icons.help, color: Colors.grey)),
                                                                              enabledBorder: UnderlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.grey,
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
                                                                      ),
                                                                      SizedBox(height: 10),
                                                                      Container(
                                                                        width: double.infinity,
                                                                        child: TextFormField(
                                                                            textAlign: TextAlign.left,
                                                                            autocorrect: true,
                                                                            controller: longitude,
                                                                            //onSaved:
                                                                            onChanged: (input) {
                                                                              if (latitude.text != '')
                                                                                setState(() {
                                                                                  print('State created');
                                                                                  isMap = true;
                                                                                  // lat=double.parse(latitude.text);
                                                                                  //  long=double.parse(longitude.text);
                                                                                });
                                                                            },
                                                                            onSaved: (input) => _con.basicInformationData.longitude = input,
                                                                            validator: (input) => input.length < 1 ? 'please enter Longitude' : null,
                                                                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                                            inputFormatters: [
                                                                              FilteringTextInputFormatter.allow(
                                                                                  RegExp(r'^(\d+)?\.?\d{0,20}')
                                                                              ),
                                                                            ],
                                                                            decoration: InputDecoration(
                                                                              labelText: S.of(context).longitude,
                                                                              labelStyle: Theme.of(context)
                                                                                  .textTheme
                                                                                  .bodyText2
                                                                                  .merge(TextStyle(color: Colors.grey)),
                                                                              //suffixIcon: Tooltip(message: "Enter Your Store Name", child: Icon(Icons.help, color: Colors.grey)),
                                                                              enabledBorder: UnderlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.grey,
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
                                                                      ),
                                                                      SizedBox(height: 30),
                                                                      /**    Container(
                                                                          margin: EdgeInsets.only(top: 20, left: 10),
                                                                          width: MediaQuery.of(context).size.width > 769 ? MediaQuery.of(context).size.width * 0.3 : double.infinity,
                                                                          height: MediaQuery.of(context).size.width > 769 ? MediaQuery.of(context).size.width * 0.2 : double.infinity,
                                                                          // child: getMap(lat, long)
                                                                          ), */
                                                                    ])))),
                                                      ]),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: MediaQuery.of(context).size.width > 769 ? 20 : 0,
                                                          left: MediaQuery.of(context).size.width > 769 ? 20 : 10,
                                                          right: MediaQuery.of(context).size.width > 769 ? 20 : 10),
                                                      child: Text(
                                                        S.of(context).store_timing,
                                                        style: MediaQuery.of(context).size.width > 769
                                                            ? Theme.of(context).textTheme.headline4
                                                            : Theme.of(context).textTheme.headline1,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: MediaQuery.of(context).size.width > 769 ? 20 : 10,
                                                          right: MediaQuery.of(context).size.width > 769 ? 30 : 0,
                                                          bottom: 20),
                                                      child: Wrap(runSpacing: 10, children: [
                                                        Container(
                                                            child: Div(
                                                                colS: 12,
                                                                colM: 6,
                                                                colL: 6,
                                                                child: Container(
                                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                    Container(
                                                                      padding: EdgeInsets.only(top: 30),
                                                                      child: Text(S.of(context).opening_time),
                                                                    ),
                                                                    Container(
                                                                      width: double.infinity,
                                                                      child: TextFormField(
                                                                        controller: timeinput,
                                                                        validator: (input) => input.length < 1 ? 'please enter the Opening time' : null,
                                                                        decoration: InputDecoration(
                                                                            prefixIcon: Icon(Icons.timer),
                                                                            suffixIcon: Tooltip(
                                                                                message:
                                                                                "Provide the details of your Store opening time (HH : MM AM or PM )",
                                                                                child: Icon(Icons.help, color: Colors.grey)),
                                                                            //icon of text field
                                                                            labelText: S.of(context).enter_time //label text of field
                                                                        ),
                                                                        readOnly: true,
                                                                        //set it true, so that user will not able to edit text
                                                                        onTap: () async {
                                                                          _selectTime('open');
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.only(top: 20),
                                                                      child: Text(S.of(context).closing_time),
                                                                    ),
                                                                    SizedBox(height: 10),
                                                                    Container(
                                                                      width: double.infinity,
                                                                      child: TextFormField(
                                                                        controller: closetime,
                                                                        //editing controller of this TextField
                                                                        validator: (input) => input.length < 1 ? 'Please enter the Closing time' : null,
                                                                        decoration: InputDecoration(
                                                                            suffixIcon: Tooltip(
                                                                                message:
                                                                                "Provide the details of your Store Closing time (HH : MM AM or PM )",
                                                                                child: Icon(Icons.help, color: Colors.grey)),
                                                                            prefixIcon: Icon(Icons.timer),
                                                                            //icon of text field
                                                                            labelText: S.of(context).enter_time //label text of field
                                                                        ),
                                                                        readOnly: true,
                                                                        //set it true, so that user will not able to edit text
                                                                        onTap: () async {
                                                                          _selectTime('close');
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ]),
                                                                ))),
                                                        Container(
                                                            child: Div(
                                                                colS: 12,
                                                                colM: 6,
                                                                colL: 6,
                                                                child: Container(
                                                                    padding:
                                                                    EdgeInsets.only(left: MediaQuery.of(context).size.width > 769 ? 20 : 0, top: 30),
                                                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                      Padding(
                                                                          padding: const EdgeInsets.only(left: 20),
                                                                          child: Text(S.of(context).mention_your_holidays)),
                                                                      Container(
                                                                        height: 80,
                                                                        width: double.infinity,
                                                                        child: ListView(
                                                                          scrollDirection: Axis.horizontal,
                                                                          children: <Widget>[
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 20),
                                                                              child: checkbox(
                                                                                "MON",
                                                                                _con.basicInformationData.holidays.monVal,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 5, right: 5),
                                                                              child: checkbox(
                                                                                "TUE",
                                                                                _con.basicInformationData.holidays.tueVal,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 5, right: 5),
                                                                              child: checkbox(
                                                                                "WED",
                                                                                _con.basicInformationData.holidays.wedVal,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 5, right: 5),
                                                                              child: checkbox(
                                                                                "THU",
                                                                                _con.basicInformationData.holidays.thurVal,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 5, right: 5),
                                                                              child: checkbox(
                                                                                "FRI",
                                                                                _con.basicInformationData.holidays.friVal,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 5, right: 5),
                                                                              child: checkbox(
                                                                                "SAT",
                                                                                _con.basicInformationData.holidays.satVal,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 5, right: 5),
                                                                              child: checkbox(
                                                                                "SUN",
                                                                                _con.basicInformationData.holidays.sunVal,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ])))),
                                                      ]),
                                                    ),
                                                  ]))
                                            ]),
                                          ])))),
                            ),
                            Container(
                              child: Scrollbar(
                                isAlwaysShown: true,
                                child: SingleChildScrollView(
                                  child: Responsive(children: [
                                    Div(
                                        colS: 12,
                                        colM: 12,
                                        colL: 12,
                                        child: Form(
                                          key: _con.bankFormKey,
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                            SizedBox(height: 10),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 20,
                                                  left: MediaQuery.of(context).size.width > 769 ? 20 : 10,
                                                  right: MediaQuery.of(context).size.width > 769 ? 20 : 10),
                                              child: Text(
                                                S.of(context).seller_kyc,
                                                style: MediaQuery.of(context).size.width > 769
                                                    ? Theme.of(context).textTheme.headline4
                                                    : Theme.of(context).textTheme.headline1,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.width > 769 ? 20 : 10,
                                                  right: MediaQuery.of(context).size.width > 769 ? 30 : 0,
                                                  bottom: 20),
                                              child: Wrap(runSpacing: 10, children: [
                                                Div(
                                                    colS: 12,
                                                    colM: 12,
                                                    colL: 5,
                                                    child: Container(
                                                        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width > 1024 ? 30 : 0),
                                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                          Container(
                                                              width: double.infinity,
                                                              child: TextFormField(
                                                                  textAlign: TextAlign.left,
                                                                  autocorrect: true,
                                                                  onSaved: (input) => _con.sellerKycData.personalProof = input,
                                                                  validator: (input) => input.length < 1 ? 'please enter the Personal Proof' : null,
                                                                  keyboardType: TextInputType.number,
                                                                  decoration: InputDecoration(
                                                                    suffixIcon: Tooltip(
                                                                        message: "Any (GOV) proof id", child: Icon(Icons.help, color: Colors.grey)),
                                                                    labelText: S.of(context).gov_personal_proof_id,
                                                                    labelStyle:
                                                                    Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.grey)),
                                                                    // suffixIcon: Tooltip(message: "Enter Your Store Name", child: Icon(Icons.help, color: Colors.grey)),
                                                                    enabledBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: Colors.grey,
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
                                                          SizedBox(height: 10),
                                                          Container(
                                                            padding: EdgeInsets.only(top: 10),
                                                            child: Container(
                                                              width: double.infinity,
                                                              child: DropdownButtonFormField(
                                                                  value: _type,
                                                                  isExpanded: true,
                                                                  validator: (input) => input.length < 1 ? 'please select your buisness type' : null,
                                                                  focusColor: Theme.of(context).colorScheme.secondary,
                                                                  items: [
                                                                    DropdownMenuItem(
                                                                      child: Text("Private Limited Company"),
                                                                      value: 'Private Limited Company',
                                                                    ),
                                                                    DropdownMenuItem(
                                                                      child: Text("Limited Liability Partnership"),
                                                                      value: 'Limited Liability Partnership',
                                                                    ),
                                                                    DropdownMenuItem(child: Text("Partnership"), value: 'Partnership'),
                                                                    DropdownMenuItem(
                                                                        child: Text("Sole Proprietorship"), value: 'Sole Proprietorship'),
                                                                    DropdownMenuItem(child: Text("One Person Company"), value: 'One Person Company'),
                                                                    DropdownMenuItem(child: Text(S.of(context).startup), value: 'Startup'),
                                                                    DropdownMenuItem(child: Text("Other"), value: 'Other'),
                                                                  ],
                                                                  onChanged: (value) {
                                                                    setState(() {
                                                                      _type = value;
                                                                      _con.sellerKycData.businessType = value;
                                                                    });
                                                                  }),
                                                            ),
                                                          ),
                                                        ]))),
                                                Div(
                                                    colS: 12,
                                                    colM: 12,
                                                    colL: 5,
                                                    child: Container(
                                                        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width > 1024 ? 30 : 0),
                                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                          Container(
                                                              width: double.infinity,
                                                              child: TextFormField(
                                                                  textAlign: TextAlign.left,
                                                                  autocorrect: true,
                                                                  validator: (input) => input.length < 1 ? 'please enter the Started year' : null,
                                                                  keyboardType: TextInputType.text,
                                                                  onSaved: (input) => _con.sellerKycData.selectedYear = input,
                                                                  decoration: InputDecoration(
                                                                    labelText: S.of(context).started_year,
                                                                    labelStyle:
                                                                    Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.grey)),
                                                                    suffixIcon: Tooltip(
                                                                        message: "Enter the company started year",
                                                                        child: Icon(Icons.help, color: Colors.grey)),
                                                                    enabledBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: Colors.grey,
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
                                                        ]))),
                                              ]),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context).size.width > 769 ? 10 : 0,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: MediaQuery.of(context).size.width > 769 ? 20 : 0,
                                                  left: MediaQuery.of(context).size.width > 769 ? 20 : 10,
                                                  right: MediaQuery.of(context).size.width > 769 ? 20 : 10),
                                              child: Text(
                                                S.of(context).holders_bank_details,
                                                style: MediaQuery.of(context).size.width > 769
                                                    ? Theme.of(context).textTheme.headline4
                                                    : Theme.of(context).textTheme.headline1,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.width > 769 ? 20 : 10,
                                                  right: MediaQuery.of(context).size.width > 769 ? 30 : 0,
                                                  bottom: 20),
                                              child: Wrap(runSpacing: 10, children: [
                                                Div(
                                                    colS: 12,
                                                    colM: 12,
                                                    colL: 5,
                                                    child: Container(
                                                        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width > 1024 ? 30 : 0),
                                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                          Container(
                                                              width: double.infinity,
                                                              child: TextFormField(
                                                                  textAlign: TextAlign.left,
                                                                  autocorrect: true,
                                                                  onSaved: (input) => _con.sellerKycData.holdersName = input,
                                                                  validator: (input) => input.length < 1 ? 'Please enter the Holders name' : null,
                                                                  keyboardType: TextInputType.text,
                                                                  decoration: InputDecoration(
                                                                    labelText: S.of(context).holders_name,
                                                                    labelStyle:
                                                                    Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.grey)),
                                                                    suffixIcon: Tooltip(
                                                                        message: "Please enter the Holders name",
                                                                        child: Icon(Icons.help, color: Colors.grey)),
                                                                    enabledBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: Colors.grey,
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
                                                          SizedBox(height: 10),
                                                          Container(
                                                              width: double.infinity,
                                                              child: TextFormField(
                                                                  textAlign: TextAlign.left,
                                                                  autocorrect: true,
                                                                  keyboardType: TextInputType.text,
                                                                  validator: (input) => input.length < 1 ? 'Please enter the Branch' : null,
                                                                  onSaved: (input) => _con.sellerKycData.branch = input,
                                                                  decoration: InputDecoration(
                                                                    labelText: S.of(context).branch,
                                                                    labelStyle:
                                                                    Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.grey)),
                                                                    suffixIcon: Tooltip(
                                                                        message: "Please enter the Branch",
                                                                        child: Icon(Icons.help, color: Colors.grey)),
                                                                    enabledBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: Colors.grey,
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
                                                        ]))),
                                                Div(
                                                    colS: 12,
                                                    colM: 12,
                                                    colL: 5,
                                                    child: Container(
                                                        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width > 1024 ? 30 : 0),
                                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                          Container(
                                                              width: double.infinity,
                                                              child: TextFormField(
                                                                  textAlign: TextAlign.left,
                                                                  autocorrect: true,
                                                                  onSaved: (input) => _con.sellerKycData.accountNumber = input,
                                                                  validator: (input) => input.length < 1 ? 'please enter the Account Number' : null,
                                                                  keyboardType: TextInputType.text,
                                                                  decoration: InputDecoration(
                                                                    labelText: S.of(context).account_number,
                                                                    labelStyle:
                                                                    Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.grey)),
                                                                    suffixIcon: Tooltip(
                                                                        message: "Please enter the Account Number",
                                                                        child: Icon(Icons.help, color: Colors.grey)),
                                                                    enabledBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: Colors.grey,
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
                                                          SizedBox(height: 10),
                                                          Container(
                                                              width: double.infinity,
                                                              child: TextFormField(
                                                                  textAlign: TextAlign.left,
                                                                  autocorrect: true,
                                                                  validator: (input) => input.length < 1 ? 'Please enter Bank Code' : null,
                                                                  keyboardType: TextInputType.text,
                                                                  onSaved: (input) => _con.sellerKycData.bankCode = input,
                                                                  decoration: InputDecoration(
                                                                    labelText: S.of(context).bank_code,
                                                                    labelStyle:
                                                                    Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.grey)),
                                                                    enabledBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: Colors.grey,
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
                                                          SizedBox(height: 10),
                                                          Container(
                                                              width: double.infinity,
                                                              child: TextFormField(
                                                                  textAlign: TextAlign.left,
                                                                  autocorrect: true,
                                                                  onSaved: (input) => _con.sellerKycData.bankName = input,
                                                                  validator: (input) => input.length < 1 ? 'Please enter bank name' : null,
                                                                  keyboardType: TextInputType.text,
                                                                  decoration: InputDecoration(
                                                                    labelText: S.of(context).bank_name,
                                                                    labelStyle:
                                                                    Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.grey)),
                                                                    enabledBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: Colors.grey,
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
                                                        ])))
                                              ]),
                                            ),
                                          ]),
                                        )),
                                  ]),
                                ),
                              ),
                            ),
                            SettingPopUpWidget(terms: _con.terms, con: _con)
                          ],
                        ),
                      ),
                      Align(
                          child: Container(
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                (_tabController.index != 0)
                                    ? Container(
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.width > 769 ? 5 : 0,
                                        left: MediaQuery.of(context).size.width > 769 ? 13 : 0,
                                        right: MediaQuery.of(context).size.width > 769 ? 13 : 0,
                                        bottom: MediaQuery.of(context).size.width > 769 ? 5 : 0),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColorDark,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                        child: TextButton(
                                            onPressed: () {
                                              //_tabController.animateTo((_tabController.index -1));

                                              setState(() {
                                                _tabController.animateTo((_tabController.index - 1));
                                              });
                                            },
                                            child: Wrap(children: [
                                              Icon(Icons.arrow_back, color: Theme.of(context).primaryColorLight),
                                              Container(
                                                  padding: EdgeInsets.only(top: 3, left: 10, right: 5),
                                                  child: Text(S.of(context).previous,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: 'Touche W03 Regular',
                                                          fontWeight: FontWeight.w100,
                                                          color: Theme.of(context).primaryColorLight))),
                                            ]))))
                                    : Container(),
                                Container(
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.width > 769 ? 5 : 0,
                                        left: MediaQuery.of(context).size.width > 769 ? 13 : 0,
                                        right: MediaQuery.of(context).size.width > 769 ? 13 : 0,
                                        bottom: MediaQuery.of(context).size.width > 769 ? 5 : 0),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColorDark,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: (_tabController.index != 3)
                                          ? TextButton(
                                          onPressed: () {
                                            if (_tabController.index == 1) {
                                              if (_con.loginFormKey.currentState.validate()) {
                                                _con.loginFormKey.currentState.save();
                                                if (_con.basicInformationData.logo != '' && _con.basicInformationData.logo != null) {
                                                 // _con.basicInfoUpdate();
                                                  setState(() {
                                                    _tabController.animateTo((_tabController.index + 1));
                                                  });
                                                } else {
                                                  _con.showToast("Please upload your logo", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
                                                }
                                              }
                                            }
                                            if (_tabController.index == 3) {
                                             // _con.settingUpdate();
                                            }

                                            if(_tabController.index==0){

                                              setState(() {
                                                _tabController.animateTo((_tabController.index + 1));
                                              });
                                            }

                                            if (_tabController.index ==2) {
                                              if (_con.bankFormKey.currentState.validate()) {
                                                _con.bankFormKey.currentState.save();
                                                //_con.kycOfSellersUpdate();
                                                setState(() {
                                                  _tabController.animateTo((_tabController.index + 1));
                                                });
                                              }
                                            }
                                          },
                                          child: Wrap(children: [
                                            Icon(_tabController.index != 2 ? Icons.arrow_forward_outlined : Icons.thumb_up,
                                                color: Theme.of(context).primaryColorLight),
                                            Container(
                                                padding: EdgeInsets.only(top: 3, left: 10, right: 5),
                                                child: Text(_tabController.index == 2 ? S.of(context).done : S.of(context).next,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: 'Touche W03 Regular',
                                                        fontWeight: FontWeight.w100,
                                                        color: Theme.of(context).primaryColorLight))),
                                          ]))
                                          : Container(),
                                    )),
                              ])))
                    ]))),
          )),
    );
  }

  imagePickerBottomsheet() {
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
                  title: new Text(S.of(context).gallery),
                  onTap: () => getImagegaller(),
                ),
              ],
            ),
          );
        });
  }

  File _image;
  int currStep = 0;
  final picker = ImagePicker();

  Future getImage() async {
    if (GetPlatform.isWeb || GetPlatform.isMobile) {
      final pickedFile = await picker.getImage(
          source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          _con.basicInformationData.logo = pickedFile;
          Navigator.of(context).pop();
        } else {
          print('No image selected.');
        }
      });
    }  else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        _con.basicInformationData.logo = _image;
      });

      Navigator.of(context).pop();
    }
  }

  Future getImagegaller() async {

    if (GetPlatform.isWeb || GetPlatform.isMobile) {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          _con.basicInformationData.logo = pickedFile;
          Navigator.of(context).pop();
        } else {
          print('No image selected.');
        }
      });
    }  else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        _con.basicInformationData.logo = _image;
      });

      Navigator.of(context).pop();
    }
  }
}
