import 'package:flutter/material.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import '../controllers/secondary_controller.dart';
import '../elements/AEDeliveryTipsWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/delivery_Tips.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

class DeliveryTips extends StatefulWidget {


  @override
  _DeliveryTipsState createState() => _DeliveryTipsState();
}

class _DeliveryTipsState extends StateMVC<DeliveryTips> {
  SecondaryController _con;
  _DeliveryTipsState() : super(SecondaryController()) {
    _con = controller;
  }
  @override
  void initState() {

    super.initState();
    _con.listenForDeliveryTips();
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
                      child:Wrap(
                          alignment: WrapAlignment.start,
                          children:[
                            Div(
                                colS:12,
                                colM:12,
                                colL:12,
                                child:Wrap(
                                    children:[
                                      Text(
                                        S.of(context).manage_delivery_tips,
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
                                            DeliveryTipsPopupHelper.exit(context,_con,DeliveryTipsModel(),'add');
                                            //DeliveryFeesPopupHelper.exit(context);
                                          },
                                        ),
                                      ),


                                    ]
                                )
                            ),


                          ]
                      ),
                    ),

                    SizedBox(height: 20),




                    _con.deliveryTipsList.isEmpty?EmptyOrdersWidget():Container(
                      margin: EdgeInsets.only(left:20, right: 20,bottom:30),
                      child: Wrap(
                        children: List.generate(_con.deliveryTipsList.length,(index) {
                          DeliveryTipsModel _deliveryTipsData = _con.deliveryTipsList.elementAt(index);
                          return InkWell(onTap: () {
                            Imagepickerbottomsheet(_con.deliveryTipsList[index].id, _con.deliveryTipsList[index]);
                          }, child:Div(
                            colS:12,
                            colM:4,
                            colL:2,
                            child:Container(
                                padding:EdgeInsets.only(left:10,right:10,top:10,bottom:10),
                                child:Container(
                                    padding:EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color:Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5.0,
                                            spreadRadius: 1,
                                          ),
                                        ]),
                                    child:Column(
                                      children: [
                                        Text(Helper.pricePrint(_deliveryTipsData.tips),style:Theme.of(context).textTheme.headline5.merge(TextStyle(fontWeight: FontWeight.w600))),
                                                Text(S.of(context).delivery_tips),

                                      ],
                                    )

                                )
                            ),

                          ));
                        }
                        ),
                      ),
                    ),




                  ],
                )),
          ],
        ),
      ),
    );
  }
  // ignore: non_constant_identifier_names
  Imagepickerbottomsheet(id, TipsDetails) {
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
                    DeliveryTipsPopupHelper.exit(context,_con, TipsDetails,'edit'),
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: ()  async{
                    await _con.delete('tips',id);

                    Navigator.pop(context);
                    setState(() {
                     _con.deliveryTipsList.clear();



                    });

                  },
                ),
              ],
            ),
          );
        });
  }
}


class DeliveryTipsPopupHelper {

  static exit(context,con,deliveryTipsDetails,pageType) => showDialog(context: context, builder: (context) =>  AEDeliveryTipsWidget(con:con,deliveryTipsDetails:deliveryTipsDetails,pageType:pageType));
}



