
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_and_signup_web/src/components/constants.dart';

import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/models/shop_type.dart';
import 'package:login_and_signup_web/src/repository/product_repository.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// ignore: must_be_immutable
class ShopDetailsWidget extends StatefulWidget{
  SecondaryController con;
  Function callback;
  ShopTypeModel shopType;
  String pageType;
  // create some values





  ShopDetailsWidget({Key key, this.con,this.callback, this.shopType, this.pageType}) : super(key: key);
  @override
  _ShopDetailsWidgetState createState() => _ShopDetailsWidgetState();
}

class _ShopDetailsWidgetState extends StateMVC<ShopDetailsWidget> {

  String test;

  Color pickerColor ;
  Color currentColor ;
  void changeColor(Color color) {
    setState(() => currentColor = color);
     widget.con.shopTypeData.colorCode = color.value.toRadixString(16);

  }
  List<DropDownModel> dropDownList = <DropDownModel>[];
  var code = '443a49';
  String _value ;
  List<DropDownModel> dropDownListnc = <DropDownModel>[];
  String _svalue;
  @override
  void initState() {


    listenForDropdown('shop_type', 'type', 'status', 'success');
    listenForDropdownnc('supercategory', 'name');
   if(widget.pageType=='add') {

     pickerColor = Color(0xff443a49);
     currentColor = Color(0xff443a49);
     widget.con.shopTypeData.colorCode = '#$code';
   } else {

     widget.con.shopTypeData.shopTypeId = widget.shopType.shopTypeId;
     widget.con.shopTypeData.colorCode = widget.shopType.colorCode;
     widget.con.shopTypeData.superCategory = widget.shopType.superCategory;
     widget.con.shopTypeData.previewImage = 'no_change';
     widget.con.shopTypeData.coverImage = 'no_change';


     pickerColor = HexColor(widget.shopType.colorCode);
     currentColor = HexColor(widget.shopType.colorCode);
     super.initState();
   }

  }
  Future<void> listenForDropdownnc(table, select) async {
    dropDownListnc.clear();
    final Stream<DropDownModel> stream = await getDropdownDataNC(table, select);

    stream.listen((DropDownModel _list) {
      setState(() => dropDownListnc.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      if(widget.pageType!='add') {
        setState(() =>_svalue =  widget.shopType.superCategory);
      }
    });
  }
  Future<void> listenForDropdown(table, select, column, para1) async {
    dropDownList.clear();
    final Stream<DropDownModel> stream = await getDropdownDataSC(table, select, column, para1);

    stream.listen((DropDownModel _list) {
      setState(() => dropDownList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      if(widget.pageType!='add') {
        setState(() => _value = widget.shopType.shopTypeId);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                                  Text(widget.pageType=='add'?S.of(context).add_shop_type:'Edit Shop Type',
                                      style: Theme.of(context).textTheme.headline4
                                  ),
                                   SizedBox(height:20),
                                  Form(
                                    key: widget.con.generalFormKey,
                                    child: Padding(
                                      padding: EdgeInsets.only(right:GetPlatform.isMobile ? 15 : 18, left:GetPlatform.isMobile ? 15 : 18),
                                      child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:[
                                      Container(
                                      child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:[
                                            Text(S.of(context).select_your_super_category),
                                            Container(
                                              width: double.infinity,
                                              child: DropdownButtonFormField(
                                                  value: _svalue, //
                                                  isExpanded: true,
                                                  focusColor: transparent,
                                                  validator: (value) => value == null ? S.of(context).please_select : null,
                                                  items: dropDownListnc.map((DropDownModel map) {
                                                    return new DropdownMenuItem(
                                                      value: map.id,
                                                      child: new Text(map.name, style: new TextStyle(color: Colors.black)),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      widget.con.shopTypeData.superCategory = value;
                                                      _svalue = value;
                                                    });
                                                  }),
                                            ),


                                            SizedBox(height: 15),
                                            Text(S.of(context).select_your_shop_varient_type),
                                            Container(
                                              width: double.infinity,

                                              child: DropdownButtonFormField(
                                                  value: _value,
                                                  isExpanded: true,
                                                  validator: (value) => value == null ? S.of(context).please_select : null,
                                                  focusColor:transparent,

                                                  items: dropDownList.map((DropDownModel map) {
                                                    return new DropdownMenuItem(
                                                      value: map.id,
                                                      child: new Text(map.name, style: new TextStyle(color: Colors.black)),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      widget.con.shopTypeData.shopTypeId = value;
                                                      _value = value;
                                                    });
                                                  }),
                                            ),
                                            SizedBox(height: 20),
                                            Padding(
                                              padding: EdgeInsets.only(top:10),
                                              child: Container(
                                                  width: double.infinity,

                                                  child: TextFormField(
                                                      textAlign: TextAlign.left,
                                                      autocorrect: true,
                                                      initialValue: widget.shopType.focusTypeName,
                                                      onSaved: (input) =>widget.con.shopTypeData.focusTypeName = input,
                                                      validator: (input) => input.length < 1 ? S.of(context).please_enter_your_category : null,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        labelText: S.of(context).type_name,
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
                                            // ignore: deprecated_member_use
                                            FlatButton(
                                              onPressed: (){
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      titlePadding: const EdgeInsets.all(0.0),
                                                      contentPadding: const EdgeInsets.all(0.0),
                                                      content: SingleChildScrollView(
                                                        child: ColorPicker(
                                                          pickerColor: currentColor,
                                                          onColorChanged: changeColor,
                                                          colorPickerWidth: 300.0,
                                                          pickerAreaHeightPercent: 0.7,
                                                          enableAlpha: true,
                                                          displayThumbColor: true,
                                                          showLabel: true,
                                                          paletteType: PaletteType.hsv,
                                                          pickerAreaBorderRadius: const BorderRadius.only(
                                                            topLeft: const Radius.circular(2.0),
                                                            topRight: const Radius.circular(2.0),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );

                                              },
                                              color:currentColor,
                                              child: Text(S.of(context).dashboard_color),
                                              textColor: Colors.white70,


                                            ),
                                            SizedBox(height: 20),

                                            Text(
                                              S.of(context).select_your_preview_icon,
                                              style: Theme.of(context).textTheme.bodyText1,
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                widget.pageType=='add'?Container(
                                                  width: size.width > 670 ? 180:200,
                                                  height: size.height > 670 ? 180: 200,
                                                  child:  GestureDetector(
                                                    onTap: () {
                                                      Imagepickerbottomsheet('type1');
                                                    },
                                                    child: _image == null?Image(image:AssetImage('assets/img/image_placeholder.png'),
                                                        height: double.infinity,
                                                        width:double.infinity,
                                                        fit:BoxFit.fill
                                                    ): GetPlatform.isWeb?Image.network(_image.path):Image.file(_image),
                                                  ), )
                                                    :Container(
                                                  color: Theme.of(context).primaryColor,
                                                  width: size.width > 670 ? 180:200,
                                                  height: size.height > 670 ? 180: 200,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Imagepickerbottomsheet('type1');
                                                    },
                                                    child: _image == null?Image(image:NetworkImage(widget.shopType.previewImage),
                                                      height: double.infinity,
                                                      width:double.infinity,
                                                      fit: BoxFit.fill,
                                                    ):  GetPlatform.isWeb?Image.network(_image.path):Image.file(_image),),
                                                ),
                                              ],
                                            ),

                                            SizedBox(height: 10),
                                            Text(
                                              S.of(context).select_your_cover_icons,
                                              style: Theme.of(context).textTheme.bodyText1,
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                widget.pageType=='add'?Container(
                                                  width: size.width > 670 ? 180:200,
                                                  height: size.height > 670 ? 180: 200,
                                                  child:  GestureDetector(
                                                    onTap: () {
                                                      Imagepickerbottomsheet('type2');
                                                    },
                                                    child: _image2 == null?Image(image:AssetImage('assets/img/image_placeholder.png'),
                                                        height: double.infinity,
                                                        width:double.infinity,
                                                        fit:BoxFit.fill
                                                    ): GetPlatform.isWeb?Image.network(_image2.path):Image.file(_image2),
                                                  ), )
                                                    :Container(
                                                  color: Theme.of(context).primaryColor,
                                                  width: size.width > 670 ? 180:200,
                                                  height: size.height > 670 ? 180: 200,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Imagepickerbottomsheet('type2');
                                                    },
                                                    child: _image2 == null?Image(image:NetworkImage(widget.shopType.coverImage),
                                                      height: double.infinity,
                                                      width:double.infinity,
                                                      fit: BoxFit.fill,
                                                    ): GetPlatform.isWeb?Image.network(_image2.path):Image.file(_image2),),
                                                ),
                                              ],
                                            ),

                                            SizedBox(height: 30),


                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                // ignore: deprecated_member_use
                                                FlatButton(
                                                  onPressed: () {

                                                    widget.pageType=='add'?widget.con.addEdFocusType(context,'null','do_add'):widget.con.addEdFocusType(context,widget.shopType.id,'update');


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
                                    ]
                                  )
                          )
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
  Imagepickerbottomsheet(type) {
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
                  onTap: () => getImage(type),
                ),
                new ListTile(
                  leading: new Icon(Icons.image),
                  title: new Text(S.of(context).gallery),
                  onTap: () => getImagegaller(type),
                ),
              ],
            ),
          );
        });
  }

  File _image;
  File _image2;
  int currStep = 0;
  final picker = ImagePicker();

  Future getImage(type) async {
    if (GetPlatform.isWeb || GetPlatform.isMobile) {
    final pickedFile = await picker.getImage(source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
    setState(() {
      if (pickedFile != null) {
        if(type=='type1') {
          _image = File(pickedFile.path);
          widget.con.shopTypeData.previewImage = pickedFile;
        }else{
          _image2 = File(pickedFile.path);
          widget.con.shopTypeData.coverImage = pickedFile;
        }

        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
    } else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        if(type=='type1') {
        _image = File(result.files.single.path);
        widget.con.shopTypeData.previewImage = _image;
        }else{
          _image2 = File(result.files.single.path);
          widget.con.shopTypeData.coverImage = _image2;
        }
      });

      Navigator.of(context).pop();
    }
  }

  Future getImagegaller(type) async {
    if (GetPlatform.isWeb || GetPlatform.isMobile) {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          if (type == 'type1') {
            _image = File(pickedFile.path);
            widget.con.shopTypeData.previewImage = pickedFile;
          } else {
            _image2 = File(pickedFile.path);
            widget.con.shopTypeData.coverImage = pickedFile;
          }
          // widget.con.categoryData.uploadImage = pickedFile;

          Navigator.of(context).pop();
        } else {
          print('No image selected.');
        }
      });
    }else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        if(type=='type1') {
          _image = File(result.files.single.path);
          widget.con.shopTypeData.previewImage = _image;
        }else{
          _image2 = File(result.files.single.path);
          widget.con.shopTypeData.coverImage = _image2;
        }
      });

      Navigator.of(context).pop();
    }
  }



}
