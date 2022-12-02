import 'package:badges/badges.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:products_deliveryboy/src/elements/EmptyOrdersWidget.dart';
import 'package:products_deliveryboy/src/helpers/helper.dart';
import 'package:products_deliveryboy/src/models/orderHistory.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../generated/l10n.dart';
import '../controllers/order_controller.dart';

class OrdersHistoryWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  OrdersHistoryWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _OrdersHistoryWidgetState createState() => _OrdersHistoryWidgetState();
}

class _OrdersHistoryWidgetState extends StateMVC<OrdersHistoryWidget> {
  OrderController _con;

  _OrdersHistoryWidgetState() : super(OrderController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForOrdersHistory();
    super.initState();
  }

  Future<Null> _refreshLocalGallery() async {
    print('refreshing stocks...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_outlined,
              color: Theme.of(context).hintColor),
          onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).orders_history,
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: _con.orders.isEmpty
          ? EmptyOrdersWidget()
          : RefreshIndicator(
              onRefresh: _refreshLocalGallery,
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 10),
                children: <Widget>[
                  ListView.builder(
                    itemCount: _con.orders.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      OrderHistoryModel _orderTrack =
                          _con.orders.elementAt(index);
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/OrderDetails',
                              arguments: _orderTrack.id);
                        },
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.topLeft,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 10, left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(0.05),
                                              offset: Offset(0, 5),
                                              blurRadius: 1)
                                        ],
                                        /*border: Border.all(
                              width: 1,
                              color:Theme.of(context).dividerColor,
                          ),*/

                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Wrap(children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 15,
                                                        right: 15,
                                                        top: 20),
                                                    child: Container(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      decoration:
                                                          new BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image:
                                                            new DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                              '${GlobalConfiguration().getValue('base_upload')}uploads/vendor_image/vendor_${_orderTrack.vendorId}.png'),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      padding: EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 35),
                                                      child: Image(
                                                          image: AssetImage(
                                                              'assets/img/processing.gif'),
                                                          width: 20,
                                                          height: 20)),
                                                ]),
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15,
                                                                right: 15,
                                                                top: 20),
                                                        child: Text(
                                                            ' #${_orderTrack.id}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline3),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                        ),
                                                        child: Text(
                                                            timeago.format(DateTime
                                                                .fromMillisecondsSinceEpoch(
                                                                    int.parse(_orderTrack.date) *
                                                                        1000)),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .caption
                                                                .merge(TextStyle(
                                                                    color: Theme.of(context)
                                                                        .primaryColorDark,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600))),
                                                      ),
                                                    ]),
                                              ],
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(
                                                    left: 15,
                                                    right: 15,
                                                    top: 10),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                  child: Text(
                                                                _orderTrack
                                                                    .shopName,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline3
                                                                    .merge(TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w400)),
                                                              )),
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 15,
                                                                      right: 10,
                                                                      top: 0),
                                                              child: Badge(
                                                                toAnimate:
                                                                    false,
                                                                shape:
                                                                    BadgeShape
                                                                        .square,
                                                                badgeColor: _orderTrack
                                                                            .status ==
                                                                        'Delivered'
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .deepOrange,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                badgeContent:
                                                                    Text(
                                                                  _orderTrack
                                                                      .status,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .caption
                                                                      .merge(TextStyle(
                                                                          color: Theme.of(context)
                                                                              .primaryColorLight,
                                                                          height:
                                                                              1.2)),
                                                                ),
                                                              ),
                                                            ),
                                                          ]),
                                                      Container(
                                                          child: Text(
                                                              _orderTrack
                                                                  .shopAddress,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .caption)),
                                                    ])),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  bottom: 10,
                                                  right: 15,
                                                  top: 5),
                                              child: Wrap(children: [
                                                Div(
                                                    colS: 12,
                                                    colM: 12,
                                                    colL: 12,
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Colors.red,
                                                              border:
                                                                  Border.all(
                                                                width: 3,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColorLight,
                                                              ),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  spreadRadius:
                                                                      2,
                                                                  blurRadius:
                                                                      10,
                                                                  offset: Offset(
                                                                      0,
                                                                      3), // changes position of shadow
                                                                ),
                                                              ],
                                                            ),
                                                            child: Icon(
                                                                Icons.circle,
                                                                color: Theme.of(
                                                                        context)
                                                                    .disabledColor
                                                                    .withOpacity(
                                                                        0.1),
                                                                size: 15),
                                                          ),
                                                          Expanded(
                                                              child: DottedLine(
                                                            direction:
                                                                Axis.horizontal,
                                                            lineLength:
                                                                double.infinity,
                                                            lineThickness: 1.0,
                                                            dashLength: 4.0,
                                                            dashColor:
                                                                Colors.grey,
                                                            dashRadius: 0.0,
                                                            dashGapLength: 4.0,
                                                            dashGapColor: Colors
                                                                .transparent,
                                                            dashGapRadius: 0.0,
                                                          )),
                                                          Container(
                                                            child: Icon(
                                                                Icons
                                                                    .delivery_dining,
                                                                color: Theme.of(
                                                                        context)
                                                                    .disabledColor,
                                                                size: 29),
                                                          ),
                                                          Expanded(
                                                              child: DottedLine(
                                                            direction:
                                                                Axis.horizontal,
                                                            lineLength:
                                                                double.infinity,
                                                            lineThickness: 1.0,
                                                            dashLength: 4.0,
                                                            dashColor:
                                                                Colors.grey,
                                                            dashRadius: 0.0,
                                                            dashGapLength: 4.0,
                                                            dashGapColor: Colors
                                                                .transparent,
                                                            dashGapRadius: 0.0,
                                                          )),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorDark,
                                                              border:
                                                                  Border.all(
                                                                width: 3,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColorLight,
                                                              ),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  spreadRadius:
                                                                      2,
                                                                  blurRadius:
                                                                      10,
                                                                  offset: Offset(
                                                                      0,
                                                                      3), // changes position of shadow
                                                                ),
                                                              ],
                                                            ),
                                                            child: Icon(
                                                                Icons.circle,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColorDark,
                                                                size: 15),
                                                          ),
                                                        ])),
                                              ]),
                                            ),
                                            Container(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Wrap(children: [
                                                  Div(
                                                    colS: 6,
                                                    colM: 6,
                                                    colL: 6,
                                                    child: Container(
                                                        width: double.infinity,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15,
                                                                bottom: 20,
                                                                right: 10),
                                                        child: Wrap(children: [
                                                          RichText(
                                                            text: new TextSpan(
                                                                text: Helper
                                                                    .pricePrint(
                                                                        _orderTrack
                                                                            .amount),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline2
                                                                    .merge(TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                                children: []),
                                                          )
                                                        ])),
                                                  ),
                                                  Div(
                                                    colS: 6,
                                                    colM: 6,
                                                    colL: 6,
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                                '/OrderDetails',
                                                                arguments:
                                                                    _orderTrack
                                                                        .id);
                                                      },
                                                      child: Container(
                                                          width:
                                                              double.infinity,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  bottom: 20,
                                                                  right: 15),
                                                          child: Text(
                                                            S
                                                                .of(context)
                                                                .view_details,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle2
                                                                .merge(TextStyle(
                                                                    color: Colors
                                                                        .orange)),
                                                          )),
                                                    ),
                                                  )
                                                ])),
                                          ]),
                                    ),
                                  ),

                                  /* Positioned.fill(
                              left: -10,
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                      margin: EdgeInsets.only(top: 30, left: 1),
                                      child: Image(image: AssetImage('assets/img/waiting.png'), fit: BoxFit.fitWidth, width: 110, height: 40))),
                            ),*/
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
