import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handy/src/repository/order_repository.dart';
import '/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:handy/generated/l10n.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(new MaterialApp(home: new MyBookings()));
}

class MyBookings extends StatefulWidget {
  @override
  MyBookingsState createState() => new MyBookingsState();
}

class MyBookingsState extends State<MyBookings>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 2);
    print(currentUser.value.id);
        print('current data');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: new Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(170),
          child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: SafeArea(
                child: new Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 30.0,
                            height: 50.0,
                          ),
                          Text(
                            S.of(context).booking_history,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline4.merge(
                                TextStyle(
                                    color:
                                        Theme.of(context).primaryColorLight)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 52),
                    new Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      margin: EdgeInsets.only(top: 15),
                      child: TabBar(
                        indicatorWeight: 03,
                        indicatorColor: Colors.blue,
                        labelColor: Color(0xff2D2727),
                        labelStyle: Theme.of(context).textTheme.headline1,
                        unselectedLabelStyle:
                            Theme.of(context).textTheme.subtitle2,
                        tabs: <Widget>[
                          Tab(
                              child: Text(S.of(context).process,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                  ))),
                          Tab(
                              child: Text(S.of(context).completed,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                  ))),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
        body: TabBarView(children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: 100,
            child: Column(children: [
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.88,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("HService")
                                .where("providerId",
                                    isEqualTo: currentUser.value.id)
                                .where("providerRatingStatus", isEqualTo: 'no')
                                .snapshots(),
                            builder: (context, snapshot) {

                              if (snapshot.hasError || snapshot.data == null) {
                                return Container();
                              } else {
                                return ListView.builder(
                                  itemCount: snapshot.data.docs.length,
                                  shrinkWrap: true,
                                  reverse: true,
                                  padding: EdgeInsets.only(top: 16),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot course =
                                    snapshot.data.docs[index];

                                    int timeInMillis = course['bookingTime'];
                                    var date =
                                        DateTime.fromMillisecondsSinceEpoch(
                                            timeInMillis);
                                    var formattedDate =
                                        DateFormat.d().format(date);
                                    var formattedmonth =
                                        DateFormat.MMM().format(date);
                                    var formattedyear =
                                        DateFormat.y().format(date);
                                    return Container(
                                      padding: EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 10,
                                          bottom: 10),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {


                                            currentBookView.value.bookid =
                                                course['bookId'];
                                            currentBookView.value.userid =
                                                course['userid'];
                                            currentBookView.value.username =
                                                course['username'];
                                            currentBookView.value.mobile =
                                                course['userMobile'];

                                            Navigator.of(context).pushNamed(
                                                '/BookTracking',
                                                arguments: course['bookId']);
                                          },
                                          child: Container(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  //                   <--- left side
                                                  color: Colors.grey[200],
                                                  width: 2.0,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Column(children: [
                                                        Text(formattedDate,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800)),
                                                        Text(formattedmonth),
                                                        Text(formattedyear,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey)),
                                                      ]),
                                                      SizedBox(width: 10.0),
                                                      Container(
                                                        height: 58,
                                                        width: 58,
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/img/userImage.png'),
                                                          maxRadius: 30,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 16,
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Text(
                                                                  course['username'],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 1,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  )),
                                                              SizedBox(
                                                                height: 6,
                                                              ),
                                                              Text(
                                                                course['subcategoryName'],
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Image(
                                                  image: course['status'] ==
                                                          'pending'
                                                      ? AssetImage(
                                                          "assets/img/waiting.gif")
                                                      : course['status'] ==
                                                              'accepted'
                                                          ? AssetImage(
                                                              "assets/img/my_marker.png")
                                                          : course['status'] ==
                                                                  'ontheway'
                                                              ? AssetImage(
                                                                  "assets/img/onthway.gif")
                                                              : course['status'] ==
                                                                      'processing'
                                                                  ? AssetImage(
                                                                      "assets/img/processing.gif")
                                                                  : course['status'] ==
                                                                              'paymentPending' ||
                                                                          course['status'] ==
                                                                              'confirmUnSuccess'
                                                                      ? AssetImage(
                                                                          "assets/img/paymentwaiting.gif")
                                                                      : course['status'] ==
                                                                              'completed'
                                                                          ? AssetImage(
                                                                              "assets/img/complete.jpg")
                                                                          : course['status'] == 'Success'
                                                                              ? AssetImage("assets/img/complete.jpg")
                                                                              : course['status'] == 'rejected'
                                                                                  ? AssetImage("assets/img/rejected.png")
                                                                                  : null,
                                                  fit: BoxFit.cover,
                                                  height: 50,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            height: 100,
            child: Column(children: [
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.88,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("HService")
                                .where("providerId",
                                    isEqualTo: currentUser.value.id)
                                .where("status", isEqualTo: 'Success')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError || snapshot.data == null) {
                                return Container();
                              } else {
                                return ListView.builder(
                                  itemCount: snapshot.data.docs.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(top: 16),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot course =
                                        snapshot.data.docs[index];
                                    int timeInMillis = course['bookingTime'];
                                    var date =
                                        DateTime.fromMillisecondsSinceEpoch(
                                            timeInMillis);
                                    var formattedDate =
                                        DateFormat.d().format(date);
                                    var formattedmonth =
                                        DateFormat.MMM().format(date);
                                    var formattedyear =
                                        DateFormat.y().format(date);
                                    return Container(
                                      padding: EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 10,
                                          bottom: 10),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                '/BookTracking',
                                                arguments: course['bookId']);
                                            // Navigator.of(context).pushNamed('/my_schedule');
                                          },
                                          child: Container(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  //                   <--- left side
                                                  color: Colors.grey[200],
                                                  width: 2.0,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Column(children: [
                                                        Text(formattedDate,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800)),
                                                        Text(formattedmonth),
                                                        Text(formattedyear,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey)),
                                                      ]),
                                                      SizedBox(width: 10.0),
                                                      Container(
                                                        height: 58,
                                                        width: 58,
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/img/userImage.png'),
                                                          maxRadius: 30,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 16,
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Text(
                                                                  course['username'],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 1,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  )),
                                                              SizedBox(
                                                                height: 6,
                                                              ),
                                                              Text(
                                                                course['subcategoryName'],
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Image(
                                                  image: course['status'] ==
                                                          'completed'
                                                      ? AssetImage(
                                                          "assets/img/complete.jpg")
                                                      : course['status'] ==
                                                              'Success'
                                                          ? AssetImage(
                                                              "assets/img/complete.jpg")
                                                          : course['status'] ==
                                                                  'rejected'
                                                              ? AssetImage(
                                                                  "assets/img/rejected.png")
                                                              : null,
                                                  fit: BoxFit.cover,
                                                  height: 50,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
