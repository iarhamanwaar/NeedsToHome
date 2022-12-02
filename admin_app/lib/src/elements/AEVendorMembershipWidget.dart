
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/models/vendor_membership.dart';
import 'package:login_and_signup_web/src/repository/product_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

import '../components/constants.dart';

// ignore: must_be_immutable
class AEVendorMembershipWidget extends StatefulWidget{
  SecondaryController con;
  VendorMembershipModel memberdetails;
  String pageType;
  Function setState;
  AEVendorMembershipWidget({Key key, this.con, this.memberdetails, this.pageType,this.setState}) : super(key: key);
  @override
  _AEVendorMembershipWidgetState createState() => _AEVendorMembershipWidgetState();
}

class _AEVendorMembershipWidgetState extends StateMVC<AEVendorMembershipWidget> {
  // ignore: non_constant_identifier_names
  String _Type;
  List<DropDownModel> dropDownList = <DropDownModel>[];
  @override
  void initState() {
    listenForDropdown('shop_focus', 'title',);
    if(widget.pageType=='edit'){

      widget.con.vendorMembershipData.shoptype =  widget.memberdetails.shoptype;
      widget.con.vendorMembershipData.uploadImage = 'no_change';
    }


    // TODO: implement initState
    super.initState();

  }

  Future<void> listenForDropdown(table, select) async {
    dropDownList.clear();
    final Stream<DropDownModel> stream = await getDropdownDataNC(table, select);
    stream.listen((DropDownModel _list) {
     setState(() => dropDownList.add(_list));

    }, onError: (a) {
      print(a);
    }, onDone: () {
      if(widget.pageType=='edit') {
        setState(() => _Type = widget.memberdetails.shoptype);
      }
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


                                SizedBox(height:10),
                                widget.pageType=='add'?Text(S.of(context).add_membership_plan,style: Theme.of(context).textTheme.headline4,):
                                    Text(S.of(context).edit_membership_plan,style: Theme.of(context).textTheme.headline4,),

                                Form(
                                  key: widget.con.registerFormKey,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 18, left:18),
                                    child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[

                                          Padding(
                                            padding: EdgeInsets.only(top:10),


                                            child: Container(
                                                width: double.infinity,

                                                child: TextFormField(
                                                    textAlign: TextAlign.left,
                                                    autocorrect: true,
                                                    initialValue: widget.memberdetails.planname,
                                                    onSaved: (input) =>  widget.con.vendorMembershipData.planname = input,
                                                    validator: (input) => input.length < 1 ? S.of(context).please_enter_the_name : null,
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(
                                                      labelText: S.of(context).plan_name,
                                                      labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                      enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
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
                                                    ))),
                                          ),

                                          SizedBox(height: 10),

                                          Padding(
                                            padding: EdgeInsets.only(top:10),
                                            child: Container(
                                                width: double.infinity,

                                                child: TextFormField(
                                                    textAlign: TextAlign.left,
                                                    autocorrect: true,
                                                    initialValue:widget.memberdetails.price ,
                                                    onSaved: (input) =>  widget.con.vendorMembershipData.price =  input,
                                                    validator: (input) => input.length < 1 ? 'Please enter the price' : null,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.allow(
                                                          Helper.getDecimalPointLimit()
                                                      ),
                                                    ],
                                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                    decoration: InputDecoration(
                                                      labelText: S.of(context).price,
                                                      labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                      enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
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
                                                    ))),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(top:10),
                                            child: Container(
                                                width: double.infinity,

                                                child: TextFormField(
                                                    textAlign: TextAlign.left,
                                                    autocorrect: true,
                                                    initialValue: widget.memberdetails.commission,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.allow(
                                                          RegExp(r'^(\d+)?\.?\d{0,2}')
                                                      ),
                                                    ],
                                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                    onSaved: (input) =>  widget.con.vendorMembershipData.commission = input,
                                                    validator: (input) => input.length < 1 ? 'Please enter the commission' : null,

                                                    decoration: InputDecoration(
                                                      labelText: S.of(context).commission,
                                                      labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                      enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
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
                                                    ))),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(top:10),
                                            child: Container(
                                                width: double.infinity,

                                                child: TextFormField(
                                                    textAlign: TextAlign.left,
                                                    autocorrect: true,
                                                    initialValue:widget.memberdetails.productlimit,
                                                    onSaved: (input) =>  widget.con.vendorMembershipData.productlimit = input,
                                                    validator: (input) => input.length < 1 ? 'Please enter the product upload limit' : null,
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(
                                                      labelText: S.of(context).please_upload_limit,
                                                      labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                      enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
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
                                                    ))),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(top:10),
                                            child: Container(
                                                width: double.infinity,

                                                child: TextFormField(
                                                    textAlign: TextAlign.left,
                                                    autocorrect: true,
                                                    initialValue: widget.memberdetails.validity,
                                                    onSaved: (input) =>  widget.con.vendorMembershipData.validity = input,
                                                    validator: (input) => input.length < 1 ? 'Please enter the validity' : null,
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(
                                                      labelText: S.of(context).validity_days,
                                                      labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                      enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
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
                                                    ))),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(top:10),
                                            child:Container(
                                              width: double.infinity,
                                              child: DropdownButtonFormField(
                                                  value: _Type, //
                                                  isExpanded: true,
                                                  focusColor: transparent,
                                                  validator: (value) => value == null ? S.of(context).please_select : null,
                                                  items: dropDownList.map((DropDownModel map) {
                                                    return new DropdownMenuItem(
                                                      value: map.id,
                                                      child: new Text(map.name, style: new TextStyle(color: Colors.black)),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      widget.con.vendorMembershipData.shoptype= value;
                                                      print(widget.con.vendorMembershipData.shoptype);
                                                      _Type = value;
                                                    });
                                                  }),
                                            ),
                                          ),


                                          SizedBox(height: 20),

                                          Text(
                                            S.of(context).select_your_banner,
                                            style: Theme.of(context).textTheme.bodyText1,
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children:[
                                              widget.pageType=='add'?Container(
                                                width:150,
                                                height:150,
                                                child:  GestureDetector(
                                                  onTap: () {
                                                    Imagepickerbottomsheet();
                                                  },
                                                  child: _image == null?Image(image:AssetImage('assets/img/image_placeholder.png'),
                                                      height: double.infinity,
                                                      width:double.infinity,
                                                      fit:BoxFit.fill
                                                  ): GetPlatform.isWeb?Image.network(_image.path):Image.file(_image),
                                                ), ): Container(


                                                width:150,
                                                height:150,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Imagepickerbottomsheet();
                                                  },
                                                  child: _image == null?Image(image:NetworkImage(widget.memberdetails.uploadImage),
                                                    height: double.infinity,
                                                    width:double.infinity,
                                                    fit: BoxFit.fill,
                                                  ): GetPlatform.isWeb?Image.network(_image.path):Image.file(_image),),
                                              ),
                                            ]
                                          ),

                                          SizedBox(height:20),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // ignore: deprecated_member_use
                                              FlatButton(
                                                onPressed: () {
                                                 widget.con.addEditMemberPlanList(widget.pageType,widget.memberdetails.id,context);
                                                },
                                                padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                                                color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                                shape: StadiumBorder(),
                                                child: Text(
                                                  'submit',
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
                        ),
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
        widget.con.vendorMembershipData.uploadImage = pickedFile;
        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
    } else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        widget.con.vendorMembershipData.uploadImage = _image;
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
        widget.con.vendorMembershipData.uploadImage = pickedFile;
        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
    } else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        widget.con.vendorMembershipData.uploadImage = _image;
      });

      Navigator.of(context).pop();
    }
  }



}
