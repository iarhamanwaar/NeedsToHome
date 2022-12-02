import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';
import '../../generated/l10n.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

class VendorList extends StatefulWidget {
  @override
  _VendorListState createState() => _VendorListState();
}

class _VendorListState extends State<VendorList>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool isSwitched = false;

  bool status = false;
  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0),
      child: Column(
        children: [
          // give the tab bar a height [can change hheight to preferred height]

          Container(
            //color:Colors.white70,
            color: Theme.of(context).primaryColor.withOpacity(0.6),
            child: Container(
              margin: EdgeInsets.only(
                  left: 20.0, top: 40.0, right: 20, bottom: 10.0),
              child: Wrap(alignment: WrapAlignment.spaceBetween, children: [
                Div(
                    colS: 6,
                    colM: 6,
                    colL: 6,
                    child: Wrap(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(S.of(context).vendor_list,
                            style: Theme.of(context).textTheme.headline4),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        padding: EdgeInsets.zero,
                        color: Theme.of(context).colorScheme.secondary,
                        icon: const Icon(Icons.shopping_cart),
                        iconSize: 20.0,
                        //color: Palette.facebookBlue,
                        onPressed: () {},
                      ),
                    ])),
                Div(
                  colS: 6,
                  colM: 6,
                  colL: 6,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 20.0,
                                spreadRadius: 5.0,
                              ),
                            ]),
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: S.of(context).search,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .caption
                                .merge(TextStyle(fontSize: 14)),
                            suffixIcon: Icon(Icons.search,
                                color: Theme.of(context).colorScheme.secondary),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                          ),
                        ))
                  ]),
                ),
              ]),
            ),
          ),

          Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
                //color:Colors.white70,
                color: Theme.of(context).primaryColor.withOpacity(0.6)),
            child: TabBar(
              controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicatorWeight: 2.0,
              isScrollable: true,
              indicatorColor: Color(0xFF5e078e),
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.teal,
              tabs: [
                // first tab [you can add an icon using the icon property]
                Tab(
                    child: Container(
                  child: Text(S.of(context).new_orders,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                )),

                // second tab [you can add an icon using the icon property]
                Tab(
                    child: Container(
                  child: Text(S.of(context).prepared,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                )),
                Tab(
                    child: Container(
                  child: Text(S.of(context).delivered,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                )),

                // second tab [you can add an icon using the icon property]
                Tab(
                    child: Container(
                  child: Text(S.of(context).cancelled,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                )),
                Tab(
                    child: Container(
                  child: Text(S.of(context).delivered,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                )),

                // second tab [you can add an icon using the icon property]
                Tab(
                    child: Container(
                  child: Text(S.of(context).cancelled,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                )),
              ],
            ),
          ),
          // tab bar view here
          SizedBox(height: 5),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  child: SingleChildScrollView(
                    child: Responsive(children: [
                      Div(
                        colS: 12,
                        colM: 12,
                        colL: 12,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                children: List.generate(3, (index) {
                                  return InkWell(
                                    child: Div(
                                      colS: 12,
                                      colM: 12,
                                      colL: 4,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 5.0,
                                                spreadRadius: 1.0,
                                              ),
                                            ]),
                                        margin: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 10.0,
                                            bottom: 10),
                                        child: Column(children: [
                                          Stack(children: [
                                            ClipRRect(
                                                //borderRadius: BorderRadius.all(Radius.circular(10)),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0),
                                                ),
                                                child: Image(
                                                    image: AssetImage(
                                                        'assets/img/userImage5.jpeg'),
                                                    width: double.infinity,
                                                    height: 150,
                                                    fit: BoxFit.fill)),
                                            ClipRRect(
                                              //borderRadius: BorderRadius.all(Radius.circular(10)),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(0),
                                              ),
                                              child: Container(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.01,
                                                      ),
                                                      Container(
                                                        height: 150,
                                                        width: double.infinity,
                                                        child: Stack(children: [
                                                          Container(
                                                            alignment: Alignment
                                                                .bottomLeft,

                                                            /* background black light to dark gradient color */
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient:
                                                                  new LinearGradient(
                                                                begin:
                                                                    const Alignment(
                                                                        0.0,
                                                                        -1.0),
                                                                end:
                                                                    const Alignment(
                                                                        0.0,
                                                                        0.6),
                                                                colors: <Color>[
                                                                  const Color(
                                                                          0x8A000000)
                                                                      .withOpacity(
                                                                          0.0),
                                                                  const Color(
                                                                          0x8A000000)
                                                                      .withOpacity(
                                                                          0.9),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                              bottom: 10,
                                                              left: 10,
                                                              right: 10,
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        S.of(context).restaurant_and_restores,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white)),
                                                                    Text(
                                                                        S.of(context).delivering_all_type_of_cuisines,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white)),
                                                                  ]))
                                                        ]),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ]),
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 10,
                                                        bottom: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 45,
                                                          width: 45,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    "assets/img/userImage5.jpeg"),
                                                                fit: BoxFit
                                                                    .fill),
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    Colors.grey,
                                                                blurRadius: 5.0,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text('Luxury Beauty '),
                                                      ],
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 15,
                                                        right: 15,
                                                        bottom: 10),
                                                    child: Wrap(children: [
                                                      Icon(Icons.phone,
                                                          size: 15,
                                                          color: Colors.grey),
                                                      SizedBox(width: 5),
                                                      Text('9873393893',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey)),
                                                    ])),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 15,
                                                        right: 15,
                                                        bottom: 10),
                                                    child: Row(children: [
                                                      Icon(Icons.add_location,
                                                          size: 15,
                                                          color: Colors.grey),
                                                      SizedBox(width: 5),
                                                      Expanded(
                                                        child: Text(
                                                            'salem chennai, tailnadu, china, greek, banglore, coimbatore, fransisco',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey)),
                                                      )
                                                    ])),
                                                ClipRRect(
                                                  //borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(0),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                  child: Container(
                                                    color: Theme.of(context)
                                                        .dividerColor,
                                                    width: double.infinity,
                                                    padding: EdgeInsets.only(
                                                      bottom: 10,
                                                      top: 10,
                                                      left: 15,
                                                      right: 15,
                                                    ),
                                                    child: Wrap(children: [
                                                      Div(
                                                        colS: 4,
                                                        colM: 4,
                                                        colL: 4,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          // ignore: deprecated_member_use
                                                          child: FlatButton(
                                                            onPressed: () {},
                                                            color: Colors.blue,
                                                            splashColor:
                                                                Colors.blue,
                                                            textColor:
                                                                Colors.white,
                                                            child: Text(
                                                                S
                                                                    .of(context)
                                                                    .view_more,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText2
                                                                    .merge(TextStyle(
                                                                        color: Colors
                                                                            .white))),
                                                          ),
                                                        ),
                                                      ),
                                                      Div(
                                                        colS: 4,
                                                        colM: 4,
                                                        colL: 4,
                                                        child: GestureDetector(
                                                          onTap: () {},
                                                          child: Center(
                                                            child: Switch(
                                                              value: isSwitched,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  isSwitched =
                                                                      value;
                                                                  print(
                                                                      isSwitched);
                                                                });
                                                              },
                                                              activeTrackColor:
                                                                  Colors
                                                                      .lightGreenAccent,
                                                              activeColor:
                                                                  Colors.green,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Div(
                                                        colS: 4,
                                                        colM: 4,
                                                        colL: 3,
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 10),
                                                            child: Wrap(
                                                                alignment:
                                                                    WrapAlignment
                                                                        .end,
                                                                children: [
                                                                  Icon(
                                                                      Icons
                                                                          .star,
                                                                      size: 17,
                                                                      color: Colors
                                                                          .orangeAccent),
                                                                  SizedBox(
                                                                      width: 3),
                                                                  Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top:
                                                                              2),
                                                                      child: Text(
                                                                          '4'))
                                                                ])),
                                                      )
                                                    ]),
                                                  ),
                                                ),
                                              ])
                                        ]),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ]),
                      ),
                    ]),
                  ),
                ),
                Container(child: Text('tsr')),
                Container(child: Text('tsr')),
                Container(child: Text('tsr')),
                Container(child: Text('tsr')),
                Container(child: Text('tsr')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
