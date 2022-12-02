
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/models/banner.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'AEBannerWidget.dart';
import 'EmptyOrdersWidget.dart';

// ignore: must_be_immutable
class BannerWidget extends StatefulWidget {
  int typeID;
  SecondaryController con;
  BannerWidget({Key key, this.typeID, this.con}) : super(key: key);
  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends StateMVC<BannerWidget> {


  @override
  void initState() {
    // TODO: implement initState
    widget.con.listenForBanner(widget.typeID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return   widget.con.bannerList.isEmpty? EmptyOrdersWidget():Container(
      child: SingleChildScrollView(
          child:Responsive(
              children:[
                Div(
                    colS:12,
                    colM:12,
                    colL:12,
                    child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Wrap(

                            children: List.generate( widget.con.bannerList.length, (index) {
                              BannerModel _bannerData =  widget.con.bannerList.elementAt(index);
                              return  InkWell(
                                  onTap: () {
                                      Imagepickerbottomsheet( widget.con.bannerList[index].id,  widget.con.bannerList[index]);
                                  }, child:Div(
                                    colS: 12,
                                    colM: 12,
                                    colL: 4,

                                    child:  Container(
                                      decoration: BoxDecoration(
                                          color:Colors.white,
                                          borderRadius: BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 5.0,
                                              spreadRadius: 1,
                                            ),
                                          ]),
                                      margin: EdgeInsets.only(left:15,right:15, top: 10.0,bottom:10),

                                      child:Column(
                                          children:[

                                            ClipRRect(
                                              //borderRadius: BorderRadius.all(Radius.circular(10)),
                                                borderRadius: BorderRadius.circular(10.0),
                                                child: Image.network(_bannerData.uploadImage,
                                                    width:double.infinity,
                                                    height:150,
                                                    fit:BoxFit.fill,
                                                ),

                                                )





                                          ]
                                      ),
                                    ),
                                  ),
                                );

                            }
                            ),
                          ),
                        ]
                    )

                )


              ]
          )
      ),

    );
  }
  // ignore: non_constant_identifier_names
  Imagepickerbottomsheet(id, details) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new ListTile(
                  leading: new Icon(Icons.edit),
                  title: new Text(S.of(context).edit),
                  onTap: () => {
                    Navigator.pop(context),
                  AddBannerHelper.exit(context, widget.con, details,'edit'),
                   // AddCategoryHelper.exit(context,widget.con, categoryDetails,'edit'),
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: ()  async{
                 await  widget.con.delete('banner',id);

                    Navigator.pop(context);
                   setState(() {
                     widget.con.bannerList.clear();



                    });

                  },
                ),
              ],
            ),
          );
        });
  }
}
class AddBannerHelper {

  static exit(context,con,details,pageType) => showDialog(context: context, builder: (context) =>  BannerPopup(con: con,details: details,pageType: pageType,));
}