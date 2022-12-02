import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/elements/AETimeSlotWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/models/delivery_timeslot.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:responsive_ui/responsive_ui.dart';

class DeliveryTimeSlot extends StatefulWidget {
  @override
  _DeliveryTimeSlotState createState() => _DeliveryTimeSlotState();
}

class _DeliveryTimeSlotState extends StateMVC<DeliveryTimeSlot> {

  SecondaryController _con;
  _DeliveryTimeSlotState() : super(SecondaryController()) {
    _con = controller;

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _con.listenForDeliveryTimeSlot();
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
                                        S.of(context).manage_time_slot,
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
                                      color: Colors.white,
                                      icon: const Icon(Icons.add),
                                      iconSize: 30.0,
                                      //color: Palette.facebookBlue,
                                      onPressed: () {
                                        DeliveryFeesPopupHelper.exit(context, _con);
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
                    _con.deliverTimeSlotList.isEmpty? EmptyOrdersWidget(): Container(
                      margin: EdgeInsets.only(left:20, right: 20,bottom:30),
                      child:
                      Wrap(

                        children: List.generate(_con.deliverTimeSlotList.length, (index) {
                          DeliveryTimeSlotModel _timeSlotData = _con.deliverTimeSlotList.elementAt(index);
                          return InkWell(
                       onTap: () {
                         Imagepickerbottomsheet(_con.deliverTimeSlotList[index].id, _con.deliverTimeSlotList[index]);
                       },  child:Div(
                            colS:12,
                            colM:6,
                            colL:4,
                            child:Container(
                                padding:EdgeInsets.only(left:10,right:10,top:10,bottom:10),
                                child:Container(
                                    padding:EdgeInsets.only(left:20,right:20,top:20,bottom:10),
                                    decoration: BoxDecoration(
                                        color:Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5.0,
                                            spreadRadius: 1.0,
                                          ),
                                        ]),
                                    child:Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Wrap(
                                                children:[
                                                  Text(_timeSlotData.fromTime,style: Theme.of(context).textTheme.headline2.merge(TextStyle(color:Colors.brown,fontWeight: FontWeight.w600)),),
                                                  SizedBox(width:4),


                                                ]
                                            ),
                                            Column(
                                              children: [
                                                Text(S.of(context).to,style: Theme.of(context).textTheme.subtitle1),
                                                Text(S.of(context).time,style: Theme.of(context).textTheme.caption),
                                              ],
                                            ),
                                            Wrap(
                                                children:[
                                                  Text(_timeSlotData.toTime,style: Theme.of(context).textTheme.headline2.merge(TextStyle(color:Colors.brown,fontWeight: FontWeight.w600)),),
                                                  SizedBox(width:4),


                                                ]
                                            ),


                                          ],
                                        ),
                                        SizedBox(height:10),

                                      ],
                                    )

                                )
                            ),
                          ),
                          );
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
  Imagepickerbottomsheet(id, Details) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: ()  async{
                    if(_con.deliverTimeSlotList.length!=1) {
                      await _con.delete('deliveryTimeSlot', id);

                      setState(() {_con.deliverTimeSlotList.clear();});
                    }
                    Navigator.pop(context);

                  },
                ),
              ],
            ),
          );
        });
  }
}



class DeliveryFeesPopupHelper {

  static exit(context,con) => showDialog(context: context, builder: (context) =>  AETimeSlotWidget(con: con, ));
}
