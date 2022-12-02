import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/banner.dart';
import 'package:login_and_signup_web/src/models/checkout.dart';
import 'package:login_and_signup_web/src/models/invoice.dart';
import 'package:login_and_signup_web/src/models/order_list.dart';
import 'package:login_and_signup_web/src/models/payment_report.dart';
import 'package:login_and_signup_web/src/models/summary_report.dart';
import 'package:login_and_signup_web/src/repository/order_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toast/toast.dart';
import 'package:vrouter/vrouter.dart';

import '../models/product_details2.dart';
import '../repository/order_repository.dart' as repository;
class OrderController extends ControllerMVC {
  GlobalKey<FormState> bannerFormKey;
  BannerModel bannerData = new BannerModel();
  InvoiceModel invoiceData = new InvoiceModel();
  SummaryReport summaryData = new SummaryReport();
  // ignore: deprecated_member_use
  List<Map<String, dynamic>> originalSource = List<Map<String, dynamic>>();
  double totalPaid;
  double totalDue;
  OverlayEntry loader;
  List<OrderList> orderList = <OrderList>[];
  OrderList orderData=OrderList();
  List<OrderList> orderListTemp = <OrderList>[];
  List<PaymentReport> invoiceList = <PaymentReport>[];
  Checkout invoiceDetailsData = new Checkout();
  // ignore: deprecated_member_use
  List<Map<String, dynamic>> source = List<Map<String, dynamic>>();
  bool isLoading = true;
  OrderController() {
    loader = Helper.overlayLoader(context);
    bannerFormKey = new GlobalKey<FormState>();
  }



  Future<void> listenForOrderList(String id, pageType) async {
    Stream<OrderList> stream;
    orderListTemp.clear();
    orderList.clear();
    if(pageType=='takeaway'){
      stream = await getOrderTakeawayList(id);
    } else {
      stream = await getOrderList(id);
    }
    stream.listen((OrderList _list) {
      if(id =='all'){
        setState(()=>orderListTemp.add(_list));
      }
      else{
        setState(() => orderList.add(_list));
      }
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }
  filterOrder( List<OrderList> orders, String filterString) {
    List<OrderList> tempOrder = orders;
    List<OrderList> _orders = tempOrder
        .where((u) =>
    (u.itemName.toLowerCase().contains(filterString.toLowerCase())) ||
        (u.orderId.toString().toLowerCase().contains(filterString.toLowerCase())) || (u.username.toString().toLowerCase().contains(filterString.toLowerCase())))
        .toList();

    return _orders;
  }

  Future<void> listenForInvoiceList() async {
    setState(() => isLoading = true);
    final Stream<Map<String, dynamic>> stream = await getInvoiceReport('all');
    stream.listen((Map<String, dynamic> _list) {
      setState(() => source.add(_list));
      setState(() => isLoading = false);
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  listenForInvoice(id){
    repository.getInvoice(id).then((value) {
      invoiceData = value;
    }).whenComplete(() {

    });
  }


  listenForInvoiceDetails(id){
    repository.getInvoiceDetails(id).then((value) {
      setState(() => invoiceDetailsData = value);
      print(invoiceDetailsData.addressUser.username);
    }).whenComplete(() {

    });
  }

  listenForSummary(id){
    repository.getSummaryReport(id).then((value) {
      setState((){
        summaryData = value;
        if(summaryData.totalPaidCommission==0){
          totalPaid =1;
        }
        if(summaryData.totalDueCommission==0){
          totalDue =1;
        }
      });


    }).whenComplete(() {

    });
  }

  editOrderStatus(id,pagetype){
    Overlay.of(context).insert(loader);
    repository.editOrderStatusDetails(orderData, id).then((value) {
      showToastPopup("Update Successfully", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }).catchError((e) {
      loader.remove();
      // ignore: deprecated_member_use
    }).whenComplete(() {
      Helper.hideLoader(loader);
      VRouter.of(context).to('/Order');
      listenForOrderList(pagetype,'orders');
      //listenForProductsByCategory('Itemproduct');
    });
  }

  manualDriverStatusUpdate(orderID, id,orderDetailsData, context){
    if(id!=null) {
      Overlay.of(context).insert(loader);
      repository.manualStatusUpdate(orderID, id).then((value) {


        if(GetPlatform.isWeb || GetPlatform.isMobile){
          FirebaseFirestore.instance
              .collection('orderDetails')
              .doc(orderID)
              .update({
            'orderId': orderID,
            'status': 'RShipped',
            'driverId': value.driverId,
            'driverName': value.driverName,
            'driverPhone': value.phone,
            'driverLatitude': double.parse(value.latitude),
            'driverLongitude': double.parse(value.longitude),
            'driverStatus': 'Waiting'
          }).catchError((e) {
            print(e);
          });
        } else {

          Firestore.instance
              .collection('orderDetails')
              .document(orderID)
              .update({'orderId': orderID, 'status':  'RShipped', 'driverId': value.driverId, 'driverName': value.driverName,'driverPhone': value.phone,
            'driverLatitude': double.parse(value.latitude), 'driverLongitude': double.parse(value.longitude),'driverStatus':'Waiting'}).catchError((e) {
            print(e);
          });
        }


        setState((){
          orderList.remove(orderDetailsData);
        });


      }).whenComplete(() {
        Helper.hideLoader(loader);
        Navigator.pop(context);
      });
    }else{
      showToastPopup("Select your driver", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }
  }

  updateOrderStatusStep2(type, driverState, orderID, orderDetailsData,vendorId, context){

    repository.orderStatusUpdateStep2(type, driverState, orderID,vendorId).then((value) {
      showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      if(GetPlatform.isWeb || GetPlatform.isMobile){

        FirebaseFirestore.instance
            .collection('orderDetails')
            .doc(orderID)
            .update({
          'orderId': orderID,
          'status': 'RShipped',
          'driverId': value.driverId,
          'driverName': value.driverName,
          'driverPhone': value.phone,
          'driverLatitude': double.parse(value.latitude),
          'driverLongitude': double.parse(value.longitude),
          'driverStatus': 'Waiting'
        }).catchError((e) {
          print(e);
        });
      }else{
        Firestore.instance
            .collection('orderDetails')
            .document(orderID)
            .update({'orderId': orderID, 'status':  'RShipped', 'driverId': value.driverId, 'driverName': value.driverName,'driverPhone': value.phone,
          'driverLatitude':  double.parse(value.latitude), 'driverLongitude': double.parse(value.longitude),'driverStatus':'Waiting'}).catchError((e) {
          print(e);
        });
      }

      setState((){
        orderList.remove(orderDetailsData);
      });

    }).whenComplete(() {
      Navigator.pop(context);
    });
  }


  Future<void> listenForOrderListTakeaway(String id) async {
    final Stream<OrderList> stream = await getOrderTakeawayList(id);
    stream.listen((OrderList _list) {
      setState(() => orderList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  updateOrderStatus(id, status,OrderList orderDetails){

    Overlay.of(context).insert(loader);
    repository.orderStatusUpdate(id, status).then((value) {

      // setState(() => invoiceDetailsData = value);
      // print(invoiceDetailsData.addressUser.username);
      showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      if(GetPlatform.isWeb || GetPlatform.isMobile){

       FirebaseFirestore.instance
           .collection('orderDetails')
           .doc(id)
           .update({
         'orderId': id,
         'status': status,
         'ShopAddress': orderDetails.shopAddress,
         'DriverATime': DateTime
             .now()
             .millisecondsSinceEpoch
       }).catchError((e) {
         print(e);
       });
     } else {
        Firestore.instance
            .collection('orderDetails')
            .document(id)
            .update({'orderId': id, 'status':  status,'ShopAddress': orderDetails.shopAddress,
          'DriverATime': DateTime.now().millisecondsSinceEpoch}).catchError((e) {
          print(e);
        });
     }
      setState((){
        orderList.remove(orderDetails);
      });

    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }


  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

  void showToastPopup(String msg, context,  {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }
  filterProduct( List<ProductDetails2> products, String filterString) {
    List<ProductDetails2> tempProducts = products;
    List<ProductDetails2> _products = tempProducts
        .where((u) =>
    (u.product_name.toLowerCase().contains(filterString.toLowerCase())) ||
        (u.id.toString().toLowerCase().contains(filterString.toLowerCase())))
        .toList();
    return _products;
  }

}