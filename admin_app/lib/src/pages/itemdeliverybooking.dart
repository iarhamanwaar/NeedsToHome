import 'package:flutter/material.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/elements/AEStaffWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

class ItemDeliveryBooking extends StatefulWidget {
  @override
  _ItemDeliveryBookingState createState() => _ItemDeliveryBookingState();
}

class _ItemDeliveryBookingState extends StateMVC<ItemDeliveryBooking>  {
  SecondaryController _con;
  _ItemDeliveryBookingState() : super(SecondaryController()) {
    _con = controller;
  }

  @override
  // ignore: must_call_super
  void initState()  {
    _con.listenForItemDelivery();
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
                        child:Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children:[
                              Div(
                                  colS:6,
                                  colM:6,
                                  colL:6,
                                  child:Wrap(
                                      children:[
                                        Text(
                                          'Item Delivery Booking',
                                          style: Theme.of(context).textTheme.headline4,
                                        ),
                                        SizedBox(width:10),
                                      ]
                                  )
                              ),
                            ]
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _con.itemDeliveryList.isEmpty?EmptyOrdersWidget():Container(
                          margin: EdgeInsets.only(top:20,left:20, right: 20,bottom:30),
                          child:SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                                child: DataTable(
                                    columns: [
                                      DataColumn(
                                        label: Text('PickUp Address'),
                                      ),
                                      DataColumn(
                                        label: Text('Delivery Address'),
                                      ),
                                      DataColumn(
                                        label: Text('Item'),
                                      ),
                                      DataColumn(
                                        label: Text('Note'),
                                      ),
                                      DataColumn(
                                        label: Text('Total Km'),
                                      ),
                                      DataColumn(
                                        label: Text('Driver Fees'),
                                      ),
                                      DataColumn(
                                        label: Text('Commission'),
                                      ),
                                      DataColumn(
                                        label: Text('Total Amount'),
                                      ),
                                      DataColumn(
                                        label: Text('Date'),
                                      ),
                                      DataColumn(
                                        label: Text('Status'),
                                      ),
                                      DataColumn(
                                        label: Text('User ID'),
                                      ),
                                      DataColumn(
                                        label: Text('Driver ID'),
                                      ),

                                    ],
                                    rows: List.generate(_con.itemDeliveryList.length, (index) {
                                      return DataRow(cells:
                                      [
                                        DataCell(Text(_con.itemDeliveryList[index].pickupAddress??' ')),
                                        DataCell(Text(_con.itemDeliveryList[index].deliveryAddress??' ')),
                                        DataCell(Text(_con.itemDeliveryList[index].item??' ')),
                                        DataCell(Text(_con.itemDeliveryList[index].notes??' ')),
                                        DataCell(Text(_con.itemDeliveryList[index].totalKm??' ')),
                                        DataCell(Text(_con.itemDeliveryList[index].driverFees??' ')),
                                        DataCell(Text(_con.itemDeliveryList[index].commission??' ')),
                                        DataCell(Text(_con.itemDeliveryList[index].totalAmount??' ')),
                                        DataCell(Text(_con.itemDeliveryList[index].date??' ')),
                                        DataCell(Text(_con.itemDeliveryList[index].status??' ')),
                                        DataCell(Text(_con.itemDeliveryList[index].userId??' ')),
                                        DataCell(Text(_con.itemDeliveryList[index].driverId??' ')),
                                      ]
                                      );
                                    }
                                    )
                                )
                            ),
                          )
                      )

                    ])),
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
                    AddEdPopupHelper.exit(context,_con, Details,'edit'),
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: ()  async{
                    await _con.delete('shopFocusType',id);

                    Navigator.pop(context);
                    setState(() {_con.shopTypeList.clear();});

                  },
                ),
              ],
            ),
          );
        });
  }
}




class AddEdPopupHelper {

  static exit(context,con,details, pageType) => showDialog(context: context, builder: (context) =>  AEStaffWidget(con: con,staff: details,pageType: pageType, ));
}