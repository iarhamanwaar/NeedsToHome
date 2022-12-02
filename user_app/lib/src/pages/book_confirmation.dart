import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/controllers/hservice_controller.dart';
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/pages/payment_page.dart';
import 'package:multisuperstore/src/repository/hservice_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repository/order_repository.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';

class BookConfirmation extends StatefulWidget {
  @override
  _BookConfirmationState createState() => _BookConfirmationState();
}

class _BookConfirmationState extends StateMVC<BookConfirmation> {

  HServiceController _con;

  _BookConfirmationState() : super(HServiceController()) {
    _con = controller;
  }

  @override
  void initState() {
    if( currentBookDetail.value.paymentType=='' ||  currentBookDetail.value.paymentType==null){
      currentBookDetail.value.paymentType = 'online';
      currentBookDetail.value.paymentMethod = 'COD';
      print('no payment type selected');
    }
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color:Theme.of(context).primaryColorDark
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 27.0, left: 10.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 20.0),
                  Text(S.of(context).booking_confirmation,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4.merge(TextStyle(color: Theme.of(context).colorScheme.primary))
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.88,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text(
                                    '\$4',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w900, color: Colors.transparent),
                                  ),
                                  Text(S.of(context).price_hr, textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0, color: Colors.transparent)),
                                ]),
                                Expanded(
                                    child: Column(
                                      children: [
                                        new Container(
                                          width: 110.0,
                                          height: 110.0,
                                          child: Card(
                                            child: new CircleAvatar(
                                              backgroundImage: new NetworkImage(currentBookDetail.value.providerImage),
                                              radius: 80.0,
                                            ),
                                            elevation: 2.0,
                                            shape: CircleBorder(),
                                            clipBehavior: Clip.antiAlias,
                                          ),
                                        ),
                                      ],
                                    )),
                                Column(children: [
                                  Text(
                                      '${Helper.pricePrint(currentBookDetail.value.chargeperhrs)}/${currentBookDetail.value.type}',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.subtitle1
                                  ),

                                ]),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      currentBookDetail.value.providerName,
                                      style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontWeight: FontWeight.w700)),
                                    ),
                                    Text(
                                      currentBookDetail.value.providerMobile,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:[

                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[
                                          Text(
                                            S.of(context).booking_services,
                                            style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontWeight: FontWeight.w800)),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            '${currentBookDetail.value.service} - ${currentBookDetail.value.subcategoryName}',
                                            style: Theme.of(context).textTheme.subtitle2,
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Text(
                                            S.of(context).date,
                                            style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontWeight: FontWeight.w800)),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            currentBookDetail.value.date,
                                            style: Theme.of(context).textTheme.subtitle2,
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Text(
                                            S.of(context).time,
                                            style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontWeight: FontWeight.w800)),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            currentBookDetail.value.time,
                                            style: Theme.of(context).textTheme.subtitle2,
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Text(
                                            S.of(context).confirm_address,
                                            style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontWeight: FontWeight.w800)),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Container(
                                            width:size.width * 0.7,
                                            child:Text(
                                              currentBookDetail.value.address,
                                              style: Theme.of(context).textTheme.subtitle2,
                                            ),
                                          ),

                                          SizedBox(
                                            height: 20.0,
                                          ),

                                        ]
                                    )
                                  ]
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),

            currentBookDetail.value.type=='Fixed'?    Container(
              color:Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(S.of(context).bill_details, style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color:Colors.red))),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(S.of(context).item_total, style: Theme.of(context).textTheme.subtitle2),
                      Text(Helper.pricePrint( currentBookDetail.value.chargeperhrs), style: Theme.of(context).textTheme.subtitle2),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(S.of(context).tax, style: TextStyle(color: Colors.blue)),
                                Text('${Helper.pricePrint(setting.value.handyTax)}',
                                    style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color: Colors.blue))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),


                  Container(
                    alignment: Alignment.center,
                    height: 60.0,
                    child: Row(
                      children: <Widget>[
                        Text(
                          S.of(context).to_pay,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Spacer(),
                        Text(
                          _con.grantTotal(double.parse( currentBookDetail.value.chargeperhrs)),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ):Container(),
    currentBookDetail.value.type!='Fixed'? Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {},
                child: Container(
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 60.0,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                          // ignore: deprecated_member_use
                          child: FlatButton(
                            onPressed: () {

                              _con.book_firebase();
                            },
                            child: Center(
                                child: Text(
                                  S.of(context).book,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    )),
              ),
            ):

            Container(

                alignment:Alignment.bottomCenter,

                decoration:BoxDecoration(
                  color:Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.2),
                      blurRadius: 1,
                      spreadRadius: 0.3,
                    ),
                  ],
            ),
                child:Wrap(
                    alignment: WrapAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          margin:EdgeInsets.only(top:10),
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Container(
                            padding: EdgeInsets.only(top:5,right:10,left:10,bottom:10),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              InkWell(
                                onTap:() async {
                                 await Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentPages()));
                                  setState(() {
                                    currentUser.value;
                                  });
                                 currentBookDetail.value.paymentType = currentUser.value.paymentType;
                                 currentBookDetail.value.paymentMethod = currentCheckout.value.payment.method;
                                },
                                child:Column(
                                    children:[
                                      Container(
                                          child:Wrap(
                                              children:[
                                                Container(
                                                    width: 30,height:30,
                                                    child:Image.asset( currentUser.value.paymentImage)
                                                ),
                                                Container(
                                                    padding: EdgeInsets.only(left:7,bottom:8),
                                                    child:Text(S.of(context).pay_using,)
                                                ),
                                                Icon(
                                                    Icons.arrow_drop_up
                                                )

                                              ]
                                          )
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left:30),
                                        child:Text(
                                          _con.grantTotal(double.parse( currentBookDetail.value.chargeperhrs)),
                                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ]
                                ),

                              ),

                            ]),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                       //   _con.gotoPayment();


                          _con.paymentGate(currentBookDetail.value.grandTotal);
                        },
                        child: Container(
                            margin:EdgeInsets.only(top:10),
                            width: MediaQuery.of(context).size.width * 0.6,
                            height:65,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(6)
                            ),
                            child: Column(

                                children:[

                                  Container(
                                    padding:EdgeInsets.only(top:8,left:10,right:5),
                                    child: Text( _con.grantTotal(double.parse( currentBookDetail.value.chargeperhrs)), style: Theme.of(context).textTheme.headline1.merge(TextStyle(color:Theme.of(context).primaryColorLight))),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top:9,right:12,left:12,),
                                    child: Text(
                                      S.of(context).place_order,
                                      style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: Theme.of(context).primaryColorLight)),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ])
                        ),
                      ),
                    ])
            ),
          ],
        ),
      ),
    );
  }
}
