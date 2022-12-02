
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/models/staff.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
// ignore: must_be_immutable
class AEStaffWidget extends StatefulWidget{
  SecondaryController con;
  StaffModel staff;
  String pageType;
  AEStaffWidget({Key key, this.con, this.staff, this.pageType}) : super(key: key);
  @override
  _AEStaffWidgetState createState() => _AEStaffWidgetState();
}

class _AEStaffWidgetState extends StateMVC<AEStaffWidget> {
  // ignore: non_constant_identifier_names
  String _Type='1';
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
                                widget.pageType=='add'?Text('Add Staff'):
                                Text('Edit MemberShip Plan'),

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
                                                    //initialValue: widget.details.title,
                                                    onSaved: (input) =>  widget.con.staffData.name = input,
                                                    validator: (input) => input.length < 1 ? 'please enter Your name' : null,
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(
                                                      labelText: 'Name',
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

                                                    onSaved: (input) =>  widget.con.staffData.phone =  input,
                                                    validator: (input) => input.length < 1 ? 'please enter Your Phone' : null,
                                                    keyboardType: TextInputType.number,
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

                                                    onSaved: (input) =>  widget.con.staffData.address = input,
                                                    validator: (input) => input.length < 1 ? 'Please enter your address' : null,
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

                                          Padding(
                                            padding: EdgeInsets.only(top:10),
                                            child: Container(
                                                width: double.infinity,

                                                child: TextFormField(
                                                    textAlign: TextAlign.left,
                                                    autocorrect: true,

                                                    onSaved: (input) =>  widget.con.staffData.email = input,
                                                    validator: (input) => input.length < 1 ? 'Please enter email' : null,
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

                                                    onSaved: (input) =>  widget.con.staffData.password = input,
                                                    validator: (input) => input.length < 1 ? 'Please enter Password' : null,
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
                                            child:Container(
                                              width: double.infinity,
                                              child: DropdownButton(
                                                  value: _Type,
                                                  isExpanded: true,
                                                  focusColor: Theme.of(context).colorScheme.secondary,
                                                  underline: Container(
                                                    color: Colors.grey[300],
                                                    height: 1.0,
                                                  ),
                                                  items: [
                                                    DropdownMenuItem(
                                                      child: Text("1"),
                                                      value: '1',
                                                    ),
                                                    DropdownMenuItem(
                                                      child: Text("2"),
                                                      value: '2',
                                                    ),
                                                    DropdownMenuItem(child: Text("3"), value: '3'),
                                                  ],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _Type = value;
                                                      widget.con.staffData.role = value;
                                                    });
                                                  }),
                                            ),
                                          ),


                                          SizedBox(height: 20),

                                          Text(
                                            'Upload Image',
                                            style: Theme.of(context).textTheme.bodyText1,
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.2,
                                            height: MediaQuery.of(context).size.width * 0.15,
                                            child: GestureDetector(
                                              onTap: () {
                                                Imagepickerbottomsheet();
                                              },
                                              child: _image == null?Image(image:AssetImage('assets/img/image_placeholder.png'),
                                                height: double.infinity,
                                                width:double.infinity,
                                                fit: BoxFit.fill,
                                              ): Image.network(_image.path),),
                                          ),
                                          SizedBox(height:20),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // ignore: deprecated_member_use
                                              FlatButton(
                                                onPressed: () {
                                                  widget.con.addEditStaffList('add','Null',context);
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
                  title: new Text('camera'),
                  onTap: () => getImage(),
                ),
                new ListTile(
                  leading: new Icon(Icons.image),
                  title: new Text('gallery'),
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
        widget.con.staffData.uploadImage = pickedFile;
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
        widget.con.staffData.uploadImage = pickedFile;
        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
  }



}
