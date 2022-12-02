
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/elements/PermissionDeniedWidget.dart';
import 'package:multisuperstore/src/repository/settings_repository.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:toast/toast.dart';

import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final googleSignIn = GoogleSignIn();
  //FacebookLogin facebookLogin = FacebookLogin();
  final userData = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  currentUser.value.apiToken == null
          ? PermissionDeniedWidget()
          : Stack(
        clipBehavior: Clip.none, alignment: Alignment.center,
        children: [
          Image(image:AssetImage('assets/img/profilebg.jpg'),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Container(
            width: double.infinity,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[


                Stack(
                  clipBehavior: Clip.none, alignment: Alignment.center,
                  children: [
                    Image(image:AssetImage('assets/img/profilebg.png'),
                      height: MediaQuery.of(context).size.height * 0.33,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      margin: EdgeInsets.only(top:170),
                      width: MediaQuery.of(context).size.width,
                      height:110,
                      decoration: BoxDecoration(
                          color:Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),),
                    Positioned(
                      top:100,
                      child:Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top:10),
                            height: 90.0,
                            width: 90.0,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                            child: GestureDetector(
                              onTap: () {
                               // Imagepickerbottomsheet();
                              },

                              child: currentUser.value.loginVia=='GMail' ?CircleAvatar(
                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                  backgroundImage: NetworkImage(userData.photoURL)

                              ):CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: currentUser.value.image != 'no_image' &&  currentUser.value.image != null
                                    ? NetworkImage(currentUser.value.image)
                                    : AssetImage(
                                  'assets/img/userImage.png',
                                ),
                              ),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(left:10,right:10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          currentUser.value.name,
                                          style: Theme.of(context).textTheme.headline4,
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(currentUser.value.email,
                                            style:Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Colors.grey))
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              )
                          ),


                        ],
                      ),
                    ),
                  ],
                ),






                Expanded(
                  child: Container(
                    width:double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: SingleChildScrollView(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Container(
                            width:double.infinity,
                            margin:EdgeInsets.only(left:5,right:5),
                            padding: EdgeInsets.only(top:10),
                            child: Wrap(
                                children:[
                                  Wrap(
                                      children:[
                                        Div(
                                          colL:3,
                                          colM:3,
                                          colS:3,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pushNamed('/Chat');
                                            },
                                            child:Container(
                                            padding: EdgeInsets.only(bottom:10),
                                            child:Column(
                                                children:[

                                                    Container(
                                                      child: Icon(Icons.chat_outlined,size: 20),
                                                    ),

                                                  SizedBox(height:5),
                                                  Container(
                                                    child: Text(
                                                      S.of(context).chat,
                                                      textAlign: TextAlign.center,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: Theme.of(context).textTheme.bodyText2,
                                                    ),
                                                  ),
                                                ]
                                            ),
                                          ),
                                          )
                                        ),

                                        Div(
                                          colL:3,
                                          colM:3,
                                          colS:3,
                                          child: GestureDetector(
                                            onTap: ()  async {
                                             await Navigator.of(context).pushNamed('/edit_profile');
                                             setState(() {
                                               currentUser.value;
                                             });
                                            },
                                            child:Container(
                                            padding: EdgeInsets.only(bottom:10),
                                            child:Column(
                                                children:[
                                                   Container(
                                                      child:   Icon(Feather.settings,size: 20,),
                                                    ),

                                                  SizedBox(height:5),
                                                  Container(
                                                    child: Text(
                                                      S.of(context).settings,
                                                      textAlign: TextAlign.center,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: Theme.of(context).textTheme.bodyText2,
                                                    ),
                                                  ),
                                                ]
                                            ),
                                          ),),
                                        ),
                                        Div(
                                          colL:3,
                                          colM:3,
                                          colS:3,
                                          child:GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pushNamed('/wallet');
                                            },
                                            child:Container(
                                            padding: EdgeInsets.only(bottom:10),
                                            child:Column(
                                                children:[
                                                  Container(
                                                      child: Icon(Icons.credit_card,size: 20),
                                                    ),

                                                  SizedBox(height:5),
                                                  Container(
                                                    child: Text(
                                                      S.of(context).wallet,
                                                      textAlign: TextAlign.center,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: Theme.of(context).textTheme.bodyText2,
                                                    ),
                                                  ),
                                                ]
                                            ),
                                          ),)
                                        ),
                                        Div(
                                          colL:3,
                                          colM:3,
                                          colS:3,
                                          child: GestureDetector(
                                            onTap: () {
                                              if (currentUser.value.apiToken != null) {

                                                //facebookLogin.logOut();
                                                logout().then((value) async {
                                                  await googleSignIn.disconnect();

                                                  await FirebaseAuth.instance.signOut();
                                                  showToast("${S.of(context).logout} ${S.of(context).successfully}", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
                                                  Navigator.of(context).pushNamedAndRemoveUntil('/Login', (Route<dynamic> route) => false, arguments: 1);
                                                });
                                              } else {
                                                Navigator.of(context).pushNamed('/Login');
                                              }
                                            },
                                            child:Container(
                                              padding: EdgeInsets.only(bottom:10),
                                              child:Column(
                                                  children:[
                                                    Container(
                                                      child: Icon(Icons.power_settings_new_sharp,size: 20),
                                                    ),

                                                    SizedBox(height:5),
                                                    Container(
                                                      child: Text(
                                                        S.of(context).logout,
                                                        textAlign: TextAlign.center,
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: Theme.of(context).textTheme.bodyText2,
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                            ),
                                          ),
                                        ),

                                      ]),
                                ]),),

                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 25,vertical:10),
                              child:Text(S.of(context).menu,style:Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).primaryColorDark)))
                          ),

                          ListView(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top:0),
                            shrinkWrap: true,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/Pages', arguments: 2);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 25,vertical:13),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[

                                      Container(
                                        padding:EdgeInsets.only(right:18),
                                        child: Icon(
                                            Feather.home,size:20,
                                            color: Theme.of(context).backgroundColor
                                        ),
                                      ),
                                      Text(
                                          S.of(context).home,
                                          style: Theme.of(context).textTheme.subtitle2
                                      ),

                                    ],
                                  ),

                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await Navigator.of(context).pushNamed('/edit_profile');
                                  setState(() {
                                    currentUser.value;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 25,vertical:13),
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding:EdgeInsets.only(right:18),
                                        child:Icon(Feather.settings,size:20,color: Theme.of(context).backgroundColor),
                                      ),
                                      Text(
                                          S.of(context).settings,
                                          style: Theme.of(context).textTheme.subtitle2

                                      ),

                                    ],
                                  ),

                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/Orders');
                                  // Navigator.of(context).pushNamed('/Pages', arguments: 4);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 25,vertical:13),
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding:EdgeInsets.only(right:18),
                                        child: Icon(Feather.shopping_bag, size:20, color: Theme.of(context).backgroundColor),
                                      ),
                                      Text(
                                          S.of(context).my_orders,
                                          style: Theme.of(context).textTheme.subtitle2

                                      ),

                                    ],
                                  ),

                                ),
                              ),
                              InkWell(
                                onTap: () async{
                                  var whatsapp =setting.value.customerSupport;
                                  var whatsappURlAndroid = "whatsapp://send?phone="+whatsapp+"&text=Hi ${setting.value.appName}";
                                  // ignore: deprecated_member_use
                                  // android , web
                                  // ignore: deprecated_member_use
                                  if(await canLaunch(whatsappURlAndroid)){
                                    // ignore: deprecated_member_use
                                    await launch(whatsappURlAndroid);
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: new Text("whatsapp no installed")));
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 25,vertical:13),
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding:EdgeInsets.only(right:18),
                                        child: Icon( Icons.help, size:20, color: Theme.of(context).backgroundColor),
                                      ),
                                      Text(
                                          S.of(context).support_chat,
                                          style: Theme.of(context).textTheme.subtitle2

                                      ),

                                    ],
                                  ),

                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/H_MyBooking');
                                  // Navigator.of(context).pushNamed('/Pages', arguments: 4);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 25,vertical:13),
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding:EdgeInsets.only(right:18),
                                        child: Icon( Icons.cleaning_services, size:20, color: Theme.of(context).backgroundColor),
                                      ),
                                      Text(
                                          S.of(context).my_services,
                                          style: Theme.of(context).textTheme.subtitle2

                                      ),

                                    ],
                                  ),

                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/My_FavoriteStore');
                                  // Navigator.of(context).pushNamed('/Pages', arguments: 4);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 25,vertical:13),
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding:EdgeInsets.only(right:18),
                                        child: Icon( Icons.store_outlined, size:20, color: Theme.of(context).backgroundColor),
                                      ),
                                      Text(
                                          S.of(context).my_favorite_store,
                                          style: Theme.of(context).textTheme.subtitle2

                                      ),

                                    ],
                                  ),

                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/policy',arguments: 'Privacy Policy');
                                  // Navigator.of(context).pushNamed('/Pages', arguments: 4);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 25,vertical:13),
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding:EdgeInsets.only(right:18),
                                        child: Icon( Icons.privacy_tip_outlined, size:20, color: Theme.of(context).backgroundColor),
                                      ),
                                      Text(
                                          S.of(context).privacy_policy,
                                          style: Theme.of(context).textTheme.subtitle2

                                      ),

                                    ],
                                  ),

                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/policy',arguments: 'Return Policy');
                                  // Navigator.of(context).pushNamed('/Pages', arguments: 4);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 25,vertical:13),
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding:EdgeInsets.only(right:18),
                                        child: Icon( Icons.assignment_return_outlined, size:20, color: Theme.of(context).backgroundColor),
                                      ),
                                      Text(
                                          S.of(context).return_policy,
                                          style: Theme.of(context).textTheme.subtitle2

                                      ),

                                    ],
                                  ),

                                ),
                              ),

                              InkWell(
                                onTap: () {
                                  if (Theme.of(context).brightness == Brightness.dark) {
                                    // setBrightness(Brightness.light);
                                    setting.value.brightness.value = Brightness.light;
                                  } else {
                                    setting.value.brightness.value = Brightness.dark;
                                    //  setBrightness(Brightness.dark);
                                  }
                                  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                                  setting.notifyListeners();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 25,vertical:13),
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding:EdgeInsets.only(right:18),
                                        child:Icon(Feather.cloud_lightning, size:20, color: Theme.of(context).backgroundColor),
                                      ),
                                      Text(
                                          Theme.of(context).brightness == Brightness.dark ? S.of(context).light_mode : S.of(context).dark_mode,
                                          style: Theme.of(context).textTheme.subtitle1
                                      ),

                                    ],
                                  ),

                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (currentUser.value.apiToken != null) {
                                    if(currentUser.value.loginVia=='Fb') {
                                      FacebookAuth.instance.logOut();
                                    }

                                    logout().then((value) async {
                                      if(currentUser.value.loginVia=='GMail') {
                                        await googleSignIn.disconnect();
                                        await FirebaseAuth.instance.signOut();
                                      }
                                      showToast("${S.of(context).logout} ${S.of(context).successfully}", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
                                      Navigator.of(context).pushNamedAndRemoveUntil('/Login', (Route<dynamic> route) => false, arguments: 1);
                                    });
                                  } else {
                                    Navigator.of(context).pushNamed('/Login');
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 25,vertical:13),
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding:EdgeInsets.only(right:18),
                                        child:Icon(Feather.log_out, size:20, color: Theme.of(context).backgroundColor),),
                                      Text(
                                          S.of(context).logout,
                                          style: Theme.of(context).textTheme.subtitle1
                                      ),

                                    ],
                                  ),

                                ),
                              ),




                            ],
                          )


                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),


    );
  }



  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }
}


