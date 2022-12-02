import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
class PaymentGateway extends StatefulWidget {
  @override
  _PaymentGatewayState createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends StateMVC<PaymentGateway> {
  UserController _con;
  _PaymentGatewayState() : super(UserController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listenForPaymentGate();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Theme.of(context).primaryColor.withOpacity(0.6),
      child: Form(
        key: _con.generalFormKey,
        child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Div(
                  colS: 12,
                  colM: 12,
                  colL: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(left: 30.0, top: 25.0, right: 30, bottom: 10.0),
                        child:Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children:[
                              Div(
                                  colS:12,
                                  colM:12,
                                  colL:12,
                                  child:Wrap(
                                      children:[
                                        Text(
                                          S.of(context).manage_payment_gateway,
                                          style: Theme.of(context).textTheme.headline4,
                                        ),
                                        SizedBox(width:10),



                                      ]
                                  )
                              ),


                            ]
                        ),
                       ),

                      _con.loaderData? Wrap(
                       runSpacing: 10,
                       children:[
                         Div(
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
                                                     value:  _con.paymentGateData.rayzorPay,
                                                     onChanged: (value){
                                                       setState(() {
                                                         _con.paymentGateData.rayzorPay = value;
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
                                                   onSaved: (input) => _con.paymentGateData.rayzorPaySK = input,
                                                   initialValue: _con.paymentGateData.rayzorPaySK,

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
                         ),
                         Div(
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
                                                   child:Image(image:AssetImage('assets/img/upilogo.png'),
                                                       height:40
                                                   )
                                               ),
                                               Container(
                                                 width:65,
                                                 child: GestureDetector(
                                                   onTap: () {},
                                                   child: Switch(
                                                     value:   _con.paymentGateData.upiID,
                                                     onChanged: (value){
                                                       setState(() {
                                                         _con.paymentGateData.upiID = value;
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

                                                   initialValue: _con.paymentGateData.upiId,
                                                   onSaved: (input) => _con.paymentGateData.upiId = input,
                                                   decoration: InputDecoration(
                                                     labelText: 'UPI ID',
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
                         ),
                         Div(
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
                                                   child:Image(image:AssetImage('assets/img/paypal2.png'),
                                                       height:40
                                                   )
                                               ),
                                               Container(
                                                 width:65,
                                                 child: GestureDetector(
                                                   onTap: () {},
                                                   child: Switch(
                                                     value:  _con.paymentGateData.paypal,
                                                     onChanged: (value){
                                                       setState(() {
                                                         _con.paymentGateData.paypal = value;
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
                                                   initialValue: _con.paymentGateData.paypalClientID,
                                                   onSaved: (input) => _con.paymentGateData.paypalClientID = input,



                                                   decoration: InputDecoration(
                                                     labelText: 'Client ID',
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
                         ),
                         Div(
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
                                                   child:Image(image:AssetImage('assets/img/flutterwave.png'),
                                                       height:40
                                                   )
                                               ),
                                               Container(
                                                 width:65,
                                                 child: GestureDetector(
                                                   onTap: () {},
                                                   child: Switch(
                                                     value:  _con.paymentGateData.flutterWay,
                                                     onChanged: (value){
                                                       setState(() {
                                                         _con.paymentGateData.flutterWay = value;
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
                                                   onSaved: (input) => _con.paymentGateData.fwpbfPublickey = input,

                                                   initialValue: _con.paymentGateData.fwpbfPublickey,
                                                   decoration: InputDecoration(
                                                     labelText: 'PBF PublicKey',
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
                         ),
                         Div(
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
                                                   child:Image(image:AssetImage('assets/img/stripelogo.png'),
                                                       height:40
                                                   )
                                               ),
                                               Container(
                                                 width:65,
                                                 child: GestureDetector(
                                                   onTap: () {},
                                                   child: Switch(
                                                     value: _con.paymentGateData.stripe,
                                                     onChanged: (value){
                                                       setState(() {
                                                         _con.paymentGateData.stripe = value;
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

                                                   onSaved: (input) => _con.paymentGateData.stripePK = input,
                                                   initialValue: _con.paymentGateData.stripePK,
                                                   decoration: InputDecoration(
                                                     labelText: 'Publishable key',
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
                                           padding: EdgeInsets.only(top:10,left:10,right:10),
                                           child: Container(
                                               width: double.infinity,

                                               child: TextFormField(
                                                   textAlign: TextAlign.left,
                                                   autocorrect: true,
                                                   keyboardType: TextInputType.text,

                                                   onSaved: (input) => _con.paymentGateData.stripeSK = input,
                                                   initialValue: _con.paymentGateData.stripeSK,
                                                   decoration: InputDecoration(
                                                     labelText: 'Secret key',
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
                         ),
                         Div(
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
                                                   child:Image(image:AssetImage('assets/img/Paystack_Logo.png'),
                                                       height:20
                                                   )
                                               ),
                                               Container(
                                                 width:65,
                                                 child: GestureDetector(
                                                   onTap: () {},
                                                   child: Switch(
                                                     value: _con.paymentGateData.payStack,
                                                     onChanged: (value){
                                                       setState(() {
                                                         _con.paymentGateData.payStack = value;
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

                                                   onSaved: (input) => _con.paymentGateData.payStackPK = input,
                                                   initialValue: _con.paymentGateData.payStackPK,
                                                   decoration: InputDecoration(
                                                     labelText: 'Publishable key',
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
                                           padding: EdgeInsets.only(top:10,left:10,right:10),
                                           child: Container(
                                               width: double.infinity,

                                               child: TextFormField(
                                                   textAlign: TextAlign.left,
                                                   autocorrect: true,
                                                   keyboardType: TextInputType.text,

                                                   onSaved: (input) => _con.paymentGateData.payStackSK = input,
                                                   initialValue: _con.paymentGateData.payStackSK,
                                                   decoration: InputDecoration(
                                                     labelText: 'Secret key',
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
                         ),
                         Div(
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
                                                   child:Image(image:AssetImage('assets/img/mpesa.png'),
                                                       height:40
                                                   )
                                               ),
                                               Container(
                                                 width:65,
                                                 child: GestureDetector(
                                                   onTap: () {},
                                                   child: Switch(
                                                     value: _con.paymentGateData.mpesa,
                                                     onChanged: (value){
                                                       setState(() {
                                                         _con.paymentGateData.mpesa = value;
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

                                                   onSaved: (input) => _con.paymentGateData.mpesaConsumerKey = input,
                                                   initialValue: _con.paymentGateData.mpesaConsumerKey,
                                                   decoration: InputDecoration(
                                                     labelText: 'Consumer Key',
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
                                           padding: EdgeInsets.only(top:10,left:10,right:10),
                                           child: Container(
                                               width: double.infinity,

                                               child: TextFormField(
                                                   textAlign: TextAlign.left,
                                                   autocorrect: true,
                                                   keyboardType: TextInputType.text,

                                                   onSaved: (input) => _con.paymentGateData.mpesaConsumerSecret = input,
                                                   initialValue: _con.paymentGateData.mpesaConsumerSecret,
                                                   decoration: InputDecoration(
                                                     labelText: 'Consumer Secret',
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
                                           padding: EdgeInsets.only(top:10,left:10,right:10),
                                           child: Container(
                                               width: double.infinity,

                                               child: TextFormField(
                                                   textAlign: TextAlign.left,
                                                   autocorrect: true,
                                                   keyboardType: TextInputType.text,

                                                   onSaved: (input) => _con.paymentGateData.mpesaPasskey = input,
                                                   initialValue: _con.paymentGateData.mpesaPasskey,
                                                   decoration: InputDecoration(
                                                     labelText: 'Keypass',
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
                         ),

                         Padding(
                                 padding: EdgeInsets.only(top:30,left:20,right:20),
                                 child:Container(

                                       padding:EdgeInsets.only(left:20),
                                       child: Container(
                                         height: 45.0,
                                         width: 250,
                                         decoration: BoxDecoration(
                                           color: Theme.of(context).colorScheme.secondary,
                                           borderRadius: BorderRadius.circular(30),
                                           /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                                         ),
                                         // ignore: deprecated_member_use
                                         child: FlatButton(
                                           onPressed: () {

                                              _con.paymentGatewayDetailsUpdate();
                                           },
                                           child: Center(
                                               child: Wrap(
                                                   alignment: WrapAlignment.spaceBetween,
                                                   crossAxisAlignment: WrapCrossAlignment.center,
                                                   children:[
                                                     Text(S.of(context).update,
                                                       style: TextStyle(
                                                         fontSize: 15.0,
                                                         color: Theme.of(context).primaryColorLight,
                                                         fontWeight: FontWeight.w600,
                                                       ),
                                                     ),
                                                     SizedBox(width:10),

                                                   ])),
                                         ),
                                       ),
                                     )),
                         SizedBox(height: 50,)

                       ]
                     ):EmptyOrdersWidget()



                    ],
                  )),


            ],
          ),
        ),
      ),
    );
  }

}



















