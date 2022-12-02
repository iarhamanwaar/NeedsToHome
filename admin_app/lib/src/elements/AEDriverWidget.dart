
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/primaryuser_controller.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/models/driverregistermodel.dart';
import 'package:login_and_signup_web/src/repository/product_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../components/constants.dart';
// ignore: must_be_immutable
class AEDriverWidget extends StatefulWidget{
  PrimaryUserController con;
  Function setState;
  String pageType;
  DriverRegistermodel driverData;
  AEDriverWidget({Key key, this.con,this.setState,this.driverData,this.pageType});
  @override
  _AEDriverWidgetState createState() => _AEDriverWidgetState();
}

class _AEDriverWidgetState extends StateMVC<AEDriverWidget> {

  int dropDownValue = 0;
  List<DropDownModel> dropDownList = <DropDownModel>[];
  DateTime pickedDate;
  String _svalue;
  AnimationController controller1;
  Animation<double> scaleAnimation;
  String _gender = 'Male';
  String _drivingMode = '2';
  String zone;

  PrimaryUserController _con;
  _AEDriverWidgetState() : super(PrimaryUserController()) {
    _con = controller;
  }

  Future<void> listenForDropdownNC(table, select) async {
    dropDownList.clear();
    final Stream<DropDownModel> stream = await getDropdownDataNC(table, select);

    stream.listen((DropDownModel _list) {
      setState(() => dropDownList.add(_list));

    }, onError: (a) {
      print(a);
    }, onDone: () {
    });
  }
  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    listenForDropdownNC('zone', 'title');
    if(widget.pageType=='add'){
      _gender = 'Male';
      _drivingMode = '2';
    }
    else{
      _svalue=widget.driverData.zone;
      _gender = widget.driverData.gender;
      _drivingMode =widget.driverData.drivingMode.toString();
      _con.registerData.id=widget.driverData.id;
    }
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
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), colorScheme: ColorScheme.light(primary: Theme.of(context).colorScheme.secondary).copyWith(secondary: Theme.of(context).colorScheme.secondary),
            ),
            child: child,
          );
        });
    if (date != null)
      setState(() {
        pickedDate = date;
        _con.registerData.dob = "${pickedDate.year},${pickedDate.month}, ${pickedDate.day}";
      });
  }
  @override
  Widget build(BuildContext context) {

    return Container(
        alignment: Alignment.center,
        child:Div(
          colS:12,
          colM:8,
          colL:6,


          child:Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
            ),

            elevation: 0,
            backgroundColor: Colors.transparent,

            insetPadding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.1,
              left:MediaQuery.of(context).size.width * 0.09,
              right:MediaQuery.of(context).size.width * 0.09,
              bottom:MediaQuery.of(context).size.height * 0.05,
            ),
            child:Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color:Theme.of(context).primaryColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(12))
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child:Container(
                        child:Scrollbar(
                          isAlwaysShown: true,
                          child: SingleChildScrollView(
                            child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children:[
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                        )

                                      ]
                                  ),
                                  Text(S.of(context).add_driver,
                                      style: Theme.of(context).textTheme.headline4
                                  ),

                                  Form(
                                    key: _con.diverFormKey,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 40, left:40),
                                      child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:[
                                            Column(
                                              children: <Widget>[
                                                TextFormField(
                                                    textAlign: TextAlign.left,
                                                    onSaved: (input) => _con.registerData.firstname = input,
                                                    initialValue: widget.driverData.firstname??'',
                                                    validator: (input) => input.length < 3 ? S.of(context).should_be_more_than_3_characters : null,
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
                                                        initialValue: widget.driverData.lastname??'',
                                                        onSaved: (input) => _con.registerData.lastname = input,
                                                        validator: (input) => input.length < 3 ? S.of(context).should_be_more_than_3_characters  : null,
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
                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                                                      focusColor: transparent,
                                                      underline: Container(
                                                        color: Colors.grey[300],
                                                        height: 1.0,
                                                      ),
                                                      items: [
                                                        DropdownMenuItem(
                                                          child: Text("Male"),
                                                          value: 'Male',
                                                        ),
                                                        DropdownMenuItem(
                                                          child: Text("Female"),
                                                          value: 'Female',
                                                        ),
                                                        DropdownMenuItem(child: Text("Transgender"), value: 'Transgender'),
                                                        DropdownMenuItem(child: Text("Others"), value: 'Others')
                                                      ],
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _gender = value;
                                                          _con.registerData.gender = value;
                                                          //print(_con.registerData.lastname);
                                                        });
                                                      }),
                                                ),

                                                SizedBox(height: 5),
                                                Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children:[
                                                      Text(S.of(context).select_your_zone,style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.grey[500],
                                                      ),),
                                                      Container(
                                                        width: double.infinity,
                                                        child: DropdownButtonFormField(
                                                            value: _svalue, //
                                                            isExpanded: true,
                                                            focusColor: transparent,
                                                            validator: (value) => value == null ? S.of(context).please_select : null,
                                                            items: dropDownList.map((DropDownModel map) {
                                                              return new DropdownMenuItem(
                                                                child: new Text(map.name, style: new TextStyle(color: Colors.black)),
                                                                value: map.id,
                                                              );
                                                            }).toList(),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _con.registerData.zone = value;
                                                                _svalue = value;
                                                              });
                                                            }),
                                                      ),
                                                    ]
                                                ),
                                                SizedBox(
                                                    height:5
                                                ),
                                                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                                  Text(
                                                    S.of(context).driving_mode,
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
                                                      value: _drivingMode,
                                                      isExpanded: true,
                                                      focusColor: transparent,
                                                      underline: Container(
                                                        color: Colors.grey[300],
                                                        height: 1.0,
                                                      ),
                                                      items: [
                                                        DropdownMenuItem(
                                                          child: Text("Freelancer"),
                                                          value: '1',
                                                        ),
                                                        DropdownMenuItem(
                                                          child: Text("Shop"),
                                                          value: '2',
                                                        ),
                                                      ],
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _drivingMode = value;
                                                          _con.registerData.drivingMode = value;
                                                        });
                                                      }),
                                                ),
                                                SizedBox(height: 5),
                                                _drivingMode=='2'?Container(
                                                    width: double.infinity,
                                                    height: 70,
                                                    child: TextFormField(
                                                        textAlign: TextAlign.left,
                                                        autocorrect: true,
                                                        initialValue: widget.driverData.storeId??'',
                                                        onSaved: (input) => _con.registerData.storeId = input,
                                                        validator: (input) => input.length < 2 ? 'Enter your Store ID' : null,
                                                        keyboardType: TextInputType.number,
                                                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                                        decoration: InputDecoration(
                                                          hintText: S.of(context).store_id,
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
                                                        ))):Container(),
                                              ],
                                            ),
                                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                              SizedBox(height: 5),
                                              Container(
                                                  width: double.infinity,
                                                  height: 70,
                                                  child: TextFormField(
                                                    //controller: _controllerAddress1,
                                                      textAlign: TextAlign.left,
                                                      initialValue: widget.driverData.address1??'',
                                                      onSaved: (input) => _con.registerData.address1 = input,
                                                      validator: (input) => input.length < 1 ? S.of(context).please_enter_addres : null,
                                                      autocorrect: true,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        hintText: '${S.of(context).address} 1',
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

                                            ]),
                                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                              Container(
                                                  width: double.infinity,
                                                  height: 70,
                                                  child: TextFormField(
                                                      onSaved: (input) => _con.registerData.email = input,
                                                      initialValue: widget.driverData.email??'',
                                                      validator: (input) => !input.contains('@') ? S.of(context).should_be_valid_email : null,
                                                      textAlign: TextAlign.left,
                                                      autocorrect: true,
                                                      keyboardType: TextInputType.emailAddress,
                                                      decoration: InputDecoration(
                                                        hintText:S.of(context).email,
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
                                                  child: TextFormField(
                                                      initialValue: widget.driverData.mobile??'',
                                                      onSaved: (input) => _con.registerData.mobile = input,
                                                      validator: (input) => input.length < 3 ? 'Please enter your valid mobile number' : null,
                                                      textAlign: TextAlign.left,
                                                      autocorrect: true,
                                                      keyboardType: TextInputType.number,
                                                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                                      decoration: InputDecoration(
                                                        hintText: S.of(context).mobile,
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
                                                  child: TextFormField(
                                                      initialValue: widget.driverData.password??'',
                                                      onSaved: (input) => _con.registerData.password = input,
                                                      validator: (input) => input.length < 3 ? S.of(context).should_be_more_than_3_characters : null,
                                                      textAlign: TextAlign.left,
                                                      obscureText: true,
                                                      decoration: InputDecoration(
                                                        hintText: S.of(context).password,
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
                                            ]),

                                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                              SizedBox(height: 20),
                                              GestureDetector(
                                                onTap: () {
                                                  Imagepickerbottomsheet();
                                                },
                                                child: Container(
                                                  width:150,
                                                  height:150,
                                                  child: _image == null?Image(image:AssetImage('assets/img/image_placeholder.png'),
                                                    height: double.infinity,
                                                    width:double.infinity,
                                                    fit: BoxFit.fill,
                                                  ):  GetPlatform.isWeb?Image.network(_image.path):Image.file(_image),
                                                ),
                                              ),
                                              Container(
                                                  width: double.infinity,
                                                  height: 70,
                                                  child: TextFormField(
                                                      textAlign: TextAlign.left,
                                                      autocorrect: true,
                                                      initialValue: widget.driverData.licenseno??'',
                                                      onSaved: (input) => _con.registerData.licenseno = input,
                                                      validator: (input) => input.length < 1 ? 'Please enter your Driving Licence' : null,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        hintText: 'Driving Licence No',
                                                        hintStyle: Theme.of(context).textTheme.caption,
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
                                                      initialValue: widget.driverData.aboutyou??'',
                                                      onSaved: (input) => _con.registerData.aboutyou = input,
                                                      validator: (input) => input.length < 1 ? 'Please enter about you' : null,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        hintText: S.of(context).about,
                                                        hintStyle: Theme.of(context).textTheme.caption,
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
                                            /*Container(
                                               width: MediaQuery.of(context).size.width * 0.1,
                                               height: MediaQuery.of(context).size.height * 0.2,
                                               child: GestureDetector(
                                                 onTap: () {
                                                   Imagepickerbottomsheet();
                                                 },
                                                 child: _image == null?Image(image:AssetImage(''),
                                                   height: double.infinity,
                                                   width:double.infinity,
                                                   fit: BoxFit.fitHeight,
                                                 ): Image.network(_image.path),),
                                             ),*/
                                            SizedBox(height: 10),


                                            SizedBox(height:20),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                // ignore: deprecated_member_use
                                                FlatButton(
                                                  onPressed: () {
                                                    //  _con.addBanner();
                                                    _con.register(widget.pageType);
                                                  },
                                                  padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                                                  color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                                  shape: StadiumBorder(),
                                                  child: Text(
                                                    S.of(context).submit,
                                                    style: Theme.of(context).textTheme.headline6.merge(
                                                        TextStyle(
                                                            color: Theme.of(context)
                                                                .primaryColorLight)),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(height:30),
                                          ]
                                      ),

                                    ),
                                  ),
                                ]
                            ),
                          ),),
                      )
                  ),




                ],
              ),
            ),
          ),

        )

    );



  }





  // ignore: non_constant_identifier_names
  Imagepickerbottomsheet() {
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
      final pickedFile = await picker.getImage(source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          widget.driverData.image = pickedFile;
          Navigator.of(context).pop();
        } else {
          print('No image selected.');
        }
      });
    } else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        widget.driverData.image = _image;
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
          widget.driverData.image = pickedFile;

          Navigator.of(context).pop();
        } else {
          print('No image selected.');
        }
      });
    }else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        widget.driverData.image = _image;
      });
      print(_image);
      Navigator.of(context).pop();
    }
  }



}
