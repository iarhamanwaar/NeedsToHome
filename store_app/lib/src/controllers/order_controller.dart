import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/banner.dart';
import 'package:login_and_signup_web/src/models/checkout.dart';
import 'package:login_and_signup_web/src/models/invoice.dart';
import 'package:login_and_signup_web/src/models/order_list.dart';
import 'package:login_and_signup_web/src/models/payment_report.dart';
import 'package:login_and_signup_web/src/models/product_details2.dart';
import 'package:login_and_signup_web/src/models/summary_report.dart';
import 'package:login_and_signup_web/src/repository/order_repository.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/order_repository.dart' as repository;
import 'package:toast/toast.dart';
class OrderController extends ControllerMVC {
  GlobalKey<FormState> bannerFormKey;
  GlobalKey<FormState> formKey;
  BannerModel bannerData = new BannerModel();
  InvoiceModel invoiceData = new InvoiceModel();
  SummaryReport summaryData = new SummaryReport();

  double totalPaid;
  double totalDue;
  List<OrderList> orderList = <OrderList>[];
  List<OrderList> orderListTemp = <OrderList>[];
  List<PaymentReport> invoiceList = <PaymentReport>[];
  Checkout invoiceDetailsData = new Checkout();
  // ignore: deprecated_member_use
  List<Map<String, dynamic>> source = List<Map<String, dynamic>>();
  // ignore: deprecated_member_use
  List<Map<String, dynamic>> originalSource = List<Map<String, dynamic>>();
  bool isLoading = true;
  OverlayEntry loader;
  OrderController() {
    loader = Helper.overlayLoader(context);
    bannerFormKey = new GlobalKey<FormState>();
    formKey = new GlobalKey<FormState>();
  }


  Future<void> listenForOrderList(String id, pageType) async {
     Stream<OrderList> stream;
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

  Future<void> listenForOrderListTakeaway(String id) async {
    final Stream<OrderList> stream = await getOrderTakeawayList(id);
    stream.listen((OrderList _list) {
      setState(() => orderList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForOrderListSearch(String id) async {
    final Stream<OrderList> stream = await getOrderListSearch(id);
    stream.listen((OrderList _list) {
      setState(() => orderList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
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
  Future<void> listenForInvoiceList(String id) async {
    setState(() => isLoading = true);
    final Stream<Map<String, dynamic>> stream = await getInvoiceReport(id);
    stream.listen((Map<String, dynamic> _list) {
      setState(() => source.add(_list));
      setState(() => originalSource.add(_list));

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
     // print(invoiceDetailsData.addressUser.username);
    }).whenComplete(() {

    });
  }

  filterOrder( List<OrderList> order, String filterString) {
    List<OrderList> tempOrders = order;
    List<OrderList> _order = tempOrders
        .where((u) =>
    (u.itemName.toLowerCase().contains(filterString.toLowerCase())) ||
        (u.orderId.toString().toLowerCase().contains(filterString.toLowerCase())) || (u.username.toString().toLowerCase().contains(filterString.toLowerCase())))
        .toList();

    return _order;
  }

  updateOrderStatus(id, status,OrderList orderDetails){
    Overlay.of(context).insert(loader);
    repository.orderStatusUpdate(id, status).then((value) {

     // setState(() => invoiceDetailsData = value);
      // print(invoiceDetailsData.addressUser.username);
      showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      if (GetPlatform.isWeb || GetPlatform.isMobile) {
        FirebaseFirestore.instance
            .collection('orderDetails')
            .doc(id)
            .update({
          'orderId': id,
          'status': status,
          'ShopAddress': currentUser.value.address,
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
            .update({'orderId': id, 'status':  status,'ShopAddress': currentUser.value.address,
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


  updateOrderAmountStatus(id, amount,OrderList orderDetails, context){
    Overlay.of(context).insert(loader);
    repository.updateAmount(id, amount).then((value) {

      // setState(() => invoiceDetailsData = value);
      // print(invoiceDetailsData.addressUser.username);
      showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);




    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }


  updateOrderStatusStep2(type, driverState, orderID, orderDetailsData, context){

    repository.orderStatusUpdateStep2(type, driverState, orderID).then((value) {
      showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      if (GetPlatform.isWeb || GetPlatform.isMobile) {
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
      }else {


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




  updateOrderPop(id, status){

    repository.orderStatusUpdate(id, status).then((value) {
    }).whenComplete(() {

    });
  }

  manualDriverStatusUpdate(orderID, id,orderDetailsData, context){
   if(id!=null) {
     Overlay.of(context).insert(loader);
     repository.manualStatusUpdate(orderID, id).then((value) {

       if (GetPlatform.isWeb || GetPlatform.isMobile) {
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

  listenForSummary(id){
    repository.getSummaryReport(id).then((value) {
      setState((){
        summaryData = value;
        if(summaryData.totalPaid==0){
          totalPaid =1;
        }
        if(summaryData.totalDue==0){
          totalDue =1;
        }
      });


    }).whenComplete(() {

    });
  }


  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

  void showToastPopup(String msg, context,  {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

}