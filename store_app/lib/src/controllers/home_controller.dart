import 'package:login_and_signup_web/src/models/bargraph.dart';
import 'package:login_and_signup_web/src/models/dashboard.dart';
import 'package:login_and_signup_web/src/models/topproducts.dart';
import 'package:login_and_signup_web/src/repository/home_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/home_repository.dart' as repository;
class HomeController extends ControllerMVC {
 //GlobalKey<FormState> bannerFormKey;

  Dashboard dashboardData = new Dashboard();
  String name;

  List<BarGraphModel> barGraphList = <BarGraphModel>[];
  List<TopProduct> topProductList=<TopProduct>[];
  HomeController() {

  //  bannerFormKey = new GlobalKey<FormState>();

  }

  Future<void> listenForTopProducts(id) async {

    final Stream<TopProduct> stream = await getTopProducts(id);
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

    final Stream<BarGraphModel> stream = await getBarGraph();
    stream.listen((BarGraphModel _list) {
      setState(() => barGraphList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      print(barGraphList.length);
    });
  }








}