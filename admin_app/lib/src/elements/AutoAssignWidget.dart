import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/order_controller.dart';
import 'package:login_and_signup_web/src/models/order_list.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
// ignore: must_be_immutable
class AutoAssignWidget extends StatefulWidget{

  AutoAssignWidget({Key key, this.con, this.orderId, this.orderDetails}) : super(key: key);
  OrderController con;
  String orderId;
  OrderList orderDetails;
  @override
  _AutoAssignWidgetState createState() => _AutoAssignWidgetState();
}

class _AutoAssignWidgetState extends StateMVC<AutoAssignWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {

        widget.con.updateOrderStatusStep2('autoAssign', 1, widget.orderId, widget.orderDetails, widget.orderDetails.shopId,context);

    });


  }

  @override
  Widget build(BuildContext context) {

    return Responsive(
      alignment: WrapAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Div(
              colS:12,
              colM:8,
              colL:6,
              child:  Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                ),

                elevation: 0,
                backgroundColor: Colors.transparent,
                child: _buildChild(context),
                insetPadding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.2,
                  left:MediaQuery.of(context).size.width * 0.09,
                  right:MediaQuery.of(context).size.width * 0.09,
                  bottom:MediaQuery.of(context).size.width * 0.2,
                ),
              ),
            )
          ],
        )

      ],
    );

  }

  _buildChild
      (BuildContext context) => SingleChildScrollView(
    child:Container(

      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              S.of(context).auto_assign,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                'assets/img/autoassign.gif',
                height: 140,
                width: 140,
              ),
            ),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Finding the nearest driver',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Text(
              'Please wait...',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 24,
          ),



        ],
      ),
    ),
  );

}