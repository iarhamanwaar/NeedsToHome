import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:vrouter/vrouter.dart';

class PlanExpiredWidget extends StatefulWidget {
  const PlanExpiredWidget({Key key}) : super(key: key);

  @override
  _PlanExpiredWidgetState createState() => _PlanExpiredWidgetState();
}

class _PlanExpiredWidgetState extends StateMVC<PlanExpiredWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
                padding: EdgeInsets.only(
                    top: 30,
                    bottom: 30,
                    left: size.width > 769 ? 30 : 10,
                    right: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black26,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  child: Text(S.of(context).plan_expired,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          .merge(TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorLight)))),
                              SizedBox(height: 20),
                              IconButton(
                                onPressed: () {
                                  logout().then((value) {
                                    // ignore: deprecated_member_use
                                    VRouter.of(context).pushReplacement('/login');
                                  });
                                },
                                icon: Icon(Icons.power_settings_new_sharp,
                                    color: Theme.of(context).primaryColorLight),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: size.width > 769
                                        ? size.height * 0.3
                                        : 0.2,
                                    bottom: 30,
                                    left: size.width > 769
                                        ? 10
                                        : size.width * 0.03,
                                    right: size.width > 769
                                        ? 10
                                        : size.width * 0.03),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                            Text(S.of(context).your_plan_is_expired_please_update_your_plan,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3
                                                    .merge(TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColorLight)))
                                          ]))
                                    ]),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // ignore: deprecated_member_use
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    padding: EdgeInsets.only(
                                        top: 15,
                                        bottom: 15,
                                        left: 40,
                                        right: 40),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(1),
                                    shape: StadiumBorder(),
                                    child: Text(
                                      S.of(context).upgrade,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .merge(TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorLight)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ))));
  }
}
