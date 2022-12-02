
import 'package:login_and_signup_web/src/repository/secondary_repository.dart' as secondaryRepo;
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/elements/AEProviderWidget.dart';
import 'package:login_and_signup_web/src/elements/CustomPaginatedTableWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/models/provider.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import '../controllers/hservice_controller.dart';
import '../elements/SeviceViewWidget.dart';
import '../models/excel_export.dart';
import '../repository/secondary_repository.dart';

class Provider extends StatefulWidget {
  @override
  _ProviderState createState() => _ProviderState();
}

class _ProviderState extends StateMVC<Provider>  {
  HServiceController _con;
  List<ProviderModel> providerList=<ProviderModel>[];
  _ProviderState() : super(HServiceController()) {
    _con = controller;
  }
  bool isSwitched = false;
  int rowsperpage=10;
  List<ProviderModel> itemList=<ProviderModel>[];
  @override
  // ignore: must_call_super
  void initState()  {
    _con.listenForProvider();
    itemList=_con.providerList;

  }

  callback(){
  }
  @override
  Widget build(BuildContext context) {
    List<ExcelExportModel> excelProperty = <ExcelExportModel>[
      ExcelExportModel(title: 'id', columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).user_name, columnWidth: 20.82, bold: true),
      ExcelExportModel(title: 'dob', columnWidth: 25.82, bold: true),
      ExcelExportModel(title: S.of(context).gender, columnWidth: 12.82, bold: true),
      ExcelExportModel(title: S.of(context).email, columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).mobile, columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).address, columnWidth: 30.82, bold: true),
      ExcelExportModel(title: S.of(context).about, columnWidth: 12.82, bold: true),
      ExcelExportModel(title: S.of(context).status, columnWidth: 12.82, bold: true),
      ExcelExportModel(title: 'Working Experience', columnWidth: 12.82, bold: true),
      ExcelExportModel(title: S.of(context).date, columnWidth: 12.82, bold: true),


    ];
    var size=MediaQuery.of(context).size;
    final _dtSource = UserDataTableSource(
      userData: itemList,
      context: context,
      con: _con,
      setState: setState,
    );
    return Container(
      color:Theme.of(context).primaryColor.withOpacity(0.6),
      child: SingleChildScrollView(
        child: Column(
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
                                        InkWell(
                                          onTap:() async {
                                            int row =  itemList.length;
                                            int col = excelProperty.length;
                                            // ignore: deprecated_member_use
                                            var twoDList = List.generate(row, (i) => List(col), growable: false);
                                            int i = 0;
                                            itemList.forEach((element) {
                                              twoDList[i][0] = element.id;
                                              twoDList[i][1] = element.username;
                                              twoDList[i][2] = element.dob;
                                              twoDList[i][3] = element.gender;
                                              twoDList[i][4] = element.email;
                                              twoDList[i][5] = element.mobile;
                                              twoDList[i][6] = '${element.address1},${element.address2},${element.city} ${element.state}' ;
                                              twoDList[i][7] = element.about;
                                              twoDList[i][8] = element.status;
                                              twoDList[i][9] = element.workingexperience;
                                              twoDList[i][10] = element.registerdate;
                                              i++;
                                            });


                                            secondaryRepo.createExcel(excelProperty, twoDList,'provider');
                                          },
                                          child: Padding(
                                              padding:EdgeInsets.only(left:8,top:5),
                                              child:Image(image:AssetImage('assets/img/excel.png'),
                                                  width:25,height:25
                                              )
                                          ),
                                        ),
                                        /**  Container(
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
                                            //AddEdPopupHelper.exit(context, _con, ProviderModel(), 'add');
                                            AddEdPopupHelper.exit(context, _con, ProviderModel(), 'add');
                                            },
                                            ),
                                            ), */

                                      ]
                                  )
                              ),
                              /** Container(
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
                                  Theme.of(context).accentColor,
                                  width: 1.0,
                                  ),
                                  ),
                                  )),
                                  ), */

                            ]
                        ),
                      ),
                      itemList.isEmpty?EmptyOrdersWidget():Container(
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
                              child: TextFormField(
                                onChanged: (e){
                                  setState((){

                                    itemList =_con.filterProviderUser(_con.providerListTemp, e);

                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  hintText:S.of(context).search,
                                  hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                                  labelText: S.of(context).search,
                                  labelStyle: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 14)),
                                  suffixIcon: IconButton(
                                    icon:Icon(Icons.search, color: Theme.of(context).colorScheme.secondary), onPressed: () {  },
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                                  focusedBorder:
                                  OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                                ),
                              ),
                            )
                          ],
                          dataColumns: [
                            DataColumn(
                              label: Text('S.NO',style: Theme.of(context).textTheme.headline1,),),
                            DataColumn(
                              label: Text(S.of(context).user_name,style: Theme.of(context).textTheme.headline1,),),
                            DataColumn(
                              label: Text('Dob',style: Theme.of(context).textTheme.headline1,),
                            ),
                            DataColumn(
                              label: Text(S.of(context).gender,style: Theme.of(context).textTheme.headline1,),
                            ),
                            DataColumn(
                              label: Text(S.of(context).email,style: Theme.of(context).textTheme.headline1,),
                            ),
                            DataColumn(
                              label: Text(S.of(context).mobile,style: Theme.of(context).textTheme.headline1,),
                            ),

                            DataColumn(
                              label: Text(S.of(context).address,style: Theme.of(context).textTheme.headline1,),
                            ),
                            DataColumn(
                              label: Text('Working experience',style: Theme.of(context).textTheme.headline1,),
                            ),

                            DataColumn(
                              label: Text('Register date',style: Theme.of(context).textTheme.headline1,),
                            ),
                            DataColumn(
                              label: Text(S.of(context).status,style: Theme.of(context).textTheme.headline1,),
                            ),
                            DataColumn(
                              label: Text(S.of(context).action,style: Theme.of(context).textTheme.headline1,),
                            ),

                          ],
                          //header:  Text('zones'),
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
                  title: new Text('View'),
                  onTap: () => {
                    Navigator.pop(context),

                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.edit),
                  title: new Text(S.of(context).edit),
                  onTap: () => {
                    Navigator.pop(context),
                    //AddEdPopupHelper.exit(context,_con, Details,'edit'),
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: ()  async{
                    //await _con.delete('shopFocusType',id);

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






class UserDataTableSource extends DataTableSource {
  UserDataTableSource({
    List<ProviderModel> userData,

    BuildContext context,
    Function setState,
    HServiceController con,

    //this.onRowSelect,
  })  : itemList = userData,
        context=context,
        setState=setState,
        _con=con,
        assert(userData != null);

  final List<ProviderModel> itemList;
  final context;
  HServiceController _con;
  StateSetter setState;
  //final OnRowSelect onRowSelect;
  bool isSwitched = false;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= itemList.length) {
      return null;
    }
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text((index+1).toString()??' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(itemList[index].username??' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(itemList[index].dob??' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(itemList[index].gender??' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(itemList[index].email??' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(itemList[index].mobile??' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(itemList[index].address1??' '+' '+itemList[index].address2??' '+' '+itemList[index].city??' '+' '+itemList[index].state??' '+' '+itemList[index].zipcode??' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(itemList[index].workingexperience??' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(itemList[index].registerdate??' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(


          Switch(
          value: itemList[index].status,
          onChanged: (value) {
            setState(() {
              itemList[index].status = value;
              if(value==true){
                isSwitched=false;
                itemList[index].status=true;
                statusUpdate('provider',itemList[index].id,'status','success');
              } else{
                isSwitched=true;
                itemList[index].status=false;
                //widget.details.status = false;
                statusUpdate('provider',itemList[index].id,'status','block');
              }
            });
          },
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.green,
        ),
        ),
        DataCell(
            Row(
                children: [

            Container(
                width: 70,
                height: 25,
                // ignore: deprecated_member_use
                child: FlatButton(
                    onPressed: (){
                      ServicePopupHelper.exit(context, _con,itemList[index]);
                    },
                    color: Colors.green,
                    shape: StadiumBorder(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                      'Services',
                        style: Theme.of(context).textTheme.caption.merge(
                            TextStyle(
                                color: Theme.of(context)
                                    .primaryColorLight)),
                      ),
                    )
                )
    ),
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
                        content: Text("Are you sure to delete?",maxLines: 5,),
                        actions: <Widget>[
                          // ignore: deprecated_member_use
                          FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _con.delete('provider',itemList[index].id);
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
            ])
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


class ServicePopupHelper {

  //static exit(context,con,details, pageType) => showDialog(context: context, builder: (context) =>  AEProviderWidget(con: con,providerDetails: details,pageType: pageType, ));
  static exit(context,con, details) => showDialog(context: context, builder: (context) =>  ServiceViewWidget(providerDetails: details ));
}