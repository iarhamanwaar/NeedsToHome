import 'package:after_layout/after_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:products_deliveryboy/src/controllers/order_details_controller.dart';
import 'package:products_deliveryboy/src/pages/providerhome.dart';
import 'package:products_deliveryboy/src/repository/user_repository.dart';
import '../elements/DrawerWidget.dart';
import '../models/route_argument.dart';
import '../pages/orders.dart';
import '../pages/orders_history.dart';
import '../pages/profile.dart';

// ignore: must_be_immutable
class PagesTestWidget extends StatefulWidget {
  dynamic currentTab;
  RouteArgument routeArgument;
  Widget currentPage = OrdersWidget();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  PagesTestWidget({
    Key key,
    this.currentTab,
  }) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 1;
    }
  }

  @override
  _PagesTestWidgetState createState() {
    return _PagesTestWidgetState();
  }
}

class _PagesTestWidgetState extends State<PagesTestWidget>
    with AfterLayoutMixin<PagesTestWidget> {
  initState() {
    super.initState();
    _selectTab(widget.currentTab);
  }

  @override
  void didUpdateWidget(PagesTestWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem == 3 ? 1 : tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage =
              ProfileWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 1:
          widget.currentPage =
              ProviderHome(parentScaffoldKey: widget.scaffoldKey);
          break;

        case 2:
          widget.currentPage =
              OrdersWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 3:
          widget.currentPage =
              OrdersHistoryWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: widget.scaffoldKey,
        drawer: DrawerWidget(),
        body: widget.currentPage,
        bottomNavigationBar: SnakeNavigationBar.color(
          behaviour: SnakeBarBehaviour.floating,
          snakeShape: SnakeShape.circle,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          padding: const EdgeInsets.all(10),

          backgroundColor: Colors.transparent,
          unselectedItemColor: Colors.blueGrey,

          snakeViewColor: Theme.of(context).focusColor,

          currentIndex: widget.currentTab,
          onTap: (int i) {
            print(i);
            this._selectTab(i);
          },
          // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),

            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.wifi_tethering_sharp),

            ),
          ],
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) async {


    // TODO: implement afterFirstLayout
    if (currentUser.value.firstLoad) {
      if (currentUser.value.apiToken != null) {
        FirebaseFirestore.instance
            .collection("orderDetails")
            .where("driverId", isEqualTo: currentUser.value.id)
            .where("status", isEqualTo: 'RShipped')
            .where("driverStatus", isEqualTo: 'Waiting')
            .snapshots()
            .listen((snapshot) {
          snapshot.docs.forEach((result) {
            _showAlert(context, result, _selectTab);
          });
        });
      }
    }
  }

  void _showAlert(BuildContext context, course, tab) {
    loadCallMusic();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ExitConfirmationDialogranger(
            course: course, currentTab: tab, player: player));
  }

  final player = AudioPlayer();
  Future loadCallMusic() async {
    await player.setAsset('assets/audio/calling.mp3');
    await player.play();
  }
}

// ignore: must_be_immutable
class ExitConfirmationDialogranger extends StatefulWidget {
  ExitConfirmationDialogranger(
      {Key key, this.course, this.currentTab, this.player})
      : super(key: key);
  DocumentSnapshot course;
  dynamic currentTab;
  final player;
  @override
  _ExitConfirmationDialograngerState createState() =>
      _ExitConfirmationDialograngerState();
}

class _ExitConfirmationDialograngerState
    extends StateMVC<ExitConfirmationDialogranger> {
  OrderDetailsController _con;
  _ExitConfirmationDialograngerState() : super(OrderDetailsController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    /**  int timeInMillis = widget.course['bookingtime'];
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    var formattedDate = DateFormat.d().format(date);
    var formattedmonth = DateFormat.MMM().format(date);
    var formattedyear = DateFormat.y().format(date); */
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          height: 380,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'NEW ASSIGN',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'assets/img/driverboy.png',
                    height: 80,
                    width: 80,
                  ),
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12))),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                '${widget.course['shopName']}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Text(
                  '${widget.course['shopName']} sent you a request for delivery',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25, left: 25, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RawMaterialButton(
                      onPressed: () async {
                        await widget.player.stop();
                        //  _con.updateData(widget.course.id, 'rejected');
                        return Navigator.of(context).pop(true);
                      },
                      elevation: 2.0,
                      fillColor: Colors.redAccent,
                      child: Icon(
                        Icons.close,
                        size: 28.0,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                    RawMaterialButton(
                      onPressed: () async {
                        _con.statusAccepted(
                            'Accepted', widget.course['orderId'], '');
                        //  widget.currentTab(2);
                        await widget.player.stop();
                        Navigator.of(context).pop(true);
                      },
                      elevation: 2.0,
                      fillColor: Theme.of(context).colorScheme.secondary,
                      child: Icon(
                        Icons.check,
                        size: 28.0,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
