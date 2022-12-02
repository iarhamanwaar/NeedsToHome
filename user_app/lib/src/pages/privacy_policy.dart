import 'package:flutter/material.dart';
import 'package:multisuperstore/src/elements/EmptyOrdersWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/settings_controller.dart';
// ignore: must_be_immutable
class PrivacyPolicy extends StatefulWidget {
  String policy;
  int id;
  PrivacyPolicy({this.policy, this.id});

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends StateMVC<PrivacyPolicy> {
  SettingsController _con;

  _PrivacyPolicyState() : super(SettingsController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.policy == 'Terms and Conditions') {
      _con.listenForPolicy(1);
    } else if (widget.policy == 'Privacy Policy') {
      _con.listenForPolicy(2);
    } else if (widget.policy == 'Return Policy') {
      _con.listenForPolicy(3);
    } else if (widget.policy == 'About Us') {
      _con.listenForPolicy(4);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(
              color: Theme.of(context).backgroundColor
          ),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: Text(
            widget.policy=='Terms and Conditions'?S.of(context).terms_and_conditions:
            widget.policy=='Privacy Policy'? S.of(context).privacy_policy:
            widget.policy=='Return Policy'? S.of(context).return_policy:
            widget.policy,
            textAlign: TextAlign.center,
            style:  Theme.of(context).textTheme.headline3,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                (_con.policyList.length == 0)
                    ? EmptyOrdersWidget()
                    : Padding(
                        padding: EdgeInsets.only(top:10,left:20,right:20),
                        child: Text(
                          _con.policyList[0].policy??" ",
                          style: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 15, letterSpacing: 1.5)),
                        ),
                      )
              ],
            ),
          ),
        ));
  }
}
