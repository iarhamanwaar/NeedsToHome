import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/settings_controller.dart';
import '../repository/user_repository.dart';
import '../../generated/l10n.dart';

class SettingsWidget extends StatefulWidget {
  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends StateMVC<SettingsWidget> {
  SettingsController _con;

  _SettingsWidgetState() : super(SettingsController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          elevation: 0,
          centerTitle: true,
          title: Text(
            S.of(context).settings,
            style: Theme.of(context)
                .textTheme
                .headline6
                .merge(TextStyle(letterSpacing: 1.3, color: Colors.white)),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            '${currentUser.value.name}',
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            '${currentUser.value.email}',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                        width: 55,
                        height: 55,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(300),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('/Pages', arguments: 0);
                          },
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(currentUser.value.image),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text(
                        S.of(context).profile_settings,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        S.of(context).full_name,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      trailing: Text(
                        '${currentUser.value.name}',
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        S.of(context).email,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      trailing: Text(
                        '${currentUser.value.email}',
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        S.of(context).phone,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      trailing: Text(
                        '${currentUser.value.phone}',
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        S.of(context).about,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      trailing: Text(
                        S.of(context).delivery_boy,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
