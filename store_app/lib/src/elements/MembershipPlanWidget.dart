import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/components/constants.dart';
import 'package:login_and_signup_web/src/components/custom_divider_view.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/vendor_membership.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/pages/Payment.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vrouter/vrouter.dart';

class MembershipPlan extends StatefulWidget {
  const MembershipPlan({Key key}) : super(key: key);

  @override
  _MembershipPlanState createState() => _MembershipPlanState();
}

class _MembershipPlanState extends StateMVC<MembershipPlan> {
  UserController _con;
  _MembershipPlanState() : super(UserController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listenForMembership(currentUser.value.focusID);
    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
                padding: EdgeInsets.only(
                    top: 30,
                    bottom: 30,
                    left: size.width > 769 ? 30 : 10,
                    right: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black26,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    S.of(context).select_your_plan,
                                    style: size.width > 769
                                        ? Theme.of(context)
                                            .textTheme
                                            .headline4
                                            .merge(TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight))
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .merge(TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight)),
                                  ),
                                  SizedBox(width: 20),
                                  IconButton(
                                    onPressed: () {
                                      logout().then((value) {
                                        // ignore: deprecated_member_use
                                        VRouter.of(context).pushReplacement('/login');
                                      });
                                    },
                                    icon: Icon(Icons.power_settings_new_sharp,
                                        color: Theme.of(context)
                                            .primaryColorLight),
                                  )
                                ],
                              )),
                              SizedBox(height: 20),
                              _con.vendorMembershipList.isEmpty
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          top: size.width > 769
                                              ? size.height * 0.3
                                              : 0.2),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                child: Text(S.of(context).loading,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline3
                                                        .merge(TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorLight))))
                                          ]),
                                    )
                                  : Container(),
                              Wrap(
                                  runSpacing: 10,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: List.generate(
                                      _con.vendorMembershipList.length,
                                      (index) {
                                    VendorMembershipModel _vendorMembership =
                                        _con.vendorMembershipList
                                            .elementAt(index);
                                    return _vendorMembership.id == 'not_found'
                                        ? Text(S.of(context).no_plan_found,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3
                                                .merge(TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColorLight)))
                                        : Container(
                                            width: size.width > 769
                                                ? size.width * 0.2
                                                : double.infinity,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 5.0,
                                                    spreadRadius: 1.0,
                                                  ),
                                                ]),
                                            margin: EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                top: 10.0,
                                                bottom: 10),
                                            child: Column(children: [
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 20,
                                                                left: 20,
                                                                right: 20),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              width: 60,
                                                              height: 60,
                                                              child: ClipRRect(
                                                                  //borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  child: Image(
                                                                    image: AssetImage(
                                                                        'assets/img/bgimage.png'),
                                                                    width: 70,
                                                                    height: 70,
                                                                    fit: BoxFit
                                                                        .fitHeight,
                                                                  )),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                  child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          _vendorMembership
                                                                              .planname,
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .headline1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          maxLines:
                                                                              2,
                                                                        ),
                                                                        RichText(
                                                                          text: new TextSpan(
                                                                              text: Helper.pricePrint(''),
                                                                              style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(
                                                                                    color: Color(0xFF8c98a8).withOpacity(1.0),
                                                                                  )),
                                                                              children: [
                                                                                TextSpan(text: _vendorMembership.price, style: Theme.of(context).textTheme.headline4),
                                                                                TextSpan(
                                                                                    text: ' /user',
                                                                                    style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(
                                                                                          color: Color(0xFF8c98a8).withOpacity(1.0),
                                                                                        )))
                                                                              ]),
                                                                        )
                                                                      ])),
                                                            ),
                                                          ],
                                                        )),
                                                    SizedBox(height: 20),
                                                    CustomDividerView(
                                                        dividerHeight: 1),
                                                    Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10,
                                                                left: 20,
                                                                right: 20),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.check),
                                                            SizedBox(width: 10),
                                                            Expanded(
                                                              child: Container(
                                                                child: RichText(
                                                                  text: new TextSpan(
                                                                      text: S.of(context).commision,
                                                                      style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(
                                                                            color:
                                                                                Color(0xFF8c98a8).withOpacity(1.0),
                                                                          )),
                                                                      children: [
                                                                        TextSpan(
                                                                            text:
                                                                                '% ${_vendorMembership.price}',
                                                                            style:
                                                                                Theme.of(context).textTheme.subtitle2.merge(TextStyle(color: Colors.black))),
                                                                      ]),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                    Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10,
                                                                left: 20,
                                                                right: 20),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.check),
                                                            SizedBox(width: 10),
                                                            Expanded(
                                                              child: Container(
                                                                child: RichText(
                                                                  text: new TextSpan(
                                                                      text: S.of(context).total_product_upload,
                                                                      style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(
                                                                            color:
                                                                                Color(0xFF8c98a8).withOpacity(1.0),
                                                                          )),
                                                                      children: [
                                                                        TextSpan(
                                                                            text:
                                                                                _vendorMembership.productlimit,
                                                                            style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color: Colors.black))),
                                                                      ]),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                    Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10,
                                                                bottom: 20,
                                                                left: 20,
                                                                right: 20),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.check),
                                                            SizedBox(width: 10),
                                                            Expanded(
                                                              child: Container(
                                                                child: RichText(
                                                                  text: new TextSpan(
                                                                      text:
                                                                      S.of(context).validity,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .subtitle2
                                                                          .merge(
                                                                              TextStyle(color: Colors.black)),
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              ' ${_vendorMembership.validity}',
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .subtitle2
                                                                              .merge(TextStyle(
                                                                                color: Color(0xFF8c98a8).withOpacity(1.0),
                                                                              )),
                                                                        ),
                                                                      ]),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: 10,
                                                          bottom: 20,
                                                          left: 20,
                                                          right: 20),
                                                      child: InkWell(
                                                        onTap: () {
                                                          _con.selectedPlan
                                                                  .paymentType =
                                                              'offline';
                                                          _con.selectedPlan
                                                                  .paymentStatus =
                                                              'success';
                                                          _con.selectedPlan
                                                                  .planId =
                                                              _vendorMembership
                                                                  .id;
                                                          _con.selectedPlan
                                                                  .vendorId =
                                                              currentUser
                                                                  .value.id;
                                                          if (_vendorMembership
                                                                  .price !=
                                                              '0') {
                                                            PaymentGatewayHelper
                                                                .exit(context,
                                                                    _con.selectedPlan);
                                                          } else {
                                                            _con.selectedPlan
                                                                    .token =
                                                                currentUser
                                                                    .value
                                                                    .apiToken;
                                                            _con.selectedPlan
                                                                    .paymentType =
                                                                'office';
                                                            _con.upDatePlans(_con
                                                                .selectedPlan);
                                                          }
                                                        },
                                                        child: Container(
                                                          height: 47,
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                kPrimaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  25),
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: kPrimaryColor
                                                                    .withOpacity(
                                                                        0.2),
                                                                spreadRadius: 4,
                                                                blurRadius: 7,
                                                                offset: Offset(
                                                                    0, 3),
                                                              ),
                                                            ],
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              S.of(context).choose_plan,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ])
                                            ]),
                                          );
                                  })),
                              /*Wrap(

                                          runSpacing: 10,
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children:[
                                            Container(
                                              width:MediaQuery.of(context).size.width * 0.2,
                                              decoration: BoxDecoration(
                                                  color:Theme.of(context).primaryColor,
                                                  borderRadius: BorderRadius.circular(15.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 5.0,
                                                      spreadRadius: 1.0,
                                                    ),
                                                  ]),
                                              margin: EdgeInsets.only(left:15,right:15, top: 10.0,bottom:10),

                                              child:Column(
                                                  children:[


                                                    Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children:[
                                                          Container(
                                                              padding:EdgeInsets.only(top:20,left:20,right:20),
                                                              child:Row(
                                                                children: [
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(10)
                                                                    ),
                                                                    width:60,height:60,
                                                                    child:ClipRRect(
                                                                      //borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        child:Image(image:AssetImage('assets/img/bgimage.png'),
                                                                          width: 70,height:70,fit: BoxFit.fitHeight,
                                                                        )),
                                                                  ),
                                                                  Container(
                                                                      padding: EdgeInsets.only(left:10,right:10),
                                                                      child:Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children:[
                                                                            Text('Basic',
                                                                                style:Theme.of(context).textTheme.headline1
                                                                            ),
                                                                            RichText(
                                                                              text: new TextSpan(text: '\$',
                                                                                  style: Theme.of(context).textTheme.subtitle2
                                                                                      .merge(TextStyle(color: Color(0xFF8c98a8).withOpacity(1.0),)),
                                                                                  children: [
                                                                                    TextSpan(
                                                                                        text: ' 24',
                                                                                        style: Theme.of(context).textTheme.headline4
                                                                                    ),
                                                                                    TextSpan(
                                                                                        text: ' /user',
                                                                                        style: Theme.of(context).textTheme.subtitle2
                                                                                            .merge(TextStyle(color: Color(0xFF8c98a8).withOpacity(1.0),))
                                                                                    )
                                                                                  ]),
                                                                            )
                                                                          ]
                                                                      )
                                                                  ),


                                                                ],
                                                              )
                                                          ),
                                                          SizedBox(height:20),
                                                          CustomDividerView(dividerHeight:1),
                                                          Container(
                                                              padding:EdgeInsets.only(top:10,left:20,right:20),
                                                              child:Row(
                                                                children: [
                                                                  Icon(Icons.check),
                                                                  SizedBox(width:10),
                                                                  Container(

                                                                    child:RichText(
                                                                      text: new TextSpan(text: 'Get started with ',
                                                                          style: Theme.of(context).textTheme.subtitle2
                                                                              .merge(TextStyle(color: Color(0xFF8c98a8).withOpacity(1.0),)),
                                                                          children: [
                                                                            TextSpan(
                                                                                text: ' messaging',
                                                                                style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Colors.black))
                                                                            ),

                                                                          ]),
                                                                    ),
                                                                  ),

                                                                ],
                                                              )
                                                          ),
                                                          Container(
                                                              padding:EdgeInsets.only(top:10,left:20,right:20),
                                                              child:Row(
                                                                children: [
                                                                  Icon(Icons.check),
                                                                  SizedBox(width:10),
                                                                  Container(

                                                                    child:RichText(
                                                                      text: new TextSpan(text: 'Flexible',
                                                                          style: Theme.of(context).textTheme.subtitle2
                                                                              .merge(TextStyle(color: Color(0xFF8c98a8).withOpacity(1.0),)),
                                                                          children: [
                                                                            TextSpan(
                                                                                text: ' team meetings',
                                                                                style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Colors.black))
                                                                            ),

                                                                          ]),
                                                                    ),
                                                                  ),

                                                                ],
                                                              )
                                                          ),

                                                          Container(
                                                              padding:EdgeInsets.only(top:10,bottom:20,left:20,right:20),
                                                              child:Row(
                                                                children: [
                                                                  Icon(Icons.check),
                                                                  SizedBox(width:10),
                                                                  Container(

                                                                    child:RichText(
                                                                      text: new TextSpan(text: '5TB',
                                                                          style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Colors.black)),
                                                                          children: [
                                                                            TextSpan(
                                                                              text: ' cloud storage',

                                                                              style: Theme.of(context).textTheme.subtitle2
                                                                                  .merge(TextStyle(color: Color(0xFF8c98a8).withOpacity(1.0),)),
                                                                            ),

                                                                          ]),
                                                                    ),
                                                                  ),

                                                                ],
                                                              )
                                                          ),
                                                          Container(
                                                            padding:EdgeInsets.only(top:10,bottom:20,left:20,right:20),
                                                            child:InkWell(
                                                              onTap: () {


                                                              },
                                                              child: Container(
                                                                height: 47,
                                                                width: double.infinity,
                                                                decoration: BoxDecoration(
                                                                  color: kPrimaryColor,
                                                                  borderRadius: BorderRadius.all(
                                                                    Radius.circular(25),
                                                                  ),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: kPrimaryColor.withOpacity(0.2),
                                                                      spreadRadius: 4,
                                                                      blurRadius: 7,
                                                                      offset: Offset(0, 3),
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    'Choose Plan',
                                                                    style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 18,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),),





                                                        ]
                                                    )
                                                  ]
                                              ),
                                            ),
                                            /*Container(
                                              width:MediaQuery.of(context).size.width * 0.2,
                                              decoration: BoxDecoration(
                                                  color:Colors.black,
                                                  borderRadius: BorderRadius.circular(15.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 5.0,
                                                      spreadRadius: 1.0,
                                                    ),
                                                  ]),
                                              margin: EdgeInsets.only(left:15,right:15, top: 10.0,bottom:10),

                                              child:Column(
                                                  children:[
                                                    /*Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 100,
                                      margin: EdgeInsets.only(right:20,top:10),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(25),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: kPrimaryColor.withOpacity(0.2),
                                            spreadRadius: 4,
                                            blurRadius: 7,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'POPULAR',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),*/


                                                    Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children:[
                                                          Container(
                                                              padding:EdgeInsets.only(top:20,left:20,right:20),
                                                              child:Row(
                                                                children: [
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(10)
                                                                    ),
                                                                    width:60,height:60,
                                                                    child:ClipRRect(
                                                                      //borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        child:Image(image:AssetImage('assets/img/bgimage.png'),
                                                                          width: 70,height:70,fit: BoxFit.fitHeight,
                                                                        )),
                                                                  ),
                                                                  Container(
                                                                      padding: EdgeInsets.only(left:10,right:10),
                                                                      child:Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children:[
                                                                            Text('Startup',
                                                                                style:Theme.of(context).textTheme.headline1.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                                                                            ),
                                                                            RichText(
                                                                              text: new TextSpan(text: '\$',
                                                                                  style: Theme.of(context).textTheme.subtitle2
                                                                                      .merge(TextStyle(color:Theme.of(context).primaryColorLight.withOpacity(0.7),)),
                                                                                  children: [
                                                                                    TextSpan(
                                                                                        text: ' 24',
                                                                                        style: Theme.of(context).textTheme.headline4.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                                                                                    ),
                                                                                    TextSpan(
                                                                                        text: ' /user',
                                                                                        style: Theme.of(context).textTheme.subtitle2
                                                                                            .merge(TextStyle(color: Color(0xFF8c98a8).withOpacity(1.0),))
                                                                                    )
                                                                                  ]),
                                                                            )
                                                                          ]
                                                                      )
                                                                  ),


                                                                ],
                                                              )
                                                          ),
                                                          SizedBox(height:20),
                                                          CustomDividerView(dividerHeight:1),
                                                          Container(
                                                              padding:EdgeInsets.only(top:10,left:20,right:20),
                                                              child:Row(
                                                                children: [
                                                                  Icon(Icons.check,color:Theme.of(context).primaryColorLight),
                                                                  SizedBox(width:10),
                                                                  Container(

                                                                    child:RichText(
                                                                      text: new TextSpan(text: 'All features in ',
                                                                          style: Theme.of(context).textTheme.subtitle2
                                                                              .merge(TextStyle(color: Color(0xFF8c98a8).withOpacity(1.0),)),
                                                                          children: [
                                                                            TextSpan(
                                                                                text: ' basic',
                                                                                style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                                                                            ),

                                                                          ]),
                                                                    ),
                                                                  ),

                                                                ],
                                                              )
                                                          ),
                                                          Container(
                                                              padding:EdgeInsets.only(top:10,left:20,right:20),
                                                              child:Row(
                                                                children: [
                                                                  Icon(Icons.check,color:Theme.of(context).primaryColorLight),
                                                                  SizedBox(width:10),
                                                                  Container(

                                                                    child:RichText(
                                                                      text: new TextSpan(text: 'Flexible',
                                                                          style: Theme.of(context).textTheme.subtitle2
                                                                              .merge(TextStyle(color: Color(0xFF8c98a8).withOpacity(1.0),)),
                                                                          children: [
                                                                            TextSpan(
                                                                                text: ' call scheduling',
                                                                                style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                                                                            ),

                                                                          ]),
                                                                    ),
                                                                  ),

                                                                ],
                                                              )
                                                          ),

                                                          Container(
                                                              padding:EdgeInsets.only(top:10,bottom:20,left:20,right:20),
                                                              child:Row(
                                                                children: [
                                                                  Icon(Icons.check,color:Theme.of(context).primaryColorLight),
                                                                  SizedBox(width:10),
                                                                  Container(

                                                                    child:RichText(
                                                                      text: new TextSpan(text: '15TB',
                                                                          style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).primaryColorLight)),
                                                                          children: [
                                                                            TextSpan(
                                                                              text: ' cloud storage',
                                                                              style: Theme.of(context).textTheme.subtitle2
                                                                                  .merge(TextStyle(color: Color(0xFF8c98a8).withOpacity(1.0),)),

                                                                            ),

                                                                          ]),
                                                                    ),
                                                                  ),

                                                                ],
                                                              )
                                                          ),
                                                          Container(
                                                            padding:EdgeInsets.only(top:10,bottom:20,left:20,right:20),
                                                            child:InkWell(
                                                              onTap: () {


                                                              },
                                                              child: Container(
                                                                height: 47,
                                                                width: double.infinity,
                                                                decoration: BoxDecoration(
                                                                  color: kPrimaryColor,
                                                                  borderRadius: BorderRadius.all(
                                                                    Radius.circular(25),
                                                                  ),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: kPrimaryColor.withOpacity(0.2),
                                                                      spreadRadius: 4,
                                                                      blurRadius: 7,
                                                                      offset: Offset(0, 3),
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    'Choose Plan',
                                                                    style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 18,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),),





                                                        ]
                                                    )
                                                  ]
                                              ),
                                            ),*/
                                            /*Container(
                                              width:MediaQuery.of(context).size.width * 0.2,
                                              decoration: BoxDecoration(
                                                  color:Theme.of(context).primaryColor,
                                                  borderRadius: BorderRadius.circular(15.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 5.0,
                                                      spreadRadius: 1.0,
                                                    ),
                                                  ]),
                                              margin: EdgeInsets.only(left:15,right:15, top: 10.0,bottom:10),

                                              child:Column(
                                                  children:[


                                                    Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children:[
                                                          Container(
                                                              padding:EdgeInsets.only(top:20,left:20,right:20),
                                                              child:Row(
                                                                children: [
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(10)
                                                                    ),
                                                                    width:60,height:60,
                                                                    child:ClipRRect(
                                                                      //borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        child:Image(image:AssetImage('assets/img/bgimage.png'),
                                                                          width: 70,height:70,fit: BoxFit.fitHeight,
                                                                        )),
                                                                  ),
                                                                  Container(
                                                                      padding: EdgeInsets.only(left:10,right:10),
                                                                      child:Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children:[
                                                                            Text('Basic',
                                                                                style:Theme.of(context).textTheme.headline1
                                                                            ),
                                                                            RichText(
                                                                              text: new TextSpan(text: '\$',
                                                                                  style: Theme.of(context).textTheme.subtitle2
                                                                                      .merge(TextStyle(color: Color(0xFF8c98a8).withOpacity(1.0),)),
                                                                                  children: [
                                                                                    TextSpan(
                                                                                        text: ' 24',
                                                                                        style: Theme.of(context).textTheme.headline4
                                                                                    ),
                                                                                    TextSpan(
                                                                                        text: ' /user',
                                                                                        style: Theme.of(context).textTheme.subtitle2
                                                                                            .merge(TextStyle(color: Color(0xFF8c98a8).withOpacity(1.0),))
                                                                                    )
                                                                                  ]),
                                                                            )
                                                                          ]
                                                                      )
                                                                  ),


                                                                ],
                                                              )
                                                          ),
                                                          SizedBox(height:20),
                                                          CustomDividerView(dividerHeight:1),
                                                          Container(
                                                              padding:EdgeInsets.only(top:10,left:20,right:20),
                                                              child:Row(
                                                                children: [
                                                                  Icon(Icons.check),
                                                                  SizedBox(width:10),
                                                                  Container(

                                                                    child:RichText(
                                                                      text: new TextSpan(text: 'Get started with ',
                                                                          style: Theme.of(context).textTheme.subtitle2
                                                                              .merge(TextStyle(color: Color(0xFF8c98a8).withOpacity(1.0),)),
                                                                          children: [
                                                                            TextSpan(
                                                                                text: ' messaging',
                                                                                style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Colors.black))
                                                                            ),

                                                                          ]),
                                                                    ),
                                                                  ),

                                                                ],
                                                              )
                                                          ),
                                                          Container(
                                                              padding:EdgeInsets.only(top:10,left:20,right:20),
                                                              child:Row(
                                                                children: [
                                                                  Icon(Icons.check),
                                                                  SizedBox(width:10),
                                                                  Container(

                                                                    child:RichText(
                                                                      text: new TextSpan(text: 'Flexible',
                                                                          style: Theme.of(context).textTheme.subtitle2
                                                                              .merge(TextStyle(color: Color(0xFF8c98a8).withOpacity(1.0),)),
                                                                          children: [
                                                                            TextSpan(
                                                                                text: ' team meetings',
                                                                                style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Colors.black))
                                                                            ),

                                                                          ]),
                                                                    ),
                                                                  ),

                                                                ],
                                                              )
                                                          ),

                                                          Container(
                                                              padding:EdgeInsets.only(top:10,bottom:20,left:20,right:20),
                                                              child:Row(
                                                                children: [
                                                                  Icon(Icons.check),
                                                                  SizedBox(width:10),
                                                                  Container(

                                                                    child:RichText(
                                                                      text: new TextSpan(text: '5TB',
                                                                          style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Colors.black)),
                                                                          children: [
                                                                            TextSpan(
                                                                              text: ' cloud storage',

                                                                              style: Theme.of(context).textTheme.subtitle2
                                                                                  .merge(TextStyle(color: Color(0xFF8c98a8).withOpacity(1.0),)),
                                                                            ),

                                                                          ]),
                                                                    ),
                                                                  ),

                                                                ],
                                                              )
                                                          ),
                                                          Container(
                                                            padding:EdgeInsets.only(top:10,bottom:20,left:20,right:20),
                                                            child:InkWell(
                                                              onTap: () {


                                                              },
                                                              child: Container(
                                                                height: 47,
                                                                width: double.infinity,
                                                                decoration: BoxDecoration(
                                                                  color: kPrimaryColor,
                                                                  borderRadius: BorderRadius.all(
                                                                    Radius.circular(25),
                                                                  ),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: kPrimaryColor.withOpacity(0.2),
                                                                      spreadRadius: 4,
                                                                      blurRadius: 7,
                                                                      offset: Offset(0, 3),
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    'Choose Plan',
                                                                    style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 18,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),),





                                                        ]
                                                    )
                                                  ]
                                              ),
                                            ),*/


                                          ]),*/
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ))));
  }
}

class PaymentGatewayHelper {
  static exit(context, selectedPlan) => showDialog(
      context: context,
      builder: (context) => PaymentPage(
            selectedPlan: selectedPlan,
          ));
}
