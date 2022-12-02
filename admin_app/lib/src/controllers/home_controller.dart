
import 'package:login_and_signup_web/src/models/bargraph1.dart';

import 'package:login_and_signup_web/src/models/dashboard.dart';
import 'package:login_and_signup_web/src/models/dashboard_counter.dart';

import 'package:login_and_signup_web/src/models/top_vendor.dart';
import 'package:login_and_signup_web/src/models/topproduct.dart';
import 'package:login_and_signup_web/src/repository/home_repository.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

import '../repository/home_repository.dart' as repository;
class HomeController extends ControllerMVC {
 //GlobalKey<FormState> bannerFormKey;

  Dashboard dashboardData = new Dashboard();
  String name;

  List<BarGraph1Model> barGraphList = <BarGraph1Model>[];
  List<TopVendor> topVendorList = <TopVendor>[];
  List<TopProduct> topProductList =<TopProduct>[];
  List<DashboardCounter> dashboardCounterList = <DashboardCounter>[];
  HomeController() {

  //  bannerFormKey = new GlobalKey<FormState>();

  }


  Future<void> listenForTopProducts() async {

    final Stream<TopProduct> stream = await getTopProducts();
    stream.listen((TopProduct _list) {
      setState(() => topProductList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {

    });
  }

  listenForTopBar(){

    repository.dashboardTopBar().then((value) {
      setState(() => dashboardData = value);
    }).whenComplete(() {

    });
  }

  Future<void> listenForBarGraph() async {

    final Stream<BarGraph1Model> stream = await getBarGraph();
    stream.listen((BarGraph1Model _list) {
      setState(() => barGraphList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      print(barGraphList.length);
    });
  }

  Future<void> listenForDashboardCounter() async {

    final Stream<DashboardCounter> stream = await getDashboardCounter();
    stream.listen((DashboardCounter _list) {
      setState(() => dashboardCounterList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      print(barGraphList.length);
    });
  }

  Future<void> listenForTopVendor() async {

    final Stream<TopVendor> stream = await getTopVendor();
    stream.listen((TopVendor _list) {
      setState(() => topVendorList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {

    });
  }







}