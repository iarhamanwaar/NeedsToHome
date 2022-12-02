import 'package:login_and_signup_web/src/elements/DriverDetailsViewWidget.dart';
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/elements/UserViewDetailsWidget.dart';

class Dialogs extends StatefulWidget {
  @override
  _DialogsState createState() => _DialogsState();
}

class _DialogsState extends State<Dialogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("POPUP")
      ),
      body: Container(
        margin: EdgeInsets.only(top:30),
        child: Center(
          child:Column(
            children:[
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: (){
                  showDialog(context: context,
                      builder: (BuildContext context){
                        return DriverDetailsViewWidget();
                      }
                  );
                },
                child: Text("Driver Details"),

              ),
              SizedBox(height:30),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: (){
                  showDialog(context: context,
                      builder: (BuildContext context){
                        return UserViewDetailsWidget();
                      }
                  );
                },
                child: Text("User Details"),

              ),
            ]
          )

        ),
      ),
    );
  }
}
