import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:products_deliveryboy/src/helpers/helper.dart';
import 'package:products_deliveryboy/src/models/orderHistory.dart';
import 'package:products_deliveryboy/src/models/payment.dart';
import 'package:products_deliveryboy/src/repository/user_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../generated/i18n.dart';
import '../repository/order_repository.dart';
import '../repository/order_repository.dart' as repository;

class OrderController extends ControllerMVC {
  List<OrderHistoryModel> orders = <OrderHistoryModel>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  Payment paymentData =  new Payment();
  OverlayEntry loader;
  final player = AudioPlayer();
  OrderController() {
    loader = Helper.overlayLoader(context);
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }


   Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }



  Future loadCallMusic() async {
    await player.setAsset('assets/audio/statusupdate.mp3');
    await player.play();
  }
  void listenForOrdersHistory({String message}) async {
    final Stream<OrderHistoryModel> stream = await getOrdersHistory();
    stream.listen((OrderHistoryModel _order) {
      setState(() {
        orders.add(_order);
      });
    }, onError: (a) {
      print(a);
      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.current.verify_your_internet_connection),
      ));
    }, onDone: () {
      if (message != null) {
        // ignore: deprecated_member_use
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  updateData(id, status) {

    if(status=='Delivered') {

      FirebaseFirestore.instance.collection('orderDetails').doc(id).update({'driverStatus': status,'status':'Completed'}).catchError((e) {
        print(e);

      });
      currentUser.value.currentOrderID ='no_order';
      Fluttertoast.showToast(
        msg: 'Order is  completed successfully',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
      );
      Navigator.of(context).pushReplacementNamed('/Pages', arguments: 1);
    } else if(status=='Pickuped'){
      FirebaseFirestore.instance.collection('orderDetails').doc(id).update({'driverStatus': status,'status':'Shipped'}).catchError((e) {
        print(e);
      });
      Timer(Duration(seconds: 2), () {
        FirebaseFirestore.instance.collection('orderDetails').doc(id).update({'driverStatus': status,'status':'OnTheWay'}).catchError((e) {
          print(e);
        });
      });


    } else{
      FirebaseFirestore.instance.collection('orderDetails').doc(id).update({'driverStatus': status}).catchError((e) {
        print(e);
      });

    }
    Helper.hideLoader(loader);
  }

  getSingleValue(){
    repository.getSingleValue('policy', 'policy_id',5,'value',).then((value) {
      print('dataer');
      print(value);
      return value;
    }).catchError((e) {

    }).whenComplete(() {

    });
  }

  statusUpdate(status, orderId,otp) async {
    Overlay.of(context).insert(loader);

    repository.status(status, orderId, otp).then((value) {
      updateData(orderId, status);
      loadCallMusic();
        Fluttertoast.showToast(
          msg: 'Order is  ' + status + ' successfully',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
        );
      return value;
    });
    Helper.hideLoader(loader);
  }

  Future<void> refreshOrders() async {
    orders.clear();

  }
}
