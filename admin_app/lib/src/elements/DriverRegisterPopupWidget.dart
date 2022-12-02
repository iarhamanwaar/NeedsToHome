import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/components/constants.dart';
import 'package:login_and_signup_web/src/repository/product_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:toast/toast.dart';

class DriverRegisterPopupWidget extends StatefulWidget {
  const DriverRegisterPopupWidget({Key key}) : super(key: key);

  @override
  _DriverRegisterPopupWidgetState createState() => _DriverRegisterPopupWidgetState();
}

class _DriverRegisterPopupWidgetState extends StateMVC<DriverRegisterPopupWidget> with SingleTickerProviderStateMixin {
  UserController _con;

  _DriverRegisterPopupWidgetState() : super(UserController()) {
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



  setSelectedRadio(String val) {
    setState(() {
      selectedRadio = val;
      _con.basicInformationData.business = val;
    });
  }

  bool ratingOne = false;
  bool status = false;


  DateTime pickedDate;

  String _gender = 'Male';
  String _drivingMode = '1';
  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
    _con.getSingleStatus();
    selectedRadio = 'Government Reg. Company';
    _con.basicInformationData.business = 'Government Reg. Company';
    formkey = new GlobalKey<FormState>();
    formkey1 = new GlobalKey<FormState>();
    //_con.getSingleValue();
    _con.listenForZone();
    listenForDropdown('shop_focus', 'title', 'status', 'success');
    pickedDate = DateTime.now();
    selectedRadio = '1';

  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    timeinput.text = '';
    closetime.text = '';
  }

  int checkedItem = 0;



  bool state = true;

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
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), colorScheme: ColorScheme.light(primary: Theme.of(context).colorScheme.secondary).copyWith(secondary: Theme.of(context).colorScheme.secondary),
            ),
            child: child,
          );
        });
    if (date != null)
      setState(() {
        pickedDate = date;
      });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.only(
        top: size.height * 0.1,
        left: size.width * 0.09,
        right: size.width * 0.09,
        bottom: size.height * 0.05,
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            width:size.width,
            height: size.height,
            color: Theme.of(context).primaryColor,
            child: Container(
                child: Container(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                    child: Column(children: [

                      Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children:[
                            
                            Text(S.of(context).add_driver,
                                style: Theme.of(context).textTheme.headline4
                            ),
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
                          /*onTap: (_) {
                            _tabController.index = _tabController.previousIndex;
                          },*/
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
                                  child: Text('General', style: TextStyle(fontWeight: FontWeight.w600)),
                                )),
                            Tab(
                                child: Container(
                                  child: Text('Address', style: TextStyle(fontWeight: FontWeight.w600)),
                                )),

                            // second tab [you can add an icon using the icon property]
                            Tab(
                                child: Container(
                                  child: Text('Zone', style: TextStyle(fontWeight: FontWeight.w600)),
                                )),
                            Tab(
                                child: Container(
                                  child: Text('Account', style: TextStyle(fontWeight: FontWeight.w600)),
                                )),
                            Tab(
                                child: Container(
                                  child: Text('Vehicle Details', style: TextStyle(fontWeight: FontWeight.w600)),
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
                                                    child:Column(
                                                        crossAxisAlignment:CrossAxisAlignment.start,
                                                        children:[

                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 20,
                                                            left:size.width > 769 ? 20 : 10,
                                                            right:size.width > 769 ? 20 : 10),
                                                        child: Text(
                                                          'General',
                                                          style: size.width > 769
                                                              ? Theme.of(context).textTheme.headline4
                                                              : Theme.of(context).textTheme.headline1,
                                                        ),
                                                      ),

                                                      Container(
                                                        margin: EdgeInsets.only(
                                                          
                                                            left: size.width > 769 ? 20 : 10,
                                                            right: size.width > 769 ? 20 : 10,
                                                            bottom: 20),
                                                        child: Wrap(runSpacing: 10, children: [
                                                          Container(
                                                              child: Div(
                                                                  colS: 12,
                                                                  colM: 12,
                                                                  colL: 6,
                                                                  child: Container(
                                                                
                                                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                                                                      Container(
                                                                        padding: EdgeInsets.only(left:10,right:10),
                                                                        width: double.infinity,
                                                                        child:TextFormField(
                                                                            textAlign: TextAlign.left,

                                                                            validator: (input) => input.length < 3
                                                                                ? S
                                                                                .of(context)
                                                                                .should_be_more_than_3_characters
                                                                                : null,
                                                                            autocorrect: true,
                                                                            keyboardType: TextInputType.text,
                                                                            decoration: InputDecoration(
                                                                              labelText: S.of(context).first_name,
                                                                              labelStyle: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                                                              enabledBorder: UnderlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: textFieldBorder,
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
                                                                            )
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        padding: EdgeInsets.only(left:10,right:10,top:20),
                                                                        child:Text(
                                                                          'DOB',
                                                                          style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                                                        ),
                                                                      ),

                                                                      Container(
                                                                        padding: EdgeInsets.only(left:10,right:10,top:10),
                                                                        child:InkWell(
                                                                          onTap: _pickDate,
                                                                          child: Row(
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .spaceBetween,
                                                                            children: [
                                                                              Text(
                                                                                "${pickedDate.year},${pickedDate.month}, ${pickedDate.day}",
                                                                                style: Theme.of(context).textTheme.headline1,
                                                                              ),
                                                                              Icon(Icons.arrow_drop_down)
                                                                            ],
                                                                          ),
                                                                        ),),
                                                                        Container(
                                                                        padding: EdgeInsets.only(left:10,right:10,top:20),
                                                                        child:Text(
                                                                          S.of(context).driving_mode,
                                                                          style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                                                        ),
                                                                      ),
                                                                      _drivingMode == '2'
                                                                          ? Container(
                                                                          width: double.infinity,
                                                                          height: 70,
                                                                          padding: EdgeInsets.only(left:10,right:10),
                                                                          child: TextFormField(
                                                                            textAlign: TextAlign.left,
                                                                            autocorrect: true,

                                                                            validator: (input) =>
                                                                            input.length < 2
                                                                                ? 'Enter your Store ID'
                                                                                : null,
                                                                            keyboardType:
                                                                            TextInputType.number,


                                                                            decoration: InputDecoration(
                                                                              hintText: 'Store ID',
                                                                              labelStyle:  Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                                                              enabledBorder: UnderlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: textFieldBorder,
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
                                                                            ),

                                                                          ))
                                                                          : Container(),
                                                                      Container(
                                                                        padding: EdgeInsets.only(top:20,left:10,right:10,bottom:15),
                                                                        child:InkWell(
                                                                          onTap: (){
                                                                            setSelectedRadio('1');
                                                                          },
                                                                          child: Container(
                                                                              padding: EdgeInsets.only(top: 10,right: 10,bottom:10),
                                                                              decoration: BoxDecoration(
                                                                                  color:Theme.of(context).primaryColor,
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                  boxShadow: [
                                                                                    BoxShadow(
                                                                                      color: Theme.of(context).dividerColor.withOpacity(0.2),
                                                                                      blurRadius: 1,
                                                                                      spreadRadius: 1,
                                                                                    ),
                                                                                  ]
                                                                              ),
                                                                              child:Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,

                                                                                children: [
                                                                                  Container(
                                                                                    child:Radio(
                                                                                        value: '1',
                                                                                        groupValue: selectedRadio,
                                                                                        activeColor: Colors.blue,
                                                                                        onChanged: (val) {

                                                                                          setSelectedRadio(val);

                                                                                        }),
                                                                                  ),

                                                                                  SizedBox(width:5),

                                                                                  Expanded(
                                                                                    child: Container(
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text('Freelancer',style: Theme.of(context).textTheme.headline1),


                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),

                                                                                ],
                                                                              )
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        padding: EdgeInsets.only(left:10,right:10,bottom:15),
                                                                        child:InkWell(
                                                                          onTap: (){
                                                                            setSelectedRadio('2');
                                                                          },
                                                                          child: Container(
                                                                              padding: EdgeInsets.only(top: 10,right: 10,bottom:10),
                                                                              decoration: BoxDecoration(
                                                                                  color:Theme.of(context).primaryColor,
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                  boxShadow: [
                                                                                    BoxShadow(
                                                                                      color: Theme.of(context).dividerColor.withOpacity(0.2),
                                                                                      blurRadius: 1,
                                                                                      spreadRadius: 1,
                                                                                    ),
                                                                                  ]
                                                                              ),
                                                                              child:Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,

                                                                                children: [
                                                                                  Container(
                                                                                    child:Radio(
                                                                                        value: '2',
                                                                                        groupValue: selectedRadio,
                                                                                        activeColor: Colors.blue,
                                                                                        onChanged: (val) {

                                                                                          setSelectedRadio(val);

                                                                                        }),
                                                                                  ),

                                                                                  SizedBox(width:5),
                                                                                  Expanded(
                                                                                    child: Container(
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text('Shop',style: Theme.of(context).textTheme.headline1),


                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),

                                                                                ],
                                                                              )
                                                                          ),
                                                                        ),
                                                                      ),
                                                                          
                                                                      
                                                                    ]),
                                                                  )
                                                              )
                                                              ),
                                                          
                                                          
                                                          Container(
                                                            child: Div(
                                                                colS: 12,
                                                                colM: 12,
                                                                colL: 6,
                                                                child: Container(
                                                                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width > 1024 ? 10 : 0),
                                                                    child: Column(
                                                                        crossAxisAlignment:CrossAxisAlignment.start,
                                                                        children: [
                                                                      Container(
                                                                          width: double.infinity,
                                                                          padding: EdgeInsets.only(left:10,right:10),
                                                                          child: TextFormField(
                                                                              textAlign: TextAlign.left,
                                                                              autocorrect: true,
                                                                              keyboardType: TextInputType.text,

                                                                              validator: (input) => input.length < 3
                                                                                  ? S
                                                                                  .of(context)
                                                                                  .should_be_more_than_3_characters
                                                                                  : null,
                                                                              decoration: InputDecoration(
                                                                                labelText:  S.of(context).last_name,
                                                                                labelStyle:  Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                                                                enabledBorder: UnderlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: textFieldBorder,
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

                                                                      Container(
                                                                        padding: EdgeInsets.only(left:10,right:10,top:20),
                                                                        child:Text(
                                                                          S.of(context).gender,
                                                                          style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        padding: EdgeInsets.only(left:10,right:10,),
                                                                        width: double.infinity,
                                                                        child: DropdownButton(
                                                                            value: _gender,
                                                                            isExpanded: true,
                                                                            focusColor:transparent,
                                                                            underline: Container(
                                                                              color: textFieldBorder,
                                                                              height: 1.0,
                                                                            ),
                                                                            items: [
                                                                              DropdownMenuItem(
                                                                                child: Text('Male'),
                                                                                value: 'Male',
                                                                              ),
                                                                              DropdownMenuItem(
                                                                                child: Text('Female'),
                                                                                value: 'Female',
                                                                              ),
                                                                              DropdownMenuItem(
                                                                                  child: Text('Transgender'),
                                                                                  value: 'Transgender'),

                                                                            ],
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                _gender = value;

                                                                              });
                                                                            }
                                                                        ),
                                                                      ),







                                                                    ]
                                                                          )
                                                                          )
                                                                    ),
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

                              Container(
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
                                                        'Address',
                                                        style: MediaQuery.of(context).size.width > 769
                                                            ? Theme.of(context).textTheme.headline4
                                                            : Theme.of(context).textTheme.headline1,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: size.width > 769 ? 20 : 10,
                                                          right: size.width > 769 ? 30 : 0,
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
                                                                      padding: EdgeInsets.only(left:10,right:10),
                                                                      width: double.infinity,
                                                                      child:TextFormField(
                                                                          textAlign: TextAlign.left,

                                                                          validator: (input) => input.length < 1
                                                                              ? 'Please enter your address'
                                                                              : null,
                                                                          autocorrect: true,
                                                                          keyboardType: TextInputType.text,
                                                                          decoration: InputDecoration(
                                                                            labelText: '${S.of(context).address} 1',
                                                                            labelStyle: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                                                            enabledBorder: UnderlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: textFieldBorder,
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
                                                                          )
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.only(left:10,right:10),
                                                                      width: double.infinity,
                                                                      child:TextFormField(
                                                                          textAlign: TextAlign.left,

                                                                          autocorrect: true,
                                                                          keyboardType: TextInputType.text,
                                                                          decoration: InputDecoration(
                                                                            labelText:  S.of(context).city,
                                                                            labelStyle:  Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                                                            enabledBorder: UnderlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: textFieldBorder,
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
                                                                          )
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                        width: double.infinity,
                                                                        padding: EdgeInsets.only(left:10,right:10),
                                                                        child: TextFormField(
                                                                            textAlign: TextAlign.left,
                                                                            autocorrect: true,
                                                                            keyboardType: TextInputType.number,

                                                                            inputFormatters: <TextInputFormatter>[
                                                                              FilteringTextInputFormatter
                                                                                  .digitsOnly
                                                                            ],
                                                                            decoration: InputDecoration(
                                                                              labelText:S.of(context).zipcode,

                                                                              labelStyle: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                                                              enabledBorder: UnderlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: textFieldBorder,
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
                                                                        padding: EdgeInsets.only(left:10,right:10),
                                                                        child: TextFormField(
                                                                            textAlign: TextAlign.left,

                                                                            autocorrect: true,
                                                                            keyboardType: TextInputType.text,
                                                                            decoration: InputDecoration(
                                                                              labelText: '${S.of(context).address} 2',
                                                                              labelStyle:  Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                                                              enabledBorder: UnderlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: textFieldBorder,
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
                                                                    Container(
                                                                        width: double.infinity,
                                                                        padding: EdgeInsets.only(left:10,right:10),
                                                                        child: TextFormField(
                                                                            textAlign: TextAlign.left,

                                                                            autocorrect: true,
                                                                            keyboardType: TextInputType.text,
                                                                            decoration: InputDecoration(
                                                                              labelText: S.of(context).state,
                                                                              labelStyle: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                                                              enabledBorder: UnderlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: textFieldBorder,
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
                                                                    SizedBox(height: 40),
                                                                    InkWell(
                                                                      onTap: () async {



                                                                      },

                                                                      child: Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        children: [
                                                                          Text('Get address map',
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


                                                                  ]))),
                                                        ),

                                                       

                                                      ]),
                                                    ),


                                                  ]))
                                            ]),
                                          ])))),

                            Container(
                              child: Scrollbar(
                                isAlwaysShown: true,
                                child: SingleChildScrollView(
                                  child: Responsive(children: [
                                    Div(
                                        colS: 12,
                                        colM: 12,
                                        colL: 6,
                                        child: Container(
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                            SizedBox(height: 10),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 20,
                                                  left: size.width > 769 ? 20 : 10,
                                                  right: size.width > 769 ? 20 : 10),
                                              child: Text('Select Your Zone',style: size.width > 769
                                                    ? Theme.of(context).textTheme.headline4
                                                    : Theme.of(context).textTheme.headline1,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                      top:10,
                                                  left: size.width > 769 ? 20 : 10,
                                                  right: size.width > 769 ? 30 : 0,
                                                  bottom: 20),
                                              child:Container(
                                                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width > 1024 ? 30 : 0),
                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                    _con.zoneList.isEmpty?EmptyOrdersWidget():Column(
                                                      children: List.generate(_con.zoneList.length, (index) {
                                                        return Container(
                                                          padding: EdgeInsets.only(top:8,bottom:8),
                                                          child:InkWell(
                                                            onTap: (){
                                                              setSelectedRadio( _con.zoneList[index].zoneId);
                                                            },
                                                            child: Container(
                                                                padding: EdgeInsets.only(top: 10,right: 10,bottom:10),
                                                                decoration: BoxDecoration(
                                                                    color:Theme.of(context).primaryColor,
                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Theme.of(context).dividerColor.withOpacity(0.2),
                                                                        blurRadius: 1,
                                                                        spreadRadius: 1,
                                                                      ),
                                                                    ]
                                                                ),
                                                                child:Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,

                                                                  children: [
                                                                    Container(
                                                                      child:Radio(
                                                                          value: _con.zoneList[index].zoneId,
                                                                          groupValue: selectedRadio,
                                                                          activeColor: Colors.blue,
                                                                          onChanged: (val) {

                                                                            setSelectedRadio(val);

                                                                          }),
                                                                    ),

                                                                    SizedBox(width:10),
                                                                    Expanded(
                                                                      child: Container(
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(_con.zoneList[index].title,style: Theme.of(context).textTheme.headline1),


                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),

                                                                  ],
                                                                )
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ]))
                                            ),

                                          ]),
                                        )),
                                  ]),
                                ),
                              ),
                            ),
                            Container(
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
                                                      'Address',
                                                      style: MediaQuery.of(context).size.width > 769
                                                          ? Theme.of(context).textTheme.headline4
                                                          : Theme.of(context).textTheme.headline1,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: size.width > 769 ? 20 : 10,
                                                        right: size.width > 769 ? 30 : 0,
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
                                                                    padding: EdgeInsets.only(left:10,right:10),
                                                                    width: double.infinity,
                                                                    child:TextFormField(
                                                                        textAlign: TextAlign.left,

                                                                        validator: (input) =>
                                                                        !input.contains('@') ? S.of(context).should_be_valid_email : null,
                                                                        autocorrect: true,
                                                                        keyboardType: TextInputType.emailAddress,
                                                                        decoration: InputDecoration(
                                                                          labelText:  S.of(context).email,
                                                                          labelStyle: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                                                          enabledBorder: UnderlineInputBorder(
                                                                            borderSide: BorderSide(
                                                                              color: textFieldBorder,
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
                                                                        )
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding: EdgeInsets.only(left:10,right:10),
                                                                    width: double.infinity,
                                                                    child:TextFormField(
                                                                        textAlign: TextAlign.left,
                                                                        obscureText: true,
                                                                        autocorrect: true,

                                                                        validator: (input) => input.length <
                                                                            3
                                                                            ? S
                                                                            .of(context)
                                                                            .should_be_more_than_3_characters
                                                                            : null,
                                                                        keyboardType: TextInputType.text,
                                                                        decoration: InputDecoration(
                                                                          labelText: S.of(context).password,
                                                                          labelStyle: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                                                          enabledBorder: UnderlineInputBorder(
                                                                            borderSide: BorderSide(
                                                                              color: textFieldBorder,
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
                                                                        )
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin:EdgeInsets.only(top:20,left:10,right:10),
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(6),
                                                                      color: Theme.of(context).dividerColor,
                                                                    ),
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(10.0),
                                                                      child: TextFormField(
                                                                        maxLines: 5,

                                                                        validator: (input) =>
                                                                        input.length < 1
                                                                            ? 'Please enter about you'
                                                                            : null,
                                                                        decoration: InputDecoration.collapsed(
                                                                          hintText: S.of(context).about,
                                                                          hintStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .subtitle2
                                                                              .merge(TextStyle(color: Colors.grey)),
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
                                                                padding: EdgeInsets.only(right: size.width > 1024 ? 10 : 0),
                                                                child: Column(
                                                                  crossAxisAlignment:CrossAxisAlignment.start,
                                                                    children: [
                                                                  Container(
                                                                    padding: EdgeInsets.only(left:10,right:10),
                                                                    width: double.infinity,
                                                                    child:TextFormField(
                                                                        textAlign: TextAlign.left,

                                                                        autocorrect: true,
                                                                        keyboardType: TextInputType.number,
                                                                        inputFormatters: <
                                                                            TextInputFormatter>[
                                                                          FilteringTextInputFormatter
                                                                              .digitsOnly
                                                                        ],
                                                                        decoration: InputDecoration(
                                                                          hintText: S.of(context).mobile,
                                                                          labelStyle: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                                                          enabledBorder: UnderlineInputBorder(
                                                                            borderSide: BorderSide(
                                                                              color: textFieldBorder,
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
                                                                        )
                                                                    ),
                                                                  ),
                                                                  SizedBox(height:20),
                                                                  Container(
                                                                    padding: EdgeInsets.only(left:10,right:10),
                                                                    child: Text(
                                                                      S.of(context).profile,
                                                                      style: Theme.of(context)
                                                                          .textTheme
                                                                          .headline4,
                                                                    ),
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      imagePickerBottomsheet();
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

                                                                ]))),
                                                      ),



                                                    ]),
                                                  ),


                                                ]))
                                          ]),
                                        ])))),
                            Container(
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
                                                      'Select Your Vehicle Type',
                                                      style: MediaQuery.of(context).size.width > 769
                                                          ? Theme.of(context).textTheme.headline4
                                                          : Theme.of(context).textTheme.headline1,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: size.width > 769 ? 20 : 10,
                                                        right: size.width > 769 ? 30 : 0,
                                                        bottom: 20),
                                                    child: Wrap(runSpacing: 10, children: [
                                                      Container(
                                                          child: Div(
                                                              colS: 12,
                                                              colM: 12,
                                                              colL: 6,
                                                              child: Container(
                                                                padding: EdgeInsets.only(right:size.width > 1024 ? 30 : 0),
                                                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                                                                  _drivingMode == 'Bike'
                                                                      ? Container(
                                                                    padding:
                                                                    EdgeInsets.only(left: 10, right: 10),
                                                                    width: double.infinity,
                                                                    child: TextFormField(
                                                                        textAlign: TextAlign.left,
                                                                        autocorrect: true,
                                                                        keyboardType: TextInputType.text,

                                                                        decoration: InputDecoration(
                                                                          labelText:'Driving License',
                                                                          labelStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .subtitle1
                                                                              .merge(TextStyle(
                                                                              color: Theme.of(context)
                                                                                  .hintColor)),
                                                                          enabledBorder: UnderlineInputBorder(
                                                                            borderSide: BorderSide(
                                                                              color: textFieldBorder,
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

                                                                        validator: (input) => input.length < 1
                                                                            ? 'Please enter your Vehicle Color'
                                                                            : null,
                                                                        decoration: InputDecoration(
                                                                          labelText:'Vehicle Color',
                                                                          labelStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .subtitle1
                                                                              .merge(TextStyle(
                                                                              color:
                                                                              Theme.of(context).hintColor)),
                                                                          enabledBorder: UnderlineInputBorder(
                                                                            borderSide: BorderSide(
                                                                              color: textFieldBorder,
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


                                                                ]),
                                                              ))),
                                                      Container(
                                                        child: Div(
                                                            colS: 12,
                                                            colM: 12,
                                                            colL: 6,
                                                            child: Container(
                                                                padding: EdgeInsets.only(right: size.width > 1024 ? 10 : 0,top:20),
                                                                child: Column(
                                                                    crossAxisAlignment:CrossAxisAlignment.start,
                                                                    children: [
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


                                                                      Container(
                                                                        padding: EdgeInsets.only(left: 10, right: 10,top:20),
                                                                        width: double.infinity,
                                                                        child: TextFormField(
                                                                            textAlign: TextAlign.left,
                                                                            autocorrect: true,
                                                                            keyboardType: TextInputType.text,

                                                                            decoration: InputDecoration(
                                                                              labelText: 'Vehicle Model',
                                                                              labelStyle: Theme.of(context)
                                                                                  .textTheme
                                                                                  .subtitle1
                                                                                  .merge(TextStyle(
                                                                                  color:
                                                                                  Theme.of(context).hintColor)),
                                                                              enabledBorder: UnderlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: textFieldBorder,
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

                                                                    ]))),
                                                      ),



                                                    ]),
                                                  ),


                                                ]))
                                          ]),
                                        ])))),
                          ],
                        ),
                      ),
                      Align(
                          child: Container(
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                (_tabController.index != 0)
                                    ? Container(
                                    padding: EdgeInsets.only(
                                        top: size.width > 769 ? 5 : 0,
                                        left: size.width > 769 ? 13 : 0,
                                        right: size.width > 769 ? 13 : 0,
                                        bottom:size.width > 769 ? 5 : 0),
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
                                        top: size.width > 769 ? 5 : 0,
                                        left: size.width > 769 ? 13 : 0,
                                        right: size.width > 769 ? 13 : 0,
                                        bottom:size.width > 769 ? 5 : 0),
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
