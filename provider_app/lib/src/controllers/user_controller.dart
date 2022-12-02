import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:handy/src/models/zonelistmodel.dart';
import 'package:handy/src/pages/otp_verification_email.dart';
import '../../generated/l10n.dart';
import '/src/helpers/helper.dart';
import '/src/models/category.dart';
import '/src/models/register.dart';
import '/src/models/select_dropdown.dart';
import '/src/repository/category_repository.dart';
import '/src/repository/user_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as repository;
import 'package:http/http.dart' as http;

class UserController extends ControllerMVC {
  User user = new User();
  bool hidePassword = true;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<FormState> categoryFormKey;
  GlobalKey<FormState> registerFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  Category category = new Category();
  Registermodel registerData = new Registermodel();
  List<Category> categoryList = <Category>[];
  List<ZoneListModel> zoneList = <ZoneListModel>[];
  OverlayEntry loader;
  List<SelectDropdown> categoryDropdown = <SelectDropdown>[];
  List<SelectDropdown> subcategoryDropdown = <SelectDropdown>[];
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  UserController() {
    loader = Helper.overlayLoader(context);
    loginFormKey = new GlobalKey<FormState>();
    categoryFormKey = new GlobalKey<FormState>();
    registerFormKey = new GlobalKey<FormState>();
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

          if (value != null && value.apiToken != null) {
            // ignore: deprecated_member_use
            gettoken();
            Navigator.of(context).pushReplacementNamed('/Pages', arguments: 1);
          } else {
            // ignore: deprecated_member_use
         scaffoldKey?.currentState?.showSnackBar(SnackBar(
              content: Text(S.current.wrong_email_or_password),
            ));
          }
        }).catchError((e) {

          print('errors stage');
          print(e);
          //loader.remove();
          // ignore: deprecated_member_use
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text('This account is not exist'),
          ));
        }).whenComplete(() {
          Helper.hideLoader(loader);
        });

    }
  }

  registrationNext(step,page,Registermodel details){
    if (formKeys[step].currentState.validate()) {
      formKeys[step].currentState.save();
      print(details.toMap());
      Navigator.of(context).pushNamed('/$page', arguments: details );
    }
  }

  getLatLong(Registermodel registerData) async {
    if (formKeys[1].currentState.validate()) {
      formKeys[1].currentState.save();
      final query = "${registerData.address1},${registerData
          .address2},${registerData.city}, ${registerData.state},${registerData
          .zipcode}";


      List<Location> locations = await locationFromAddress(query);
      locations.forEach((element) {
        registerData.latitude = element.latitude;
        registerData.longtitude = element.longitude;
      });
    }
    registrationNext(1,'step3', registerData);


  }

  gettoken() {
    FirebaseMessaging.instance.getToken().then((deviceid) {
      var table = 'provider' + currentUser.value.id;
      FirebaseFirestore.instance.collection('providerToken').doc(table).set({'Token': deviceid, 'Id': currentUser.value.id}).catchError((e) {
        print('firebase error');
        print(e);

      });
    });
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

  void register(File image,File proofImage,registerData) async {
    FocusScope.of(context).unfocus();
    Overlay.of(context).insert(loader);
    registerData.category.clear();
    categoryList.forEach((element) {
      registerData.category.add(element);
      //  print(element.categoryName);
    });
    print(registerData.toMap());
    final uri = Uri.parse("${GlobalConfiguration().getValue('api_base_url')}Api_provider/Register/");
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = json.encode(registerData.toMap());
    var pic = await http.MultipartFile.fromPath('image', image.path);
    request.files.add(pic);

    var pic2 = await http.MultipartFile.fromPath('proofImage', proofImage.path);
    request.files.add(pic2);

    var response = await request.send();
    if (response.statusCode == 200) {
      Navigator.of(context).pushReplacementNamed('/Success');

      Helper.hideLoader(loader);
    } else {
      Helper.hideLoader(loader);
    }
  }

  void pushCategory() async {
    if (categoryFormKey.currentState.validate()) {
      categoryFormKey.currentState.save();
      setState(() {
        categoryList.add(category);
      });
    }

    category = new Category();
    Navigator.pop(context);
  }

  void popCategory(categoryData) async {
    setState(() {
      categoryList.remove(categoryData);
    });
  }

  void popCategoryDynamic(Category categoryData) async {
    setState(() {
      categoryList.remove(categoryData);
    });
    repository.removeService(categoryData.categoryId, categoryData.subcategoryId).then((value) {});
  }

  void pushCategoryDynamic() async {
    if (categoryFormKey.currentState.validate()) {
      categoryFormKey.currentState.save();
      setState(() {
        categoryList.add(category);
      });
      repository.addService(category).then((value) {});
      category = new Category();
      Navigator.pop(context);
    }
  }

  Future<void> listenForService() async {
    final Stream<Category> stream = await getService();
    stream.listen((Category _service) {
      setState(() => categoryList.add(_service));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  updatePassword(User user) {
    Overlay.of(context).insert(loader);
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();


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

  void listenForCategory() async {
    final Stream<SelectDropdown> stream = await getCategory();
    stream.listen((SelectDropdown _category) {
      setState(() {
        categoryDropdown.add(_category);
      });
      categoryDropdown.forEach((element) {
        print(element.toMap());
      });
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  void listenForSubCategory(id) async {
    refreshHome();
    final Stream<SelectDropdown> stream = await getSubCategory(id);
    stream.listen((SelectDropdown _order) {
      setState(() {
        subcategoryDropdown.add(_order);
      });
      subcategoryDropdown.forEach((element) {
        print(subcategoryDropdown.length);
        print(element.name);
      });
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> refreshHome() async {
    subcategoryDropdown = <SelectDropdown>[];
    print('test1');
  }
}
