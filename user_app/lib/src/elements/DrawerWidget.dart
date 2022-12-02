import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toast/toast.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';
import '../../generated/l10n.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends StateMVC<DrawerWidget> {
  final googleSignIn = GoogleSignIn();
  //FacebookLogin facebookLogin = FacebookLogin();
  final userData = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    print('image show${currentUser.value.image}');
    // TODO: implement initState
    super.initState();
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              currentUser.value.apiToken != null ? Navigator.of(context).pushNamed('/Profile') : Navigator.of(context).pushNamed('/Login');
            },
            child: currentUser.value.apiToken != null
                ?UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(0.1),
              ),
              accountName: Text(
                currentUser.value.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              accountEmail: currentUser.value.email!=''?Text(
                currentUser.value.email,
                style: Theme.of(context).textTheme.caption,
              ):Text(
                currentUser.value.phone,
                style: Theme.of(context).textTheme.caption,
              ),
              currentAccountPicture:currentUser.value.loginVia=='GMail' ?CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  backgroundImage: NetworkImage(userData.photoURL)

              ):CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                backgroundImage: currentUser.value.image != 'no_image' && currentUser.value.image != null
                    ?NetworkImage(currentUser.value.image)
                    : AssetImage(
                  'assets/img/userImage.png',
                ),
              ),
            ) : Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(0.1),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          size: 32,
                          color: Theme.of(context).colorScheme.background.withOpacity(1),
                        ),
                        SizedBox(width: 30),
                        Text(
                          S.of(context).guest,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
          ),

          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Pages', arguments: 2);
            },
            leading: Icon(
    Feather.home,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).home,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
      /*    ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Vertical', arguments: 2);
            },
            leading: Icon(
              Feather.home,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).home,
              style: Theme.of(context).textTheme.headline1,
            ),
          ), */


          currentUser.value.apiToken != null ? ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Profile');
            },
            leading: Icon(
              Feather.user,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).profile,
              style: Theme.of(context).textTheme.headline1,
            ),
          ):Container(),

        /*  ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/notification');
            },
            leading: Icon(
              Icons.notifications_none_outlined,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).notifications,
              style: Theme.of(context).textTheme.headline1,
            ),
          ), */

          ListTile(
            onTap: () {
             Navigator.of(context).pushReplacementNamed('/Pages', arguments: 3);


            },
            leading: Icon(
              Icons.panorama_wide_angle,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).my_orders,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),

          ListTile(
            onTap: () {
              if (currentUser.value.apiToken != null) {
                Navigator.of(context).pushNamed('/H_MyBooking');
              } else{
                Navigator.of(context).pushNamed('/Login');
              }
            },
            leading: Icon(
              Icons.cleaning_services,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).my_services,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),

          ListTile(
            onTap: () {

              if (currentUser.value.apiToken != null) {
                Navigator.of(context).pushNamed('/wallet');
              } else{
                Navigator.of(context).pushNamed('/Login');
              }
            },
            leading: Icon(
              Icons.account_balance_wallet_outlined,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).wallet,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          ListTile(
            onTap: () {

              if (currentUser.value.apiToken != null) {
                Navigator.of(context).pushNamed('/Chat', arguments: 4);
              } else{
                Navigator.of(context).pushNamed('/Login');
              }
            },
            leading: Icon(
              Icons.chat_outlined,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).chat,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          ListTile(
            onTap: () {


              if (currentUser.value.apiToken != null) {
                Navigator.of(context).pushNamed('/My_FavoriteStore');
              } else{

                Navigator.of(context).pushNamed('/Login');
              }
            },
            leading: Icon(
              Icons.store_outlined,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).my_favorite_store,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          ListTile(
            onTap: () {
              if (currentUser.value.apiToken != null) {
                Navigator.of(context).pushNamed('/Settings');
              } else {
                Navigator.of(context).pushNamed('/Login');
              }
            },
            leading: Icon(
              Feather.settings,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).settings,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          ListTile(
            onTap: () {

              Navigator.of(context).pushNamed('/policy',arguments: 'Terms and Conditions');
            },
            leading: Icon(
              Icons.file_copy_outlined,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).terms_and_conditions,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          ListTile(
            onTap: () {

              Navigator.of(context).pushNamed('/policy',arguments: 'Privacy Policy');
            },
            leading: Icon(
              Icons.privacy_tip_outlined,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).privacy_policy,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          ListTile(
            onTap: () {

              Navigator.of(context).pushNamed('/policy',arguments: 'Return Policy');
            },
            leading: Icon(
              Icons.assignment_return_outlined,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).return_policy,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),

          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Languages');
            },
            leading: Icon(
              Icons.translate,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).language,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          ListTile(
            onTap: () {
              if (Theme.of(context).brightness == Brightness.dark) {
                  setBrightness(Brightness.light);
                setting.value.brightness.value = Brightness.light;
              } else {
                setting.value.brightness.value = Brightness.dark;
                 setBrightness(Brightness.dark);
              }
              // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
              setting.notifyListeners();
            },
            leading: Icon(
              Icons.brightness_6_outlined,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              Theme.of(context).brightness == Brightness.dark ? S.of(context).light_mode : S.of(context).dark_mode,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          ListTile(
            onTap: () {
              if (currentUser.value.apiToken != null) {

                //facebookLogin.logOut();

               if(currentUser.value.loginVia=='Fb') {
                 FacebookAuth.instance.logOut();
               }
               if(currentUser.value.loginVia=='GMail') {
                  googleSignIn.disconnect();
                  FirebaseAuth.instance.signOut();
               }
                logout().then((value) async {

                  showToast("${S.of(context).logout} ${S.of(context).successfully}", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
                  Navigator.of(context).pushNamedAndRemoveUntil('/Login', (Route<dynamic> route) => false, arguments: 1);
                });
              } else {
                Navigator.of(context).pushNamed('/Login');
              }
            },
            leading: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              currentUser.value.apiToken != null ? S.of(context).logout : S.of(context).login,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),

          ListTile(
            dense: true,
            title: Text(
              '${S.of(context).version} 2.5.1',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          )
        ],
      ),
    );
  }
}
