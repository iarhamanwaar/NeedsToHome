import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/elements/ShopTypeBoxWidget.dart';
import 'package:login_and_signup_web/src/elements/ShopDetailsWidget.dart';
import 'package:login_and_signup_web/src/models/shop_type.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

class ShopTypes extends StatefulWidget {
  @override
  _ShopTypesState createState() => _ShopTypesState();
}

class _ShopTypesState extends StateMVC<ShopTypes>  {
  SecondaryController _con;
  _ShopTypesState() : super(SecondaryController()) {
    _con = controller;
  }

  @override
  // ignore: must_call_super
  void initState()  {
    _con.listenForShopTypeList();
  }

  callback(){


  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Theme.of(context).primaryColor.withOpacity(0.6),
      child: SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Div(
                colS: 12,
                colM: 12,
                colL: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 30.0, top: 25.0, right: 30, bottom: 10.0),
                      child: Div(
                                colS: GetPlatform.isMobile?  12 :8,
                                colM:GetPlatform.isMobile?  12 :8,
                                colL:GetPlatform.isMobile?  12 :8,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children:[
                                      Expanded(
                                          child:Wrap(
                                              children:[
                                                Text(
                                                  S.of(context).manage_shop_type,
                                                  style: Theme.of(context).textTheme.headline4,
                                                ),
                                                SizedBox(width:10),
                                                Container(
                                                  height: 30.0,
                                                  width: 30.0,
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: IconButton(
                                                    padding: EdgeInsets.zero,
                                                    color: Theme.of(context).primaryColorLight,
                                                    icon: const Icon(Icons.add),
                                                    iconSize: 30.0,
                                                    //color: Palette.facebookBlue,
                                                    onPressed: () {
                                                      AddEdPopupHelper.exit(context, _con, this.callback, ShopTypeModel(), 'add');
                                                      //AddEdPopupHelper.exit(context, _con, ShopTypeModel(), 'add');
                                                    },
                                                  ),
                                                ),
                                              ]
                                          )

                                      ),
                                      SizedBox(width:10),


                                    ]
                                ),
                            ),




                    ),


                    SizedBox(height: 20),
                    _con.shopTypeList.isEmpty?EmptyOrdersWidget():Container(
                      margin: EdgeInsets.only(left:20, right: 20,bottom:30),
                      child:  Wrap(
                        children: List.generate(_con.shopTypeList.length, (index) {
                          ShopTypeModel _shopTypeData = _con.shopTypeList.elementAt(index);
                          return   InkWell(
                               onTap: () {
                                 Imagepickerbottomsheet(_con.shopTypeList[index].id, _con.shopTypeList[index]);
                               },
                            child:ShopTypeBoxWidget(shopTypeData: _shopTypeData,),
                                  );
                        }),),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );



  }

  // ignore: non_constant_identifier_names
  Imagepickerbottomsheet(id, Details) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new ListTile(
                  leading: new Icon(Icons.adjust_sharp),
                  title: new Text('ID: $id'),
                  onTap: () => {
                    Navigator.pop(context),

                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.edit),
                  title: new Text(S.of(context).edit),
                  onTap: () => {
                    Navigator.pop(context),
                  AddEdPopupHelper.exit(context,_con, this.callback, Details,'edit'),
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: ()  async{
                    return  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(S.of(context).confirm),
                          content: Text("If you delete this ShopType all shops in this ShopType will be deleted,Are you sure you wish to delete this shoptype?",
                            maxLines: 5,
                          ),
                          actions: <Widget>[
                            // ignore: deprecated_member_use
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _con.delete('shop_focus',id);
                                  _con.vendorDelete(id);
                                  setState(() {_con.shopTypeList.clear();});
                                },
                                child: Text(S.of(context).delete)
                            ),
                            // ignore: deprecated_member_use
                            FlatButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(S.of(context).cancel),
                            ),
                          ],
                        );
                      },
                    );



                  },
                ),
              ],
            ),
          );
        });
  }
}




class AddEdPopupHelper {

  static exit(context,con, callback, details, pageType) => showDialog(context: context, builder: (context) =>  ShopDetailsWidget(con: con,callback: callback,shopType: details, pageType: pageType, ));
}
