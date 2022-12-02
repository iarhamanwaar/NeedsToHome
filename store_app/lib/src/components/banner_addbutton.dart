
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/elements/AEBannerWidget.dart';
import 'package:login_and_signup_web/src/models/banner.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class BannerAddButton extends StatefulWidget {
  @override
  _BannerAddButtonState createState() => _BannerAddButtonState();
}

class _BannerAddButtonState extends StateMVC<BannerAddButton> {

  SecondaryController _con;

  _BannerAddButtonState() : super(SecondaryController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      width: 30.0,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        color: Colors.white,
        icon: const Icon(Icons.add),
        iconSize: 30.0,
        //color: Palette.facebookBlue,
        onPressed: () {
          AddBannerHelper.exit(context,_con,BannerModel(),'add');
        },
      ),
    );
  }
}

class AddBannerHelper {

  static exit(context,con,details,pageType) => showDialog(context: context, builder: (context) =>  BannerPopup(con: con,details: details,pageType: pageType,));
}
