import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/src/controllers/home_controller.dart';
import 'package:multisuperstore/src/models/vendor.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'NoShopFoundWidget.dart';
import 'RectangularLoaderWidget.dart';
import 'ShopListWidget.dart';
// ignore: must_be_immutable
class SearchShopListWidget extends StatefulWidget {

  HomeController con;
  List<Vendor> vendor;
  SearchShopListWidget({Key key,this.con, this.vendor});
  @override
  _SearchShopListWidgetState createState() => _SearchShopListWidgetState();
}

class _SearchShopListWidgetState extends StateMVC<SearchShopListWidget> {



  int shopType;
  int focusId;
  String previewImage;
  int i= 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),

      child:
      widget.vendor.isEmpty?RectangularLoaderWidget(): ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: widget.vendor.length,
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.only(top: 16),
            itemBuilder: (context, int index) {
              return widget.vendor[index].shopId=='no_data'?NoShopFoundWidget():ShopList(choice: widget.vendor[index], shopType: int.parse(widget.vendor[index].shopType),focusId: int.parse(widget.vendor[index].focusType),previewImage:previewImage,);
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 0);
            },
          ),

    );
  }
}

