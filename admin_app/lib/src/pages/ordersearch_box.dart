import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/order_controller.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/elements/OrderBoxSearchWidget.dart';
import 'package:login_and_signup_web/src/models/order_list.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

// ignore: must_be_immutable
class SearchBoxOrder extends StatefulWidget {
  SearchBoxOrder({this.orderList, Key key, this.pageType}) : super(key: key);
  List<OrderList> orderList;
  String pageType;
  @override
  _SearchBoxOrderState createState() => _SearchBoxOrderState();
}

class _SearchBoxOrderState extends StateMVC<SearchBoxOrder> {
  bool isSwitched = false;
  List<OrderList> itemList;

  bool status = false;
  OrderController _con;
  _SearchBoxOrderState() : super(OrderController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listenForOrderList('all',widget.pageType);

    itemList = _con.orderListTemp;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.6),
        elevation: 0,
        title: Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(color:Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5.0),
                boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.05), offset: Offset(0, 5), blurRadius: 1)],
                border:Border.all(
                    width: 1,
                    color:Theme.of(context).dividerColor
                )
            ),
            child: TextField(
              autofocus: true,
              onChanged: (e){
                setState((){
                  itemList = _con.filterOrder(itemList, e);
                  if(e.length==0){
                    itemList = _con.orderListTemp;
                  }
                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: 'Search:Order Id/User Name/Item Name',
                hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                suffixIcon: IconButton(
                  icon:Icon(Icons.search, color: Theme.of(context).colorScheme.secondary), onPressed: () {  },
                ),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
              ),
            )),
      ),
      body: (itemList.isEmpty)?
      EmptyOrdersWidget()
      :Padding(
        padding: EdgeInsets.only(top:0),
        child:SingleChildScrollView(
            child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Wrap(
                    children: List.generate(itemList.length, (index) {
                      OrderList _orderData = itemList.elementAt(index);
                      return OrderBoxSearchWidget(orderDetails:_orderData , con:_con);
                    }
                    ),
                  ),
                ]
            )
        ),
      ),
    );
  }
}






