import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/src/helpers/helper.dart';
import '/src/models/bookingmodel.dart';
import '/src/models/miscellaneous.dart';
import '/src/models/paymentdetails.dart';
import '/src/repository/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';
import '../repository/order_repository.dart';
import 'package:http/http.dart' as http;

class OrderController extends ControllerMVC {

  List<Bookingmodel> ordersData = <Bookingmodel>[];
  List<Miscellaneous> miscellaneousData = <Miscellaneous>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> miscellaneousFormKey;
  PaymentDetails paymentDetails = new PaymentDetails();
  OverlayEntry loader;

  String status;
  OrderController() {
    loader = Helper.overlayLoader(context);
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    miscellaneousFormKey = new GlobalKey<FormState>();

    status = 'accepted';
  }
  uploadServiceImage(type, bookId, File image) async {
    print(image.path);
    final uri = Uri.parse("${GlobalConfiguration().getValue('api_base_url')}Api_provider/serviceImage_upload/$type/$bookId");
   print(uri);
    var request = http.MultipartRequest('POST', uri);
    var pic = await http.MultipartFile.fromPath('image', image.path);
    request.files.add(pic);
    print(request.fields);
    var response = await request.send();
    if (response.statusCode == 200) {
      print('success');
      print(response.reasonPhrase.toString());
    } else {}
    return 'true';
  }

  updateData(id, status) {
    var date = new DateTime.now().millisecondsSinceEpoch;
    FirebaseFirestore.instance.collection('HService').doc(id).update({'status': status}).catchError((e) {
      print(e);
    });
    if (status == 'rejected') {
      FirebaseFirestore.instance
          .collection('HService')
          .doc(id)
          .update({'userRatingStatus': 'true', 'providerRatingStatus': 'true'}).catchError((e) {
        print(e);
      });
    }

    if (status == 'Success') {
      FirebaseFirestore.instance
          .collection('HService')
          .doc(id)
          .update({'userRatingStatus': 'no', 'providerRatingStatus': 'waiting'}).catchError((e) {
        print(e);
      });
    }

    if (status == 'accepted') {
      FirebaseFirestore.instance.collection('HStatusManager').doc(id).update({'serviceAccepted': true, 'serviceAcceptedTime': date}).catchError((e) {
        print(e);
      });
    } else if (status == 'ontheway') {
      FirebaseFirestore.instance
          .collection('HStatusManager')
          .doc(id)
          .update({'startedCustomerPlaced': true, 'startedCustomerPlacedTime': date}).catchError((e) {
        print(e);
      });
    } else if (status == 'processing') {
      FirebaseFirestore.instance
          .collection('HStatusManager')
          .doc(id)
          .update({'providerArrived': true, 'providerArrivedTime': date, 'jobStarted': true, 'jobStartedTime': date}).catchError((e) {
        print(e);
      });
    } else if (status == 'paymentPending') {
      FirebaseFirestore.instance.collection('statusmanager').doc(id).update({'jobCompleted': true, 'jobCompletedTime': date}).catchError((e) {
        print(e);
      });
    }

    updateDataPayment(id, status);
    updateStatus(status, date, id);
  }

  updateDataPayment(id, status) {
    if (status == 'paid') {
      FirebaseFirestore.instance.collection('h_payment').doc(id).update({'paymentStatus': status}).catchError((e) {
        print(e);
      });
    }
  }

  updateStatus(status, date, id) {
    statusUpdate(status, date, id).then((value) {}).catchError((e) {}).whenComplete(() {});
  }

  changestate(state) {
    setState(() {
      status = state;
    });
    print(status);
  }

  addMiscellaneous() {
    Miscellaneous data = new Miscellaneous();
    setState(() {
      miscellaneousData.add(data);
    });
  }

  removeMiscellaneous(index) {
    setState(() {
      miscellaneousData.removeAt(index);
    });
  }

  miscellaneousCatch() {
    Overlay.of(context).insert(loader);

    double perMinCharge = double.parse(((currentPayment.value.chargeperhrs / 60)).toStringAsFixed(2));


    if (miscellaneousFormKey.currentState.validate()) {
      miscellaneousFormKey.currentState.save();
      currentPayment.value.miscellaneous.clear();
      currentPayment.value.miscellaneousAmount = 0;
      miscellaneousData.forEach((element) {
        currentPayment.value.miscellaneous.add(element);
        currentPayment.value.miscellaneousAmount += element.price;
      });

      print(currentPayment.value.totalMin);
      //print(currentPayment.value.miscellaneousAmount);
      currentPayment.value.total = perMinCharge * currentPayment.value.totalMin;
      currentPayment.value.paymentStatus = 'paymentPending';
      currentPayment.value.subtotal = currentPayment.value.miscellaneousAmount + currentPayment.value.total;
      currentPayment.value.commissionAmount = double.parse(((currentPayment.value.total * currentPayment.value.commission) / 100).toStringAsFixed(2));
      currentPayment.value.taxAmount = double.parse((( (currentPayment.value.total).toDouble() * setting.value.defaultTax) / 100).toStringAsFixed(2));
      currentPayment.value.grandTotal = double.parse((currentPayment.value.subtotal + currentPayment.value.taxAmount).toStringAsFixed(2));
      paymentUpdate();
      currentPayment.value.grandTotal =  double.parse(currentPayment.value.grandTotal.toStringAsFixed(2));
      FirebaseFirestore.instance.collection('HService').doc(currentPayment.value.bookingId).update(
          {'status': 'paymentPending', 'workedHrs': currentPayment.value.workedHours, 'grandTotal': currentPayment.value.grandTotal}).catchError((e) {
        print(e);
      });
      FirebaseFirestore.instance
          .collection('HStatusManager')
          .doc(currentPayment.value.bookingId)
          .update({'jobCompleted': true, 'jobCompletedTime': DateTime.now().millisecondsSinceEpoch}).catchError((e) {
        print(e);
      });
      bookOrdered();
      updateStatus('jobCompleted', DateTime.now().millisecondsSinceEpoch, currentPayment.value.bookingId);
    }
  }

  void sendServer() {}

  void bookOrdered() {
    paymentData(1).then((value) {
      Navigator.pop(context, "Stop");
    }).catchError((e) {
      loader.remove();
      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(e),
      ));
    }).whenComplete(() {
      loader.remove();
      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text('Successfully completed'),
      ));
    });
  }

  backError() {
    // ignore: deprecated_member_use
    scaffoldKey?.currentState?.showSnackBar(SnackBar(
      content: Text('Cannot be close before you complete'),
    ));
  }

  paymentUpdate() async {
    final databaseReference = FirebaseFirestore.instance;
    await databaseReference.collection("h_payment").doc(currentPayment.value.bookingId).set(currentPayment.value.toMap());
  }

  processComplete(bookDetails) async {
    currentPayment.value.providerName = bookDetails['providerName'];
    currentPayment.value.providerId = bookDetails['providerId'];
    currentPayment.value.bookingId = bookDetails['bookId'];
    currentPayment.value.time = bookDetails['time'];
    currentPayment.value.commission = setting.value.commission;
    currentPayment.value.billingName = bookDetails['username'];
    currentPayment.value.chargeperhrs = double.parse(bookDetails['chargeperhrs']);
    currentPayment.value.tax = setting.value.defaultTax;
    String formattedDate = DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(bookDetails['bookingTime']));
    currentPayment.value.date = formattedDate;
    print(setting.value.commission);
    var result = await Navigator.of(context).pushNamed('/takePhoto');
    return result;
  }

  setTime(num) {}

  completeFixedType(amount, bookId){
    FirebaseFirestore.instance.collection('HService').doc(bookId).update(
        {'status': 'Success', 'workedHrs': '0', 'grandTotal': amount, 'providerRatingStatus': 'true', 'userRatingStatus':'true'}).catchError((e) {
      print(e);
    });
    FirebaseFirestore.instance
        .collection('HStatusManager')
        .doc(bookId)
        .update({'jobCompleted': true, 'jobCompletedTime': DateTime.now().millisecondsSinceEpoch}).catchError((e) {
      print(e);
    });
    bookOrdered();
    updateStatus('jobCompleted', DateTime.now().millisecondsSinceEpoch, bookId);

  }
}
String getTimeString(int value) {
  final int hour = value ~/ 60;
  final int minutes = value % 60;
  return '${hour.toString().padLeft(2, "0")}Hrs:${minutes.toString().padLeft(2, "0")}Min';
}




