import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/elements/GeneralSettingsTabWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

class GeneralSettings extends StatefulWidget {
  @override
  _GeneralSettingsState createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends StateMVC<GeneralSettings> {
  UserController _con;
  _GeneralSettingsState() : super(UserController()) {
    _con = controller;
  }
  ScrollController _customScrollViewController;
  ScrollController _singleChildScrollViewController;
  final _sliverAppBarExpandedHeight = 300.0;


  @override
  void initState() {
    _customScrollViewController = ScrollController();
    _singleChildScrollViewController = ScrollController();
      _singleChildScrollViewController.addListener(() {
      if (_singleChildScrollViewController.offset <
          _sliverAppBarExpandedHeight) {
        _customScrollViewController
            .jumpTo(_singleChildScrollViewController.offset);
      }
    });

    super.initState();
    _con.listenForSetting();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scrollbar(
          isAlwaysShown: true,
          child:Stack(
            children: [


              CustomScrollView(
                reverse: false,
                physics: NeverScrollableScrollPhysics(),
                controller: _customScrollViewController,
                slivers: [
                  SliverAppBar(
                    pinned:false,
                    automaticallyImplyLeading: false,
                    expandedHeight: _sliverAppBarExpandedHeight,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.asset(
                          'assets/img/profile_bg.jpg',
                          fit: BoxFit.cover,
                          height:200
                      ),
                    ),
                  ),
                  SliverFillRemaining(),
                ],
              ),

              SingleChildScrollView(
                reverse: false,
                //controller: _singleChildScrollViewController,
                child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[

                        Container(
                        margin: EdgeInsets.only(top: _sliverAppBarExpandedHeight - 200),
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: Align(

                          child:Responsive(
                              children:[
                                _con.loaderData? Wrap(
                                    children:[

                                      Div(
                                          colS: 12,
                                          colM:12,
                                          colL:12,
                                          child: Container(

                                            child:GeneralSettingsTabWidget( con:_con),
                                          )
                                      ),

                                    ]
                                ):EmptyOrdersWidget(),



                              ]
                          ),


                        ),
                      ),
                            //:EmptyOrdersWidget(),
                    ]
                ),

              ),

            ],
          )
      );
  }
}