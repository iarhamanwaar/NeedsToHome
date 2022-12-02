import 'package:flutter/material.dart';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:products_deliveryboy/src/elements/EmptyOrdersWidget.dart';
import 'package:products_deliveryboy/src/elements/OrderSummaryWidget.dart';
import 'package:products_deliveryboy/src/models/cart_responce.dart';
import 'package:products_deliveryboy/src/repository/user_repository.dart';
import '../../generated/l10n.dart';
import '../controllers/order_details_controller.dart';
import '../elements/DrawerWidget.dart';
import '../elements/OrderItemWidget.dart';
import '../helpers/helper.dart';


// ignore: must_be_immutable
class OrderWidget extends StatefulWidget {
  OrderWidget({Key key, this.orderId}) : super(key: key);
  String orderId;

  @override
  _OrderWidgetState createState() {
    return _OrderWidgetState();
  }
}

class _OrderWidgetState extends StateMVC<OrderWidget> with SingleTickerProviderStateMixin {
  TabController _tabController;

  OrderDetailsController _con;
  TextEditingController optController = new TextEditingController();
  _OrderWidgetState() : super(OrderDetailsController()) {
    _con = controller;
  }

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    _con.listenForOrderDetails(widget.orderId);

    super.initState();



  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _con.scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).order_details,
          style: Theme.of(context).textTheme.headline5.merge(TextStyle(letterSpacing: 1.3)),
        ),
        /**   actions: <Widget>[
       new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        ], */
      ),
      body: _con.orderDetailLoader==false? EmptyOrdersWidget(): Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.9),
                boxShadow: [
                  BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).hintColor.withOpacity(0.1)),
                    child: Icon(
                      Icons.update,
                      color: Theme.of(context).hintColor.withOpacity(0.8),
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${S.of(context).order_id}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                _con.orderData.payment_type=='cash on delivery'?S.of(context).cash_on_delivery:'Online',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.caption,
                              ),
                              Text(
                                '${DateFormat('yyyy-MM-dd – hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(int.parse(_con.orderData.deliver_assignedtime) * 1000))}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(S.of(context).total, style: Theme.of(context).textTheme.subtitle1),
                            Text(
                              '${_con.orderData.product_details.length} ${S.of(context).items}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.only(top: 10),
                child: TabBar(
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.red,
                  tabs: [
                    Tab(
                        child: Text(
                      S.of(context).ordered_products,
                      style: TextStyle(color: Colors.deepPurple, fontSize: 15),
                    )),
                    Tab(
                        child: Text(
                      S.of(context).contact_info,
                      style: TextStyle(color: Colors.deepPurple, fontSize: 15),
                    )),
                  ],
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.deepPurple,
                  indicatorWeight: 2,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  unselectedLabelStyle: TextStyle(),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).primaryColor,
                child: TabBarView(
                  children: [
                    Container(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            ListView.separated(
                              padding: EdgeInsets.only(bottom: 50),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: _con.orderData.product_details.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 15);
                              },
                              itemBuilder: (context, index) {
                                CartResponce _productDetails = _con.orderData.product_details.elementAt(index);
                                return OrderItemWidget(productDetails: _productDetails, shopTypeId:  _con.orderData.shopTypeId,);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    //listview//

                    Container(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      S.of(context).delivery_addresses,
                                      style: Theme.of(context).textTheme.headline3.merge(TextStyle(color:Theme.of(context).primaryColorDark)),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      _con.orderData.address.username,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  SizedBox(
                                    width: 42,
                                    height: 42,
                                    // ignore: deprecated_member_use
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0),
                                      disabledColor: Theme.of(context).focusColor.withOpacity(0.4),
                                      onPressed: () {
//                                    Navigator.of(context).pushNamed('/Profile',
//                                        arguments: new RouteArgument(param: _con.order.deliveryAddress));
                                      },
                                      child: Icon(
                                        Icons.person,
                                        color: Theme.of(context).primaryColor,
                                        size: 24,
                                      ),
                                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
                                      shape: StadiumBorder(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      ' ${_con.orderData.address.addressSelect}',
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      '${_con.orderData.address.phone}',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    width: 42,
                                    height: 42,
                                    // ignore: deprecated_member_use
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0),
                                      onPressed: () {
                                        _callNumber(_con.orderData.address.phone);
                                      },
                                      child: Icon(
                                        Icons.call,
                                        color: Theme.of(context).primaryColor,
                                        size: 24,
                                      ),
                                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
                                      shape: StadiumBorder(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      S.of(context).pickup_address,
                                      style: Theme.of(context).textTheme.headline3.merge(TextStyle(color:Theme.of(context).primaryColorDark)),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      _con.orderData.shop.username,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  SizedBox(
                                    width: 42,
                                    height: 42,
                                    // ignore: deprecated_member_use
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0),
                                      disabledColor: Theme.of(context).focusColor.withOpacity(0.4),
                                      onPressed: () {
//                                    Navigator.of(context).pushNamed('/Profile',
//                                        arguments: new RouteArgument(param: _con.order.deliveryAddress));
                                      },
                                      child: Icon(
                                        Icons.person,
                                        color: Theme.of(context).primaryColor,
                                        size: 24,
                                      ),
                                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
                                      shape: StadiumBorder(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      _con.orderData.shop.addressSelect,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      _con.orderData.shop.phone,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    width: 42,
                                    height: 42,
                                    // ignore: deprecated_member_use
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0),
                                      onPressed: () {
                                        _callNumber(_con.orderData.shop.phone);
                                      },
                                      child: Icon(
                                        Icons.call,
                                        color: Theme.of(context).primaryColor,
                                        size: 24,
                                      ),
                                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
                                      shape: StadiumBorder(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  controller: _tabController,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(

                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                    boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.15), offset: Offset(0, -2), blurRadius: 5.0)]),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                     Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children:[
                                Text(
                                  S.of(context).total,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                IconButton(
                                  onPressed: (){
                                    OrderSummaryPopupHelper.exit(context, _con.orderData);
                                  },
                                  icon: Icon(Icons.help),
                                ),
                              ]
                            )
                          ),
                          Text(' ${Helper.pricePrint(_con.orderData.paymentDetails.grand_total)}',
                              style: Theme.of(context).textTheme.headline4.
                              merge(TextStyle(color:Theme.of(context).primaryColorDark)))
                        ],
                      ),
                     ),
                      SizedBox(height: 20),


                        // ignore: deprecated_member_use
                      _con.orderData.delivery_state=='Waiting'?Container(
                         width: double.infinity,
                         color: Colors.grey,
                         height: 50,
                         child: Dismissible(
                          key: Key('Accepted'),

                             onDismissed: (direction) {
                                print(direction);
                                if (_con.orderData.delivery_state == 'Waiting') {
                                  _con.statusUpdate(
                                      'Accepted', _con.orderData.sale_code, '',
                                      '', '');
                                  _con.loadCallMusic();
                                  setState(() {
                                    _con.orderData.delivery_state = 'Accepted';
                                  });

                                }
                             },
                          child:Container(
                              width: double.infinity,
                              color: Colors.green,
                              height: 50,
                              child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:[


                                    Container(
                                    width:80,height:25,
                                    margin: EdgeInsets.only(right:0,),
                                    padding: EdgeInsets.only(left:15),
                                    child: Image.asset('assets/img/arrow.gif',
                                      width:double.infinity,height:double.infinity,
                                    ),
                                  ),

                                  Container(
                                    child:Text(S.of(context).swipe_to_accept_the_order,
                                      style: Theme.of(context).textTheme.headline1
                                          .merge(TextStyle(color:Theme.of(context).primaryColorLight)),
                                    )
                                  ),



                            ]
                          ))
                        ),):  _con.orderData.delivery_state=='Accepted'?Container(
                         width: double.infinity,
                         color: Colors.green,
                         height: 50,
                         child: Dismissible(
                             key: Key('Start'),

                             onDismissed: (direction) {
                               print(direction);
                              if (_con.orderData.delivery_state == 'Accepted') {
                               _con.statusStart('Start', _con.orderData.sale_code, '', '', _con.orderData);


                               }
                             },
                             child:Container(
                                 width: double.infinity,
                                 color: Colors.green,
                                 height: 50,
                                 child:Row(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children:[


                                       Container(
                                         width:80,height:25,
                                         margin: EdgeInsets.only(right:0,),
                                         padding: EdgeInsets.only(left:15),
                                         child: Image.asset('assets/img/arrow.gif',
                                           width:double.infinity,height:double.infinity,
                                         ),
                                       ),

                                       Container(
                                           child:Text(S.of(context).swipe_to_accept_the_order,
                                             style: Theme.of(context).textTheme.headline1
                                                 .merge(TextStyle(color:Theme.of(context).primaryColorLight)),
                                           )
                                       ),



                                     ]
                                 ))
                         ),):  _con.orderData.delivery_state=='Start' ||  _con.orderData.delivery_state == 'Pickuped'?Container(
                         width: double.infinity,
                         color: Colors.grey,
                         height: 50,
                         child:RawMaterialButton(

                             key: Key('Start'),
                                 onPressed: (){


                                     if (_con.orderData.delivery_state == 'Start' || _con.orderData.delivery_state == 'Pickuped') {
                                       if(currentUser.value.liveStatus==true) {
                                         if(currentUser.value.latitude!=null && currentUser.value.longitude!=null) {
                                           Navigator.of(context).pushNamed(
                                               '/Map', arguments: _con.orderData);
                                         }else{
                                           Fluttertoast.showToast(
                                             msg: S.of(context).restart_your_driving_mode,
                                             toastLength: Toast.LENGTH_LONG,
                                             gravity: ToastGravity.BOTTOM,
                                             timeInSecForIosWeb: 5,
                                           );
                                         } }else {
// ignore: deprecated_member_use
                                         _con.scaffoldKey?.currentState?.showSnackBar(SnackBar(
                                           content: Text(S.of(context).please_turn_on_your_driving_mode),
                                         ));

                                       }}

                                 },
                             child:Container(
                                 width: double.infinity,
                                 color:  Colors.amber,
                                 height: 50,
                                 child:Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children:[


                                       Container(
                                         width:50,height:30,
                                         margin: EdgeInsets.only(right:0,),
                                         padding: EdgeInsets.only(left:15),
                                         child: Image.asset('assets/img/onthway.gif',fit: BoxFit.fitHeight,
                                           width:double.infinity,height:double.infinity,
                                         ),
                                       ),

                                       Center(
                                           child:Text('${S.of(context).iam_on_the_way}! >>>',
                                             style: Theme.of(context).textTheme.headline1
                                                 .merge(TextStyle(color:Theme.of(context).primaryColorLight)),
                                           )
                                       ),
                                       Container(

                                         child:Text('swipe',style: TextStyle(color: Colors.transparent),)
                                       ),



                                     ]
                                 ))
                         ),):Container(
              width: double.infinity,
              color: Colors.grey,
              height: 50,
              child: RawMaterialButton(
                  key: Key('1'),

                  onPressed: () {

                  },
                  child:Container(
                      width: double.infinity,
                      color: Colors.green,
                      height: 50,
                      child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[



                            Container(
                                child:Text(S.of(context).completed,
                                  style: Theme.of(context).textTheme.headline1
                                      .merge(TextStyle(color:Theme.of(context).primaryColorLight)),
                                )
                            ),



                          ]
                      ))
              ),),


                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  deliveryConfirm(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(S.of(context).delivery_confirmation),
            content: TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              keyboardType: TextInputType.number,
              controller: optController,
              decoration: InputDecoration(
                hintText: S.of(context).enter_otp,
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              // ignore: deprecated_member_use
              FlatButton(
                child: new Text(S.of(context).confirm),
                onPressed: () async {
                  bool res = await _con.statusUpdate('delivered', _con.orderData.sale_code, optController.text, _con.orderData.delivery_state,'');
                  print(res);
                  if (res == true) {
                    setState(() {
                      _con.orderData.delivery_state = 'delivered';
                    });

                    return 'success';
                  }
                },
              ),
              // ignore: deprecated_member_use
              FlatButton(
                child: new Text(S.of(context).dismiss),
                onPressed: () {
                  Navigator.pop(context, "failed");
                  return 'failed';
                },
              ),
            ],
          );
        });
  }

  _callNumber(phone) async {
    String number = phone; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}


class OrderSummaryPopupHelper {

  static exit(context, orderDetails) => showDialog(context: context,
      barrierDismissible: false,
      builder: (context) => OrderSummaryWidget(orderData: orderDetails,),
      );
}
