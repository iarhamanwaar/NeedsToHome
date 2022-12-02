
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mpesa/mpesa.dart';
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/models/address.dart';
import 'package:multisuperstore/src/models/hstatusmanager.dart';
import 'package:multisuperstore/src/repository/hservice_repository.dart';
import 'package:multisuperstore/src/repository/order_repository.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';
import '../models/hsubcategory.dart';
import '../pages/flutterwave_payment.dart';
import '../pages/global_payment.dart';
import '../pages/paypal_payment.dart';
import '../pages/stripe_payment.dart';
import '../pages/uip_india.dart';
import '../repository/settings_repository.dart';
class HServiceController extends ControllerMVC {
  List<HSubcategory> subcategory = <HSubcategory>[];
  List<HSubcategory> category = <HSubcategory>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<ScaffoldState> timescaffoldKey;
  OverlayEntry loader;
  Address addressData = Address();
  Razorpay _razorpay;
  final databaseReference = FirebaseFirestore.instance;
  HServiceController() {
    loader = Helper.overlayLoader(context);
    this.timescaffoldKey = new GlobalKey<ScaffoldState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }


  Future<void> listenForSubcategories(id) async {
    final Stream<HSubcategory> stream = await getSubcategories(id);
    stream.listen((HSubcategory _subcategory) {
      if (_subcategory.id != null) {
        setState(() => subcategory.add(_subcategory));
      }
    }, onError: (a) {
      print(a);
      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text('Verify your internet connection'),
      ));
    }, onDone: () {});
  }

  Future<void> listenForCategories() async {
    final Stream<HSubcategory> stream = await getCategories();
    stream.listen((HSubcategory _category) {
      if (_category.id != null) {
        setState(() => category.add(_category));
      }
    }, onError: (a) {
      print(a);
      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text('Verify your internet connection'),
      ));
    }, onDone: () {});
  }


  void gotoMap(){

    if(currentBookDetail.value.address!=null) {

      Navigator.of(context).pushNamed('/mapH');
    }else{
      // ignore: deprecated_member_use
      timescaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text('Please select your address'),
      ));
    }
  }

  gotoBooking(String categoryId,String subCategoryId, String name, String img ){
    currentBookDetail.value.categoryId = categoryId;
    currentBookDetail.value.subcategoryId = subCategoryId;
    currentBookDetail.value.subcategoryName = name;
    currentBookDetail.value.subcategoryImg = img;
    Navigator.of(context)
        .pushNamed('/H_schedule');
  }
// ignore: non_constant_identifier_names
  void book_firebase() async {
    try {
     Overlay.of(context).insert(loader);

      int currentTime = DateTime
          .now()
          .millisecondsSinceEpoch;
      currentBookDetail.value.bookingTime = currentTime;
      currentBookDetail.value.status = 'pending';
      currentBookDetail.value.username = currentUser.value.name;
      currentBookDetail.value.userMobile = currentUser.value.phone;
      currentBookDetail.value.userid = currentUser.value.id;
      String bookId = 'U${currentBookDetail.value.userid}D$currentTime';
      currentBookDetail.value.bookId = bookId;
      currentBookDetail.value.userRatingStatus = 'no';
      currentBookDetail.value.providerRatingStatus = 'no';



      FirebaseFirestore.instance.collection("HService").doc(bookId).set(
            currentBookDetail.value.toMap()).catchError((e) {
        print(e);
      });

      StatusManager _status = new StatusManager();
      _status.serviceBooked = true;
      _status.bookId = bookId;
      _status.serviceBooked = true;
      _status.serviceBookedTime = DateTime
          .now()
          .millisecondsSinceEpoch;

      FirebaseFirestore.instance.collection("HStatusManager").doc(bookId).set(
          _status.toMap());

      bookOrdered();
    } catch(e){
      print('firebase error$e');

    }
  }

  void bookOrdered() {
    bookOrderData(1).then((value) {
      Helper.hideLoader(loader);
      Navigator.of(context).pushReplacementNamed('/HThankyou');

    }).catchError((e) {
      loader.remove();
      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(e),
      ));
    }).whenComplete(() {
      //refreshOrders();


      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text('Your order is booked'),
      ));
    });
  }

  paymentGate(amount){

    print('gateway');
    print('${currentUser.value.paymentType}-$amount');


    if (currentBookDetail.value.paymentMethod == 'online') {
      if(currentUser.value.paymentType=='RayzorPay'){
        _razorpay = Razorpay();
        _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
        _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
        _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
        openCheckout(amount);
      } if(currentBookDetail.value.paymentType == 'Paypal'){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PayPalPaymentWidget()));
      }if(currentBookDetail.value.paymentType == 'Stripe'){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => StripePaymentWidget()));
      }if(currentBookDetail.value.paymentType == 'flutterwave'){

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => FlutterWavePaymentWidget()));
      }if(currentBookDetail.value.paymentType == 'Paystack'){

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => GlobalPaymentWidget(pageTitle: 'Paystack',)));
      }if(currentBookDetail.value.paymentType == 'wallet'){
        book_firebase();
      } if(currentBookDetail.value.paymentType == 'UPI'){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentUPI()));
      } if(currentBookDetail.value.paymentType == 'mpesa'){

        Mpesa mpesa = Mpesa(
          clientKey: setting.value.mpesaConsumerKey,
          clientSecret: setting.value.mpesaConsumerSecret,
          passKey: setting.value.mpesaPasskey,
          environment: "sandbox",
        );

        mpesa
            .lipaNaMpesa(
          phoneNumber: currentUser.value.phone,
          amount: amount,
          businessShortCode: "174379",
          callbackUrl: "https://www.google.co.in/",
        )
            .then((result) {
            book_firebase();
        })
            .catchError((error) {
          showToast('Error', gravity: Toast.BOTTOM,
              duration: Toast.LENGTH_SHORT);
        });
      }
    } else {

      book_firebase();
    }

  }


  void openCheckout(amount) async {
    var options = {
      'key': setting.value.razorpay_key,
      'amount': amount * 100,
      'name': setting.value.appName,
      'description': 'Online Shopping',
      'prefill': {'contact': currentUser.value.phone, 'email': currentUser.value.email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      // debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    //Fluttertoast.showToast(msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
    book_firebase();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("ERROR: " + response.code.toString());
    //Fluttertoast.showToast(msg: "ERROR: " + response.code.toString() + " - " + response.message, timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Fluttertoast.showToast(msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }


  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

  grantTotal(double amount){
    double  taxAmount = amount * double.parse(setting.value.handyTax)/100;
    double grandTotal = (amount + taxAmount);
    currentBookDetail.value.tax = setting.value.handyTax;
    currentBookDetail.value.taxAmount = taxAmount.toString();
    currentBookDetail.value.grandTotal = double.parse(grandTotal.toStringAsFixed(setting.value.currencyDecimalDigits));
    return currentBookDetail.value.grandTotal.toString();
  }

}


