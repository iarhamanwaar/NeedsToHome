import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mpesa/mpesa.dart';
import 'package:multisuperstore/src/components/directions_model.dart';
import 'package:multisuperstore/src/components/directions_repository.dart';
import 'package:multisuperstore/src/models/recharge.dart';
import 'package:multisuperstore/src/pages/global_payment.dart';
import 'package:multisuperstore/src/repository/home_repository.dart';
import 'package:multisuperstore/src/repository/settings_repository.dart';
import 'package:multisuperstore/src/repository/wallet_repository.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';
import '../../generated/l10n.dart';
import '../models/coupon.dart';
import '../models/timeslot.dart';
import '../helpers/helper.dart';
import '../models/checkout.dart';
import '../models/variant.dart';
import '../pages/flutterwave_payment.dart';
import '../pages/paypal_payment.dart';
import '../pages/stripe_payment.dart';
import '../pages/uip_india.dart';
import '../repository/user_repository.dart';
import '../repository/order_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/product_repository.dart';

class CartController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  int cartCount = 0;
  List<CouponModel> couponList = <CouponModel>[];
  List<CouponModel> tempCouponList = <CouponModel>[];
  List<TimeSlot> timeSlot = <TimeSlot>[];
  bool checkOutButtonLoad = false;
  Razorpay _razorpay;
  GlobalKey<ScaffoldState> scaffoldCheckout;
  bool couponStatus = false;
  OverlayEntry loader;
  bool paymentLoading = true;
  Recharge rechargeData = new Recharge();
  TextEditingController couponController;
  CartController() {
    this.scaffoldCheckout = new GlobalKey<ScaffoldState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    loader = Helper.overlayLoader(context);
    couponController = TextEditingController();
  }

  @override
  void initState() {
    // settingRepo.initSettings();

    super.initState();

  }

  getOriginalDistance() async {

    LatLng _origin = LatLng(currentUser.value.latitude, currentUser.value.longitude);
    LatLng _destination = LatLng(double.parse(currentCheckout.value.shopLatitude), double.parse(currentCheckout.value.shopLongitude));
    Directions _info;
    final directions = await DirectionsRepository().getDirections(origin: _origin, destination: _destination);
    setState(() => _info = directions);
    if(_info?.totalDistance!=null) {
      var parts = _info.totalDistance.split("km");
      var part1 = parts[0].replaceAll(new RegExp(r'[^\w\s]+\.'), '');
      currentCheckout.value.km = double.parse(part1);
    } else {
      currentCheckout.value.km = 1;
    }


    calculateDeliveryFees();

  }

  @override
  void dispose() {
    super.dispose();
   // _razorpay.clear();
  }

  calculateDeliveryFees(){

    if( currentUser.value.zoneId!="no_matched" && currentCheckout.value.zoneId == currentUser.value.zoneId){

    if( currentCheckout.value.deliverType != 3) {

      currentCheckout.value.delivery_fees = Helper.calculateDeliveryFees().toDouble();
    }else{
      currentCheckout.value.delivery_fees = 0;
    }


    currentCheckout.value.deliveryPossible = true;
    }else{
      currentCheckout.value.deliveryPossible = false;
    }
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    currentCart.notifyListeners();

    grandSummary();

  }

  listenForCartsCount() async {
    setState(() => cartCount = currentCart.value.length);
  }

  calculateAmount() {

    double totalprice = 0;

    int addon =0;
    currentCart.value.forEach((element) {
      element.addon.forEach((addonElement) {
        addon += int.parse(addonElement.price)* element.qty;
      });
      totalprice += (double.parse(element.price) * element.qty)+ addon;

    });
    return double.parse(totalprice.toStringAsFixed(setting.value.currencyDecimalDigits));
  }

  decrementQty(id, variantId) {
    bool removeState;
    currentCart.value.forEach((element) {
      if (element.id == id && element.variant == variantId) {
        if (element.qty > 1) {
          element.qty = element.qty - 1;
        } else {
          removeState = true;
        }
      }
    });
    if (removeState == true) {
      currentCart.value.removeWhere((item) => item.id == id && item.variant  == variantId);
    }

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    if(currentCheckout.value.couponStatus){
      applyCoupon(currentCheckout.value.couponData, 'indirect');
    } else {
      grandSummary();
    }
    setCurrentCartItem();
    if (currentCart.value.length == 0) {
      currentCheckout.value.shopName = null;
      currentCheckout.value.shopTypeID = 0;
      currentCheckout.value.shopId = null;
      Navigator.of(context).pushReplacementNamed('/EmptyList');
    }
  }

  showQty(id, variantID) {
    String qty;
    currentCart.value.forEach((element) {
      if (element.id == id && element.variant==variantID) {
        qty = element.qty.toString();
      }
    });
    return qty;
  }

  incrementQty(id, variantId, variantModel variantData) {
    currentCart.value.forEach((element) {


      if (element.id == id && element.variant == variantId) {

        if(int.parse(variantData.maxPurchase) >element.qty || int.parse(variantData.maxPurchase) == 0) {
          element.qty = element.qty + 1;
        } else {
          showToast("You reached maximum limit", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }
      }

    });

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    if(currentCheckout.value.couponStatus){

      applyCoupon(currentCheckout.value.couponData, 'indirect');
    } else {
      grandSummary();
    }
    setCurrentCartItem();
  }



  grandSummary() {

    double saveamount = 0;
    double totalprice = 0;
    double totalsalesprice = 0;
    double tax =0;
    double addon =0;
    double packingCharge = 0;

    currentCart.value.forEach((element) {
      totalprice += double.parse(element.price) * element.qty;
      tax += element.tax * element.qty;
      packingCharge  += element.packingCharge * element.qty;
      totalsalesprice += double.parse(element.strike) * element.qty;
      element.addon.forEach((addonElement) {
        addon += double.parse(addonElement.price)* element.qty;
      });

    });
    tax = double.parse(tax.toStringAsFixed(setting.value.currencyDecimalDigits));


    currentCheckout.value.packingCharge =  packingCharge;

    saveamount = double.parse(totalsalesprice.toStringAsFixed(setting.value.currencyDecimalDigits)) -  double.parse(totalprice.toStringAsFixed(setting.value.currencyDecimalDigits));
    currentCheckout.value.sub_total = double.parse((totalprice +addon).toStringAsFixed(setting.value.currencyDecimalDigits));
    currentCheckout.value.discount = double.parse(saveamount.toStringAsFixed(setting.value.currencyDecimalDigits));
    currentCheckout.value.tax = tax;
    currentCheckout.value.payment.tax = tax;
    couponStatus = currentCheckout.value.couponStatus;
    if (currentCheckout.value.couponStatus == false) {
      if(currentCheckout.value.deliverType!=3) {
        currentCheckout.value.grand_total = double.parse(
            (totalprice + addon + currentCheckout.value.delivery_tips + currentCheckout.value.packingCharge +
                currentCheckout.value.delivery_fees + tax).toStringAsFixed(setting.value.currencyDecimalDigits));

      } else{
        currentCheckout.value.grand_total = double.parse(
            (totalprice + addon  + tax).toStringAsFixed(setting.value.currencyDecimalDigits));
      }
    }
    paymentLoading =false;
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    currentCart.notifyListeners();

    return saveamount;
  }



  redirect() {
    if (currentCart.value.length == 0) {
      Navigator.of(context).pushReplacementNamed('/EmptyList');
    }
  }

  Future<void> listenForCoupons(type,vendorId,user) async {
    final Stream<CouponModel> stream = await getCoupon(type, vendorId,user);
    stream.listen((CouponModel _coupons) {
      setState(() => couponList.add(_coupons));
      setState(() => tempCouponList.add(_coupons));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }



  applyCoupon(CouponModel couponData, type) {
    double totalPrice = 0;
    double discountAmount = 0;
    double addon =0;
    double tax =0;
    double packingCharge =0;
    double grandTotal = 0;
    double totalstrikeprice = 0;
    double saveamount= 0;
    currentCart.value.forEach((element) {
      totalPrice += double.parse(element.price) * element.qty;
      totalstrikeprice += double.parse(element.strike) * element.qty;
      tax += element.tax * element.qty;
      packingCharge  += element.packingCharge * element.qty;
      element.addon.forEach((addonElement) {
        addon += double.parse(addonElement.price)* element.qty;
      });
    });
    grandTotal = totalPrice+addon;
    saveamount = double.parse(grandTotal.toStringAsFixed(setting.value.currencyDecimalDigits)) - double.parse(totalstrikeprice.toStringAsFixed(
        setting.value.currencyDecimalDigits));

    if(grandTotal>= couponData.minimumPurchasedAmount) {
      if(couponData.couponType=='1' || couponData.couponType=='2' || couponData.couponType=='3') {
        if (couponData.discountType == 'amount') {

          discountAmount = saveamount + couponData.discount;
          currentCheckout.value.discount = double.parse(discountAmount.toStringAsFixed(setting.value.currencyDecimalDigits)).abs();
          currentCheckout.value.grand_total =
              (grandTotal - couponData.discount) + packingCharge + tax + currentCheckout.value.delivery_fees;

        } else {

          discountAmount = ((grandTotal * couponData.discount) / 100);
          currentCheckout.value.discount =saveamount + discountAmount;
          currentCheckout.value.discount = double.parse(currentCheckout.value.discount.toStringAsFixed(setting.value.currencyDecimalDigits)).abs();
              currentCheckout.value.grand_total =
              (grandTotal - discountAmount) + packingCharge + tax + currentCheckout.value.delivery_fees;

        }
      } else if(couponData.couponType=='4'){
        currentCheckout.value.delivery_fees = 0;
        currentCheckout.value.discount = saveamount + discountAmount;
        currentCheckout.value.discount = double.parse(currentCheckout.value.discount.toStringAsFixed(setting.value.currencyDecimalDigits)).abs();
        currentCheckout.value.grand_total =
            (grandTotal - discountAmount) + packingCharge + tax +currentCheckout.value.delivery_fees ;

      }


      currentCheckout.value.couponData = couponData;
      currentCheckout.value.couponStatus = true;
      currentCheckout.value.couponCode = couponData.code;
      currentCheckout.value.packingCharge = packingCharge;
      currentCheckout.value.sub_total = grandTotal;
      currentCheckout.value.tax = tax;
      currentCheckout.value.payment.tax = tax;


      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      currentCart.notifyListeners();

      if (type == 'direct') {
        showToast(S.of(context).your_coupon_is_applied_successfully, gravity: Toast.BOTTOM,
            duration: Toast.LENGTH_SHORT);
        Navigator.pop(context, currentCheckout.value.couponStatus);
      }
    } else {
      removeCoupon();
    }
  }

  removeCoupon() {
    currentCheckout.value.couponCode = '';
    currentCheckout.value.couponStatus = false;
    currentCheckout.value.couponData =  new CouponModel();
    double totalPrice = 0;
    double discountAmount = 0;
    double addon =0;
    double tax =0;
    double packingCharge =0;
    double grandTotal = 0;
    double totalstrikeprice = 0;
    double saveamount= 0;
    currentCart.value.forEach((element) {
      totalPrice += double.parse(element.price) * element.qty;
      tax += element.tax * element.qty;
      totalstrikeprice += double.parse(element.strike) * element.qty;
      packingCharge  += element.packingCharge * element.qty;
      element.addon.forEach((addonElement) {
        addon += double.parse(addonElement.price)* element.qty;
      });
    });

    grandTotal = totalPrice+addon;
    saveamount = double.parse(grandTotal.toStringAsFixed(setting.value.currencyDecimalDigits)) -  double.parse(totalstrikeprice.toStringAsFixed(setting.value.currencyDecimalDigits));
    currentCheckout.value.sub_total = grandTotal;
    currentCheckout.value.delivery_fees = Helper.calculateDeliveryFees().toDouble();
    currentCheckout.value.tax = tax;
    currentCheckout.value.payment.tax = tax;
    currentCheckout.value.discount = saveamount  + discountAmount;
    currentCheckout.value.discount = double.parse(currentCheckout.value.discount.toStringAsFixed(setting.value.currencyDecimalDigits)).abs();
    currentCheckout.value.grand_total = (grandTotal - discountAmount) +packingCharge+tax + currentCheckout.value.delivery_fees;
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    currentCart.notifyListeners();

    setState(() => couponStatus = false);
    showToast(S.of(context).your_coupon_is_removed_successfully, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);


  }

  clearCart(){
    currentCart.value.clear();
    currentCheckout.value = new Checkout();
    setCurrentCartItem();
  }

  void gotoPayment() {
    currentCheckout.value.address.addressSelect = currentUser.value.selected_address;
    currentCheckout.value.address.userId = currentUser.value.id;
    currentCheckout.value.address.phone = currentUser.value.phone;
    currentCheckout.value.address.username = currentUser.value.name;
    currentCheckout.value.userId = currentUser.value.id;
    currentCheckout.value.address.longitude = currentUser.value.longitude;
    currentCheckout.value.address.latitude = currentUser.value.latitude;
    print('payment Type${currentUser.value.paymentType}');
    if(currentUser.value.paymentType=='COD'){
      currentCheckout.value.payment.paymentType = 'cash on delivery';
      currentCheckout.value.payment.method = 'cash on delivery';

    } else {
      currentCheckout.value.payment.paymentType = currentUser.value.paymentType;
      currentCheckout.value.payment.method = 'online';

    }

    currentCheckout.value.cart = currentCart.value;
    if (currentUser.value.selected_address == null) {
      showToast("Please select your address", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);

    } else {

      if(currentCheckout.value.deliverType==1 || currentCheckout.value.deliverType==3) {
        currentCheckout.value.deliveryTimeSlot = '';
        print('Delivery type ${   currentCheckout.value.uploadImage}');

        if(currentCheckout.value.uploadImage=='no') {
          paymentGate();
        }else {
          bookOrder(currentCheckout.value);
        }
      }else if (currentCheckout.value.deliveryTimeSlot == null || currentCheckout.value.deliveryTimeSlot == '') {
        showToast("Please select your deliver time slot", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);

      } else {


        if(currentCheckout.value.uploadImage=='no') {
          paymentGate();
        } else {
          bookOrder(currentCheckout.value);
        }
      }
    }
  }


  void openCheckout() async {
    var options = {
      'key': setting.value.razorpay_key,
      'amount': currentCheckout.value.grand_total * 100,
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


  paymentGate(){
    print(currentUser.value.paymentType);
    print('payment type${currentCheckout.value.payment.method}');
    print(currentCheckout.value.payment.paymentType);
    paymentProcess();
    if (currentCheckout.value.payment.method == 'online') {
    if(currentUser.value.paymentType=='RayzorPay'){
      _razorpay = Razorpay();
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
      openCheckout();
    } if(currentCheckout.value.payment.paymentType == 'Paypal'){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PayPalPaymentWidget()));
      }if(currentCheckout.value.payment.paymentType == 'Stripe'){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => StripePaymentWidget()));
      }if(currentCheckout.value.payment.paymentType == 'flutterwave'){

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => FlutterWavePaymentWidget()));
      }if(currentCheckout.value.payment.paymentType == 'Paystack'){

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => GlobalPaymentWidget(pageTitle: 'Paystack',)));
    }if(currentCheckout.value.payment.paymentType == 'wallet'){
        bookOrder(currentCheckout.value);
      } if(currentCheckout.value.payment.paymentType == 'UPI'){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentUPI()));
    } if(currentCheckout.value.payment.paymentType == 'mpesa'){

      Mpesa mpesa = Mpesa(
        clientKey: setting.value.mpesaConsumerKey,
        clientSecret: setting.value.mpesaConsumerSecret,
        passKey: setting.value.mpesaPasskey,
        environment: "sandbox",
      );

        mpesa
            .lipaNaMpesa(
          phoneNumber: currentUser.value.phone,
          amount: currentCheckout.value.grand_total,
          businessShortCode: "174379",
          callbackUrl: "https://www.google.co.in/",
        )
            .then((result) {
          bookOrder(currentCheckout.value);
        })
            .catchError((error) {
          showToast('Error', gravity: Toast.BOTTOM,
              duration: Toast.LENGTH_SHORT);
        });
    }
    } else {

      bookOrder(currentCheckout.value);
    }

  }


  paymentProcess(){


    currentCheckout.value.payment.packingCharge = currentCheckout.value.packingCharge;
    currentCheckout.value.payment.delivery_tips = currentCheckout.value.delivery_tips;
    currentCheckout.value.payment.delivery_fees = currentCheckout.value.delivery_fees;
    currentCheckout.value.payment.sub_total     = currentCheckout.value.sub_total;
    currentCheckout.value.payment.discount      = currentCheckout.value.discount;
    currentCheckout.value.payment.grand_total   = currentCheckout.value.grand_total;

  }


  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    //Fluttertoast.showToast(msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
    bookOrder(currentCheckout.value);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("ERROR: " + response.code.toString());
    //Fluttertoast.showToast(msg: "ERROR: " + response.code.toString() + " - " + response.message, timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Fluttertoast.showToast(msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }


  void bookOrder(Checkout order) {
    print('Distance${  currentCheckout.value.km}');
    order.saleCode = '${DateTime.now().millisecondsSinceEpoch}${currentUser.value.id}';
    FirebaseFirestore.instance
        .collection('orderDetails')
        .doc(order.saleCode)
        .set({'status': 'Placed', 'userId': currentUser.value.id, 'orderId': order.saleCode, 'shopId': order.shopId,'userName': currentUser.value.name,'grandState':false,
      'originLatitude': currentUser.value.latitude, 'originLongitude': currentUser.value.longitude, 'shopLatitude': double.tryParse(currentCheckout.value.shopLatitude),
      'shopLongitude': double.tryParse(currentCheckout.value.shopLongitude),'shopName':currentCheckout.value.shopName,'processingTime': Helper.calculateTime(  currentCheckout.value.km,  currentCheckout.value.handoverTime,true),}).catchError((e) {
      print(e);
    });
    Overlay.of(context).insert(loader);
    bookOrderResp().then((value) {
      if(order.uploadImage!='no') {
        sendImage(order.uploadImage, value);
      }

      if(currentCheckout.value.payment.paymentType=='wallet'){
        currentUser.value.walletAmount = (double.parse(currentUser.value.walletAmount) - currentCheckout.value.payment.grand_total).toString();
        print(currentUser.value.walletAmount);
        setCurrentUserUpdate(currentUser.value);
      }




      Navigator.of(context).pushNamed('/Thankyou', arguments: value);
    }).catchError((e) {
      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(e),
      ));
    }).whenComplete(() {
      Helper.hideLoader(loader);
      //refreshOrders();
      /** scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(S.of(context).orderThisorderidHasBeenCanceled(order.id)),
          )); */
    });
  }

  void sendImage(File image, saleCode) async {


    final String _apiToken = 'api_token=${currentUser.value.apiToken}';
    // ignore: deprecated_member_use
    final uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api/sendimage/${currentUser.value.id}/$saleCode?$_apiToken");
    var request = http.MultipartRequest('POST', uri);
    var pic = await http.MultipartFile.fromPath('image', image.path);
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      // Navigator.of(context).pushReplacementNamed('/Success');

    } else {}
  }



  getTimeSlot() async {
    final Stream<TimeSlot> stream = await getTimeSlotData();
    stream.listen((TimeSlot _timeSlot) {
      setState(() => timeSlot.add(_timeSlot));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  calculateDistance(lat1, lon1,lat2,lon2){

    setState(() => checkOutButtonLoad = true);
    double distance = Helper.distance(lat1, lon1, double.parse(lat2), double.parse(lon2), setting.value.distanceUnit);
   if(1==2) {
     currentCheckout.value.km = distance;
     if (distance < setting.value.coverDistance) {
       currentCheckout.value.deliveryPossible = true;
     } else {
       currentCheckout.value.deliveryPossible = false;
     }
     // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
     currentCart.notifyListeners();
   } else{
     getZoneId().then((value) {

       currentUser.value.zoneId = value;
       print(currentUser.value.zoneId );
       if( currentUser.value.zoneId!="no_matched" && currentCheckout.value.zoneId == currentUser.value.zoneId){
         currentCheckout.value.deliveryPossible = true;
       }else{
         currentCheckout.value.deliveryPossible = false;
       }

       setCurrentUser(currentUser.value);
       // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
       currentCart.notifyListeners();
       setState(() => checkOutButtonLoad = false);
     }).catchError((e) {

     });
   }
    print(currentCheckout.value.deliveryPossible);


  }

  void walletTopUp(amount){
    rechargeData.user_id = currentUser.value.id;
    rechargeData.type = 'credit';
    rechargeData.amount = amount;
    Overlay.of(context).insert(loader);
    SendRecharge(rechargeData).then((value) {

      if (value == true) {
        Navigator.of(context).pushReplacementNamed('/WThankyou');
      } else {
        // ignore: deprecated_member_use
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text('Error'),
        ));
      }
    }).catchError((e) {
      loader.remove();
      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text('Enter your amount'),
      ));
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  couponSearch(List<CouponModel> list, code){

      List<CouponModel> tempList = list;
      List<CouponModel> dataList = tempList
        .where((u) =>
    (u.code.toLowerCase().contains(code.toLowerCase())) ||
    (u.title.toString().toLowerCase().contains(code.toLowerCase())))
    .toList();
        return dataList;
  }


  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

}
