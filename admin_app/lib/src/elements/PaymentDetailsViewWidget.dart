
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/components/padding_constants.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/payment_report.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

// ignore: must_be_immutable
class PaymentDetailsViewWidget extends StatefulWidget {
  PaymentReport payment;

  PaymentDetailsViewWidget({Key key, this.payment}) : super(key: key);

  @override
  _PaymentDetailsViewWidgetState createState() => _PaymentDetailsViewWidgetState();
}

class _PaymentDetailsViewWidgetState extends StateMVC<PaymentDetailsViewWidget> {
  // ignore: non_constant_identifier_names
  String _Type = 'Vendor';
  String id;

  SecondaryController _con;
  _PaymentDetailsViewWidgetState() : super(SecondaryController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PaddingConstants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    var size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          height: 450,

          padding: EdgeInsets.only(left: PaddingConstants.padding,top: PaddingConstants.avatarRadius
              + PaddingConstants.padding, right: PaddingConstants.padding,bottom: PaddingConstants.padding
          ),
          margin: EdgeInsets.only(top:PaddingConstants.avatarRadius,left:size.width >670 ? size.width * 0.27: PaddingConstants.padding,right:size.width >670 ? size.width * 0.27: PaddingConstants.padding),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(PaddingConstants.padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                ),
              ]
          ),
          child:SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text('Order ID',style:Theme.of(context).textTheme.subtitle1),
                  Container(
                      width:size.width > 670 ? size.width * 0.2: 140,
                    alignment: Alignment.topRight,
                    child:Text(widget.payment.invoiceID,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style:Theme.of(context).textTheme.subtitle1)
                  ),

                ]
              ),
              SizedBox(height:5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Vendor Settlement',style:Theme.of(context).textTheme.subtitle1),
                    Container(
                        width:size.width > 670 ? size.width * 0.2: 140,
                        alignment: Alignment.topRight,
                        child:Text(Helper.pricePrint(widget.payment.settlementAmount),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:Theme.of(context).textTheme.subtitle1)
                    ),

                  ]
              ),
              SizedBox(height:5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Driver Settlement',style:Theme.of(context).textTheme.subtitle1),
                    Container(
                        width:size.width > 670 ? size.width * 0.2: 140,
                        alignment: Alignment.topRight,
                        child:Text(Helper.pricePrint(widget.payment.driverSettlement.toString()),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:Theme.of(context).textTheme.subtitle1)
                    ),

                  ]
              ),
              SizedBox(height:5),








              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Order Date',style:Theme.of(context).textTheme.subtitle1),
                    Container(
                        width:size.width > 670 ? size.width * 0.2: 140,
                        alignment: Alignment.topRight,
                        child:Text(widget.payment.date,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            maxLines: 1,
                            style:Theme.of(context).textTheme.subtitle1)
                    ),
                  ]
              ),
              SizedBox(height:10),
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
                          child: Text("Vendor"),
                          value: 'Vendor',
                        ),
                        DropdownMenuItem(
                          child: Text("Driver"),
                          value: 'Driver',
                        ),

                      ],
                      onChanged: (value) {
                        setState(() {
                          _Type = value;

                        });
                      }),
                ),
              ),
              SizedBox(height:10),
              Padding(
                padding: EdgeInsets.only(top:10),


                child: Container(
                    width: double.infinity,

                    child: TextField(
                        textAlign: TextAlign.left,
                        autocorrect: true,
                        onChanged: (e){
                          id = e;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Transaction ID',
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
              SizedBox(height:35),
             Align(
                alignment: Alignment.center,
               // ignore: deprecated_member_use
               child: FlatButton(
                 onPressed: () {
                   print(widget.payment.invoiceID);
                  _con.paymentStatsUpdate(_Type,widget.payment.invoiceID,id);
                   Navigator.pop(context);
                   },
                 padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                 color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                 shape: StadiumBorder(),
                 child: Text(
                   'Update',
                   style: Theme.of(context).textTheme.headline6.merge(
                       TextStyle(
                           color: Theme.of(context)
                               .primaryColorLight)),
                 ),
               ),
              ),
            ],
          ),
    ),
        ),

      ],
    );
  }
}
