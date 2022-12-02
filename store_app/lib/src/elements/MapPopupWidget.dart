
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/components/light_color.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

class MapPopupWidget extends StatefulWidget {
  @override
  _MapPopupWidgetState createState() => _MapPopupWidgetState();
}

class _MapPopupWidgetState extends StateMVC<MapPopupWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.center,
        child: Div(
          colS: 12,
          colM: 10,
          colL: 10,
          child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
            backgroundColor: LightColor.navyBlue1,
            insetPadding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.09,
              right: MediaQuery.of(context).size.width * 0.09,
              bottom: MediaQuery.of(context).size.height * 0.05,
            ),
            child: Container(
              width: double.infinity,
              padding:
                  EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: [
                    Expanded(
                        child: Container(
                            child: Text(S.of(context).assign_delivery_man,
                                style: Theme.of(context).textTheme.headline1))),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.close),
                    )
                  ]),
                  Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Wrap(children: [
                        Div(
                            colS: 12,
                            colM: 6,
                            colL: 4,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1,
                                              color: Colors.grey[200])),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 45,
                                              width: 45,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/img/userImage5.jpeg"),
                                                    fit: BoxFit.fill),
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 5.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 7),
                                            Expanded(
                                              child: Text('Srinatha nalinga'),

                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 5, right: 10),
                                              // ignore: deprecated_member_use
                                              child: FlatButton(
                                                onPressed: () {},
                                                color: Colors.blue,
                                                splashColor: Colors.blue,
                                                textColor: Colors.white,
                                                child: Text(S.of(context).assign,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .merge(TextStyle(
                                                            color:
                                                                Colors.white))),
                                              ),
                                            ),
                                          ]))
                                ])),
                        Div(
                          colS: 12,
                          colM: 6,
                          colL: 8,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding:
                                        EdgeInsets.only(left: 30, right: 20),
                                    child: Image(
                                      image: AssetImage(
                                        'assets/img/bgimage.png',
                                      ),
                                      width: double.infinity,
                                      height: size.height * 0.6,
                                      fit: BoxFit.fill,
                                    ))
                              ]),
                        )
                      ])),
                ],
              ),
            ),
          ),
        ));
  }
}
