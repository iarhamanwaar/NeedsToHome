import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:products_deliveryboy/src/repository/user_repository.dart';
import 'package:responsive_ui/responsive_ui.dart';
import '../../generated/l10n.dart';

class ProfileWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  ProfileWidget({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Container(
              child: Stack(
                children: <Widget>[
                  //background
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.38,
                          color: Colors.transparent,
                          child: ClipPath(
                            clipper: BackClipper(),
                            child: Container(
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //forground
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: Container(
                              height: 90.0,
                              width: 90.0,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(100.0)),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(currentUser.value.image),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                    width: 90.0,
                                    height: 45.0,
                                    child: FlareActor(
                                      "assets/switcher.flr",
                                      alignment: Alignment.center,
                                    )),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      currentUser.value.name,
                                      style: Theme.of(context).textTheme.headline4.merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.0), color: Colors.black12),
                                      child: Text(
                                        currentUser.value.gender=='Male'?S.of(context).male:S.of(context).female,
                                        style:
                                            Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  logout().then((value) {
                                    Fluttertoast.showToast(
                                      msg: "${S.of(context).logout} ${S.of(context).successfully}",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 5,
                                    );
                                    Navigator.of(context).pushNamedAndRemoveUntil('/Login', (Route<dynamic> route) => false);
                                  });
                                },
                                child: Container(
                                  width: 90.0,
                                  height: 45.0,
                                  child: Center(
                                    child: Icon(
                                      Icons.power_settings_new,
                                      size: 35,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
    Container(
    padding: EdgeInsets.only(left:10,right:10),
    child: Wrap(
      children:[
        Div(
          colS:6,
          colM:6,
          colL:6,
          child:Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(S.of(context).email,
                    style:
                    Theme.of(context).textTheme.headline4.merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 5,
                ),
                Text(currentUser.value.email,
                    style:
                    Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
        Div(
          colS:6,
          colM:6,
          colL:6,
          child: Container(
            child: Column(
              children: <Widget>[
                Text(S.of(context).phone,
                    style:
                    Theme.of(context).textTheme.headline4.merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 5,
                ),
                Text(
                  currentUser.value.phone,
                  style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),


      ]
    ),
    ),
                       /* Container(
                          padding: EdgeInsets.symmetric(horizontal: size.width *0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                width: size.width * 0.475,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(S.of(context).email,
                                        style:
                                            Theme.of(context).textTheme.headline4.merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
                                        textAlign: TextAlign.center),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(currentUser.value.email,
                                        style:
                                            Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.white.withOpacity(0.5),
                                width: 1.0,
                                height: 40.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.475,
                                child: Column(
                                  children: <Widget>[
                                    Text(S.of(context).phone,
                                        style:
                                            Theme.of(context).textTheme.headline4.merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
                                        textAlign: TextAlign.center),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      currentUser.value.phone,
                                      style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),*/
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                        ),
                        ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed('/Pages', arguments: 1);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                height: MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      S.of(context).home,
                                      style: Theme.of(context).textTheme.headline1,
                                    ),
                                    Icon(
                                      Icons.home,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      //                   <--- left side
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed('/Pages', arguments: 2);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                height: MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      S.of(context).recent_orders,
                                      style: Theme.of(context).textTheme.headline1,
                                    ),
                                    Icon(Icons.shopping_basket, color: Colors.grey)
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      //                   <--- left side
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed('/Settings');
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                height: MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      S.of(context).settings,
                                      style: Theme.of(context).textTheme.headline1,
                                    ),
                                    Icon(Icons.settings, color: Colors.grey)
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      //                   <--- left side
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                logout().then((value) {
                                  Fluttertoast.showToast(
                                    msg: "${S.of(context).logout} ${S.of(context).successfully}",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 5,
                                  );
                                  Navigator.of(context).pushNamedAndRemoveUntil('/Login', (Route<dynamic> route) => false);
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                height: MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      S.of(context).logout,
                                      style: Theme.of(context).textTheme.headline1,
                                    ),
                                    Icon(Icons.exit_to_app, color: Colors.grey)
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      //                   <--- left side
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - size.height / 5);

    var firstControlPoint = new Offset(size.width / 2, size.height + 25);
    var firstEndPoint = new Offset(size.width, size.height - size.height / 5);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width, 0.0);

    var secondControlPoint = new Offset(size.width / 2, size.height / 5 + 25);
    var secondEndPoint = new Offset(0.0, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
