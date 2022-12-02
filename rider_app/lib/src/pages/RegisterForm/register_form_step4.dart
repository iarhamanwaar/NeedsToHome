import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../generated/l10n.dart';
import '../../controllers/user_controller.dart';
import '../../models/register.dart';
import 'register_form_step5.dart';


// ignore: must_be_immutable
class RegisterFormStep4 extends StatefulWidget {
  RegisterFormStep4({Key key, this.registerData}) : super(key: key);
  RegisterModel registerData;
  @override
  _RegisterFormStep4State createState() => _RegisterFormStep4State();
}

class _RegisterFormStep4State extends StateMVC<RegisterFormStep4> {
  UserController _con;
  _RegisterFormStep4State() : super(UserController()) {
    _con = controller;
  }
  File _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    var color = Colors.grey[300];
    return Scaffold(
      key: _con.scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            //color: Theme.of(context).primaryColorDark,
              image: DecorationImage(
                  image: AssetImage('assets/img/background_image.jpg',
                  ),
                  fit: BoxFit.fill
              )
          ),
          child: SafeArea(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only( left: 10.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color:Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 10.0),
                      Text('Account',
                        style: Theme.of(context).textTheme.headline4.merge(TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),


                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    width:double.infinity,
                    padding: EdgeInsets.only(left:20,right:20,top:20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              spreadRadius: 15
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Form(
                      key: _con.formKeys[3],
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[


                                      Container(
                                        padding: EdgeInsets.only(left:10,right:10),
                                        width: double.infinity,
                                        child:TextFormField(
                                            textAlign: TextAlign.left,
                                            onSaved: (input) => widget.registerData.email = input,
                                            validator: (input) =>
                                            !input.contains('@') ? S.of(context).should_be_valid_email : null,
                                            autocorrect: true,
                                            keyboardType: TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              labelText:  S.of(context).email,
                                              labelStyle: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: color,
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
                                      SizedBox(height:5),
                                      Container(
                                        padding: EdgeInsets.only(left:10,right:10),
                                        width: double.infinity,
                                        child:TextFormField(
                                            textAlign: TextAlign.left,
                                          onSaved: (input) => widget.registerData.mobile = int.parse(input),
                                            validator: (input) => input.length <
                                                3
                                                ? S.of(context).valid_mobile_number
                                                : null,
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
                                                  color: color,
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
                                            onSaved: (input) => widget.registerData.password = input,
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
                                                  color: color,
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

                                        child: Text(
                                          S.of(context).profile,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          imagePickerBottomSheet();
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
                                        margin:EdgeInsets.only(top:20,left:10,right:10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          color: Theme.of(context).dividerColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextFormField(
                                            maxLines: 5,
                                         onSaved: (input) => widget.registerData.aboutyou = input,
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
                                    ]
                                )
                            )









                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.bottomRight,
                  child:Container(
                      width: double.infinity,
                      height: 70,
                      color: Theme.of(context).primaryColor,
                      child:Container(
                          padding: EdgeInsets.only(left:10,right:10,top:10,bottom:10),
                          child:  MaterialButton(
                              onPressed:(){
    if (_con.formKeys[3].currentState.validate()) {
      _con.formKeys[3].currentState.save();
      if (_image != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                RegisterFormStep5(
                  registerData: widget.registerData,
                  image: _image,)));
      } else {
        // ignore: deprecated_member_use
        _con.scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content:
          Text(S
              .of(context)
              .upload_your),
        ));
      }
    }
                                },
                              color:Theme.of(context).colorScheme.secondary,
                              child: Text(S.of(context).save_and_proceed,
                                style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).primaryColorLight)),
                              )
                          )
                      )
                  ),

                ),
              ],
            ),
          )
      ),
    );

  }

  void imagePickerBottomSheet() {
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
                /*new ListTile(
                  leading: new Icon(Icons.image),
                  title: new Text('Gallery'),
                  onTap: () => getImagegaller(),
                ),*/
              ],
            ),
          );
        });
  }

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
}
