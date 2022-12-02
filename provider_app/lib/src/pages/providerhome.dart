import 'package:custom_switch/custom_switch.dart';
import 'package:handy/generated/l10n.dart';
import '../elements/HandyServiceStatus.dart';
import '/src/controllers/home_controller.dart';
import '/src/helpers/helper.dart';
import '/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

void main() {
  runApp(new MaterialApp(home: new ProviderHome()));
}

class ProviderHome extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  ProviderHome({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _ProviderHomeState createState() => _ProviderHomeState();
}

class _ProviderHomeState extends StateMVC<ProviderHome> {
  bool isSwitched = false;

  bool status = false;
  HomeController _con;
  _ProviderHomeState() : super(HomeController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.getDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
        key: _con.scaffoldKey,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: new IconButton(
            icon: new Icon(Icons.sort, color: Colors.black),
            onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
          ),
          actions: [
            Container(
              height: 16,
              padding: EdgeInsets.only(top: 10, bottom: 10, right: 15),
              child: AspectRatio(
                aspectRatio: 2.09,
                child: CustomSwitch(
                  activeColor: Colors.black,
                  value: currentUser.value.liveStatus,
                  onChanged: (value) {
                    _con.updateStatus(value);
                  },
                ),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(children: [
                            Container(
                              padding: EdgeInsets.only(top: 40, bottom: 15),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                        height: 250,
                                        width: double.infinity,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Theme.of(context)
                                                      .disabledColor
                                                      .withOpacity(0.05),
                                                  blurRadius: 1)
                                            ],
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/img/cardbg1.jpeg'),
                                                fit: BoxFit.fill)),
                                        child: Stack(children: [
                                          Positioned(
                                            top: 43,
                                            right: size.width < 769
                                                ? size.width * 0.15
                                                : size.width * 0.01,
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                          child: Text(
                                                        Helper.pricePrint(_con
                                                            .dashboardData
                                                            .todayEarn),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline4
                                                            .merge(TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColorLight)),
                                                      )),
                                                      Container(
                                                          child: Text(
                                                        S.of(context).today_earn,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline4
                                                            .merge(TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColorLight)),
                                                      )),
                                                    ])),
                                          ),
                                          Positioned(
                                              bottom: 45,
                                              right: size.width < 769
                                                  ? size.width * 0.05
                                                  : size.width * 0.02,
                                              left: size.width < 769
                                                  ? size.width * 0.05
                                                  : size.width * 0.02,
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                                child: Text(
                                                              Helper.pricePrint(_con
                                                                  .dashboardData
                                                                  .lastSDaysEarn),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle2
                                                                  .merge(TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColorLight)),
                                                            )),
                                                            Container(
                                                                child: Text(
                                                              S
                                                                  .of(context)
                                                                  .last_7_days,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .caption
                                                                  .merge(TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColorLight)),
                                                            )),
                                                          ]),
                                                    ),
                                                    Container(
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                                child: Text(
                                                              Helper.pricePrint(_con
                                                                  .dashboardData
                                                                  .thisMonthEarn),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle2
                                                                  .merge(TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColorLight)),
                                                            )),
                                                            Container(
                                                                child: Text(
                                                              S
                                                                  .of(context)
                                                                  .this_month,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .caption
                                                                  .merge(TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColorLight)),
                                                            )),
                                                          ]),
                                                    ),
                                                    Container(
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                                child: Text(
                                                              Helper.pricePrint(_con
                                                                  .dashboardData
                                                                  .totalEarn),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle2
                                                                  .merge(TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColorLight)),
                                                            )),
                                                            Container(
                                                                child: Text(
                                                              S
                                                                  .of(context)
                                                                  .total_earn,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .caption
                                                                  .merge(TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColorLight)),
                                                            )),
                                                          ]),
                                                    ),
                                                  ])),
                                        ])),
                                  ),
                                  Positioned(
                                      top: -29,
                                      left: 40,
                                      child: Container(
                                          child: Image(
                                        image: AssetImage(
                                            'assets/img/handyman.png'),
                                        width: 90,
                                        height: 170,
                                        fit: BoxFit.fitHeight,
                                      )))
                                ],
                              ),
                            ),
                            HandyServiceStatus(),
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                padding: EdgeInsets.only(
                                    left: 15, top: 15, right: 15, bottom: 15),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context)
                                            .disabledColor
                                            .withOpacity(0.05),
                                        blurRadius: 1)
                                  ],
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          child: Text(
                                        S.of(context).orders,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                      )),
                                      SizedBox(height: 10),
                                      Wrap(children: [
                                        Div(
                                            colS: 4,
                                            colM: 4,
                                            colL: 4,
                                            child: Container(
                                                height: 100,
                                                margin: EdgeInsets.only(
                                                    left: 5,
                                                    top: 5,
                                                    right: 5,
                                                    bottom: 5),
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    top: 10,
                                                    right: 10,
                                                    bottom: 10),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                            child: Text(
                                                          S
                                                              .of(context)
                                                              .total_orders,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText2
                                                              .merge(TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorLight)),
                                                        )),
                                                      ),
                                                      Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Container(
                                                                child: Text(
                                                              _con.dashboardData
                                                                  .todayOrders
                                                                  .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline1
                                                                  .merge(TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColorLight)),
                                                            )),
                                                          ])
                                                    ]))),
                                        Div(
                                            colS: 4,
                                            colM: 4,
                                            colL: 4,
                                            child: Container(
                                                height: 100,
                                                margin: EdgeInsets.only(
                                                    left: 5,
                                                    top: 5,
                                                    right: 5,
                                                    bottom: 5),
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    top: 10,
                                                    right: 10,
                                                    bottom: 10),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                            child: Text(
                                                          S
                                                              .of(context)
                                                              .this_month,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText2
                                                              .merge(TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorLight)),
                                                        )),
                                                      ),
                                                      Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Container(
                                                                child: Text(
                                                              _con.dashboardData
                                                                  .thisMonthOrders
                                                                  .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline1
                                                                  .merge(TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColorLight)),
                                                            )),
                                                          ])
                                                    ]))),
                                        Div(
                                            colS: 4,
                                            colM: 4,
                                            colL: 4,
                                            child: Container(
                                                height: 100,
                                                margin: EdgeInsets.only(
                                                    left: 5,
                                                    top: 5,
                                                    right: 5,
                                                    bottom: 5),
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    top: 10,
                                                    right: 10,
                                                    bottom: 10),
                                                decoration: BoxDecoration(
                                                  color: Colors.purple,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                            child: Text(
                                                          S
                                                              .of(context)
                                                              .total_orders,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText2
                                                              .merge(TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorLight)),
                                                        )),
                                                      ),
                                                      Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Container(
                                                                child: Text(
                                                              _con.dashboardData
                                                                  .totalOrders
                                                                  .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline1
                                                                  .merge(TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColorLight)),
                                                            )),
                                                          ])
                                                    ]))),
                                      ]),
                                    ])),
                            SizedBox(height: 10),
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, bottom: 20),
                                padding: EdgeInsets.only(
                                    left: 15, top: 20, right: 15, bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context)
                                            .disabledColor
                                            .withOpacity(0.05),
                                        blurRadius: 1)
                                  ],
                                ),
                                child: Wrap(children: [
                                  Div(
                                      colS: 6,
                                      colM: 6,
                                      colL: 6,
                                      child: Container(
                                          child: Container(
                                              width: size.width > 769
                                                  ? size.width * 0.5
                                                  : size.width * 0.4,
                                              height: size.width > 769
                                                  ? size.height * 0.2
                                                  : size.height * 0.13,
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/img/cash.png'),
                                                fit: BoxFit.fitHeight,
                                              )))),
                                  Div(
                                      colS: 6,
                                      colM: 6,
                                      colL: 6,
                                      child: Container(
                                          padding: EdgeInsets.only(
                                            top: 5,
                                          ),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    S
                                                        .of(context)
                                                        .cash_in_your_hand,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .merge(TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Text(
                                                    Helper.pricePrint(_con
                                                        .dashboardData
                                                        .cashInHand),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1
                                                        .merge(TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorLight)),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                /**  Container(
                                                        width: 100,
                                                        child:MaterialButton(
                                                          onPressed: () {},
                                                          color:Theme.of(context).accentColor,
                                                          shape: StadiumBorder(),
                                                          height: 30,
                                                          padding: EdgeInsets.zero,
                                                          child: Center(child:Container(
                                                              padding: EdgeInsets.only(left:10,right:10),
                                                              child:Text('Test Now',
                                                                  textAlign: TextAlign.center,
                                                                  style:TextStyle(fontFamily:'Touche W03 Regular',fontWeight: FontWeight.w100,color: Theme.of(context).primaryColorLight)
                                                              )
                                                          ),),

                                                        )
                                                    ) */
                                              ]))),
                                ])),
                          ]),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
