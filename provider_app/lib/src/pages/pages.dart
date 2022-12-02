import 'package:after_layout/after_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:just_audio/just_audio.dart';
import '/src/controllers/order_controller.dart';
import '/src/pages/providerhome.dart';
import '/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';
import '../elements/DrawerWidget.dart';
import '../models/route_argument.dart';
import '../pages/profile.dart';
import 'package:handy/generated/l10n.dart';
import 'mybookings.dart';

// ignore: must_be_immutable
class PagesTestWidget extends StatefulWidget {
  dynamic currentTab;
  RouteArgument routeArgument;
  Widget currentPage = ProviderHome();
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
    getGroupInfo();

  }

  // the method below returns a Future

  getGroupInfo() async {}

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
          widget.currentPage = MyBookings();
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

    if (currentUser.value.apiToken != null && widget.currentTab != 2) {
      print('data load1');
      FirebaseFirestore.instance
          .collection("HService")
          .where("providerId", isEqualTo: currentUser.value.id)
          .snapshots()
          .listen((snapshot) {
        snapshot.docs.forEach((result) {
          if (result.data()["status"] == 'pending') {
            _showAlert(context, result, _selectTab);
          }
        });
      });
    }}
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
  ExitConfirmationDialogranger({Key key, this.course, this.currentTab,  this.player})
      : super(key: key);
  DocumentSnapshot course;
  final player;
  dynamic currentTab;
  @override
  _ExitConfirmationDialograngerState createState() =>
      _ExitConfirmationDialograngerState();
}

class _ExitConfirmationDialograngerState
    extends StateMVC<ExitConfirmationDialogranger> {
  OrderController _con;
  _ExitConfirmationDialograngerState() : super(OrderController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    int timeInMillis = widget.course['bookingTime'];
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    var formattedDate = DateFormat.d().format(date);
    var formattedmonth = DateFormat.MMM().format(date);
    var formattedyear = DateFormat.y().format(date);
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
                  S.of(context).new_request,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'assets/img/italy.png',
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
                '${widget.course['username']}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Text(
                  '${widget.course['providerName']} sent you a request for ${widget.course['subcategoryName']} at as soon as possible on $formattedyear-$formattedmonth-$formattedDate.',
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
                        _con.updateData(widget.course.id, 'rejected');
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
                        await widget.player.stop();
                        _con.updateData(widget.course.id, 'accepted');
                        widget.currentTab(2);
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

