
import 'package:flutter/material.dart';
import 'package:products_deliveryboy/src/helpers/helper.dart';
import 'package:products_deliveryboy/src/models/order_list.dart';

import '../../generated/l10n.dart';

// ignore: must_be_immutable
class OrderSummaryWidget extends StatefulWidget {
  OrderList orderData;
  OrderSummaryWidget({Key key, this.orderData}) : super(key: key);

  @override
  _OrderSummaryWidgetState createState() => _OrderSummaryWidgetState();
}

class _OrderSummaryWidgetState extends State<OrderSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
      insetPadding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.09,
        left: MediaQuery.of(context).size.width * 0.09,
        right: MediaQuery.of(context).size.width * 0.09,
        bottom: MediaQuery.of(context).size.width * 0.09,
      ),
    );
  }

  _buildChild(BuildContext context) => SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close))
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  padding: EdgeInsets.only(right: 18, left: 18),
                  child: Text(S.of(context).payment_details,
                      style: Theme.of(context).textTheme.headline4),
                ),
              ]),
              Container(
                padding: EdgeInsets.only(right: 18, left: 18),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                            width: double.infinity,
                            child: Column(children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        child: Text(
                                            'Your Tips ${Helper.pricePrint(widget.orderData.paymentDetails.delivery_tips)}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1)),
                                  ]),
                              Container(
                                padding: EdgeInsets.only(bottom: 10, top: 10),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: Text(S.of(context).item_total,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1)),
                                      Expanded(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                            Container(
                                                child: Text(
                                                    Helper.pricePrint(widget
                                                        .orderData
                                                        .paymentDetails
                                                        .sub_total),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1)),
                                          ])),
                                    ]),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: Text('Delivery Fees',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1)),
                                      Expanded(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                            Container(
                                                child: Text(
                                                    Helper.pricePrint(widget
                                                        .orderData
                                                        .paymentDetails
                                                        .delivery_fees),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1)),
                                          ])),
                                    ]),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: Text(S.of(context).discount,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1)),
                                      Expanded(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                            Container(
                                                child: Text(
                                                    Helper.pricePrint(widget
                                                        .orderData
                                                        .paymentDetails
                                                        .discount),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1
                                                        .merge(TextStyle(
                                                            color:
                                                                Colors.red)))),
                                          ])),
                                    ]),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: Text(S.of(context).delivery_tips,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  .merge(TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColorDark)))),
                                      Expanded(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                            Container(
                                                child: Text(
                                                    Helper.pricePrint(widget
                                                        .orderData
                                                        .paymentDetails
                                                        .delivery_tips),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1
                                                        .merge(TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorDark)))),
                                          ])),
                                    ]),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: Text('Tax',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  .merge(TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColorDark)))),
                                      Expanded(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                            Container(
                                                child: Text(
                                                    Helper.pricePrint(widget
                                                        .orderData
                                                        .paymentDetails
                                                        .tax),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1
                                                        .merge(TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorDark)))),
                                          ])),
                                    ]),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: Text(S.of(context).to_pay,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1)),
                                      Expanded(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                            Container(
                                                child: Text(
                                                    Helper.pricePrint(widget
                                                        .orderData
                                                        .paymentDetails
                                                        .grand_total),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1)),
                                          ])),
                                    ]),
                              ),
                            ])),
                      ),
                      SizedBox(height: 40),
                    ]),
              ),
            ],
          ),
        ),
      );
}
