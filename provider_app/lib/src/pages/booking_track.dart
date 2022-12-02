import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handy/src/helpers/helper.dart';
import '/src/controllers/order_controller.dart';
import '/src/elements/CircularLoadingWidget.dart';
import '/src/repository/order_repository.dart';
import '/src/repository/user_repository.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';
import 'package:handy/generated/l10n.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'dart:io';
import 'chat_detail_page.dart';

final stateBloc = StateBloc();

class BookingTrack extends StatefulWidget {
  final Map<String, dynamic> dish;

  BookingTrack({
    this.dish,
  });

  @override
  _BookingTrackState createState() => _BookingTrackState();
}

class _BookingTrackState extends StateMVC<BookingTrack> {
  OrderController _con;
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  _BookingTrackState() : super(OrderController()) {
    _con = controller;
  }

  final _isHours = true;
  bool pageState = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    isLapHours: false,
  );
  String takentime;

  void initState() {
    super.initState();
  }

  File _image;

  _startCamera(
      BuildContext context, OrderController con, bookId, _stopWatchTimer, type) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context1) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                color: Color(0xff737373),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context1).primaryColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.rectangle,
                              border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey[200],
                                    width: 1,
                                  ))),
                          child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  S.of(context).take_a_photo,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .merge(TextStyle(
                                    color: Theme.of(context).disabledColor,
                                  )),
                                  textAlign: TextAlign.left,
                                ),
                              )),
                        ),
                        InkWell(
                          onTap: () async {
                            final picker = ImagePicker();
                            final pickedFile = await picker.pickImage(
                                source: ImageSource.camera);

                            setState(() {
                              if (pickedFile != null) {
                                _image = File(pickedFile.path);
                              } else {
                                print('No image selected.');
                              }
                            });
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: _image == null
                                  ? Image.asset(
                                'assets/img/camera.png',
                                height: 120,
                                width: 120,
                              )
                                  : Image.file(_image, height: 120, width: 190),
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12))),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _image != null
                              // ignore: deprecated_member_use
                                  ? FlatButton(
                                onPressed: () async {
                         if(type!='Fixed') {
                           _stopWatchTimer.onExecute
                               .add(StopWatchExecute.start);
                         }

                                  con.uploadServiceImage(
                                      'before', bookId, _image);
                                  con.updateData(bookId, 'processing');

                                  this.setState(() {
                                    pageState = false;
                                  });
                                  Navigator.of(context).pop();

                                  return 'start';
                                },
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 40),
                                color: Theme.of(context)
                                    .colorScheme.secondary
                                    .withOpacity(1),
                                shape: StadiumBorder(),
                                child: Text(
                                  S.of(context).ok,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .merge(TextStyle(
                                      color: Theme.of(context)
                                          .primaryColorDark)),
                                ),
                              )
                                  : Container(),
                              GestureDetector(
                                onTap: () {
            if(type!='Fixed') {
              _stopWatchTimer.onExecute
                  .add(StopWatchExecute.start);
            }
                                  con.updateData(bookId, 'processing');

                                  this.setState(() {
                                    pageState = false;
                                  });
                                  Navigator.of(context).pop();

                                  //  return 'start';
                                },
                                child: new Text(
                                  S.of(context).skip,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .merge(TextStyle(
                                      color:
                                      Theme.of(context).primaryColorDark)),
                                ),
                              )
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        _con.backError();
        return pageState;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        key: _con.scaffoldKey,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Stack(
                children: <Widget>[
                  // ignore: missing_required_param

                  Container(

                    color: Theme.of(context).primaryColorDark,
                    child: Column(children: [

                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        padding: EdgeInsets.only(top: 27.0, left: 10.0),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                if (pageState == true) {
                                  Navigator.pop(context);
                                } else {
                                  _con.backError();
                                }
                              },
                            ),
                            SizedBox(width: 30.0),
                            Text(
                              S.of(context).booking_track,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("HService")
                              .where("bookId",
                              isEqualTo: currentBookView.value.bookid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError || snapshot.data == null) {
                              return Container(
                                child: Text(S.of(context).test),
                              );
                            } else {
                              return Flexible(
                                child: Container(
                                  child: ListView.builder(
                                      itemCount: snapshot.data.docs.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(top: 16),
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot course =
                                        snapshot.data.docs[index];

                                        return Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.54,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.vertical(
                                                  top: Radius.circular(
                                                      40.0)),
                                              color: Theme.of(context).primaryColor),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width *
                                                            0.04,
                                                        right: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width *
                                                            0.04,
                                                        top: 20.0,
                                                        bottom: 0.0),
                                                    child: Text(
                                                      '#${course['bookId']}',
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1,
                                                    )),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.04,
                                                      right:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.04,
                                                      top: 0.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: <Widget>[
                                                      Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Container(
                                                                height: 45,
                                                                width: course[
                                                                'status'] ==
                                                                    'ontheway'
                                                                    ? 70
                                                                    : course['status'] ==
                                                                    'processing'
                                                                    ? 90
                                                                    : 50,
                                                                decoration:
                                                                new BoxDecoration(
                                                                    image:
                                                                    new DecorationImage(
                                                                      image: course['status'] ==
                                                                          'pending'
                                                                          ? AssetImage(
                                                                          "assets/img/waiting.gif")
                                                                          : course['status'] ==
                                                                          'accepted'
                                                                          ? AssetImage(
                                                                          "assets/img/my_marker.png")
                                                                          : course['status'] == 'ontheway'
                                                                          ? AssetImage("assets/img/onthway.gif")
                                                                          : course['status'] == 'processing'
                                                                          ? AssetImage("assets/img/processing.gif")
                                                                          : course['status'] == 'paymentPending' || course['status'] == 'confirmUnSuccess'
                                                                          ? AssetImage("assets/img/paymentwaiting.gif")
                                                                          : course['status'] == 'Success'
                                                                          ? AssetImage("assets/img/complete.jpg")
                                                                          : course['status'] == 'rejected'
                                                                          ? AssetImage("assets/img/rejected.png")
                                                                          : null,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ))),
                                                          ]),
                                                      course['status'] !=
                                                          'processing'
                                                          ? SizedBox(height: 5)
                                                          : Container(),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          course['status'] !=
                                                              'processing'
                                                              ? Text(course['subcategoryName'])
                                                              : Container(),
                                                        ],
                                                      ),
                                                      course['status'] ==
                                                          'processing' && course['type'] != 'Fixed'
                                                          ? StreamBuilder<int>(
                                                        stream:
                                                        _stopWatchTimer
                                                            .rawTime,
                                                        initialData:
                                                        _stopWatchTimer
                                                            .rawTime
                                                            .value,
                                                        builder: (context,
                                                            snap) {
                                                          final value =
                                                              snap.data;
                                                          double num1;
                                                          int num2;
                                                          num1 = value /
                                                              60000;
                                                          num2 = num1
                                                              .round();
                                                          final displayTime =
                                                          StopWatchTimer.getDisplayTime(
                                                              value,
                                                              hours:
                                                              _isHours);

                                                          currentTimerCatch
                                                              .value
                                                              .takenTime =
                                                              num2;
                                                          currentTimerCatch
                                                              .value
                                                              .takenhrs =
                                                              displayTime;

                                                          return Column(
                                                            children: <
                                                                Widget>[
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.all(
                                                                    8),
                                                                child:
                                                                Text(
                                                                  displayTime,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                      22,
                                                                      fontFamily:
                                                                      'Helvetica',
                                                                      fontWeight:
                                                                      FontWeight.bold),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      )
                                                          : Container(),
                                                      SizedBox(height: 5),
                                                      Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [

                                                            course['status'] ==
                                                                'pending'
                                                            // ignore: deprecated_member_use
                                                                ?FlatButton(
                                                              onPressed:
                                                                  () async {

                                                                _con.updateData( course['bookId'], 'accepted');
                                                              },
                                                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                                                              color: Theme.of(
                                                                  context)
                                                                  .colorScheme.secondary
                                                                  .withOpacity(
                                                                  1),
                                                              shape:
                                                              StadiumBorder(),
                                                              child: Text('Accept',
                                                                style: Theme.of(
                                                                    context)
                                                                    .textTheme
                                                                    .headline6
                                                                    .merge(
                                                                    TextStyle(color: Theme.of(context).primaryColorLight)),
                                                              ),
                                                            ):
                                                            course['status'] ==
                                                                'accepted'
                                                            // ignore: deprecated_member_use
                                                                ? FlatButton(
                                                              onPressed:
                                                                  () async {
                                                                _con.updateData(
                                                                    course[
                                                                    'bookId'],
                                                                    'ontheway');
                                                              },
                                                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                                                              color: Theme.of(
                                                                  context)
                                                                  .colorScheme.secondary
                                                                  .withOpacity(
                                                                  1),
                                                              shape:
                                                              StadiumBorder(),
                                                              child: Text(
                                                                S
                                                                    .of(context)
                                                                    .on_the_way,
                                                                style: Theme.of(
                                                                    context)
                                                                    .textTheme
                                                                    .headline6
                                                                    .merge(
                                                                    TextStyle(color: Theme.of(context).primaryColorLight)),
                                                              ),
                                                            )
                                                                : course['status'] ==
                                                                'ontheway'
                                                            // ignore: deprecated_member_use
                                                                ? FlatButton(
                                                              onPressed:
                                                                  () async {
                                                                String result = await _startCamera(
                                                                    context,
                                                                    _con,
                                                                    course['bookId'],
                                                                    _stopWatchTimer, course['type']);

                                                                if (result == 'start' && course['type'] != 'Fixed') {
                                                                  setState(() {
                                                                    pageState = false;
                                                                  });
                                                                }
                                                              },
                                                              padding: EdgeInsets.symmetric(
                                                                  vertical:
                                                                  12,
                                                                  horizontal:
                                                                  40),
                                                              color: Theme.of(context)
                                                                  .colorScheme.secondary
                                                                  .withOpacity(1),
                                                              shape:
                                                              StadiumBorder(),
                                                              child:
                                                              Text(
                                                                S.of(context).start,
                                                                style: Theme.of(context)
                                                                    .textTheme
                                                                    .headline5
                                                                    .merge(TextStyle(color: Colors.white)),
                                                              ),
                                                            )
                                                                : course['status'] ==
                                                                'processing'
                                                            // ignore: deprecated_member_use
                                                                ? FlatButton(
                                                              onPressed:
                                                                  () async {
                                                                    if(course['type'] != 'Fixed'){
                                                                currentPayment.value.totalMin = currentTimerCatch.value.takenTime;

                                                                currentPayment.value.workedHours = getTimeString(currentPayment.value.totalMin);
                                                                var result = await _con.processComplete(course);

                                                                if (result == 'Stop' ) {
                                                                  _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                                                                  pageState = true;
                                                                } } else {
                                                                    _con.completeFixedType(course['grandTotal'], course['bookId']);
                                                                    }


                                                              },
                                                              padding:
                                                              EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                                                              color:
                                                              Theme.of(context).colorScheme.secondary.withOpacity(1),
                                                              shape:
                                                              StadiumBorder(),
                                                              child:
                                                              Text(
                                                                S.of(context).completed,
                                                                style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: Theme.of(context).primaryColorLight)),
                                                              ),
                                                            )
                                                                : course['status'] == 'paymentPending' ||
                                                                course['status'] == 'Success'
                                                                ? Padding(
                                                              padding: EdgeInsets.only(bottom: 20.0, top: 0.0),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: <Widget>[
                                                                  SizedBox(height: 10),
                                                                  Wrap(
                                                                    alignment: WrapAlignment.spaceBetween,
                                                                    children: <Widget>[
                                                                      course['type']!='Fixed'?Container(
                                                                        child: Column(
                                                                          children: <Widget>[
                                                                            Text(
                                                                              S.of(context).hours,
                                                                            ),
                                                                            Text(
                                                                              course['workedHrs'],
                                                                              style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600)),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ):Container(),
                                                                      Container(
                                                                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03, right: MediaQuery.of(context).size.width * 0.03),
                                                                        width: MediaQuery.of(context).size.width * 0.4,
                                                                        alignment: Alignment.center,
                                                                        child: RichText(
                                                                          text: new TextSpan(text: '', children: [
                                                                            new TextSpan(
                                                                              text: 'RM',
                                                                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                                                                            ),
                                                                            new TextSpan(
                                                                              text: course['grandTotal'].toString(),
                                                                              style: Theme.of(context).textTheme.headline4,
                                                                            )
                                                                          ]),
                                                                        ),
                                                                      ),
                                                                      course['type']!='Fixed'? InkWell(
                                                                          onTap: () {
                                                                            _showAlert(context, course['bookId']);
                                                                          },
                                                                          child: Container(
                                                                              child: Image(
                                                                                image: AssetImage(
                                                                                  'assets/img/bookmark.png',
                                                                                ),
                                                                                width: 40,
                                                                                height: _screenSize.height * 0.05,
                                                                                fit: BoxFit.cover,
                                                                              ))):Container(),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                                : Container(),
                                                          ]),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              );
                            }
                          }),
                    ]),
                  ),
                ],
              ),
            ),
            CustomBottomSheet(
                context: context,
                dish: widget.dish,
                con: _con,
                bookId: currentBookView.value.bookid),
          ],
        ),
        floatingActionButton: Builder(
          builder: (context) => FabCircularMenu(
            key: fabKey,
            // Cannot be `Alignment.center`
            alignment: Alignment.bottomRight,
            ringColor: Colors.white.withAlpha(25),
            ringDiameter: 300.0,
            ringWidth: 150.0,
            fabSize: 64.0,
            fabElevation: 8.0,
            fabIconBorder: CircleBorder(),

            fabColor: Colors.blue,
            fabOpenIcon: Icon(Icons.flash_on, color: Colors.white),
            fabCloseIcon: Icon(Icons.close, color: Colors.white),
            fabMargin: const EdgeInsets.all(30.0),
            animationDuration: const Duration(milliseconds: 800),

            onDisplayChange: (isOpen) {},
            children: <Widget>[
              RawMaterialButton(
                onPressed: () {
                  _callNumber();
                },
                elevation: 2.0,
                fillColor: Colors.green,
                child: Icon(Icons.call,
                    size: 28.0, color: Theme.of(context).primaryColorLight),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChatDetailPage(
                          userId: currentBookView.value.userid,
                          userName: currentBookView.value.username,
                          mobile: currentBookView.value.mobile)));
                },
                elevation: 2.0,
                fillColor: Colors.green,
                child: Icon(Icons.chat,
                    size: 28.0, color: Theme.of(context).primaryColorLight),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _callNumber() async {
    String number = currentBookView.value.mobile; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}

///////////////////
// ignore: must_be_immutable
class CustomBottomSheet extends StatefulWidget {
  BuildContext context;
  String bookId;
  final Map<String, dynamic> dish;

  CustomBottomSheet(
      {Key key,
        this.context,
        this.dish,
        @required OrderController con,
        this.bookId})
      : super(key: key);

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet>
    with SingleTickerProviderStateMixin {
  double sheetTop;

  double minSheetTop = 30;

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    double sheetTop = MediaQuery.of(widget.context).size.height * 0.4;
    double minSheetTop = 30;
    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween<double>(begin: sheetTop, end: minSheetTop)
        .animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      });
  }

  forwardAnimation() {
    controller.forward();
    stateBloc.toggleAnimation();
  }

  reverseAnimation() {
    controller.reverse();
    stateBloc.toggleAnimation();
  }

  bool isExpanded = false;

  int checkedItem = 0;

  ScrollController scrollController = ScrollController(initialScrollOffset: 0);

  bool isFav = false;
  bool isReadless = false;

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: animation.value,
      left: 0,
      child: GestureDetector(
        onTap: () {
          controller.isCompleted ? reverseAnimation() : forwardAnimation();
        },
        onVerticalDragEnd: (DragEndDetails dragEndDetails) {
          //upward drag
          if (dragEndDetails.primaryVelocity < 0.0) {
            forwardAnimation();
            controller.forward();
          } else if (dragEndDetails.primaryVelocity > 0.0) {
            reverseAnimation();
          } else {
            return;
          }
        },
        child: Container(
          padding: EdgeInsets.only(top: 25),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              color: Theme.of(context).primaryColor),
          child: Column(
            children: <Widget>[
              drawerHandle(),
              Expanded(
                  flex: 1,
                  child: ListView(
                    padding: EdgeInsets.only(left: 15),
                    children: <Widget>[
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("HService")
                              .where("bookId", isEqualTo: widget.bookId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return CircularLoadingWidget(height: 500);
                            } else {
                              int timeInMillis =
                              snapshot.data.docs[0]['bookingTime'];
                              var date = DateTime.fromMillisecondsSinceEpoch(
                                  timeInMillis);
                              var formattedDate = DateFormat.d().format(date);
                              var formattedmonth =
                              DateFormat.MMM().format(date);
                              var formattedyear = DateFormat.y().format(date);
                              var time = DateFormat('HH:mm a').format(date);
                              return Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 20.0,
                                        right: 30.0,
                                        bottom: 20.0,
                                        top: 0.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              S.of(context).booking_status,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                            Text(
                                              '${S.of(context).price}-${ snapshot.data.docs[0]['type']}',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data.docs[0]
                                              ['status'],
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColorDark,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                               Helper.pricePrint(snapshot.data.docs[0]['chargeperhrs']),
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 20.0,
                                        right: 20.0,
                                        bottom: 20.0,
                                        top: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Date',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '$formattedDate.$formattedmonth.$formattedyear $time',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20.0),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              S.of(context).address,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          width: double.infinity,
                                          child: Text(
                                            snapshot.data.docs[0]
                                            ['address'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          S.of(context).tracking_system,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),

                      /* start timeline part */
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("HStatusManager")
                              .where("bookId", isEqualTo: widget.bookId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return Container();
                            } else {
                              final f = new DateFormat('yyyy-MM-dd hh:mm a');
                              bool serviceBook =
                              snapshot.data.docs[0]['serviceBooked'];
                              bool serviceAccepted =
                              snapshot.data.docs[0]['serviceAccepted'];
                              bool startedCustomerPlaced = snapshot
                                  .data.docs[0]['startedCustomerPlaced'];
                              bool providerArrived =
                              snapshot.data.docs[0]['providerArrived'];
                              bool jobStarted =
                              snapshot.data.docs[0]['jobStarted'];
                              bool jobCompleted =
                              snapshot.data.docs[0]['jobCompleted'];

                              return Padding(
                                padding:
                                const EdgeInsets.only(left: 20, right: 40),
                                child: Container(
                                  color: Theme.of(context).primaryColor,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TimelineTile(
                                        alignment: TimelineAlign.start,
                                        isFirst: true,
                                        indicatorStyle: const IndicatorStyle(
                                          width: 20,
                                          color: Colors.green,
                                        ),
                                        afterLineStyle: LineStyle(
                                          color: serviceAccepted
                                              ? Colors.green
                                              : Color(0xFFe4e4e4),
                                          thickness: 6,
                                        ),
                                        endChild: Container(
                                          constraints: const BoxConstraints(
                                            minHeight: 80,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20.0,
                                                    top: 25.0,
                                                    right: 20.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .service_booked,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2,
                                                      ),
                                                    ),
                                                    Container(
                                                      child: serviceBook
                                                          ? Text(
                                                        f.format(new DateTime
                                                            .fromMicrosecondsSinceEpoch(snapshot
                                                            .data
                                                            .docs[0]
                                                        [
                                                        'serviceBookedTime'] *
                                                            1000)),
                                                        style: Theme.of(
                                                            context)
                                                            .textTheme
                                                            .caption,
                                                      )
                                                          : Text(''),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      TimelineTile(
                                        alignment: TimelineAlign.start,
                                        beforeLineStyle: LineStyle(
                                          color: serviceAccepted
                                              ? Colors.green
                                              : Color(0xFFe4e4e4),
                                          thickness: 6,
                                        ),
                                        afterLineStyle: LineStyle(
                                          color: startedCustomerPlaced
                                              ? Colors.green
                                              : Color(0xFFe4e4e4),
                                          thickness: 6,
                                        ),
                                        indicatorStyle: IndicatorStyle(
                                          width: 20,
                                          color: serviceAccepted
                                              ? Colors.green
                                              : Color(0xFFe4e4e4),
                                        ),
                                        endChild: Container(
                                          constraints: const BoxConstraints(
                                            minHeight: 80,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20.0,
                                                    top: 25.0,
                                                    right: 20.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .service_accepted,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2,
                                                      ),
                                                    ),
                                                    Container(
                                                      child: serviceAccepted
                                                          ? Text(
                                                        f.format(new DateTime
                                                            .fromMicrosecondsSinceEpoch(snapshot
                                                            .data
                                                            .docs[0]
                                                        [
                                                        'serviceAcceptedTime'] *
                                                            1000)),
                                                        style: Theme.of(
                                                            context)
                                                            .textTheme
                                                            .caption,
                                                      )
                                                          : Text(''),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      TimelineTile(
                                        alignment: TimelineAlign.start,
                                        beforeLineStyle: LineStyle(
                                          color: startedCustomerPlaced
                                              ? Colors.green
                                              : Color(0xFFe4e4e4),
                                          thickness: 6,
                                        ),
                                        afterLineStyle: LineStyle(
                                          color: providerArrived
                                              ? Colors.green
                                              : Color(0xFFe4e4e4),
                                          thickness: 6,
                                        ),
                                        indicatorStyle: IndicatorStyle(
                                          width: 20,
                                          color: startedCustomerPlaced
                                              ? Colors.green
                                              : Color(0xFFe4e4e4),
                                        ),
                                        endChild: Container(
                                          constraints: const BoxConstraints(
                                            minHeight: 80,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20.0,
                                                    top: 25.0,
                                                    right: 20.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .started_to_customer_place,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2,
                                                      ),
                                                    ),
                                                    Container(
                                                      child:
                                                      startedCustomerPlaced
                                                          ? Text(
                                                        f.format(new DateTime
                                                            .fromMicrosecondsSinceEpoch(snapshot
                                                            .data
                                                            .docs[0]['startedCustomerPlacedTime'] *
                                                            1000)),
                                                        style: Theme.of(
                                                            context)
                                                            .textTheme
                                                            .caption,
                                                      )
                                                          : Text(''),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      TimelineTile(
                                        alignment: TimelineAlign.start,
                                        beforeLineStyle: LineStyle(
                                          color: providerArrived
                                              ? Colors.green
                                              : Color(0xFFe4e4e4),
                                          thickness: 6,
                                        ),
                                        afterLineStyle: LineStyle(
                                          color: jobStarted
                                              ? Colors.green
                                              : Color(0xFFe4e4e4),
                                          thickness: 6,
                                        ),
                                        indicatorStyle: IndicatorStyle(
                                          width: 20,
                                          color: providerArrived
                                              ? Colors.green
                                              : Color(0xFFe4e4e4),
                                        ),
                                        endChild: Container(
                                          constraints: const BoxConstraints(
                                            minHeight: 80,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20.0,
                                                    top: 25.0,
                                                    right: 20.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .provider_arrived,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2,
                                                      ),
                                                    ),
                                                    Container(
                                                      child: providerArrived
                                                          ? Text(
                                                        f.format(new DateTime
                                                            .fromMicrosecondsSinceEpoch(snapshot
                                                            .data
                                                            .docs[0]
                                                        [
                                                        'providerArrivedTime'] *
                                                            1000)),
                                                        style: Theme.of(
                                                            context)
                                                            .textTheme
                                                            .caption,
                                                      )
                                                          : Text(''),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      TimelineTile(
                                        alignment: TimelineAlign.start,
                                        beforeLineStyle: LineStyle(
                                          color: jobStarted
                                              ? Colors.green
                                              : Color(0xFFe4e4e4),
                                          thickness: 6,
                                        ),
                                        afterLineStyle: LineStyle(
                                          color: jobCompleted
                                              ? Colors.green
                                              : Color(0xFFe4e4e4),
                                          thickness: 6,
                                        ),
                                        indicatorStyle: IndicatorStyle(
                                          width: 20,
                                          color: jobStarted
                                              ? Colors.green
                                              : Color(0xFFe4e4e4),
                                        ),
                                        endChild: Container(
                                          constraints: const BoxConstraints(
                                            minHeight: 80,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20.0,
                                                    top: 25.0,
                                                    right: 20.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .job_started,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2,
                                                      ),
                                                    ),
                                                    Container(
                                                      child: jobStarted
                                                          ? Text(
                                                        f.format(new DateTime
                                                            .fromMicrosecondsSinceEpoch(snapshot
                                                            .data
                                                            .docs[0]
                                                        [
                                                        'jobStartedTime'] *
                                                            1000)),
                                                        style: Theme.of(
                                                            context)
                                                            .textTheme
                                                            .caption,
                                                      )
                                                          : Text(''),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      TimelineTile(
                                        alignment: TimelineAlign.start,
                                        isLast: true,
                                        beforeLineStyle: LineStyle(
                                          color: jobCompleted
                                              ? Colors.green
                                              : Color(0xFFe4e4e4),
                                          thickness: 6,
                                        ),
                                        indicatorStyle: IndicatorStyle(
                                          width: 20,
                                          color: jobCompleted
                                              ? Colors.green
                                              : Color(0xFFe4e4e4),
                                        ),
                                        endChild: Container(
                                          constraints: const BoxConstraints(
                                            minHeight: 80,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20.0,
                                                    top: 25.0,
                                                    right: 20.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .job_completed,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2,
                                                      ),
                                                    ),
                                                    Container(
                                                      child: jobCompleted
                                                          ? Text(
                                                        f.format(new DateTime
                                                            .fromMicrosecondsSinceEpoch(snapshot
                                                            .data
                                                            .docs[0]
                                                        [
                                                        'jobCompletedTime'] *
                                                            1000)),
                                                        style: Theme.of(
                                                            context)
                                                            .textTheme
                                                            .caption,
                                                      )
                                                          : Text(''),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          }),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  drawerHandle() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      height: 3,
      width: 65,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Color(0xffd9dbdb)),
    );
  }
}

// ignore: must_be_immutable

class StateBloc {
  StreamController animationController = StreamController.broadcast();
  final StateProvider provider = StateProvider();

  Stream get animationStatus => animationController.stream;

  void toggleAnimation() {
    provider.toggleAnimationValue();
    animationController.sink.add(provider.isAnimating);
  }

  void dispose() {
    animationController.close();
  }
}

class StateProvider {
  bool isAnimating = true;

  void toggleAnimationValue() => isAnimating = !isAnimating;
}

void _showAlert(BuildContext context, bookId) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => BillingDetailsPopup(bookId: bookId));
}

// ignore: must_be_immutable
class BillingDetailsPopup extends StatefulWidget {
  BillingDetailsPopup({Key key, this.bookId}) : super(key: key);
  String bookId;

  @override
  _BillingDetailsPopupState createState() => _BillingDetailsPopupState();
}

class _BillingDetailsPopupState extends StateMVC<BillingDetailsPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
      insetPadding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.01,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03,
          bottom: MediaQuery.of(context).size.width * 0.03),
    );
  }

  _buildChild(BuildContext context) => SingleChildScrollView(
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("h_payment")
              .where("bookingId", isEqualTo: widget.bookId)
              .snapshots(),
          builder: (context, snapshot) {
  if (snapshot.hasError || snapshot.data == null) {
  return Container();
  } else {
   double settlementAmount = snapshot.data.docs[0]['grandTotal'] - snapshot.data.docs[0]['commissionAmount'];
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    S.of(context).payment_details,
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        S.of(context).billing_details,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, right: 10, left: 10),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(S.of(context).provider_name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2),
                              Text(
                                  snapshot.data.docs[0]
                                  ['providerName'],
                                  style:
                                  Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(S.of(context).billing_name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2),
                              Container(
                                  width: 200,
                                  child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                            snapshot.data.docs[0]
                                            ['billingName'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2),
                                      ]))
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(S.of(context).booking_id,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2),
                              Text(snapshot.data.docs[0]['bookingId'],
                                  style:
                                  Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(S.of(context).date,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2),
                              Text(snapshot.data.docs[0]['date'],
                                  style:
                                  Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(S.of(context).worked_hours,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2),
                              Text(
                                  '${snapshot.data.docs[0]['workedHours']} hrs',
                                  style:
                                  Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(S.of(context).time,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2),
                              Text('08:00 hrs',
                                  style:
                                  Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(S.of(context).price,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2),
                              Text(
                                  Helper.pricePrint(snapshot.data.docs[0]['total']),
                                  style:
                                  Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                          SizedBox(height: 12),
                          snapshot.data.docs[0]
                          ['miscellaneousAmount'] !=
                              0
                              ? Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      '/viewItemDetails',
                                      arguments:
                                      snapshot.data.documents[0]);
                                },
                                child: Text(
                                    'Miscellaneous Amount (Click)',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2),
                              ),
                              Text(
                                  Helper.pricePrint(snapshot.data.docs[0]['miscellaneousAmount']),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2),
                            ],
                          )
                              : Row(),
                        ]),
                      ),
                    ),
                  ]),
                ),
                SizedBox(height: 8),
                Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, right: 10, left: 10),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tax & Service',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Tax ${snapshot.data.docs[0]['tax']}%',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2),
                              Text(
                                  Helper.pricePrint(snapshot.data.docs[0]['taxAmount']),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Service comm ${snapshot.data.docs[0]['commission']}%',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2),
                              Text(
                                 Helper.pricePrint(snapshot.data.docs[0]['commissionAmount']),
                                  style:
                                  Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                        ]),
                      ),
                    )),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Column(children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).total,
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey)),
                        Text(
                            Helper.pricePrint(snapshot.data.docs[0]['grandTotal']),
                            style: TextStyle(
                              fontSize: 18,
                            ))
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Settlement Amount',
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey)),
                        Text(Helper.pricePrint(settlementAmount),
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.cyanAccent[700]))
                      ],
                    ),
                    SizedBox(height: 12),
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () {
                        return Navigator.of(context).pop(true);
                      },
                      padding: EdgeInsets.symmetric(
                          vertical: 14, horizontal: 100),
                      color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                      shape: StadiumBorder(),
                      child: Text(
                        S.of(context).close,
                        style: Theme.of(context).textTheme.headline6.merge(
                            TextStyle(
                                color: Theme.of(context)
                                    .primaryColorLight)),
                      ),
                    ),
                    SizedBox(height: 20),
                  ]),
                ),
              ],
            );
          }}),
    ),
  );
}
