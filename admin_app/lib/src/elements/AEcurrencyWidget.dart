
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/models/currency.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

// ignore: must_be_immutable
class AEcurrencyWidget extends StatefulWidget{
  AEcurrencyWidget({Key key, this.con, this.currencyDetails, this.pageType}) : super(key: key);
  SecondaryController con;
  Currency currencyDetails;
  String pageType;
  @override
  _AEcurrencyWidgetState createState() => _AEcurrencyWidgetState();
}

class _AEcurrencyWidgetState extends StateMVC<AEcurrencyWidget> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.pageType=='edit'){
      widget.con.currencyData.uploadImage = 'no_edit';
    }
  }

  @override
  Widget build(BuildContext context) {

    return Form(key:widget.con.currencyFormKey,
      child: Container(
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
              bottom:MediaQuery.of(context).size.height * 0.1,
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
                                  Text(S.of(context).add_cuurency,
                                      style: Theme.of(context).textTheme.headline4
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(right: 40, left:40),
                                    child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[
                                          SizedBox(height:10),
                                          Container(
                                              width: double.infinity,

                                              child: TextFormField(
                                                  textAlign: TextAlign.left,
                                                  autocorrect: true,
                                                  keyboardType: TextInputType.text,
                                                  initialValue: widget.currencyDetails.currencySymbol,
                                                  validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_currency_symbol : null,
                                                  onSaved: (input) => widget.con.currencyData.currencySymbol = input,

                                                  decoration: InputDecoration(
                                                    labelText: S.of(context).currency_symbol,
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
                                          SizedBox(height:10),
                                          Container(
                                              width: double.infinity,

                                              child: TextFormField(
                                                  textAlign: TextAlign.left,
                                                  autocorrect: true,
                                                  keyboardType: TextInputType.text,
                                                  initialValue: widget.currencyDetails.currencyName,
                                                  validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_currency_name : null,
                                                  onSaved: (input) => widget.con.currencyData.currencyName = input,
                                                  decoration: InputDecoration(
                                                    labelText: S.of(context).currency_name,
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
                                          SizedBox(height:10),
                                          Container(
                                              width: double.infinity,

                                              child: TextFormField(
                                                  textAlign: TextAlign.left,
                                                  autocorrect: true,
                                                  initialValue: widget.currencyDetails.country,
                                                  keyboardType: TextInputType.text,
                                                  validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_country_name : null,
                                                  onSaved: (input) => widget.con.currencyData.country = input,
                                                  decoration: InputDecoration(
                                                    labelText: S.of(context).country,
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

                                          SizedBox(height:30),

                                          widget.pageType=='add'?  Container(
                                            color: Theme.of(context).primaryColor,
                                            width:150,
                                            height:150,
                                            child: GestureDetector(
                                              onTap: () {
                                                Imagepickerbottomsheet();
                                              },
                                              child: _image == null?Image(image:AssetImage('assets/img/category_15.jpg'),
                                                height: double.infinity,
                                                width:double.infinity,
                                                fit: BoxFit.fill,
                                              ): GetPlatform.isWeb?Image.network(_image.path):Image.file(_image),),
                                          ):Container(
                                            color: Theme.of(context).primaryColor,
                                            width:150,
                                            height:150,
                                            child: GestureDetector(
                                              onTap: () {
                                                Imagepickerbottomsheet();
                                              },
                                              child: _image == null?Image(image:NetworkImage(widget.currencyDetails.uploadImage),
                                                height: double.infinity,
                                                width:double.infinity,
                                                fit: BoxFit.fill,
                                              ): GetPlatform.isWeb?Image.network(_image.path):Image.file(_image),),
                                          ),


                                          SizedBox(height:30),
                                        ]
                                    ),

                                  ),
                                ]
                            ),
                          ),),
                      )
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child:Container(
                      padding: EdgeInsets.only(bottom:10,right:10,left:10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // ignore: deprecated_member_use
                          FlatButton(
                            onPressed: () {
                              widget.pageType=='add'?widget.con.updateCurrency(context, 'do_add', ''):
                              widget.con.updateCurrency(context, 'update', widget.currencyDetails.id);


                            },
                            padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                            color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                            shape: StadiumBorder(),
                            child: Text(
                              S.of(context).save,
                              style: Theme.of(context).textTheme.headline6.merge(
                                  TextStyle(
                                      color: Theme.of(context)
                                          .primaryColorLight)),
                            ),
                          ),



                        ],
                      ),
                    ),

                  ),



                ],
              ),
            ),
          ),

        )

    ),);



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
        widget.con.currencyData.uploadImage = pickedFile;
        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
    } else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        widget.con.currencyData.uploadImage = _image;
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
        widget.con.currencyData.uploadImage = pickedFile;

        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
    } else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        widget.con.currencyData.uploadImage = _image;
      });

      Navigator.of(context).pop();
    }
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



}
