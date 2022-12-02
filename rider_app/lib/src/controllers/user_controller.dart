import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:products_deliveryboy/src/helpers/helper.dart';
import 'package:products_deliveryboy/src/models/register.dart';
import 'package:products_deliveryboy/src/models/zonelistmodel.dart';
import 'package:products_deliveryboy/src/pages/otp_verification_email.dart';
import 'package:products_deliveryboy/src/repository/user_repository.dart';
import '../../generated/l10n.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as repository;

class UserController extends ControllerMVC {
  User user = new User();
  bool hidePassword = true;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  List<ZoneListModel> zoneList = <ZoneListModel>[];
  RegisterModel registerData = new RegisterModel();
  OverlayEntry loader;
  String otpNumber;
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];
  UserController() {
    loader = Helper.overlayLoader(context);
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();


  }




  Future<void> listenForZone() async {

    final Stream<ZoneListModel> stream = await getZoneList();
    stream.listen((ZoneListModel _list) {
      setState(() => zoneList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      print(zoneList.length);
    });
  }


  void login() async {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.login(user).then((value) {
        if (value.apiToken != null) {
          currentUser.value.liveStatus = false;
          Fluttertoast.showToast(
            msg: "${S.of(context).login} ${S.of(context).successfully}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
          );
          gettoken();
          if(value.approveState){
            Navigator.of(context).pushReplacementNamed('/Pages', arguments: 1);
          }else {
            Navigator.of(context).pushReplacementNamed('/NoticeBoard');
          }
        } else {
          // ignore: deprecated_member_use
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text(S.of(context).wrong_email_or_password),
          ));
        }
      }).catchError((e) {
        loader.remove();
        // ignore: deprecated_member_use
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(S.of(context).this_account_is_not_exist),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  getLatLong(registerData) async {
    if (formKeys[1].currentState.validate()) {
      formKeys[1].currentState.save();
      final query = "${registerData.address1},${registerData
          .address2},${registerData.city}, ${registerData.state},${registerData
          .zipcode}";


      List<Location> locations = await locationFromAddress(query);
      locations.forEach((element) {
        registerData.latitude = element.latitude;
        registerData.longitude = element.longitude;
      });
    }
    registrationNext(1,'step3', registerData);


  }
  gettoken() {

    FirebaseMessaging.instance.getToken().then((deviceid) {
      var table = 'driver' + currentUser.value.id;
      FirebaseFirestore.instance.collection('driverToken').doc(table).set({'Token': deviceid, 'Id': currentUser.value.id}).catchError((e) {
        print('firebase error');
        print(e);

      });
    });
  }


  void register(File image,File proofImage, registerData) async {
    FocusScope.of(context).unfocus();
    Overlay.of(context).insert(loader);

    final uri = Uri.parse("${GlobalConfiguration().getValue('api_base_url')}Api_delivery/register/");
    var request = http.MultipartRequest('POST', uri);
    print(registerData.toMap());
    request.fields['name'] = json.encode(registerData.toMap());

    var pic = await http.MultipartFile.fromPath('image', image.path);
    request.files.add(pic);
    var pic2 = await http.MultipartFile.fromPath('proofImage', proofImage.path);
    request.files.add(pic2);
    var response = await request.send();
    print(uri);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "${S.of(context).register} ${S.of(context).successfully}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
      );
       Navigator.of(context).pushReplacementNamed('/Login');

      Helper.hideLoader(loader);
    } else {
      Helper.hideLoader(loader);
    }
  }

  registrationNext(step,page,RegisterModel details){
    if (formKeys[step].currentState.validate()) {
      formKeys[step].currentState.save();
      print(details.toMap());
      Navigator.of(context).pushNamed('/$page', arguments: details );
    }
  }

  void otpVerification(email, con) {
    var rng = new Random();

    String code = (rng.nextInt(9000) + 1000).toString();
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();

      repository.resetPassword(user.email, code).then((value) {

      }).whenComplete(() {

      });

     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OtpVerificationEmail(email: email,otp: code,con: con,)));
    }
  }

  updatePassword(User user) {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);

      repository.updatePassword(user).then((value) {

        Navigator.of(context).pushReplacementNamed('/Login');

      }).catchError((e) {
        loader.remove();
        // ignore: deprecated_member_use

      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

}
