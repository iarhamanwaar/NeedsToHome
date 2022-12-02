import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/models/delivery_Fees.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

// ignore: must_be_immutable
class DeliveryFeesPopup extends StatefulWidget{
  DeliveryFeesPopup({Key key, this.con, this.pageType, this.deliveryFeesDetails}) : super(key: key);
  SecondaryController con;
  String pageType;
  DeliveryFees deliveryFeesDetails;
  @override
  _DeliveryFeesPopupState createState() => _DeliveryFeesPopupState();
}

class _DeliveryFeesPopupState extends StateMVC<DeliveryFeesPopup> {



  @override
  Widget build(BuildContext context) {

    return Form(
      key:widget.con.deliveryFeesFormKey,child:Container(
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

                                  widget.pageType=='add'?Text(S.of(context).add_delivery_fees,
                                      style: Theme.of(context).textTheme.headline4
                                  ):Text('Edit Delivery Fees',
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
                                                  onSaved: (input) => widget.con.deliveryFees.name = input,
                                                  initialValue: widget.deliveryFeesDetails.name,
                                                  validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_name : null,
                                                  decoration: InputDecoration(
                                                    labelText: S.of(context).name,
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
                                                  keyboardType: TextInputType.number,
                                                  validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_from_range : null,
                                                  onSaved: (input) => widget.con.deliveryFees.fromRange = input,
                                                  initialValue: widget.deliveryFeesDetails.fromRange,
                                                  inputFormatters: <TextInputFormatter>[
                                                    FilteringTextInputFormatter.digitsOnly
                                                  ],
                                                  decoration: InputDecoration(
                                                    labelText: S.of(context).from_range,
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
                                                  keyboardType: TextInputType.number,
                                                  initialValue: widget.deliveryFeesDetails.toRange,
                                                  onSaved: (input) => widget.con.deliveryFees.toRange = input,
                                                  validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_to_range : null,
                                                  inputFormatters: <TextInputFormatter>[
                                                    FilteringTextInputFormatter.digitsOnly
                                                  ],
                                                  decoration: InputDecoration(
                                                    labelText: S.of(context).to_range,

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
                                                  initialValue: widget.deliveryFeesDetails.fees,
                                                  validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_fees : null,
                                                  onSaved: (input) => widget.con.deliveryFees.fees = input,

                                                  inputFormatters: <TextInputFormatter>[
                                                    FilteringTextInputFormatter.digitsOnly
                                                  ],
                                                  decoration: InputDecoration(
                                                    labelText: S.of(context).fees,
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
                              widget.pageType=='add'?widget.con.deliveryFeesUpdate(context, widget.deliveryFeesDetails.id, 'do_add'):
                              widget.con.deliveryFeesUpdate(context, widget.deliveryFeesDetails.id, 'update');

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
                          SizedBox(width:10),
                          // ignore: deprecated_member_use



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
