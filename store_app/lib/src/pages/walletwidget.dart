
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/components/light_color.dart';
import 'package:login_and_signup_web/src/controllers/wallet_controller.dart';
import 'package:login_and_signup_web/src/elements/DailpadPopupWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class WalletWidget extends StatefulWidget {
  @override
  _WalletWidgetState createState() => _WalletWidgetState();
}

class _WalletWidgetState extends StateMVC<WalletWidget>
    with SingleTickerProviderStateMixin {
  WalletController _con;

  _WalletWidgetState() : super(WalletController()) {
    _con = controller;
  }

  int touchedIndex;

  @override
  void initState() {
    super.initState();

    _con.listenForWallet();
    _con.listenForWalletBanner();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scrollbar(
        isAlwaysShown: true,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Responsive(children: [
              Div(
                colS: 12,
                colM: 12,
                colL: 12,
                child: Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 35.0, bottom: 10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Wrap(
                            children: [
                              Div(
                                colS: 12,
                                colM: 12,
                                colL: 8,
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(
                                      top: 20, bottom: 20, right: 25, left: 25),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(15.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 20.0,
                                          spreadRadius: 5.0,
                                        ),
                                      ]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Expanded(
                                          child: Text(
                                              S.of(context).main_account,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption),
                                        ),
                                        SizedBox(width: 20),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                              S.of(context).total_earned,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption),
                                        )
                                      ]),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                  SizedBox(height: 10),
                                                  Text(_con.walletBannerData
                                                      .bankName??'',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1
                                                          .merge(TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700))),
                                                  Wrap(children: [

                                                    Text(_con.walletBannerData
                                                        .bankAccountNumber??'',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption),
                                                    SizedBox(width: 3),
                                                    Icon(Icons.arrow_forward,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary)
                                                  ]),
                                                ])),
                                          ),
                                          SizedBox(width: 20),
                                          Container(
                                            padding: EdgeInsets.only(top: 20),
                                            child: RichText(
                                              text: new TextSpan(
                                                  text: Helper.pricePrint(_con
                                                      .walletBannerData
                                                      .totalWalletBalance),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4,
                                                  children: [
                                                    new TextSpan(
                                                        text: '',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1)
                                                  ]),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),

                                      /* Wrap(
                                       children:[
                                         InkWell(
                                           onTap: () {
                                           //  MapPopupHelper.exit(context);

                                           },
                                           child: Container(
                                             height:35,
                                             width:140,
                                             padding: EdgeInsets.all(7),
                                             decoration: BoxDecoration(
                                               color: Theme.of(context).colorScheme.secondary,
                                               borderRadius: BorderRadius.all(
                                                 Radius.circular(10),
                                               ),
                                             ),
                                             child: Center(
                                               child: Text(
                                                   'Transfer money',
                                                   style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                                               ),
                                             ),
                                           ),
                                         ),
                                         SizedBox(width: 20),
                                         InkWell(
                                           onTap: () {},
                                           child: Container(
                                             height:35,
                                             width:140,
                                             padding: EdgeInsets.all(7),
                                             decoration: BoxDecoration(
                                               color: Theme.of(context).disabledColor.withOpacity(0.4),
                                               borderRadius: BorderRadius.all(
                                                 Radius.circular(10),
                                               ),
                                             ),
                                             child: Center(
                                               child: Text(
                                                   'Link accounts',
                                                   style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                                               ),
                                             ),
                                           ),
                                         ),

                                       ]
                                     ) */
                                    ],
                                  ),
                                ),
                              ),
                              Div(
                                  colS: 12,
                                  colM: 12,
                                  colL: 4,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 15),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.245,
                                          color: LightColor.navyBlue1,
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: <Widget>[
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                      S
                                                          .of(context)
                                                          .total_balance,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle2
                                                          .merge(TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorLight))),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                          Helper.pricePrint(_con
                                                              .walletBannerData
                                                              .totalWalletBalance),
                                                          style: TextStyle(
                                                              fontSize: 35,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              color: LightColor
                                                                  .yellow2)),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  _con.walletBannerData
                                                              .totalWalletBalance !=
                                                          null
                                                      ? InkWell(
                                                          onTap: () {
                                                            DailpadPopupHelper.exit(
                                                                context,
                                                                _con.walletBannerData
                                                                    .totalWalletBalance,
                                                                _con);
                                                          },
                                                          child: Container(
                                                              width:
                                                                  size.width >
                                                                          769
                                                                      ? 105
                                                                      : 130,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          5,
                                                                      vertical:
                                                                          5),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              12)),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .white,
                                                                      width: 1)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                      S.of(context).withdraw,
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                ],
                                                              )))
                                                      : Container(),
                                                ],
                                              ),
                                              Positioned(
                                                left: -170,
                                                top: -170,
                                                child: CircleAvatar(
                                                  radius: 130,
                                                  backgroundColor:
                                                      LightColor.lightBlue2,
                                                ),
                                              ),
                                              Positioned(
                                                left: -160,
                                                top: -190,
                                                child: CircleAvatar(
                                                  radius: 130,
                                                  backgroundColor:
                                                      LightColor.lightBlue1,
                                                ),
                                              ),
                                              Positioned(
                                                right: -170,
                                                bottom: -170,
                                                child: CircleAvatar(
                                                  radius: 130,
                                                  backgroundColor:
                                                      LightColor.yellow2,
                                                ),
                                              ),
                                              Positioned(
                                                right: -160,
                                                bottom: -190,
                                                child: CircleAvatar(
                                                  radius: 130,
                                                  backgroundColor:
                                                      LightColor.yellow,
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                  ))
                            ],
                          )),
                          SizedBox(
                            height: 20,
                          ),
                          Wrap(children: [
                            Div(
                              colS: 12,
                              colM: 12,
                              colL: 3,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ProjectProgressCard(
                                        color: Color(0xffFF4C60),
                                        projectName:
                                            S.of(context).requested_amount,
                                        percentComplete: '34%',
                                        progressIndicatorColor:
                                            Colors.redAccent[100],
                                        icon: Feather.box,
                                        amount: _con
                                            .walletBannerData.requestedCount
                                            .toString(),
                                        count: _con
                                            .walletBannerData.requestedAmount
                                            .toString(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Div(
                              colS: 12,
                              colM: 12,
                              colL: 3,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ProjectProgressCard(
                                        color: Color(0xff6C6CE5),
                                        projectName:
                                            S.of(context).collected_cash,
                                        percentComplete: '78%',
                                        progressIndicatorColor:
                                            Colors.blue[200],
                                        icon: Feather.loader,
                                        amount: '0',
                                        count: '0',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Div(
                              colS: 12,
                              colM: 12,
                              colL: 3,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ProjectProgressCard(
                                        color: Color(0xffFF4C60),
                                        projectName:
                                            S.of(context).total_withdraw,
                                        percentComplete: '34%',
                                        progressIndicatorColor:
                                            Colors.redAccent[100],
                                        icon: Icons.two_wheeler_outlined,
                                        amount: _con
                                            .walletBannerData.totalWithdraw
                                            .toString(),
                                        count: _con.walletBannerData
                                            .totalWithdrawAmount
                                            .toString(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Div(
                              colS: 12,
                              colM: 12,
                              colL: 3,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ProjectProgressCard(
                                        color: Color(0xffFAAA1E),
                                        projectName: S.of(context).total_orders,
                                        percentComplete: 'order',
                                        progressIndicatorColor:
                                            Colors.amber[200],
                                        icon: Icons.wifi_tethering,
                                        amount: _con
                                            .walletBannerData.totalOrderAmount
                                            .toString(),
                                        count: _con
                                            .walletBannerData.totalOrderCount
                                            .toString(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                          Container(
                              margin: EdgeInsets.only(
                                  top: 20, left: 20, right: 20, bottom: 30),
                              child:Container(
                                width:double.infinity,
                                  child: SingleChildScrollView(
                                    scrollDirection: size.width > 769 ? Axis.vertical : Axis.horizontal,
                                    child: SingleChildScrollView(
                                        child: (_con.walletList.length == 0)
                                            ? Center(
                                          child: EmptyOrdersWidget(),
                                        )
                                            : DataTable(
                                            columns: [
                                              DataColumn(
                                                label: Text('S.No'),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                    S.of(context).amount),
                                              ),
                                              DataColumn(
                                                label: Text( S.of(context).status),
                                              ),
                                              DataColumn(
                                                label: Text(S
                                                    .of(context)
                                                    .requested_date),
                                              ),
                                              DataColumn(
                                                label: Text(S
                                                    .of(context)
                                                    .processed_date),
                                              ),
                                              DataColumn(
                                                label:
                                                Text(S.of(context).notes),
                                              ),
                                            ],
                                            rows: List.generate(
                                                _con.walletList.length,
                                                    (index) {
                                                  return DataRow(cells: [
                                                    DataCell(Text(
                                                        (index + 1).toString() ??
                                                            ' ')),
                                                    //DataCell(Text(_con.walletList[index].id??' ')),
                                                    DataCell(Text(Helper.pricePrint(
                                                        _con.walletList[index]
                                                            .amount ??
                                                            ' '))),

                                                    DataCell(Row(
                                                      children: [
                                                        Container(
                                                            width: 60,
                                                            height: 25,
                                                            // ignore: deprecated_member_use
                                                            child: FlatButton(
                                                                onPressed: () {
                                                                  //AddCategoryHelper.exit(context,_con,_con.taxList[index], 'edit');
                                                                },
                                                                color: _con
                                                                    .walletList[
                                                                index]
                                                                    .status ==
                                                                    'request'
                                                                    ? Colors.orange
                                                                    : _con.walletList[index].status ==
                                                                    'under process'
                                                                    ? Colors
                                                                    .yellow
                                                                    : Colors
                                                                    .green,
                                                                shape:
                                                                StadiumBorder(),
                                                                child: Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                      8.0),
                                                                  child: Text(
                                                                    _con
                                                                        .walletList[
                                                                    index]
                                                                        .status,
                                                                    style: Theme.of(
                                                                        context)
                                                                        .textTheme
                                                                        .caption
                                                                        .merge(TextStyle(
                                                                        color: Theme.of(context)
                                                                            .primaryColorLight)),
                                                                  ),
                                                                ))),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                      ],
                                                    )),
                                                    DataCell(Text(_con
                                                        .walletList[index]
                                                        .reqDate ??
                                                        ' ')),
                                                    DataCell(Text(_con
                                                        .walletList[index]
                                                        .processDate ??
                                                        ' ')),
                                                    DataCell(Text(_con
                                                        .walletList[index]
                                                        .notes ??
                                                        ' ')),
                                                  ]);
                                                }))),
                                  ))
                              ),

                        ],
                      ),
                    )),
              ),
            ])
            // SideCard(),
          ],
        ));
  }
}

class ProjectProgressCard extends StatefulWidget {
  final Color color;
  final Color progressIndicatorColor;
  final String projectName;
  final String percentComplete;
  final IconData icon;
  final String amount;
  final String count;

  ProjectProgressCard({
    this.color,
    this.progressIndicatorColor,
    this.percentComplete,
    this.projectName,
    this.icon,
    this.amount,
    this.count,
  });

  @override
  _ProjectProgressCardState createState() => _ProjectProgressCardState();
}

class _ProjectProgressCardState extends State<ProjectProgressCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: MouseRegion(
        onEnter: (value) {
          setState(() {
            hovered = true;
          });
        },
        onExit: (value) {
          setState(() {
            hovered = false;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 275),
          width: 200,
          padding: EdgeInsets.only(top: 20, bottom: 20, right: 18, left: 18),
          decoration: BoxDecoration(
              color: hovered ? widget.color : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20.0,
                  spreadRadius: 5.0,
                ),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(
                            widget.projectName,
                            style: hovered
                                ? Theme.of(context).textTheme.bodyText1.merge(
                                    TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context)
                                            .primaryColorLight))
                                : Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .merge(TextStyle(
                                      fontWeight: FontWeight.w700,
                                    )),
                            /*style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: hovered ? Colors.white : Colors.black,
                      ),*/
                          ),
                          Text(
                            widget.amount,
                            style: hovered
                                ? Theme.of(context).textTheme.caption.merge(
                                    TextStyle(
                                        color: Theme.of(context)
                                            .primaryColorLight))
                                : Theme.of(context).textTheme.caption,
                          )
                        ])),
                  ),
                  Container(
                    height: 30.0,
                    width: 30.0,
                    child: Icon(
                      widget.icon,
                      color: !hovered ? Colors.grey : Colors.grey,
                      size: 16.0,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: hovered
                            ? Theme.of(context).scaffoldBackgroundColor
                            : Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(children: [
                Expanded(
                  child: RichText(
                    text: new TextSpan(
                      text:widget.percentComplete=='order'?widget.count:Helper.pricePrint(widget.count),
                      style: hovered
                          ? Theme.of(context).textTheme.bodyText1.merge(
                              TextStyle(
                                  color: Theme.of(context).primaryColorLight))
                          : Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        child: Icon(Icons.more_vert,
                            color: Theme.of(context).disabledColor)))
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class DailpadPopupHelper {
  static exit(context, balance, con) => showDialog(
      context: context,
      builder: (context) => DailpadPopup(
            balance: balance,
          )).then((value) => {
        con.listenForWallet(),
        con.listenForWalletBanner(),
      });
}
