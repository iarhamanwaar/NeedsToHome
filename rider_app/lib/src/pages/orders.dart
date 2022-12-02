import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:products_deliveryboy/src/controllers/order_details_controller.dart';
import 'package:products_deliveryboy/src/elements/EmptyOrdersWidget.dart';
import 'package:products_deliveryboy/src/repository/user_repository.dart';
import 'package:responsive_ui/responsive_ui.dart';
import '../../generated/l10n.dart';
import 'package:timeago/timeago.dart' as timeago;

class OrdersWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  OrdersWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends StateMVC<OrdersWidget> {
  OrderDetailsController _con;
  bool loader = true;
  int currentState;

  _OrdersWidgetState() : super(OrderDetailsController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();

    currentState = _con.getDeliveryStatus(_con.orderData.delivery_state);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).processing_orders,
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
        /**    actions: <Widget>[
            new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
            ], */
      ),
      body: RefreshIndicator(
        onRefresh: _con.refreshOrders,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 10),
          children: <Widget>[
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("orderDetails")
                    .where("driverId", isEqualTo: currentUser.value.id)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError || snapshot.data == null) {
                    return EmptyOrdersWidget();
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      reverse: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot course = snapshot.data.docs[index];

                        return course['status'] == 'Shipped' ||
                                course['status'] == 'RShipped'
                            ? Theme(
                                data: theme,
                                child: InkWell(
                                  onTap: () {
                                    if (course['driverStatus'] != 'Waiting') {
                                      Navigator.of(context).pushNamed(
                                          '/OrderDetails',
                                          arguments: course['orderId']);
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "Please accept this order first",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 5,
                                      );
                                    }
                                  },
                                  child: Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Stack(
                                          clipBehavior: Clip.none,
                                          alignment: Alignment.topLeft,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 10,
                                                    left: 10,
                                                    right: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
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

                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Wrap(children: [
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 15,
                                                                      right: 15,
                                                                      top: 20),
                                                              child: ClipOval(
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl:
                                                                      "${GlobalConfiguration().getValue('base_upload')}uploads/vendor_image/vendor_${course['shopId']}.png",
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      CircularProgressIndicator(),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Icon(Icons
                                                                          .error),
                                                                  height: 50,
                                                                  width: 50,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            course['driverStatus'] ==
                                                                        'Start' ||
                                                                    course['driverStatus'] ==
                                                                        'Pickuped'
                                                                ? Container(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            15,
                                                                        right:
                                                                            15,
                                                                        top:
                                                                            35),
                                                                    child: Image(
                                                                        image: AssetImage(
                                                                            'assets/img/processing.gif'),
                                                                        width:
                                                                            20,
                                                                        height:
                                                                            20),
                                                                  )
                                                                : Container(),
                                                          ]),
                                                          Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              15,
                                                                          right:
                                                                              15,
                                                                          top:
                                                                              20),
                                                                  child: Text(
                                                                      '#${course['orderId']}',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headline3),
                                                                ),
                                                                Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 15,
                                                                    right: 15,
                                                                  ),
                                                                  child: Text(
                                                                      timeago.format(DateTime.fromMillisecondsSinceEpoch(
                                                                          course[
                                                                              'DriverATime'])),
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .caption
                                                                          .merge(TextStyle(
                                                                              color: Theme.of(context).primaryColorDark,
                                                                              fontWeight: FontWeight.w600))),
                                                                ),
                                                              ]),
                                                        ],
                                                      ),
                                                      Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 15,
                                                                  right: 15,
                                                                  top: 10),
                                                          child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
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
                                                                          course[
                                                                              'shopName'],
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .headline3
                                                                              .merge(TextStyle(fontWeight: FontWeight.w400)),
                                                                        )),
                                                                      ),
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                15,
                                                                            right:
                                                                                0,
                                                                            top:
                                                                                0),
                                                                        child:
                                                                            Badge(
                                                                          toAnimate:
                                                                              false,
                                                                          shape:
                                                                              BadgeShape.square,
                                                                          badgeColor:
                                                                              Colors.deepPurple,
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                          badgeContent:
                                                                              Text(
                                                                            course['status'],
                                                                            style:
                                                                                Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColorLight, height: 1.2)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ]),
                                                                Container(
                                                                    child: Text(
                                                                        '${course['ShopAddress']}',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .caption)),
                                                                Container(
                                                                    child: Text(
                                                                  course[
                                                                      'driverStatus'],
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1
                                                                      .merge(TextStyle(
                                                                          fontFamily:
                                                                              'ProductSans-Thin')),
                                                                ))
                                                              ])),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
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
                                                                        color: Colors
                                                                            .red,
                                                                        border:
                                                                            Border.all(
                                                                          width:
                                                                              3,
                                                                          color:
                                                                              Theme.of(context).primaryColorLight,
                                                                        ),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.3),
                                                                            spreadRadius:
                                                                                2,
                                                                            blurRadius:
                                                                                10,
                                                                            offset:
                                                                                Offset(0, 3), // changes position of shadow
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child: Icon(
                                                                          Icons
                                                                              .circle,
                                                                          color: Theme.of(context)
                                                                              .disabledColor
                                                                              .withOpacity(0.1),
                                                                          size: 15),
                                                                    ),
                                                                    Expanded(
                                                                        child:
                                                                            DottedLine(
                                                                      direction:
                                                                          Axis.horizontal,
                                                                      lineLength:
                                                                          double
                                                                              .infinity,
                                                                      lineThickness:
                                                                          1.0,
                                                                      dashLength:
                                                                          4.0,
                                                                      dashColor:
                                                                          Colors
                                                                              .grey,
                                                                      dashRadius:
                                                                          0.0,
                                                                      dashGapLength:
                                                                          4.0,
                                                                      dashGapColor:
                                                                          Colors
                                                                              .transparent,
                                                                      dashGapRadius:
                                                                          0.0,
                                                                    )),
                                                                    Container(
                                                                      child: Icon(
                                                                          Icons
                                                                              .delivery_dining,
                                                                          color: Theme.of(context)
                                                                              .disabledColor,
                                                                          size:
                                                                              29),
                                                                    ),
                                                                    Expanded(
                                                                        child:
                                                                            DottedLine(
                                                                      direction:
                                                                          Axis.horizontal,
                                                                      lineLength:
                                                                          double
                                                                              .infinity,
                                                                      lineThickness:
                                                                          1.0,
                                                                      dashLength:
                                                                          4.0,
                                                                      dashColor:
                                                                          Colors
                                                                              .grey,
                                                                      dashRadius:
                                                                          0.0,
                                                                      dashGapLength:
                                                                          4.0,
                                                                      dashGapColor:
                                                                          Colors
                                                                              .transparent,
                                                                      dashGapRadius:
                                                                          0.0,
                                                                    )),
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Theme.of(context)
                                                                            .primaryColorDark,
                                                                        border:
                                                                            Border.all(
                                                                          width:
                                                                              3,
                                                                          color:
                                                                              Theme.of(context).primaryColorLight,
                                                                        ),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.3),
                                                                            spreadRadius:
                                                                                2,
                                                                            blurRadius:
                                                                                10,
                                                                            offset:
                                                                                Offset(0, 3), // changes position of shadow
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child: Icon(
                                                                          Icons
                                                                              .circle,
                                                                          color: Theme.of(context)
                                                                              .primaryColorDark,
                                                                          size:
                                                                              15),
                                                                    ),
                                                                  ])),
                                                        ]),
                                                      ),
                                                      Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          child: Wrap(
                                                              children: [
                                                                Div(
                                                                  colS: 6,
                                                                  colM: 6,
                                                                  colL: 6,
                                                                  child:
                                                                      Container(
                                                                          width: double
                                                                              .infinity,
                                                                          padding: EdgeInsets.only(
                                                                              left: 15,
                                                                              bottom: 20,
                                                                              right: 10),
                                                                          child: Wrap(children: [
                                                                            course['driverStatus'] == 'Waiting'
                                                                                ? Material(
                                                                                    //Wrap with Material
                                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
                                                                                    elevation: 5.0,
                                                                                    color: Colors.green,
                                                                                    clipBehavior: Clip.antiAlias, // Add This
                                                                                    child: MaterialButton(
                                                                                      minWidth: 100.0,
                                                                                      height: 10,
                                                                                      color: Colors.green,
                                                                                      child: new Text(S.of(context).accept, style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: Theme.of(context).primaryColorLight))),
                                                                                      onPressed: () {
                                                                                        _con.statusAccepted('Accepted', course['orderId'], '');
                                                                                      },
                                                                                    ),
                                                                                  )
                                                                                : Container(),
                                                                          ])),
                                                                ),
                                                                Div(
                                                                  colS: 6,
                                                                  colM: 6,
                                                                  colL: 6,
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      if (course[
                                                                              'driverStatus'] !=
                                                                          'Waiting') {
                                                                        Navigator.of(context).pushNamed(
                                                                            '/OrderDetails',
                                                                            arguments:
                                                                                course['orderId']);
                                                                      } else {
                                                                        Fluttertoast
                                                                            .showToast(
                                                                          msg:
                                                                              "Please accept this order first",
                                                                          toastLength:
                                                                              Toast.LENGTH_LONG,
                                                                          gravity:
                                                                              ToastGravity.BOTTOM,
                                                                          timeInSecForIosWeb:
                                                                              5,
                                                                        );
                                                                      }
                                                                    },
                                                                    child: Container(
                                                                        width: double.infinity,
                                                                        alignment: Alignment.centerRight,
                                                                        padding: EdgeInsets.only(left: 10, bottom: 20, right: 15),
                                                                        child: Text(
                                                                          S.of(context).view_details,
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .subtitle1
                                                                              .merge(TextStyle(color: Colors.orange)),
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
                                ))
                            : Container();
                      },
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
