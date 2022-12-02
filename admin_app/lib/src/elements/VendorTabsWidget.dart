
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/primaryuser_controller.dart';
import 'package:login_and_signup_web/src/models/vendor.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'EmptyOrdersWidget.dart';
import 'VendorBoxWidget.dart';

// ignore: must_be_immutable
class VendorTabsWidget extends StatefulWidget {
  VendorTabsWidget({Key key, this.type, this.con, this.vendorList}) : super(key: key);
  int type;
  PrimaryUserController  con;
  List<VendorModel>  vendorList;
  @override
  _VendorTabsWidgetState createState() => _VendorTabsWidgetState();
}

class _VendorTabsWidgetState extends StateMVC<VendorTabsWidget> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return    widget.vendorList.isEmpty? EmptyOrdersWidget():  Container(
        child: Scrollbar(
          isAlwaysShown: true,
          child: SingleChildScrollView(
            child: Responsive(
                children:[
                  Div(
                    colS:12,
                    colM:12,
                    colL:12,
                    child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Wrap(
                            children: List.generate( widget.vendorList.length, (index) {
                              return VendorBoxWidget(details:  widget.vendorList[index], con:  widget.con, type: widget.type,);
                            }),),
                        ]),
                  ),
                ]
            ),
          ),
        )
    );
  }
}
