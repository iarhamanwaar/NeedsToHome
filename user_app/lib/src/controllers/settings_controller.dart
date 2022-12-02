
import 'package:flutter/material.dart';
import 'package:multisuperstore/src/models/policy.dart';
import 'package:multisuperstore/src/repository/settings_repository.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as repository;

class SettingsController extends ControllerMVC {
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  List<PolicyModel> policyList=<PolicyModel>[];
  OverlayEntry loader;
  SettingsController() {

    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }


  void update(UserLocal user) async {
    repository.update(user).then((value) {
      setState(() {});
      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text('profile_settings_updated_successfully'),
      ));
    });
  }
  Future<void> listenForPolicy(id) async {

    policyList.clear();
    final Stream<PolicyModel> stream = await getPolicydata(id);
    stream.listen((PolicyModel _list) {
      setState(() => policyList.add(_list));
    }, onError: (a) {
      loader.remove();
      print(a);
    }, onDone: () {


    });
  }

}
