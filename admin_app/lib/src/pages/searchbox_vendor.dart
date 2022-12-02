import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/primaryuser_controller.dart';
import 'package:login_and_signup_web/src/controllers/search_controller.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/elements/VendorBoxWidget.dart';
import 'package:login_and_signup_web/src/models/vendor.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
// ignore: must_be_immutable
class SearchBoxVendor extends StatefulWidget {
  SearchBoxVendor({this.con,this.vendorList, Key key}) : super(key: key);
  PrimaryUserController con;
  List<VendorModel>  vendorList;
  @override
  _SearchBoxVendorState createState() => _SearchBoxVendorState();
}

class _SearchBoxVendorState extends StateMVC<SearchBoxVendor> {
  bool isSwitched = false;
  List<VendorModel>  itemList;
  bool status = false;
  SearchController _con;
  _SearchBoxVendorState() : super(SearchController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemList = widget.vendorList;
    //print('itemList:${itemList[0].vendor.length}');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.6),
        elevation: 0,
        title: Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(color:Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5.0),
                boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.05), offset: Offset(0, 5), blurRadius: 1)],
                border:Border.all(
                    width: 1,
                    color:Theme.of(context).dividerColor
                )
            ),
            child: TextField(
              autofocus: true,
              onChanged: (e){
                setState((){
                  itemList = _con.filterListVendor(widget.vendorList, e);
                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: S.of(context).search,
                hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                suffixIcon: IconButton(
                  icon:Icon(Icons.search, color: Theme.of(context).colorScheme.secondary), onPressed: () {  },
                ),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
              ),
            )),
      ),
      body: Padding(
        padding: EdgeInsets.only(top:0),
        child:SingleChildScrollView(
          child:Responsive(
            children: [
              Div(
                colS:12,
                colM:12,
                colL:12,
                child: Column(
                  children: [
                    Wrap(
                      children: List.generate(itemList.length, (index) {
                        VendorModel _vendorData = itemList.elementAt(index);
                        return VendorBoxWidget(details:  _vendorData, con:  widget.con, type: 1,);
                      }
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );



  }
}






