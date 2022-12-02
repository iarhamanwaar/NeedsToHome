

import 'package:flutter/material.dart';

import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/models/version_control.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

// ignore: must_be_immutable
class VersionControlPopupWidget extends StatefulWidget{
  VersionControl details;
  SecondaryController con;
  VersionControlPopupWidget({Key key, this.con, this.details}) : super(key: key);
  @override
  _VersionControlPopupWidgetState createState() => _VersionControlPopupWidgetState();
}

class _VersionControlPopupWidgetState extends StateMVC<VersionControlPopupWidget> {



  @override
  Widget build(BuildContext context) {

    return Form(
      key: widget.con.currencyFormKey,
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

              insetPadding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.15,
                left:MediaQuery.of(context).size.width * 0.09,
                right:MediaQuery.of(context).size.width * 0.09,
                bottom:MediaQuery.of(context).size.height * 0.15,
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
                              Text(S.of(context).edit_app_version,
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
                                                    initialValue: widget.details.appName,
                                                    validator: (input) =>  input.length < 1 ? S.of(context).should_be_more_than_3_characters : null,
                                                    onSaved: (input) => widget.con.versionData.appName = input,
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(
                                                      labelText: 'Enter Your App Name',
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
                                                     initialValue: widget.details.version,
                                                    validator: (input) =>  input.length < 1 ? S.of(context).should_be_more_than_3_characters : null,
                                                    onSaved: (input) => widget.con.versionData.version = input,

                                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                    decoration: InputDecoration(
                                                      labelText:'Enter App Version',
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
                                                    initialValue: widget.details.appLink,
                                                    validator: (input) =>  input.length < 1 ? S.of(context).should_be_more_than_3_characters : null,
                                                    onSaved: (input) => widget.con.versionData.appLink = input,

                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(
                                                      labelText:'PlayStore Link',
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

                                widget.con.updateVersion(context, 'update', widget.details.versionControlId);

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
                      ),

                    ),



                  ],
                ),
              ),
            ),

          )

      ),);



  }








}
