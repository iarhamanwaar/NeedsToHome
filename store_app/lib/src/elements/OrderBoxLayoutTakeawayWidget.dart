
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/order_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'EmptyOrdersWidget.dart';
import 'OrderBoxWidget.dart';

// ignore: must_be_immutable
class OrderBoxLayoutTakeawayWidget extends StatefulWidget {
  String tabTab;
  OrderController con;
  OrderBoxLayoutTakeawayWidget({Key key, this.tabTab, this.con}) : super(key: key);
  @override
  _OrderBoxLayoutTakeawayWidgetState createState() =>
      _OrderBoxLayoutTakeawayWidgetState();
}

class _OrderBoxLayoutTakeawayWidgetState
    extends StateMVC<OrderBoxLayoutTakeawayWidget> {


  @override
  void initState() {
    widget.con.listenForOrderListTakeaway(widget.tabTab);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  widget.con.orderList.isEmpty
        ? EmptyOrdersWidget()
        : Container(
            child: Scrollbar(
              isAlwaysShown: true,
              child: SingleChildScrollView(
                  child: Responsive(children: [
                Div(
                    colS: 12,
                    colM: 12,
                    colL: 12,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children:
                                List.generate( widget.con.orderList.length, (index) {
                              return OrderBoxWidget(
                                orderDetails:  widget.con.orderList.elementAt(index),
                                tabTab: widget.tabTab,
                                con:  widget.con,
                                pageType: 'takeaway',
                              );
                            }),
                          ),
                        ]))
              ])),
            ),
          );
  }
}
