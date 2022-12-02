import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class OrderDetailsController extends ControllerMVC {

  double taxAmount = 0.0;
  double subTotal = 0.0;
  double deliveryFee = 0.0;
  double total = 0.0;
  GlobalKey<ScaffoldState> scaffoldKey;

  OrderDetailsController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }


  Future<void> refreshOrder() async {

  }


}
