import 'package:flutter/material.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/elements/AEProviderWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/models/provider.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../controllers/hservice_controller.dart';

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends StateMVC<Booking>  {
  HServiceController _con;
  _BookingState() : super(SecondaryController()) {
    _con = controller;
  }

  @override
  // ignore: must_call_super
  void initState()  {
    _con.listenForProvider();
  }

  callback(){
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
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
                                          S.of(context).manage_provider,
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
                                              //AddEdPopupHelper.exit(context, _con, ProviderModel(), 'add');
                                              AddEdPopupHelper.exit(context, _con, ProviderModel(), 'add');
                                            },
                                          ),
                                        ),

                                      ]
                                  )
                              ),
                              Container(
                                width: 150,
                                height: 30,
                                child: TextFormField(
                                    textAlign: TextAlign.left,
                                    autocorrect: true,
                                    //initialValue: widget.details.title,
                                    //onSaved: (input) =>  widget.con.bannerData.title = input,
                                    validator: (input) => input.length < 1 ? S.of(context).please_enter_your_category : null,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: S.of(context).search,
                                      labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                          Theme.of(context).colorScheme.secondary,
                                          width: 1.0,
                                        ),
                                      ),
                                    )),
                              ),
                            ]
                        ),
                      ),

                      SizedBox(height: 10),
                      SizedBox(
                        height: 10,
                      ),
                      _con.providerList.isEmpty?EmptyOrdersWidget():Container(
                          margin: EdgeInsets.only(top:20,left:20, right: 20,bottom:30),
                          child:SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                                child: DataTable(
                                    columns: [
                                      DataColumn(
                                        label: Text(S.of(context).user_name),),
                                      DataColumn(
                                        label: Text('dob'),
                                      ),
                                      DataColumn(
                                        label: Text(S.of(context).gender),
                                      ),
                                      DataColumn(
                                        label: Text(S.of(context).email),
                                      ),
                                      DataColumn(
                                        label: Text(S.of(context).mobile),
                                      ),
                                      DataColumn(
                                        label: Text(S.of(context).address),
                                      ),

                                      DataColumn(
                                        label: Text('S.of(context).working_experience'),
                                      ),
                                      DataColumn(
                                        label: Text('S.of(context).register_date'),
                                      ),
                                      DataColumn(
                                        label: Text(S.of(context).status),
                                      ),
                                      DataColumn(
                                        label: Text('S.of(context).upload_image'),
                                      ),
                                      DataColumn(
                                        label: Text('S.of(context).live_status'),
                                      ),
                                      DataColumn(
                                        label: Text(S.of(context).option),
                                      ),

                                    ],
                                    rows: List.generate(_con.providerList.length, (index) {
                                      return DataRow(cells:
                                      [
                                        DataCell(Text(_con.providerList[index].username??' ')),
                                        DataCell(Text(_con.providerList[index].dob??' ')),
                                        DataCell(Text(_con.providerList[index].gender??' ')),
                                        DataCell(Text(_con.providerList[index].email??' ')),
                                        DataCell(Text(_con.providerList[index].mobile??' ')),
                                        DataCell(Text(_con.providerList[index].address1??' '+' '+_con.providerList[index].address2??' '+' '+_con.providerList[index].city??' '+' '+_con.providerList[index].state??' '+' '+_con.providerList[index].zipcode??' ')),
                                        DataCell(Text(_con.providerList[index].workingexperience??' ')),
                                        DataCell(Text(_con.providerList[index].registerdate??' ')),
                                        DataCell((_con.providerList[index].status=='success')?
                                        Container(
                                          decoration:BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(S.of(context).approved),
                                          ),
                                        ):Container(
                                          decoration:BoxDecoration(
                                              color: Colors.amberAccent,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("S.of(context).blocked"),
                                          ),
                                        )
                                        ),
                                        DataCell(Text(_con.providerList[index].uploadImage??' ')),
                                        DataCell(CircleAvatar(backgroundColor: Colors.lightGreen.withOpacity(0.2),child:Image(height: 10,width: 10,image: AssetImage('assets/img/online.png'),))),
                                        DataCell(Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 15,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.green
                                                ),
                                                child: Text(S.of(context).edit,textAlign: TextAlign.center),
                                              ),
                                              SizedBox(
                                                height:5,
                                              ),
                                              Container(
                                                height: 15,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.blue
                                                ),
                                                child: Text('S.of(context).view',textAlign: TextAlign.center),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                height: 15,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.red
                                                ),
                                                child: Text(S.of(context).delete,textAlign: TextAlign.center,),
                                              ),

                                            ],
                                          ),
                                        ))
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
                   // setState(() {_con.shopTypeList.clear();});

                  },
                ),
              ],
            ),
          );
        });
  }
}




class AddEdPopupHelper {

  //static exit(context,con,details, pageType) => showDialog(context: context, builder: (context) =>  AEProviderWidget(con: con,providerDetails: details,pageType: pageType, ));
  static exit(context,con,details, pageType) => showDialog(context: context, builder: (context) =>  AEProviderWidget(con: con,providerDetails: details,pageType: pageType, ));
}