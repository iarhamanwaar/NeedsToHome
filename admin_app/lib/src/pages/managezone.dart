

import 'package:flutter/material.dart';

import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/hservice_controller.dart';
import 'package:login_and_signup_web/src/elements/CustomPaginatedTableWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/models/provider.dart';
import 'package:login_and_signup_web/src/models/zone.dart';
import 'package:login_and_signup_web/src/pages/zone.dart';
import 'package:login_and_signup_web/src/repository/secondary_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';



import 'package:responsive_ui/responsive_ui.dart';
import 'package:vrouter/vrouter.dart';

class ManageZone extends StatefulWidget {
  @override
  _ManageZoneState createState() => _ManageZoneState();
}

class _ManageZoneState extends StateMVC<ManageZone>  {
  HServiceController _con;
  List<ProviderModel> providerList=<ProviderModel>[];
  List<ZoneModel> itemList=<ZoneModel>[];
  _ManageZoneState() : super(HServiceController()) {
    _con = controller;
  }
  bool isSwitched = false;
  int rowsperpage=10;
  @override
  // ignore: must_call_super
  void initState()  {
    _con.listenForZone();
    itemList=_con.zoneListTemp;

    print(providerList.length);
  }

  callback(){
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    //itemList.length<10? rowsperpage=5:rowsperpage=10;
    final _dtSource = UserDataTableSource(
      userData: itemList,
      isSwitched: isSwitched,
      con: _con,
      context: context,
      setState: setState,
    );
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
                        width: size.width*0.9,
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
                                          S.of(context).manage_zone,
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
                                              VRouter.of(context).to('/zone');



                                            },
                                          ),
                                        )

                                      ]
                                  )
                              ),
                            ]
                        ),
                      ),

                      SizedBox(height: 10),
                      SizedBox(
                        height: 10,
                      ),
                      itemList.isEmpty?EmptyOrdersWidget():Container(
                        width: size.width,
                          child: CustomPaginatedTable(

                            actions: [
                              Container(
                                  height: 40,
                                  width: 130,
                                  decoration: BoxDecoration(color:Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5.0),
                                      boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.05), offset: Offset(0, 5), blurRadius: 1)],
                                      border:Border.all(
                                          width: 1,
                                          color:Theme.of(context).dividerColor
                                      )
                                  ),
                                  child: TextField(
                                    onChanged: (e){
                                      setState((){
                                        itemList =_con.filterZone(_con.zoneListTemp, e);
                                      });
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      hintText: S.of(context).search,
                                      labelText: S.of(context).search,
                                      hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                                      suffixIcon: IconButton(
                                        icon:Icon(Icons.search, color: Theme.of(context).colorScheme.secondary), onPressed: () {  },
                                      ),
                                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                                    ),
                                  ))
                            ],
                            dataColumns: [
                              DataColumn(label: Text('S.NO',style: Theme.of(context).textTheme.headline1,),
                                tooltip: 'S.NO',
                                numeric: true,
                              ),
                              DataColumn(label: Text('zone id',style: Theme.of(context).textTheme.headline1,),
                                tooltip: 'zone id',
                              ),
                              DataColumn(label: Text('zone',style: Theme.of(context).textTheme.headline1,),
                                tooltip: 'zone',
                              ),
                              DataColumn(
                                label: Text(S.of(context).date,style: Theme.of(context).textTheme.headline1,),
                              ),
                              DataColumn(
                                label: Text('block',style: Theme.of(context).textTheme.headline1,),
                              ),
                              DataColumn(label: Text(S.of(context).no_of_shops,style: Theme.of(context).textTheme.headline1,)),
                              DataColumn(label: Text(S.of(context).no_of_drivers,style: Theme.of(context).textTheme.headline1,)),
                              DataColumn(label: Text('no.of.providers',style: Theme.of(context).textTheme.headline1,)),
                              DataColumn(label: Text(S.of(context).options,style: Theme.of(context).textTheme.headline1,)),
                            ],

                            header:  Text('zones'),
                            onRowChanged: (index) => setState(() {rowsperpage=index;}),
                            rowsPerPage: rowsperpage,//_prosvider.rowsPerPage,
                            showActions: true,
                            source: _dtSource,
                            //sortColumnIndex: _provider.sortColumnIndex,
                            //sortColumnAsc: _provider.sortAscending,
                          ),


                      )
                    ])),
          ],
        ),
      ),
    );



  }


// ignore: non_constant_identifier_names

}



class UserDataTableSource extends DataTableSource {
  UserDataTableSource({
    List<ZoneModel> userData,
    bool isSwitched,
    BuildContext context,
    Function setState,
    HServiceController con,

    //this.onRowSelect,
  })  : itemList = userData,
        context=context,
        isSwitched=isSwitched,
        setState=setState,
        _con=con,
        assert(userData != null);

  final List<ZoneModel> itemList;
  final context;
  HServiceController _con;
  bool isSwitched;
  StateSetter setState;

  //final OnRowSelect onRowSelect;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= itemList.length) {
      return null;
    }
    return DataRow.byIndex(

      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text((index+1).toString()??' ',style: Theme.of(context).textTheme.subtitle2,),),
        DataCell(Text(itemList[index].id??' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(itemList[index].title??' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(itemList[index].date??' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Switch(
          value: itemList[index].status,
          onChanged: (value) {
            setState(() {
              itemList[index].status = value;
              if(value==true){
                isSwitched=false;
                itemList[index].status=true;
                statusUpdate('zone',itemList[index].id,'status','1');
              } else{
                isSwitched=true;
                itemList[index].status=false;
                //widget.details.status = false;
                statusUpdate('zone',itemList[index].id,'status','0');
              }
            });
          },
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.green,
        ),
        ),
        DataCell(Text(itemList[index].shop.toString(),style: Theme.of(context).textTheme.subtitle2,),),
        DataCell(Text(itemList[index].drivers.toString(),style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(itemList[index].provider.toString(),style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(
            Row(
              children: [
                Container(
                    width: 60,
                    height: 25,
                    // ignore: deprecated_member_use
                    child: FlatButton(
                        onPressed: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>Zone(pageType: 'Edit',id: itemList[index].id,)));
                        },
                        color: Colors.green,
                        shape: StadiumBorder(),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            S.of(context).edit,
                            style: Theme.of(context).textTheme.caption.merge(
                                TextStyle(
                                    color: Theme.of(context)
                                        .primaryColorLight)),
                          ),
                        )
                    )
                )
                ,
                SizedBox(
                  width: 5,
                ),
                Container(
                    width: 75,
                    height: 25,
                    child:
                    // ignore: deprecated_member_use
                    FlatButton(onPressed: (){
                      return  showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(S.of(context).confirm),
                            content: Text("If you delete this zone all shops in this zone will be deleted,Are you sure you wish to delete this zone?",maxLines: 5,),
                            actions: <Widget>[
                              // ignore: deprecated_member_use
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _con.delete('zone',itemList[index].id);
                                    setState(() {_con.zoneList.clear();});
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
                        color: Colors.red,
                        shape: StadiumBorder(),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            S.of(context).delete,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.caption.merge(
                                TextStyle(
                                    color: Theme.of(context)
                                        .primaryColorLight)),
                          ),
                        )
                    )
                )
              ],
            )
        )
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => itemList.length;

  @override
  int get selectedRowCount => 0;

}

