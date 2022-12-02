import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/selected_plan.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../generated/l10n.dart';

import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/repository/settings_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

// ignore: must_be_immutable
class PaymentPage extends StatefulWidget {
  SelectedPlan selectedPlan;
  PaymentPage({Key key, this.selectedPlan}) : super(key: key);
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends StateMVC<PaymentPage> {
  String vendorKey;

  listenForPaymentStatus() {
    Timer.periodic(new Duration(seconds: 3), (timer) {
      _con.getPaymentStatus(widget.selectedPlan.key);
    });
  }

  UserController _con;
  _PaymentPageState() : super(UserController()) {
    _con = controller;
  }

  // ignore: deprecated_member_use
  List<bool> paymentSelect = List(8);
  int selectedRadio;
  int checkedItem = 0;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    //listenForPaymentStatus();

    for (int i = 0; i <= 7; i++) {
      paymentSelect[i] = false;
    }
  }

  setSelectedRadio(int val) {}

  selectPayment(id, paymentType) {
    //currentCheckout.value.payment.paymentType = paymentType;
    setState(() {
      for (int i = 0; i <= 7; i++) {
        if (id == i) {
          paymentSelect[i] = true;
        } else {
          paymentSelect[i] = false;
        }
      }
    });
    widget.selectedPlan.paymentGateway = paymentType;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: ClipRRect(
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
                          child: Column(children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.arrow_back,
                                          color: Theme.of(context)
                                              .primaryColorLight)),
                                  Expanded(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                        Container(
                                            child: Text(S.of(context).select_your_payment,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3
                                                    .merge(TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColorLight)))),
                                      ]))
                                ]),
                            SizedBox(height: 15),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Div(
                                        colS: 12,
                                        colM: 6,
                                        colL: 6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 20),
                                            setting.value.rayzorPay? Container(
                                              padding: EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 10),
                                              child: InkWell(
                                                onTap: () {
                                                  setSelectedRadio(2);
                                                  selectPayment(0, 'RayzorPay');
                                                },
                                                child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 10,
                                                        left: 10,
                                                        right: 10,
                                                        bottom: 10),
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .black12
                                                                .withOpacity(
                                                                    0.1),
                                                            blurRadius: 1.5,
                                                            spreadRadius: 1.5,
                                                          ),
                                                        ]),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                          child: Image(
                                                            image: AssetImage(
                                                                'assets/img/razorpay.png'),
                                                          ),
                                                        ),
                                                        SizedBox(width: 20),
                                                        Expanded(
                                                          child: Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    'RayzorPay',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headline1),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        paymentSelect[0] == true
                                                            ? Align(
                                                                child:
                                                                    Container(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                10),
                                                                        child:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () {},
                                                                          icon: Icon(
                                                                              Icons.check_circle,
                                                                              color: Colors.green),
                                                                        )),
                                                              )
                                                            : Container()
                                                      ],
                                                    )),
                                              ),
                                            ):Container(),
                                            setting.value.paypal?Container(
                                              padding: EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 10),
                                              child: InkWell(
                                                onTap: () {
                                                  setSelectedRadio(2);

                                                  selectPayment(2, 'Paypal');
                                                },
                                                child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 10,
                                                        left: 10,
                                                        right: 10,
                                                        bottom: 10),
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .black12
                                                                .withOpacity(
                                                                    0.1),
                                                            blurRadius: 1.5,
                                                            spreadRadius: 1.5,
                                                          ),
                                                        ]),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                          child: Image(
                                                            image: AssetImage(
                                                                'assets/img/paypal.png'),
                                                          ),
                                                        ),
                                                        SizedBox(width: 20),
                                                        Expanded(
                                                          child: Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text('Paypal',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headline1),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        paymentSelect[2] == true
                                                            ? Align(
                                                                child:
                                                                    Container(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                10),
                                                                        child:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () {},
                                                                          icon: Icon(
                                                                              Icons.check_circle,
                                                                              color: Colors.green),
                                                                        )),
                                                              )
                                                            : Container()
                                                      ],
                                                    )),
                                              ),
                                            ):Container(),
                                            setting.value.stripe?Container(
                                              padding: EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 10),
                                              child: InkWell(
                                                onTap: () {
                                                  setSelectedRadio(2);
                                                  selectPayment(3, 'Stripe');
                                                },
                                                child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 10,
                                                        left: 10,
                                                        right: 10,
                                                        bottom: 10),
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .black12
                                                                .withOpacity(
                                                                    0.1),
                                                            blurRadius: 1.5,
                                                            spreadRadius: 1.5,
                                                          ),
                                                        ]),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                          child: Image(
                                                            image: AssetImage(
                                                                'assets/img/stripe.png'),
                                                          ),
                                                        ),
                                                        SizedBox(width: 20),
                                                        Expanded(
                                                          child: Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(S.of(context).stripe,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headline1),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        paymentSelect[3] == true
                                                            ? Align(
                                                                child:
                                                                    Container(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                10),
                                                                        child:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () {},
                                                                          icon: Icon(
                                                                              Icons.check_circle,
                                                                              color: Colors.green),
                                                                        )),
                                                              )
                                                            : Container()
                                                      ],
                                                    )),
                                              ),
                                            ):Container(),
                                            setting.value.flutterWave? Container(
                                              padding: EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 10),
                                              child: InkWell(
                                                onTap: () {
                                                  setSelectedRadio(2);

                                                  selectPayment(
                                                      4, 'Flutterwave');
                                                },
                                                child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 10,
                                                        left: 10,
                                                        right: 10,
                                                        bottom: 10),
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .black12
                                                                .withOpacity(
                                                                    0.1),
                                                            blurRadius: 1.5,
                                                            spreadRadius: 1.5,
                                                          ),
                                                        ]),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                          child: Image(
                                                            image: AssetImage(
                                                                'assets/img/flutterwave.png'),
                                                          ),
                                                        ),
                                                        SizedBox(width: 20),
                                                        Expanded(
                                                          child: Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    'Flutterwave',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headline1),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        paymentSelect[4] == true
                                                            ? Align(
                                                                child:
                                                                    Container(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                10),
                                                                        child:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () {},
                                                                          icon: Icon(
                                                                              Icons.check_circle,
                                                                              color: Colors.green),
                                                                        )),
                                                              )
                                                            : Container()
                                                      ],
                                                    )),
                                              ),
                                            ):Container(),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 10),
                                              child: InkWell(
                                                onTap: () {
                                                  setSelectedRadio(2);

                                                  selectPayment(5, 'Offline');
                                                },
                                                child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 10,
                                                        left: 10,
                                                        right: 10,
                                                        bottom: 10),
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .black12
                                                                .withOpacity(
                                                                    0.1),
                                                            blurRadius: 1.5,
                                                            spreadRadius: 1.5,
                                                          ),
                                                        ]),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                          child: Image(
                                                            image: AssetImage(
                                                                'assets/img/logo.png'),
                                                          ),
                                                        ),
                                                        SizedBox(width: 20),
                                                        Expanded(
                                                          child: Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    'Offline (mode)',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headline1),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        paymentSelect[5] == true
                                                            ? Align(
                                                                child:
                                                                    Container(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                10),
                                                                        child:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () {},
                                                                          icon: Icon(
                                                                              Icons.check_circle,
                                                                              color: Colors.green),
                                                                        )),
                                                              )
                                                            : Container()
                                                      ],
                                                    )),
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                width: double.infinity,
                                                margin: EdgeInsets.only(
                                                    left: 30, right: 30),
                                                height: 46.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                // ignore: deprecated_member_use
                                                child: FlatButton(
                                                  onPressed: () {
                                                    if (currentUser.value
                                                            .profileComplete ==
                                                        '5') {
                                                      widget.selectedPlan
                                                              .passingType =
                                                          'upgrade';
                                                    } else {
                                                      widget.selectedPlan
                                                          .passingType = 'new';
                                                    }

                                                    if (widget.selectedPlan
                                                            .paymentGateway ==
                                                        'Flutterwave') {
                                                      widget.selectedPlan
                                                          .key = currentUser
                                                              .value.id +
                                                          '' +
                                                          DateTime.now()
                                                              .millisecondsSinceEpoch
                                                              .toString();
                                                      //Navigator.push(context, MaterialPageRoute(builder:(context)=>PaypalPayment()));
                                                      widget.selectedPlan
                                                              .token =
                                                          currentUser
                                                              .value.apiToken;
                                                      widget.selectedPlan
                                                              .paymentType =
                                                          'online';
                                                      _launchflutterwav(
                                                          json.encode(widget
                                                              .selectedPlan));
                                                    } else if (widget
                                                            .selectedPlan
                                                            .paymentGateway ==
                                                        'Paypal') {
                                                      widget.selectedPlan
                                                          .key = currentUser
                                                              .value.id +
                                                          '' +
                                                          DateTime.now()
                                                              .millisecondsSinceEpoch
                                                              .toString();
                                                      //Navigator.push(context, MaterialPageRoute(builder:(context)=>PaypalPayment()));
                                                      widget.selectedPlan
                                                              .token =
                                                          currentUser
                                                              .value.apiToken;
                                                      widget.selectedPlan
                                                              .paymentType =
                                                          'online';
                                                      _launchURL(json.encode(
                                                          widget.selectedPlan));
                                                    } else if (widget
                                                            .selectedPlan
                                                            .paymentGateway ==
                                                        'Stripe') {
                                                      widget.selectedPlan
                                                          .key = currentUser
                                                              .value.id +
                                                          '' +
                                                          DateTime.now()
                                                              .millisecondsSinceEpoch
                                                              .toString();
                                                      //Navigator.push(context, MaterialPageRoute(builder:(context)=>PaypalPayment()));
                                                      widget.selectedPlan
                                                              .token =
                                                          currentUser
                                                              .value.apiToken;
                                                      widget.selectedPlan
                                                              .paymentType =
                                                          'online';
                                                      _launchStripe(json.encode(
                                                          widget.selectedPlan));
                                                    } else if (widget
                                                            .selectedPlan
                                                            .paymentGateway ==
                                                        'RayzorPay') {
                                                      widget.selectedPlan
                                                          .key = currentUser
                                                              .value.id +
                                                          '' +
                                                          DateTime.now()
                                                              .millisecondsSinceEpoch
                                                              .toString();
                                                      //Navigator.push(context, MaterialPageRoute(builder:(context)=>PaypalPayment()));
                                                      widget.selectedPlan
                                                              .token =
                                                          currentUser
                                                              .value.apiToken;
                                                      widget.selectedPlan
                                                              .paymentType =
                                                          'online';
                                                      _launchRazorpay(
                                                          json.encode(widget
                                                              .selectedPlan));
                                                    } else if (widget
                                                            .selectedPlan
                                                            .paymentGateway ==
                                                        'Offline') {
                                                      widget.selectedPlan
                                                          .key = currentUser
                                                              .value.id +
                                                          '' +
                                                          DateTime.now()
                                                              .millisecondsSinceEpoch
                                                              .toString();

                                                      widget.selectedPlan
                                                              .token =
                                                          currentUser
                                                              .value.apiToken;
                                                      widget.selectedPlan
                                                              .paymentType =
                                                          'offline';
                                                      _con.upDatePlans(
                                                          widget.selectedPlan);
                                                    } else {
                                                      showToast(
                                                          "Select Your Payment Methode",
                                                          gravity: Toast.BOTTOM,
                                                          duration: Toast
                                                              .LENGTH_LONG);
                                                    }
                                                  },
                                                  child: Center(
                                                      child: Text(
                                                    S.of(context).next,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline3
                                                        .merge(TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorLight)),
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ])))))),
    );
  }

  Future<void> _launchflutterwav(formValue) async {
    Map<String, dynamic> _queryParams = {};
    Uri _url = Helper.getUri(
        'flutterwave/vendorRegister/${currentUser.value.id}/100/');
    _queryParams['api_token'] = formValue;
    _url = _url.replace(queryParameters: _queryParams);
    await canLaunch(_url.toString())
        ? await launch(_url.toString())
        : throw 'Could not launch $_url';
    listenForPaymentStatus();
  }

  Future<void> _launchStripe(formValue) async {
    Map<String, dynamic> _queryParams = {};
    Uri _url =
        Helper.getUri('stripe/vendorRegister/${currentUser.value.id}/100/');
    _queryParams['api_token'] = formValue;
    _url = _url.replace(queryParameters: _queryParams);
    await canLaunch(_url.toString())
        ? await launch(_url.toString())
        : throw 'Could not launch $_url';
    listenForPaymentStatus();
  }

  Future<void> _launchRazorpay(formValue) async {
    Map<String, dynamic> _queryParams = {};
    Uri _url =
        Helper.getUri('razorpay/vendorRegister/${currentUser.value.id}/100/');
    _queryParams['api_token'] = formValue;
    _url = _url.replace(queryParameters: _queryParams);
    await canLaunch(_url.toString())
        ? await launch(_url.toString())
        : throw 'Could not launch $_url';
    listenForPaymentStatus();
  }

  void _launchURL(formValue) async {
    Map<String, dynamic> _queryParams = {};
    Uri _url =
        Helper.getUri('paypal/vendorRegister/${currentUser.value.id}/100/');
    _queryParams['api_token'] = formValue;
    _url = _url.replace(queryParameters: _queryParams);
    await canLaunch(_url.toString())
        ? await launch(_url.toString())
        : throw 'Could not launch $_url';
    listenForPaymentStatus();
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(
      msg,
      context,
      duration: duration,
      gravity: gravity,
    );
  }
}
