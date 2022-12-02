
import 'package:flutter/material.dart';

import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';




// ignore: must_be_immutable
class PayemntGatewayTab extends StatefulWidget {
  PayemntGatewayTab({Key key, this.con}) : super(key: key);
  UserController con;
  @override
  _PayemntGatewayTabState createState() => _PayemntGatewayTabState();
}


class _PayemntGatewayTabState extends StateMVC<PayemntGatewayTab>
    with SingleTickerProviderStateMixin {


  String value;
  bool status = false;


  // ignore: non_constant_identifier_names
  bool smtp_status = false;



  @override
  Widget build(BuildContext context) {
    return  Div(
      colS: 12,
      colM:6,
      colL:6,
      child:Container(
          padding: EdgeInsets.only(top:20,left:20,right:20),
          child:Container(
              padding: EdgeInsets.only(top:20,left:20,right:20,bottom:20),
              decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color:Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                    ),
                  ]
              ),
              child:Column(
                  children:[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Container(
                              child:Image(image:AssetImage('assets/img/Razorpay.png'),
                                  height:40
                              )
                          ),
                          Container(
                            width:65,
                            child: GestureDetector(
                              onTap: () {},
                              child: Switch(
                                value:  true,
                                onChanged: (value){
                                  setState(() {
                                    widget.con.settingDetails.payment.currencyPosition = value;
                                    widget.con.adminPayment.currencyPosition = value;
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,

                              ),
                            ),),
                        ]
                    ),

                    Padding(
                      padding: EdgeInsets.only(top:10,left:10,right:10),
                      child: Container(
                          width: double.infinity,

                          child: TextFormField(
                              textAlign: TextAlign.left,
                              autocorrect: true,
                              keyboardType: TextInputType.text,



                              decoration: InputDecoration(
                                labelText: 'Secret Key',
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


                  ]
              )
          )
      ),
    );
  }
}