import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/cashonhand.dart';
import 'package:login_and_signup_web/src/pages/cinhistory.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'CustomPaginatedTableWidget.dart';
import 'EmptyOrdersWidget.dart';

//ignore: must_be_immutable
class DriverCashOnHandWidget extends StatefulWidget {
  String pageType;

  DriverCashOnHandWidget({Key key, this.pageType}) : super(key: key);

  @override
  _DriverCashOnHandWidgetState createState() => _DriverCashOnHandWidgetState();
}

class _DriverCashOnHandWidgetState extends StateMVC<DriverCashOnHandWidget> {
  SecondaryController _con;

  _DriverCashOnHandWidgetState() : super(SecondaryController()) {
    _con = controller;
  }

  List<CashOnHandModel> itemList = <CashOnHandModel>[];
  bool isSwitched = false;
  bool status = false;
  int rowsperpage=5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listenForCOH(widget.pageType);
    itemList = _con.cashOnHandList;

  }

  @override
  Widget build(BuildContext context) {
    final _dtSource = UserDataTableSource(
      userData: itemList,
      con: _con,
      context: context,
      pageType: widget.pageType
    );
    //itemList.length<10? rowsperpage=5:rowsperpage=10;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(children: [
        itemList.isEmpty?EmptyOrdersWidget():Container(
          child: CustomPaginatedTable(
            actions: [
              Container(
                  height: 40,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.05), offset: Offset(0, 5), blurRadius: 1)],
                      border: Border.all(width: 1, color: Theme.of(context).dividerColor)),
                  child: TextField(
                    autofocus: false,
                    onChanged: (e) {
                      setState(() {
                        itemList = _con.filterCin(_con.cashOnHandListTemp, e);
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: S.of(context).search,
                      labelText: S.of(context).search,
                      hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                      labelStyle: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 14)),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search, color: Theme.of(context).colorScheme.secondary),
                        onPressed: () {},
                      ),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                    ),
                  )),
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CinHistory()));
              }, icon: Icon(Icons.history_outlined),tooltip: S.of(context).history)
            ],
            dataColumns: [
              DataColumn(
                label: Text('S.No',style: Theme.of(context).textTheme.headline1,),
              ),
              DataColumn(
                label: Text(widget.pageType+' Id',style: Theme.of(context).textTheme.headline1,),
              ),
              DataColumn(
                label: Text(S.of(context).name,style: Theme.of(context).textTheme.headline1,),
              ),
              DataColumn(
                label: Text(S.of(context).amount,style: Theme.of(context).textTheme.headline1,),
              ),
              DataColumn(
                label: Text(S.of(context).action,style: Theme.of(context).textTheme.headline1,),
              ),
            ],
            //header:  Text('zones'),
            onRowChanged: (index) => setState(() {rowsperpage=index;}),
            rowsPerPage:rowsperpage,//_prosvider.rowsPerPage,
            showActions: true,
            source: _dtSource,
            //sortColumnIndex: _provider.sortColumnIndex,
            //sortColumnAsc: _provider.sortAscending,
          ),
        ),
      ]),
    );
  }
}

class UserDataTableSource extends DataTableSource {
  UserDataTableSource({
    List<CashOnHandModel> userData,
    BuildContext context,
    SecondaryController con,
    String pageType,

    //this.onRowSelect,
  })  : itemList = userData,
        context = context,
        _con = con,
        pageType = pageType,
        assert(userData != null);

  final List<CashOnHandModel> itemList;
  final context;
  SecondaryController _con;
  String pageType;

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
        DataCell(Text((index + 1).toString() ?? ' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(itemList[index].id ?? ' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(itemList[index].name ?? ' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(Helper.pricePrint(itemList[index].amount ?? ' '),style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(
          // ignore: deprecated_member_use
          InkWell(
            onTap: () {
              _con.addECinHistory(itemList[index],pageType);
            },
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(children: [
                  Icon(Icons.edit, size: 15, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    S.of(context).collect_cash,
                  )
                ]),
              ),
            ),
          ),
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
