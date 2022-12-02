
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

// ignore: must_be_immutable
class SettingPopUpWidget extends StatefulWidget {
  String terms;
  UserController con;
  SettingPopUpWidget({Key key, this.terms, this.con}) : super(key: key);

  _SettingPopUpWidgetState createState() => _SettingPopUpWidgetState();
}

class _SettingPopUpWidgetState extends State<SettingPopUpWidget> {
  bool isboost = false;
  bool istechnical = false;
  bool isaccept = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(children: [
        Responsive(children: [
          Div(
            colL: 12,
            colM: 12,
            colS: 12,
            child: Container(
              //width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Container(
                    //width: double.infinity,
                    margin: EdgeInsets.only(
                        top: 20,
                        left: MediaQuery.of(context).size.width > 769 ? 20 : 10,
                        right:
                            MediaQuery.of(context).size.width > 769 ? 20 : 10),
                    child: Text(
                      S.of(context).settings_and_agreement,
                      style: MediaQuery.of(context).size.width > 769
                          ? Theme.of(context).textTheme.headline4
                          : Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          top: 20,
                          left:
                              MediaQuery.of(context).size.width > 769 ? 20 : 10,
                          right: MediaQuery.of(context).size.width > 769
                              ? 20
                              : 10),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Container(
                            child: Text(
                              S.of(context).do_you_need_technical_assistant,
                              style: TextTheme().caption,
                            ),
                          )),
                          SizedBox(width: 20),
                          Align(
                              alignment: Alignment.topRight,
                              child: Switch(
                                  value: isboost,
                                  onChanged: (value) {
                                    setState(() {
                                      isboost = value;
                                      print(isboost);
                                    });
                                  }))
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                          top: 20,
                          left:
                              MediaQuery.of(context).size.width > 769 ? 20 : 10,
                          right: MediaQuery.of(context).size.width > 769
                              ? 20
                              : 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Container(
                            child: Text(
                              S.of(context).do_you_need_boost_for_store,
                              style: TextTheme().subtitle1,
                            ),
                          )),
                          Align(
                              alignment: Alignment.topRight,
                              child: Switch(
                                  value: istechnical,
                                  onChanged: (value) {
                                    setState(() {
                                      istechnical = value;
                                      print(isboost);
                                    });
                                  })),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(
                        top: 20,
                        left: MediaQuery.of(context).size.width > 769 ? 20 : 10,
                        right:
                            MediaQuery.of(context).size.width > 769 ? 20 : 10),
                    child: Text(
                      widget.terms,
                      style: TextTheme().caption,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                          top: 20,
                          left:
                              MediaQuery.of(context).size.width > 769 ? 20 : 10,
                          right: MediaQuery.of(context).size.width > 769
                              ? 20
                              : 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Container(
                            child: Text(
                              S
                                  .of(context)
                                  .i_here_by_accept_terms_and_conditions_above_mentioned,
                              style: TextTheme().caption,
                            ),
                          )),
                          Align(
                              alignment: Alignment.topRight,
                              child: Switch(
                                  value: isaccept,
                                  onChanged: (value) {
                                    setState(() {
                                      isaccept = value;
                                      print(isaccept);
                                    });
                                  }))
                        ],
                      )),
                ],
              ),
            ),
          )
        ])
      ]),
    ));
  }
}
