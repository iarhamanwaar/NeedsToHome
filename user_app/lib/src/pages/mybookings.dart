
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:multisuperstore/src/repository/hservice_repository.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../repository/user_repository.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:intl/intl.dart';


class MyBookings extends StatefulWidget {
  @override
  MyBookingsState createState() => new MyBookingsState();
}

class MyBookingsState extends State<MyBookings> with SingleTickerProviderStateMixin {
  TabController controller1;


  @override
  void initState() {
    super.initState();
    controller1 = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        print('back pressed');
        Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
        return true;
      },
      child: DefaultTabController(
        length: 2,
        child: new Scaffold(
          backgroundColor: currentUser.value.apiToken == null ? Colors.white : Colors.green,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(129),
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: new Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30.0, left: 10.0),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          color: currentUser.value.apiToken == null ? Colors.green : Theme.of(context).colorScheme.primary,
                          onPressed: () {
                            //  Navigator.of(context).pop();
                            Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
                          },
                        ),
                        SizedBox(width: 30.0),
                        Text(S.of(context).my_bookings,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline4.merge(TextStyle(color: currentUser.value.apiToken == null ? Colors.green :Theme.of(context).colorScheme.primary))
                            /*style: TextStyle(
                              color: currentUser.value.apiToken == null ? Colors.green : Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            )*/
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  currentUser.value.apiToken == null
                      ? Container()
                      : new Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                          margin: EdgeInsets.only(top: 15),
                          child: TabBar(
                            indicatorWeight: 03,
                            indicatorColor: Colors.blueAccent,
                            labelColor: Color(0xff2D2727),
                            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                            unselectedLabelStyle: TextStyle(),
                            tabs: <Widget>[
                              Tab(
                                  child: Text(S.of(context).process,
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 18,
                                      ))),
                              Tab(
                                  child: Text(S.of(context).completed,
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 18,
                                      ))),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
          body: currentUser.value.apiToken == null
              ? PermissionDeniedWidget()
              : TabBarView(children: [
                  Container(
                    color: Colors.white,
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
                                      .where("userid", isEqualTo: currentUser.value.id)
                                      .where("userRatingStatus", isEqualTo: 'no')
                              . snapshots(),
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
                                          DocumentSnapshot course = snapshot.data.docs[index];

                                          int timeInMillis = course['bookingTime'];
                                          var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
                                          var formattedDate = DateFormat.d().format(date);
                                          var formattedmonth = DateFormat.MMM().format(date);
                                          var formattedyear = DateFormat.y().format(date);

                                          return Container(
                                            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () {
                                                  currentBookView.value.providerMobile = course['providerMobile'];
                                                  currentBookView.value.providerId = course['providerId'];
                                                  currentBookView.value.providerName = course['providerName'];
                                                  currentBookView.value.bookId = course['bookId'];
                                                  Navigator.of(context).pushNamed('/H_BookingDetails', arguments: course['bookId']);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(bottom: 10),
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
                                                              Text(formattedDate, style:Theme.of(context).textTheme.headline4.merge(TextStyle(fontWeight: FontWeight.w800)),),
                                                              Text(formattedmonth),
                                                              Text(formattedyear, style: TextStyle(color: Colors.grey)),
                                                            ]),
                                                            SizedBox(width: 10.0),
                                                            Container(
                                                              height: 58,
                                                              width: 58,
                                                              child: CircleAvatar(
                                                                backgroundImage: NetworkImage(
                                                                    '${GlobalConfiguration().getValue('base_upload')}uploads/provider_image/provider_${course['providerId']}.jpg'),
                                                                maxRadius: 30,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 16,
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Text(course['providerName'],
                                                                        overflow: TextOverflow.ellipsis,
                                                                        maxLines: 1,
                                                                      style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(fontWeight: FontWeight.w700))
                                                                       ),
                                                                    SizedBox(
                                                                      height: 6,
                                                                    ),
                                                                    Text(
                                                                      course['categoryName'],
                                                                      overflow: TextOverflow.ellipsis,
                                                                      maxLines: 1,
                                                                      style: Theme.of(context).textTheme.caption
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Image(
                                                            image: course['status'] == 'pending'
                                                                ? AssetImage("assets/img/waiting.gif")
                                                                : course['status'] == 'accepted'
                                                                ? AssetImage("assets/img/my_marker.png")
                                                                : course['status'] == 'ontheway'
                                                                ? AssetImage("assets/img/onthway.gif")
                                                                : course['status'] == 'processing'
                                                                ? AssetImage("assets/img/processing.gif")
                                                                : course['status'] == 'processing'
                                                                ? AssetImage("assets/img/processing.gif")
                                                                : course['status'] == 'paymentPending'
                                                                ? AssetImage("assets/img/completed.png")
                                                                : course['status'] == 'rejected'
                                                                ? AssetImage("assets/img/rejected.png")
                                                                : AssetImage("assets/img/rejected.png"),
                                                            fit: BoxFit.cover,
                                                            height: 40,
                                                          ),
                                                          course['status'] == 'pending'
                                                              ? Text('Pending', style: Theme.of(context).textTheme.caption)
                                                              : course['status'] == 'accepted'
                                                              ? Text('Accepted', style: Theme.of(context).textTheme.caption)
                                                              : course['status'] == 'ontheway'
                                                              ? Text('On the way', style: Theme.of(context).textTheme.caption)
                                                              : course['status'] == 'processing'
                                                              ? Text('Processing', style: Theme.of(context).textTheme.caption)
                                                              : course['status'] == 'paymentPending'
                                                              ? Text('Payment Pending', style: Theme.of(context).textTheme.caption)
                                                              : course['status'] == 'rejected'
                                                              ? Text('Rejected', style: Theme.of(context).textTheme.caption)
                                                              : Text(''),
                                                        ],
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
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    color: Colors.white,
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
                                      .where("userid", isEqualTo: currentUser.value.id)
                                      .where("userRatingStatus", isEqualTo: 'true')
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
                                          DocumentSnapshot course = snapshot.data.docs[index];

                                          int timeInMillis = course['bookingTime'];
                                          var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
                                          var formattedDate = DateFormat.d().format(date);
                                          var formattedmonth = DateFormat.MMM().format(date);
                                          var formattedyear = DateFormat.y().format(date);
                                          return Container(
                                            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () {
                                                  currentBookView.value.providerMobile = course['providerMobile'];
                                                  currentBookView.value.providerId = course['providerId'];
                                                  currentBookView.value.providerName = course['providerName'];
                                                  currentBookView.value.bookId = course['bookId'];
                                                  Navigator.of(context).pushNamed('/H_BookingDetails', arguments: course['bookId']);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(bottom: 10),
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
                                                              Text(formattedDate, style:Theme.of(context).textTheme.headline4.merge(TextStyle(fontWeight: FontWeight.w800)),),
                                                              Text(formattedmonth),
                                                              Text(formattedyear, style: TextStyle(color: Colors.grey)),
                                                            ]),
                                                            SizedBox(width: 10.0),
                                                            Container(
                                                              height: 58,
                                                              width: 58,
                                                              child: CircleAvatar(
                                                                backgroundImage: NetworkImage(
                                                                    '${GlobalConfiguration().getValue('base_upload')}uploads/provider_image/provider_${course['providerId']}.jpg'),
                                                                maxRadius: 30,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 16,
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Text(course['providerName'],
                                                                        overflow: TextOverflow.ellipsis,
                                                                        maxLines: 1,
                                                                        style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(fontWeight: FontWeight.w700))
                                                                    ),
                                                                    SizedBox(
                                                                      height: 6,
                                                                    ),
                                                                    Text(
                                                                      course['categoryName'],
                                                                      overflow: TextOverflow.ellipsis,
                                                                      maxLines: 1,
                                                                      style: Theme.of(context).textTheme.caption
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Image(
                                                            image: course['userRatingStatus'] == 'true'
                                                                ? AssetImage("assets/img/complete.png")
                                                                : course['status'] == 'rejected'
                                                                ? AssetImage("assets/img/rejected.png")
                                                                : AssetImage("assets/img/rejected.png"),
                                                            fit: BoxFit.cover,
                                                            height: 40,
                                                          ),
                                                          course['status'] == 'paymentPending'
                                                              ? Text('Payment Pending', style: Theme.of(context).textTheme.caption)
                                                              : course['status'] == 'rejected'
                                                              ? Text('Rejected', style: Theme.of(context).textTheme.caption)
                                                              : Text(''),
                                                        ],
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
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ]),
        ),
      ),
    );
  }
}
