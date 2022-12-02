import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../generated/l10n.dart';
import '../../controllers/user_controller.dart';
import 'register_form_step6.dart';
import '../../models/register.dart';

// ignore: must_be_immutable
class RegisterFormStep5 extends StatefulWidget {
  RegisterFormStep5({Key key, this.registerData, this.image}) : super(key: key);
  Registermodel registerData;
  File image;
  @override
  _RegisterFormStep5State createState() => _RegisterFormStep5State();
}

class _RegisterFormStep5State extends StateMVC<RegisterFormStep5> {
  UserController _con;
  _RegisterFormStep5State() : super(UserController()) {
    _con = controller;
  }
  File _imageProof;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    var color = Colors.grey[300];
    return Scaffold(
      key: _con.scaffoldKey,

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
                      Text('KYC Details',
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
                      key: _con.formKeys[4],
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[


                                      Container(
                                        padding: EdgeInsets.only(left:10,right:10,top:20),
                                        child:Text(
                                          'Id Proof',
                                          style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).hintColor)),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left:10,right:10,),
                                        width: double.infinity,
                                        child: DropdownButtonFormField(
                                            value: widget.registerData.proofType,
                                            isExpanded: true,

                                            focusColor:
                                            Theme.of(context).colorScheme.secondary,

                                            validator: (input) => input.length < 1
                                                ? 'Please Select'
                                                : null,
                                            items: [
                                              DropdownMenuItem(
                                                child: Text('National ID'),
                                                value: 'National Id',
                                              ),
                                              DropdownMenuItem(
                                                child: Text('Voters ID'),
                                                value: 'Voters Id',
                                              ),
                                              DropdownMenuItem(
                                                  child: Text('Passport'),
                                                  value: 'Passport'),
                                              DropdownMenuItem(
                                                  child: Text('Driving Licence'),
                                                  value: 'Driving Licence'),
                                            ],
                                            onChanged: (value) {
                                              setState(() {

                                                widget.registerData.proofType= value;
                                              });
                                            }
                                        ),
                                      ),
                                      SizedBox(height:5),

                                      GestureDetector(
                                        onTap: () {
                                          imagePickerBottomSheet();
                                        },
                                        child:Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,color: Theme.of(context).dividerColor
                                              )
                                          ),
                                          margin: EdgeInsets.only(left:10),
                                          padding: EdgeInsets.all(10),

                                          child    : Image(image:_imageProof == null ? AssetImage('assets/img/id_proof.jpg',) :FileImage(_imageProof,),
                                            height: 100,width:100,fit: BoxFit.cover,
                                          )





                                        ),
                                        ),


                                      Container(
                                        padding: EdgeInsets.only(left:10,right:10),
                                        width: double.infinity,
                                        child:TextFormField(
                                            textAlign: TextAlign.left,
                                            onSaved: (input) => widget
                                                .registerData.accountName = input,
                                            validator: (input) => input.length < 1
                                                ? 'Please enter the holder name'
                                                : null,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              labelText: 'Account Holder Name',
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
                                      SizedBox(height: 5),
                                      Container(
                                        padding: EdgeInsets.only(left:10,right:10),
                                        width: double.infinity,
                                        child:TextFormField(
                                            textAlign: TextAlign.left,
                                            onSaved: (input) => widget
                                                .registerData.accountNo = input,
                                            validator: (input) => input.length < 1
                                                ? 'Please enter the account no'
                                                : null,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              labelText: 'Account No',
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
                                      SizedBox(height: 5),
                                      Container(
                                        padding: EdgeInsets.only(left:10,right:10),
                                        width: double.infinity,
                                        child:TextFormField(
                                            textAlign: TextAlign.left,
                                            onSaved: (input) => widget
                                                .registerData.bankName = input,
                                            validator: (input) => input.length < 1
                                                ? 'Please enter the bank name'
                                                : null,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              labelText: 'Bank Name',
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
                                      SizedBox(height: 5),
                                      Container(
                                        padding: EdgeInsets.only(left:10,right:10),
                                        width: double.infinity,
                                        child:TextFormField(
                                            textAlign: TextAlign.left,
                                            onSaved: (input) => widget
                                                .registerData.bankCode = input,
                                            validator: (input) => input.length < 1
                                                ? 'Please enter the bank code'
                                                : null,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              labelText: 'Bank Code',
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
                                      SizedBox(height: 5),
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
    if (_con.formKeys[4].currentState.validate()) {
      _con.formKeys[4].currentState.save();
      if (_imageProof != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                RegisterFormStep6(
                  proofImage: _imageProof,
                  registerData: widget.registerData,
                  image: _imageProof,)));
      } else {
        // ignore: deprecated_member_use
        _con.scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content:
          Text('Please upload your proof image'),
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
               new ListTile(
                  leading: new Icon(Icons.image),
                  title: new Text('Gallery'),
                  onTap: () => getImageGallery(),
                ),
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
          _imageProof = File(pickedFile.path);

          Navigator.of(context).pop();
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      print('camera error$e');
      print(e.code);
    }
  }


  Future getImageGallery() async {
    try {
      final pickedFile = await picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 480,
          maxWidth: 640,
          imageQuality: 50);
      setState(() {
        if (pickedFile != null) {
          _imageProof = File(pickedFile.path);
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

