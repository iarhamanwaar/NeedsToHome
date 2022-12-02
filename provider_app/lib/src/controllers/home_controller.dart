import '/src/models/dashboard_model.dart';
import '/src/models/rating.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/category.dart';
import '../repository/category_repository.dart';
import '../repository/user_repository.dart' as repository;

class HomeController extends ControllerMVC {
  List<Category> categories = <Category>[];
  DashboardModel dashboardData = new DashboardModel();
  GlobalKey<ScaffoldState> scaffoldKey;

  Rating ratingData = new Rating();
  bool liveStatus = true;
  HomeController() {
    listenForCategories();


    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void listenForCategories() async {
    final Stream<Category> stream = await getCategories();
    stream.listen((Category _category) {
      setState(() => categories.add(_category));
    }, onError: (a) {}, onDone: () {});
  }




  void rating(userId) async {
    ratingData.userId = userId;
    ratingData.providerId = repository.currentUser.value.id;
    print(ratingData.toMap());
    // repository.giveRegister(ratingData).then((value) {}).catchError((e) {}).whenComplete(() {});
    return Navigator.of(context).pop(true);
  }

  updateStatus(status) {
    repository.status(status).then((value) {
      if (status == true) {
        // ignore: deprecated_member_use
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text('You are online!'),
        ));
      } else {
        liveStatus = false;
        // ignore: deprecated_member_use
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text('You are offline!'),
        ));
      }
    });
  }

  getDashboardData() {

    repository.getDashboardDetails().then((value) {

      setState(() {
        dashboardData = value;
      });
    }).catchError((e) {

    }).whenComplete(() {

    });
  }



}

