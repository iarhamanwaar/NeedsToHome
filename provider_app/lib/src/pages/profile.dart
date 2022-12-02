import 'package:handy/generated/l10n.dart';
import '/src/pages/services.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/profile_controller.dart';
import '../elements/DrawerWidget.dart';
import '../elements/ProfileAvatarWidget.dart';
import '../repository/user_repository.dart';

class ProfileWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  ProfileWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends StateMVC<ProfileWidget> {
  ProfileController _con;

  _ProfileWidgetState() : super(ProfileController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).primaryColor),
          onPressed: () => _con.scaffoldKey?.currentState?.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColorDark,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).profile,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(
              letterSpacing: 1.3, color: Theme.of(context).primaryColor)),
        ),
      ),
      body: SingleChildScrollView(
//              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          children: <Widget>[
            ProfileAvatarWidget(user: currentUser.value),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Pages', arguments: 1);
              },
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              leading: Icon(
                Icons.home,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                S.of(context).home,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Services()),
                );
              },
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              leading: Icon(
                Icons.category,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                S.of(context).services,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/my_schedule');
              },
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              leading: Icon(
                Icons.calendar_today,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                S.of(context).my_schedule,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Pages', arguments: 2);
              },
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              leading: Icon(
                Icons.history,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                S.of(context).history,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Settings');
              },
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                S.of(context).settings,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ListTile(
              onTap: () {
                logout().then((value) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/Login', (Route<dynamic> route) => false);
                });
              },
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              leading: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                S.of(context).logout,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
