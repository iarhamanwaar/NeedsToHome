import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_and_signup_web/src/controllers/primaryuser_controller.dart';
import 'package:login_and_signup_web/src/models/user_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
// ignore: must_be_immutable
class AEUserPopup extends StatefulWidget{
  PrimaryUserController con;
  UserModel categoryDetails;
  //String categorytype;
  String pageType;
  AEUserPopup({Key key, this.con, this.categoryDetails, this.pageType}) : super(key: key);
  @override
  _AEUserPopupState createState() => _AEUserPopupState();
}

class _AEUserPopupState extends StateMVC<AEUserPopup> {

  @override
  // ignore: must_call_super
  void initState() {
    if(widget.pageType=='edit'){
      //  widget.con.hcategoryList = 'no_change';
    }
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

  _buildChild(BuildContext context) =>
      Container(

        width: double.infinity,
        decoration: BoxDecoration(
            color:Theme.of(context).primaryColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child:Scrollbar(
          isAlwaysShown: true,
          child:SingleChildScrollView(
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
            widget.pageType=='add'?Text(
                'Add User',
                style: Theme.of(context).textTheme.headline4
            ):Text('Edit User',
                style: Theme.of(context).textTheme.headline4
            ),
            Form(
              key: widget.con.bannerFormKey,
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
                                initialValue: widget.categoryDetails.userName,
                                onSaved: (input) => widget.con.userData.userName=input,
                                validator: (input) => input.length < 1 ? S.of(context).please_enter_your_name : null,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'User Name',
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

                      Padding(
                        padding: EdgeInsets.only(top:10),
                        child: Container(
                            width: double.infinity,

                            child: TextFormField(
                                textAlign: TextAlign.left,
                                autocorrect: true,
                                initialValue: widget.categoryDetails.email,
                                onSaved: (input) =>
                                widget.con.userData.email=input,
                                validator: (input) => input.length < 1 ? 'please enter your email' : null,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Email',
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
                                initialValue: widget.categoryDetails.phone,
                                onSaved: (input) =>
                                widget.con.userData.phone=input,
                                validator: (input) => input.length < 1 ? 'please enter your phone' : null,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Phone',
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
                                initialValue: widget.categoryDetails.password,
                                onSaved: (input) =>
                                widget.con.userData.password=input,
                                validator: (input) => input.length < 1 ? 'please enter your password' : null,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Password',
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
                                initialValue: widget.categoryDetails.address,
                                onSaved: (input) =>
                                widget.con.userData.address=input,
                                validator: (input) => input.length < 1 ? 'please enter your address' : null,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Address',
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
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.pageType=='add'?  Container(
                            color: Theme.of(context).primaryColor,
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
                              ): Image.network(_image.path),),
                          ):Container(
                            color: Theme.of(context).primaryColor,
                            width:150,
                            height:150,
                            child: GestureDetector(
                              onTap: () {
                                Imagepickerbottomsheet();
                              },
                              child: _image == null?Image(image:NetworkImage(widget.categoryDetails.image),
                                height: double.infinity,
                                width:double.infinity,
                                fit: BoxFit.fill,
                              ): Image.network(_image.path),),
                          ),
                        ],
                      ),
                      SizedBox(height:40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ignore: deprecated_member_use
                          FlatButton(
                            onPressed: () async {
                              //widget.con.addEditSuperCategory(widget.pageType, widget.categoryDetails.id, context);
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
        ),))
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
    final pickedFile = await picker.getImage(source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.con.userData.image = pickedFile;
        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImagegaller() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.con.userData.image = pickedFile;
        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
  }

  // ignore: non_constant_identifier_names




}
