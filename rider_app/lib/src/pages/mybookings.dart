import 'package:flutter/material.dart';


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
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(170),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: new Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      SizedBox(width: 30.0),
                      Text('My Bookings',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          )),
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
                    indicatorColor: Colors.deepPurple,
                    labelColor: Color(0xff2D2727),
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    unselectedLabelStyle: TextStyle(),
                    tabs: <Widget>[
                      Tab(
                          child: Text('Purchase',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 18,
                              ))),
                      Tab(
                          child: Text('Completed',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 18,
                              ))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(children: [
          Container(
            color: Colors.white,
            height: 100,
            child: Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.88,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: 2,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 16),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, top: 10, bottom: 10),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
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
                                              Text('5',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w800)),
                                              Text('Oct, 20'),
                                              Text('8.0 am',
                                                  style: TextStyle(
                                                      color: Colors.grey)),
                                            ]),
                                            SizedBox(width: 10.0),
                                            Container(
                                              height: 58,
                                              width: 58,
                                              child: CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    "assets/img/userImage7.jpeg"),
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
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text('REENA JOSHEP',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        )),
                                                    SizedBox(
                                                      height: 6,
                                                    ),
                                                    Text(
                                                      'COSMETICS',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .grey.shade500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(Icons.lock),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: 100,
            child: Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.88,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: 2,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 16),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, top: 10, bottom: 10),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
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
                                              Text('5',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w800)),
                                              Text('Oct, 20'),
                                              Text('8.0 am',
                                                  style: TextStyle(
                                                      color: Colors.grey)),
                                            ]),
                                            SizedBox(width: 10.0),
                                            Container(
                                              height: 58,
                                              width: 58,
                                              child: CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    "assets/img/userImage7.jpeg"),
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
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text('REENA JOSHEP',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        )),
                                                    SizedBox(
                                                      height: 6,
                                                    ),
                                                    Text(
                                                      'COSMETICS',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .grey.shade500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(Icons.lock),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
