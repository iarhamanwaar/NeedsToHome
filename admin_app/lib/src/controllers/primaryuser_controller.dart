import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/driverregistermodel.dart';
import 'package:login_and_signup_web/src/models/user_model.dart';
import 'package:login_and_signup_web/src/models/vendor.dart';
import 'package:login_and_signup_web/src/models/vendorAll.dart';
import 'package:login_and_signup_web/src/repository/primaryuser_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toast/toast.dart';

class PrimaryUserController extends ControllerMVC {
  GlobalKey<FormState> bannerFormKey;
  GlobalKey<FormState> diverFormKey;
  List<VendorAllModel> vendorList = <VendorAllModel>[];
  List<VendorModel> vendorsearchList = <VendorModel>[];
  List<UserModel> userList = <UserModel>[];
  List<DriverRegistermodel> driverList = <DriverRegistermodel>[];
  DriverRegistermodel registerData = new DriverRegistermodel();
  UserModel userData=UserModel();
  OverlayEntry loader;
  PrimaryUserController() {
    loader = Helper.overlayLoader(context);
    bannerFormKey = new GlobalKey<FormState>();
    diverFormKey = new GlobalKey<FormState>();

  }




  Future<void> listenForVendor() async {
    setState(()=>vendorList.clear());
    setState(()=>vendorsearchList.clear());
    final Stream<VendorAllModel> stream = await getVendorList();
    stream.listen((VendorAllModel _list) {
      setState(() => vendorList.add(_list));
      setState(() =>vendorsearchList.addAll(_list.vendor));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      print("vendorlength:${vendorList.length}");
    });
  }

  Future<void> listenForUser() async {
    final Stream<UserModel> stream = await getUserList();
    stream.listen((UserModel _list) {
      setState(() => userList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }
  void register(pagetype) async {
    if (diverFormKey.currentState.validate()) {
      diverFormKey.currentState.save();
      FocusScope.of(context).unfocus();
      Overlay.of(context).insert(loader);
      final uri = Uri.parse("${GlobalConfiguration().getValue('api_base_url')}Api_admin/driverregister/$pagetype");
      var request = http.MultipartRequest('POST', uri);
      print(registerData.toMap());
      request.fields['name'] = json.encode(registerData.toMap());
      //Uint8List data = await registerData.image.readAsBytes();
      //List<int> list = data.cast();
      //var pic = http.MultipartFile.fromBytes('image', list, filename: 'myFile.png');
      //request.files.add(pic);
      var response = await request.send();
      print(uri);
      if (response.statusCode == 200) {
        showToast("Registed Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        //Navigator.of(context).pushReplacementNamed('/Login');

        Helper.hideLoader(loader);
      } else {
        Helper.hideLoader(loader);
      }
    }
  }
  Future<void> listenForDrivers() async {
    final Stream<DriverRegistermodel> stream = await getDriverList();
    stream.listen((DriverRegistermodel _list) {
      setState(() => driverList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  vendorDelete(id){
    Overlay.of(context).insert(loader);
    VendorDelete(id).then((value) {
      showToast("Delete Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }).catchError((e) {
      loader.remove();
    }).whenComplete(() {
      Helper.hideLoader(loader);
      listenForUser();
      listenForVendor();
    });
  }

  delete(table, id){
    Overlay.of(context).insert(loader);
    globalDelete(table, id).then((value) {
        showToast("Delete Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }).catchError((e) {
      loader.remove();
    }).whenComplete(() {
       Helper.hideLoader(loader);
     if(table=='driver'){
       listenForDrivers();
     }else {
       listenForUser();
       listenForVendor();
     }
    });
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

  void showToastPopup(String msg, context,  {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

}