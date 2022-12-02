import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/user.dart';
import '../repository/user_repository.dart';

class ProfileController extends ControllerMVC {
  User user = new User();

  GlobalKey<ScaffoldState> scaffoldKey;

  ProfileController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForUser();
  }

  void listenForUser() {
    getCurrentUser('second').then((_user) {
      setState(() {
        user = _user;
      });
    });
  }

  Future<void> refreshProfile() async {

    user = new User();

    listenForUser();
  }
}
