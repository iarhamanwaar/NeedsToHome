import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../generated/l10n.dart';
import '../../controllers/user_controller.dart';
import '../Widget/custom_divider_view.dart';


class RegisterFormStep1 extends StatefulWidget {
  @override
  _RegisterFormStep1State createState() => _RegisterFormStep1State();
}

class _RegisterFormStep1State extends StateMVC<RegisterFormStep1> {
  UserController _con;
  _RegisterFormStep1State() : super(UserController()) {
    _con = controller;
  }
  int dropDownValue = 0;

  String selectedRadio;
  DateTime pickedDate;

  String _gender = 'Male';
  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    selectedRadio = '1';
    _con.registerData.dob =
    "${pickedDate.year},${pickedDate.month}, ${pickedDate.day}";
    _con.registerData.gender = 'Male';

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
      });
  }


  @override
  Widget build(BuildContext context) {
    var color = Colors.grey[300];
    return Scaffold(
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
                      Text(S.of(context).general,
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
                      key: _con.formKeys[0],
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Container(
                                child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[
                                     /* Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child:Text(
                                              'General Details',
                                              style: Theme.of(context).textTheme.headline2,
                                            ),
                                          ),
                                        ],
                                      ),*/

                                      Container(
                                        padding: EdgeInsets.only(left:10,right:10),
                                        width: double.infinity,
                                        child:TextFormField(
                                            textAlign: TextAlign.left,
                                            onSaved: (input) =>
                                            _con.registerData.firstname = input,
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
                                          width: double.infinity,
                                          padding: EdgeInsets.only(left:10,right:10),
                                          child: TextFormField(
                                              textAlign: TextAlign.left,
                                              autocorrect: true,
                                              keyboardType: TextInputType.text,
                                              onSaved: (input) => _con
                                                  .registerData.lastname = input,
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
                                                    color: color,
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
                                          padding: EdgeInsets.only(left:10,right:10,top:5),
                                          child:CustomDividerView(dividerHeight: 1,color:color)
                                      ),
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
                                            focusColor:
                                            Theme.of(context).colorScheme.secondary,
                                            underline: Container(
                                              color: color,
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
                                                _con.registerData.gender = value;
                                              });
                                            }
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
                                   _con.registrationNext(0,'step2', _con.registerData);
                              },
                              color: Theme.of(context).colorScheme.secondary,
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
}
