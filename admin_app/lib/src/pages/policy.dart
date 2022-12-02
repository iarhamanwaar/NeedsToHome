import 'package:flutter/material.dart';

import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

class Policy extends StatefulWidget {
  @override
  _PolicyState createState() => _PolicyState();
}

class _PolicyState extends StateMVC<Policy>
    with SingleTickerProviderStateMixin {
  SecondaryController _con;
  TabController _tabController;

  _PolicyState() : super(SecondaryController()) {
    _con = controller;
  }

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
    _con.listenForPolicy();
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width:double.infinity,
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
                        child: Text(S.of(context).policy,
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
                  child: Text(S.of(context).terms_condition,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                )),

                // second tab [you can add an icon using the icon property]
                Tab(
                    child: Container(
                  child: Text(S.of(context).privacy_policy,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                )),
                Tab(
                    child: Container(
                      child: Text(S.of(context).return_policy,
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    )),



                // second tab [you can add an icon using the icon property]
                Tab(
                    child: Container(
                  child: Text(S.of(context).about,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                )),
                Tab(
                    child: Container(
                      child: Text(S.of(context).vendor_policy,
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    )),
              ],
            ),
          ),
          (_con.policyList.length == 0)
              ? EmptyOrdersWidget()
              : Expanded(
                  child: Form(
                  key: _con.registerFormKey,
                  child: TabBarView(controller: _tabController, children: [
                    Container(
                        child: Container(
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 20.0, bottom: 10),
                      child: Responsive(children: [
                        Div(
                          colS: 12,
                          colM: 12,
                          colL: 12,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 400,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SingleChildScrollView(
                                          child: Column(children: [
                                        TextFormField(
                                          onSaved: (input) =>
                                              _con.policyData.value = input,
                                          initialValue:
                                              _con.policyList[0].value,
                                          minLines: 10,
                                          // any number you need (It works as the rows for the textarea)
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              bottom: 10, right: 10, left: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              // ignore: deprecated_member_use
                                              FlatButton(
                                                  onPressed: () {
                                                    _con.addEditPolicy('edit', 1, context);
                                                  },

                                                padding: EdgeInsets.only(
                                                    top: 15,
                                                    bottom: 15,
                                                    left: 40,
                                                    right: 40),
                                                color: Theme.of(context)
                                                    .colorScheme.secondary
                                                    .withOpacity(1),
                                                shape: StadiumBorder(),
                                                child: Text(
                                                  S.of(context).submit,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .merge(TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColorLight)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]))),
                                ),
                              ]),
                        ),
                      ]),
                    )),
                    Container(
                        child: Container(
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 20.0, bottom: 10),
                      child: Responsive(children: [
                        Div(
                          colS: 12,
                          colM: 12,
                          colL: 12,
                          child: Column(children: [
                            Container(
                              height: 400,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SingleChildScrollView(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        TextFormField(
                                          onSaved: (input) =>
                                              _con.policyData.value = input,
                                          initialValue:
                                              _con.policyList[1].value ?? "",
                                          minLines: 10,
                                          // any number you need (It works as the rows for the textarea)
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  bottom: 10, right: 10, left: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  // ignore: deprecated_member_use
                                                  FlatButton(
                                                    onPressed: () {
                                                      _con.addEditPolicy('edit', 2, context);
                                                    },

                                                    padding: EdgeInsets.only(
                                                        top: 15,
                                                        bottom: 15,
                                                        left: 40,
                                                        right: 40),
                                                    color: Theme.of(context)
                                                        .colorScheme.secondary
                                                        .withOpacity(1),
                                                    shape: StadiumBorder(),
                                                    child: Text(
                                                      S.of(context).submit,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          .merge(TextStyle(
                                                          color: Theme.of(
                                                              context)
                                                              .primaryColorLight)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      ]))),
                            ),
                          ]),
                        ),
                      ]),
                    )),
                    Container(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 15, right: 15, top: 20.0, bottom: 10),
                          child: Responsive(children: [
                            Div(
                              colS: 12,
                              colM: 12,
                              colL: 12,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 400,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: SingleChildScrollView(
                                              child: Column(children: [
                                                TextFormField(
                                                  onSaved: (input) =>
                                                  _con.policyData.value = input,
                                                  initialValue:
                                                  _con.policyList[2].value,
                                                  minLines: 10,
                                                  // any number you need (It works as the rows for the textarea)
                                                  keyboardType: TextInputType.multiline,
                                                  maxLines: null,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10, right: 10, left: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    children: [
                                                      // ignore: deprecated_member_use
                                                      FlatButton(
                                                        onPressed: () {
                                                          _con.addEditPolicy('edit', 3, context);
                                                        },

                                                        padding: EdgeInsets.only(
                                                            top: 15,
                                                            bottom: 15,
                                                            left: 40,
                                                            right: 40),
                                                        color: Theme.of(context)
                                                            .colorScheme.secondary
                                                            .withOpacity(1),
                                                        shape: StadiumBorder(),
                                                        child: Text(
                                                          S.of(context).submit,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headline6
                                                              .merge(TextStyle(
                                                              color: Theme.of(
                                                                  context)
                                                                  .primaryColorLight)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ]))),
                                    ),
                                  ]),
                            ),
                          ]),
                        )),
                    Container(
                        child: Container(
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 20.0, bottom: 10),
                      child: Responsive(children: [
                        Div(
                          colS: 12,
                          colM: 12,
                          colL: 12,
                          child: Column(children: [
                            Container(
                              height: 400,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SingleChildScrollView(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        TextFormField(
                                          onSaved: (input) =>
                                              _con.policyData.value = input,
                                          initialValue:
                                              _con.policyList[4].value ?? '',
                                          minLines: 10,
                                          // any number you need (It works as the rows for the textarea)
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  bottom: 10, right: 10, left: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  // ignore: deprecated_member_use
                                                  FlatButton(
                                                    onPressed: () {
                                                      _con.addEditPolicy('edit', 5, context);
                                                    },

                                                    padding: EdgeInsets.only(
                                                        top: 15,
                                                        bottom: 15,
                                                        left: 40,
                                                        right: 40),
                                                    color: Theme.of(context)
                                                        .colorScheme.secondary
                                                        .withOpacity(1),
                                                    shape: StadiumBorder(),
                                                    child: Text(
                                                      S.of(context).submit,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          .merge(TextStyle(
                                                          color: Theme.of(
                                                              context)
                                                              .primaryColorLight)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      ]))),
                            ),
                          ]),
                        ),
                      ]),
                    )),
                    Container(
                        child: Container(
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 20.0, bottom: 10),
                      child: Responsive(children: [
                        Div(
                          colS: 12,
                          colM: 12,
                          colL: 12,
                          child: Column(children: [
                            Container(
                              height: 400,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SingleChildScrollView(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        TextFormField(
                                          onSaved: (input) =>
                                              _con.policyData.value = input,
                                          initialValue:
                                              _con.policyList[3].value ?? '',
                                          minLines: 10,
                                          // any number you need (It works as the rows for the textarea)
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  bottom: 10, right: 10, left: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  // ignore: deprecated_member_use
                                                  FlatButton(
                                                    onPressed: () {
                                                      _con.addEditPolicy('edit', 4, context);
                                                    },

                                                    padding: EdgeInsets.only(
                                                        top: 15,
                                                        bottom: 15,
                                                        left: 40,
                                                        right: 40),
                                                    color: Theme.of(context)
                                                        .colorScheme.secondary
                                                        .withOpacity(1),
                                                    shape: StadiumBorder(),
                                                    child: Text(
                                                      S.of(context).submit,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          .merge(TextStyle(
                                                          color: Theme.of(
                                                              context)
                                                              .primaryColorLight)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      ]))),
                            ),
                          ]),
                        ),
                      ]),
                    )),
                  ]),
                )),
        ],
      ),
    );
  }
}
