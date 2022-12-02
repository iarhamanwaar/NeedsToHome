
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_and_signup_web/src/controllers/hservice_controller.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/models/subcategory_List.dart';
import 'package:login_and_signup_web/src/repository/product_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

import '../components/constants.dart';
// ignore: must_be_immutable
class AddSubCategoryPopup extends StatefulWidget{
  HServiceController con;
  SubCategoryListModel categoryDetails;
  String pageType;
  Function setState;
  AddSubCategoryPopup({Key key, this.con, this.categoryDetails, this.pageType, this.setState}) : super(key: key);
  @override
  _AddSubCategoryPopupState createState() => _AddSubCategoryPopupState();
}

class _AddSubCategoryPopupState extends StateMVC<AddSubCategoryPopup> {



  String _value ;
  List<DropDownModel> dropDownList = <DropDownModel>[];
  @override
  void initState() {
    listenForDropdown('h_category', 'category_name',);
    if(widget.categoryDetails.categoryId!=null){
       widget.con.subcategoryData.categoryId =  widget.categoryDetails.categoryId;
       widget.con.subcategoryData.uploadImage = 'no_change';
    }
    // TODO: implement initState
    super.initState();

  }
  Future<void> listenForDropdown(table, select) async {
    dropDownList.clear();
    final Stream<DropDownModel> stream = await getDropdownDataNC(table, select);
    stream.listen((DropDownModel _list) {
      widget.setState(() => dropDownList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      if(widget.pageType!='add') {
        setState(() =>  _value = widget.categoryDetails.categoryId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Responsive(
      alignment: WrapAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Div(
              colS:12,
              colM:8,
              colL:6,
              child:  Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                ),

                elevation: 0,
                backgroundColor: Colors.transparent,
                child: _buildChild(context),
                insetPadding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.1,
                  left:MediaQuery.of(context).size.width * 0.09,
                  right:MediaQuery.of(context).size.width * 0.09,
                  bottom:MediaQuery.of(context).size.width * 0.2,
                ),
              ),
            )
          ],
        )

      ],
    );

  }

  _buildChild
      (BuildContext context) => SingleChildScrollView(

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


          SizedBox(height:20),

          widget.pageType=='add'?Text("Add subcategory",
              style: Theme.of(context).textTheme.headline4
          ):Text('Edit Subcategory',
              style: Theme.of(context).textTheme.headline4
          ),
          Form(
            key:widget.con.subcategoryFormKey,
         child: Padding(
            padding: const EdgeInsets.only(right: 18, left:18),
            child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    child: DropdownButtonFormField(
                        value: _value, //
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
                            widget.con.subcategoryData.categoryId = value;

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
                            initialValue:  widget.categoryDetails.subcategoryName,
                            onSaved: (input) => widget.con.subcategoryData.subcategoryName = input,
                            validator: (input) => input.length < 1 ? S.of(context).please_enter_your_subcategory : null,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: S.of(context).sub_category_name,
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

                  SizedBox(height: 20),

                  Text(
                    S.of(context).select_your_sub_category,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      widget.pageType=='add'?  Container(
                        width:150,
                        height:150,
                        child: GestureDetector(
                          onTap: () {
                            Imagepickerbottomsheet();
                          },
                          child: _image == null?Image(image:AssetImage('assets/img/image_placeholder.png'),
                            height: double.infinity,
                            width:double.infinity,
                            fit: BoxFit.fill,
                          ): GetPlatform.isWeb?Image.network(_image.path):Image.file(_image),),
                      ):Container(
                        color: Theme.of(context).primaryColor,
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.10,
                        child: GestureDetector(
                          onTap: () {
                            Imagepickerbottomsheet();
                          },
                          child: _image == null?Image(image:NetworkImage(widget.categoryDetails.uploadImage),
                            height: double.infinity,
                            width:double.infinity,
                            fit: BoxFit.fill,
                          ):  GetPlatform.isWeb?Image.network(_image.path):Image.file(_image),),
                      ),
                    ]
                  ),


                  SizedBox(height:40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ignore: deprecated_member_use
                      FlatButton(
                        onPressed: () {

                          widget.con.addEditSubCategory(widget.pageType, widget.categoryDetails.id, context );

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



        ],
      ),
    ),
  );


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
        widget.con.subcategoryData.uploadImage = pickedFile;
        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
    } else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        widget.con.subcategoryData.uploadImage = _image;
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
          widget.con.subcategoryData.uploadImage = pickedFile;

          Navigator.of(context).pop();
        } else {
          print('No image selected.');
        }
      });
    }else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        widget.con.subcategoryData.uploadImage = _image;
      });
      print(_image);
      Navigator.of(context).pop();
    }
  }



}
