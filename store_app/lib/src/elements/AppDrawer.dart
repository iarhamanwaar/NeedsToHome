import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:vrouter/vrouter.dart';
import '../../generated/l10n.dart';
import 'app_route_observer.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../repository/settings_repository.dart';
// ignore: must_be_immutable
class AppDrawer extends StatefulWidget {
  Function callback;
   AppDrawer({@required this.permanentlyDisplay,this.callback, Key key}) : super(key: key);

  final bool permanentlyDisplay;

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with RouteAware {
  AppRouteObserver _routeObserver;
  @override
  void initState() {

    super.initState();

    _routeObserver = AppRouteObserver();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    _routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: 240,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
        ),
      child:Scrollbar(
      isAlwaysShown: true,
        child:Container(

          child: ListView(

            children: [
              CompanyName(),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: currentUser.value.image == 'no_image'?
                        AssetImage("assets/img/userImage.png"):NetworkImage(currentUser.value.image), fit: BoxFit.fill),
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
                    SizedBox(width: 25),
                    Expanded(
                        child: Container(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(currentUser.value.shopName, style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.white54))),
                        SizedBox(height: 5),
                        Text('${S.of(context).store_id}${currentUser.value.id}', style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Colors.white54)))
                      ]),
                    )),
                  ],
                ),
              ),
              NavBar(callback: widget.callback),
              //NavBarItem(icon: Feather.log_out,navtext: '' , active: false,),
            ],
          ),

    ),
    ),
    );
  }
}

// ignore: must_be_immutable
class NavBar extends StatefulWidget {
  Function callback;
  NavBar({this.callback, Key key}) : super(key: key);
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<bool> selected = [true, false, false, false, false, false, false, false, false, false, false, false,false, false, false];
  void select(int n,displayMobileLayout) {
    if (displayMobileLayout){
      widget.callback();
    }
    for (int i = 0; i < 15; i++) {
      if (i != n) {
        selected[i] = false;
      } else {
        selected[i] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),




      child: Column(
        children: [
          NavBarItem(
            icon: Feather.home,
            navtext: S.of(context).home,
            icon2: Icons.arrow_forward_ios,
            active: selected[0],
            touched: () {
              VRouter.of(context).to('/dashboard');

              setState(() {
                select(0, displayMobileLayout);
              });
            },
            navId: 1,
          ),
        /*  NavBarItem(
            icon: Feather.home,
            navtext: 'Pos Checkout',
            icon2: Icons.arrow_forward_ios,
            active: selected[0],
            touched: () {
              VRouter.of(context).to('/pos_checkout');

              setState(() {
                select(0, displayMobileLayout);
              });
            },
          ), */
          currentUser.value.shopTypeId!=2?NavBarItem(
            icon: Feather.monitor,
            navtext: S.of(context).banner,
            icon2: Icons.arrow_forward_ios,
            active: selected[1],
            touched: () {
              VRouter.of(context).to('/banner');
              setState(() {
                select(1,displayMobileLayout);
              });
            },
            navId: 2,
          ):Container(),

          NavBarItem(
            icon: Feather.list,
            navtext:  currentUser.value.shopTypeId!=2?S.of(context).category:S.of(context).menu,
            icon2: Icons.arrow_forward_ios,
            active: selected[2],
            touched: () {
              VRouter.of(context).to('/category');
              setState(() {
                select(2,displayMobileLayout);
              });
            },
            navId: 3,
          ),
          currentUser.value.shopTypeId!=2?NavBarItem(
            icon: Feather.list,
            navtext: S.of(context).sub_category,
            icon2: Icons.arrow_forward_ios,
            active: selected[3],
            touched: () {
              VRouter.of(context).to('/subcategory');
              setState(() {
                select(3,displayMobileLayout);
              });
            },
            navId: 4,
          ):Container(),

          currentUser.value.shopTypeId!=2?NavBarItem(
            icon: Feather.shopping_bag,
            navtext: S.of(context).product,
            icon2: Icons.arrow_forward_ios,
            active: selected[4],
            touched: () {
              VRouter.of(context).to('/productlist');
              setState(() {
                select(4,displayMobileLayout);
              });
            },
          ):NavBarItem(
            icon: Feather.shopping_bag,
            navtext: S.of(context).items,
            icon2: Icons.arrow_forward_ios,
            active: selected[4],
            touched: () {
              VRouter.of(context).to('/itemlist');
              setState(() {
                select(4,displayMobileLayout);
              });
            },
            navId: 5,
          ),
          NavBarItem(
            icon: Feather.box,
            navtext: S.of(context).order,
            icon2: Icons.arrow_forward_ios,
            active: selected[5],
            touched: () {
              VRouter.of(context).to('/Order');
              setState(() {
                select(5,displayMobileLayout);
              });
            },
            navId: 6,
          ),
          NavBarItem(
            icon: Feather.box,
            navtext: S.of(context).takeaway,
            icon2: Icons.arrow_forward_ios,
            active: selected[6],
            touched: () {
              VRouter.of(context).to('/takeaway');
              setState(() {
                select(6,displayMobileLayout);
              });
            },
            navId: 7,
          ),
          NavBarItem(
            icon: Icons.account_balance_wallet_outlined,
            navtext: S.of(context).wallet,
            icon2: Icons.arrow_forward_ios,
            active: selected[7],
            touched: () {
              VRouter.of(context).to('/Wallet');
              setState(() {
                select(7,displayMobileLayout);
              });
            },
            navId: 8,
          ),
        /**NavBarItem(
            icon: Feather.box,
            navtext: 'POS',
            icon2: Icons.arrow_forward_ios,
            active: selected[5],
            touched: () {
              VRouter.of(context).push('/Pos_Checkout');
              setState(() {
                select(5,displayMobileLayout);
              });
            },
          ),  */
          !GetPlatform.isMobile? NavBarItem(
            icon: Feather.upload,
            navtext: S.of(context).bulk_upload,
            icon2: Icons.arrow_forward_ios,
            active: selected[8],
            touched: () {
              VRouter.of(context).to('/bulk_upload');
              setState(() {
                select(8,displayMobileLayout);
              });
            },
            navId: 9,
          ):Container(),
          NavBarItem(
            icon: Feather.file,
            navtext: S.of(context).sales,
            icon2: Icons.arrow_forward_ios,
            active: selected[9],
            touched: () {
              VRouter.of(context).to('/report');
              setState(() {
                select(9,displayMobileLayout);
              });
            },
            navId: 10,
          ),
          NavBarItem(
            icon: Feather.clock,
            navtext: S.of(context).delivery_time_slot,
            icon2: Icons.arrow_forward_ios,
            active: selected[10],
            touched: () {
              VRouter.of(context).to('/deliverytimeslot');
              setState(() {
                select(10,displayMobileLayout);
              });
            },
            navId: 11,
          ),

          NavBarItem(
            icon: Feather.user,
            navtext: S.of(context).profile,
            icon2: Icons.arrow_forward_ios,
            active: selected[11],
            touched: () {
              VRouter.of(context).to('/profile');
              setState(() {
                select(11,displayMobileLayout);
              });
            },
            navId: 12,
          ),
          NavBarItem(
            icon: Icons.brightness_6,
            navtext: Theme.of(context).brightness == Brightness.dark ? S.of(context).light : S.of(context).dark,
            icon2: Icons.arrow_forward_ios,
            active: selected[12],
            touched: () {
              if (Theme.of(context).brightness == Brightness.dark) {

                setting.value.brightness.value = Brightness.light;
                setBrightness(Brightness.light);
              } else {
                setting.value.brightness.value = Brightness.dark;
                setBrightness(Brightness.dark);
              }
              // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
              setting.notifyListeners();
            },
            navId: 13,
          ),


          NavBarItem(
            icon: Feather.log_out,
            navtext: S.of(context).logout,
            icon2: Icons.arrow_forward_ios,
            active: selected[13],
            touched: () {
              if (currentUser.value.apiToken != null) {
                logout().then((value) {

                   // Toast.show('${S.of(context).logout} ${S.of(context).successfully}', context, duration: Toast.BOTTOM, gravity: Toast.LENGTH_SHORT ,);

// ignore: deprecated_member_use
                  VRouter.of(context).pushReplacement('/login');
                });
              } else {
                // ignore: deprecated_member_use
                VRouter.of(context).pushReplacement('/login');
              }
            },
            navId: 14,
          ),

          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(left:20,bottom:10),
            child:Text('${S.of(context).version} 2.5.1',style:Theme.of(context).textTheme.caption.merge(TextStyle(color:Colors.white54))
          )),




        ],
      ),


    );
  }
}

class CompanyName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image:AssetImage('assets/img/mainlogo.png'),
              width:60,
              height:60,
              fit: BoxFit.fitWidth,
            )

          ],
        ),
      ),
    );
  }
}

class NavBarItem extends StatefulWidget {
  final IconData icon;
  final Function touched;
  final String navtext;
  final IconData icon2;
  final bool active;
  final int navId;
  NavBarItem({this.icon, this.icon2, this.touched, this.active, this.navtext, this.navId});
  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // VRouter.of(context).push('/login');
          widget.touched();
        },
        splashColor: Colors.white,
        hoverColor: Colors.white12,
        child:Container(

            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.navId==6 || widget.navId==7?   Container(
                    padding: EdgeInsets.symmetric(vertical:2),
                    child:Column(
                        children:[
                          Theme(
                            data: ThemeData().copyWith(dividerColor: Colors.transparent),
                            child:ExpansionTile(
                              expandedCrossAxisAlignment:CrossAxisAlignment.start,
                              leading: Container(
                                margin: new EdgeInsets.only(left: 0,right: 0.0, bottom: 0.0),
                                width: 10,
                                padding: EdgeInsets.only(right: 0,left: 0),
                                child: Icon(
                                  widget.icon,
                                  color: widget.active ? Colors.white : Colors.white54,
                                  size: 15.0,
                                ),
                              ),

                              childrenPadding: EdgeInsets.all(0),
                              title: Text(
                                widget.navtext,
                                style: TextStyle(
                                  fontSize:13,
                                  color: widget.active ? Colors.white : Colors.white54,
                                ),
                              ),
                              trailing:Icon(
                                widget.icon2,
                                color: widget.active ? Colors.white : Colors.white54,
                                size: 13.0,
                              ),
                              children: <Widget>[
                                ListTile(

                                  leading: Visibility(
                                    child: Icon(
                                      Icons.circle,
                                      size: 15,
                                      color: widget.active ? Colors.white.withOpacity(0.5) : Colors.white54,
                                    ),
                                    visible: true,
                                  ),
                                  onTap: () => {
                                    VRouter.of(context).push(widget.navId==6?'/Order_new':'/TOrder_new'),
                                  },
                                  title: Text(
                                    'New Orders',
                                    style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(fontWeight:FontWeight.normal,color: Theme.of(context).primaryColorLight)),
                                  ),


                                ),
                                ListTile(

                                  leading: Visibility(
                                    child: Icon(
                                      Icons.circle,
                                      size: 15,
                                      color: widget.active ? Colors.white.withOpacity(0.5) : Colors.white54,
                                    ),
                                    visible: true,
                                  ),
                                  onTap: () => {
                                    VRouter.of(context).push(widget.navId==6?'/Order_placed':'/TOrder_placed'),
                                  },
                                  title: Text(
                                    'Accepted',
                                    style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(fontWeight:FontWeight.normal,color: Theme.of(context).primaryColorLight)),
                                  ),


                                ),
                                ListTile(

                                  leading: Visibility(
                                    child: Icon(
                                      Icons.circle,
                                      size: 15,
                                      color: widget.active ? Colors.white.withOpacity(0.5) : Colors.white54,
                                    ),
                                    visible: true,
                                  ),
                                  onTap: () => {
                                    VRouter.of(context).push(widget.navId==6?'/Order_packed':'/TOrder_packed'),
                                  },
                                  title: Text(
                                    'Packed',
                                    style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(fontWeight:FontWeight.normal,color: Theme.of(context).primaryColorLight)),
                                  ),


                                ),
                                widget.navId==6?ListTile(

                                  leading: Visibility(
                                    child: Icon(
                                      Icons.circle,
                                      size: 15,
                                      color: widget.active ? Colors.white.withOpacity(0.5) : Colors.white54,
                                    ),
                                    visible: true,
                                  ),
                                  onTap: () => {
                                    VRouter.of(context).push('/Order_shipped'),
                                  },
                                  title: Text(
                                    'Shipped',
                                    style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(fontWeight:FontWeight.normal,color: Theme.of(context).primaryColorLight)),
                                  ),


                                ):Container(),
                                ListTile(

                                  leading: Visibility(
                                    child: Icon(
                                      Icons.circle,
                                      size: 15,
                                      color: widget.active ? Colors.white.withOpacity(0.1) : Colors.white54,
                                    ),
                                    visible: true,
                                  ),
                                  onTap: () => {
                                    VRouter.of(context).push(widget.navId==6?'/Order_delivered':'/TOrder_delivered'),
                                  },
                                  title: Text(
                                    'Delivered',
                                    style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(fontWeight:FontWeight.normal,color: Theme.of(context).primaryColorLight)),
                                  ),


                                ),
                                ListTile(

                                  leading: Visibility(
                                    child: Icon(
                                      Icons.circle,
                                      size: 15,
                                      color: widget.active ? Colors.white.withOpacity(0.1) : Colors.white54,
                                    ),
                                    visible: true,
                                  ),
                                  onTap: () => {
                                    VRouter.of(context).push(widget.navId==6?'/Order_cancelled':'/TOrder_cancelled'),
                                  },
                                  title: Text(
                                    'Cancelled',
                                    style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(fontWeight:FontWeight.normal,color: Theme.of(context).primaryColorLight)),
                                  ),


                                )
                              ],
                            ),
                          )
                        ]
                    )
                ):

                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical:20),
                    child:Column(
                        children:[

                          Row(
                            children: [
                              Expanded(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 0.0),
                                        child: Icon(
                                          widget.icon,
                                          color: widget.active ? Colors.white : Colors.white54,
                                          size: 15.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          widget.navtext,
                                          style: TextStyle(
                                            color: widget.active ? Colors.white : Colors.white54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Icon(
                                  widget.icon2,
                                  color: widget.active ? Colors.white : Colors.white54,
                                  size: 13.0,
                                ),
                              ),
                            ],
                          ),
                        ]
                    )
                ),


              ],
            )


        ),
      ),
    );
  }
}
