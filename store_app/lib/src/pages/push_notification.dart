import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:responsive_ui/responsive_ui.dart';

class PushNotifiction extends StatefulWidget {
  @override
  _PushNotifictionState createState() => _PushNotifictionState();
}

class _PushNotifictionState extends State<PushNotifiction>
    with SingleTickerProviderStateMixin {
  bool isSwitched = false;
  int dropDownValue = 0;
  int _value = 1;
  bool status = false;
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scrollbar(
        isAlwaysShown: true,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Responsive(children: [
              Padding(
                  padding: EdgeInsets.all(0),
                  child: Div(
                      colS: 12,
                      colM: 12,
                      colL: 12,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [
                                Div(
                                  colS: 12,
                                  colM: 12,
                                  colL: 6,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 20,
                                        top: 20,
                                        right: 20,
                                        bottom: 20),
                                    padding: EdgeInsets.all(27),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text( S.of(context).push_notification,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                S.of(context).select_your_user,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .merge(TextStyle(
                                                        color: Colors.grey)),
                                              ),
                                              DropdownButton(
                                                  value: _value,
                                                  isExpanded: true,
                                                  focusColor: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1,
                                                  underline: Container(
                                                    height: 1,
                                                    color: Colors.grey,
                                                  ),
                                                  items: [
                                                    DropdownMenuItem(
                                                      child: Text( S.of(context).card),
                                                      value: 1,
                                                    ),
                                                    DropdownMenuItem(
                                                      child: Text( S.of(context).cash),
                                                      value: 2,
                                                    ),
                                                    DropdownMenuItem(
                                                      child: Text(
                                                          S.of(context).internet_banking),
                                                      value: 3,
                                                    ),
                                                  ],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _value = value;
                                                    });
                                                  }),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Container(
                                            width: double.infinity,
                                            child: TextField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                  S.of(context).notification_title,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                        SizedBox(height: 20),
                                        Text(
                                          S.of(context).notification_text,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color:
                                                Theme.of(context).dividerColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextField(
                                              maxLines: 5,
                                              decoration:
                                                  InputDecoration.collapsed(
                                                hintText:  S.of(context).notification_text,
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: Colors.grey)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        /*Container(
                                           width: size.width > 670 ? 100:150,
                                           height: size.height > 670 ? 100: 100,
                                           child: GestureDetector(
                                               onTap: () {

                                               },
                                               child:Image(image:AssetImage('assets/img/userImage5.jpeg'),
                                                   height: double.infinity,
                                                   width:double.infinity,
                                                   fit:BoxFit.fill
                                               )),
                                         ),*/

                                        SizedBox(height: 40),
                                        InkWell(
                                            onTap: () {},
                                            child: Container(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              padding: EdgeInsets.only(
                                                  left: size.width * 0.05,
                                                  right: size.width * 0.05),
                                              child: Container(
                                                width: double.infinity,
                                                height: 45.0,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                // ignore: deprecated_member_use
                                                child: FlatButton(
                                                  onPressed: () {},
                                                  child: Center(
                                                      child: Text(
                                                    S.of(context).submit,
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )),
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                Div(
                                  colS: 12,
                                  colM: 12,
                                  colL: 6,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 20,
                                        bottom: 20,
                                        left: 20,
                                        right: 20),
                                    padding: EdgeInsets.all(27),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        TabBar(
                                          controller: _tabController,
                                          indicatorColor: Color(0xFF5e078e),
                                          unselectedLabelColor: Colors.grey,
                                          //labelColor: Colors.black,
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                          tabs: [
                                            Tab(
                                              child: Text( S.of(context).initial_state),
                                            ),
                                            Tab(
                                              child: Text( S.of(context).expanded_view),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 500,
                                          child: TabBarView(
                                            controller: _tabController,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 20,
                                                    bottom: 20),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          S.of(context).device_preview,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline3,
                                                        ),
                                                        SizedBox(height: 20),
                                                        Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Image(
                                                              image: AssetImage(
                                                                  'assets/img/android.png'),
                                                              width: size.width,
                                                              height: 160,
                                                              fit: BoxFit.fill,
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 55,
                                                                      left: 25,
                                                                      right:
                                                                          25),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              width: size.width,
                                                              height: 95,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text('Nagamani jsss'),
                                                                                Text('ndd'),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                              width: 20),
                                                                          Container(
                                                                            width: size.width > 670
                                                                                ? 60
                                                                                : 60,
                                                                            height: size.height > 670
                                                                                ? 60
                                                                                : 60,
                                                                            child:
                                                                                GestureDetector(onTap: () {}, child: Image(image: AssetImage('assets/img/userImage5.jpeg'), height: double.infinity, width: double.infinity, fit: BoxFit.fill)),
                                                                          ),
                                                                        ]),
                                                                  ]),
                                                            ),
                                                          ],
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.only(
                                                      left: 20,
                                                      right: 20,
                                                      top: 20,
                                                      bottom: 20),
                                                  child: SingleChildScrollView(
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                        Text(
                                                          S.of(context).device_preview,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline3,
                                                        ),
                                                        SizedBox(height: 20),
                                                        Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Image(
                                                              image: AssetImage(
                                                                  'assets/img/android.png'),
                                                              width: size.width,
                                                              height: 250,
                                                              fit: BoxFit.fill,
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 85,
                                                                      left: 26,
                                                                      right:
                                                                          26),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              width: size.width,
                                                              height: 160,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        'Naga'),
                                                                    Text('ndd'),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            width: size.width > 670
                                                                                ? 100
                                                                                : 150,
                                                                            height: size.height > 670
                                                                                ? 100
                                                                                : 100,
                                                                            child:
                                                                                GestureDetector(onTap: () {}, child: Image(image: AssetImage('assets/img/userImage5.jpeg'), height: double.infinity, width: double.infinity, fit: BoxFit.fill)),
                                                                          ),
                                                                        ]),
                                                                  ]),
                                                            ),
                                                          ],
                                                        ),
                                                      ]))),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  /*Container(
                                         margin: EdgeInsets.only(left:20),
                                         padding: EdgeInsets.all(27),
                                         decoration:BoxDecoration(
                                             color:Theme.of(context).primaryColor,
                                             borderRadius: BorderRadius.circular(10)
                                         ),
                                         child:Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                              Stack(
                                                children: [
                                                  Image(image:AssetImage('assets/img/android.png'),
                                                      width:double.infinity,
                                                      height:200
                                                  )
                                                ],
                                              ),
                                             ]))*/
                                )
                              ],
                            ),
                          ]))),
            ])
            // SideCard(),
          ],
        ));
  }
}
