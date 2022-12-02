import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/elements/CustomPaginatedTableWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/models/cinHistoryModel.dart';

class CinHistory extends StatefulWidget {
  @override
  _CinHistoryState createState() => _CinHistoryState();
}

class _CinHistoryState extends StateMVC<CinHistory> with SingleTickerProviderStateMixin {
  SecondaryController _con;

  _CinHistoryState() : super(SecondaryController()) {
    _con = controller;
  }

  bool isSwitched = false;
  int rowsperpage=5;
  bool status = false;
  List<CinHistoryModel> itemList = <CinHistoryModel>[];

  @override
  void initState() {
    super.initState();
    _con.listenForCIN();
    itemList = _con.cinHistoryListTemp;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //itemList.length<10? rowsperpage=5:rowsperpage=10;
    final _dtSource = UserDataTableSource(
      userData: itemList,
    );
    return Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 30.0, top: 25.0, right: 30, bottom: 10.0),
                child: Wrap(alignment: WrapAlignment.spaceBetween, children: [
                  Div(
                      colS: 6,
                      colM: 6,
                      colL: 6,
                      child: Wrap(alignment: WrapAlignment.start, children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back_outlined)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'CIN HISTORY',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                      ])),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.6)),
                  child: itemList.isEmpty?EmptyOrdersWidget():Container(
                    width: size.width,
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
                                  itemList = _con.filterCinHistory(_con.cinHistoryListTemp, e);
                                });
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                hintText: S.of(context).search,
                                hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search, color: Theme.of(context).colorScheme.secondary),
                                  onPressed: () {},
                                ),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                              ),
                            ))
                      ],
                      dataColumns: [
                        DataColumn(
                          label: Text('S.No'),
                        ),
                        DataColumn(
                          label: Text(S.of(context).transaction_id),
                        ),
                        DataColumn(
                          label: Text(S.of(context).driver),
                        ),
                        DataColumn(
                          label: Text('Type'),
                        ),
                        DataColumn(
                          label: Text(S.of(context).amount),
                        ),
                        DataColumn(label: Text('Collected date'))
                      ],
                      //header:  Text('zones'),
                      onRowChanged: (index) => setState(() {rowsperpage=index;}),
                      rowsPerPage: rowsperpage,//_prosvider.rowsPerPage,
                      showActions: true,
                      source: _dtSource,
                      //sortColumnIndex: _provider.sortColumnIndex,
                      //sortColumnAsc: _provider.sortAscending,
                    ),
                  )),
              // tab bar view here
              SizedBox(height: 5),
            ],
          ),
        ));
  }
}
class UserDataTableSource extends DataTableSource {
  UserDataTableSource({
    List<CinHistoryModel> userData,


    //this.onRowSelect,
  })  : itemList = userData,

        assert(userData != null);

  final List<CinHistoryModel> itemList;


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
        DataCell(Text((index + 1).toString() ?? ' ')),
        DataCell(Text(itemList[index].id ?? ' ')),
        DataCell(Text('${itemList[index].driverName} (${itemList[index].driverId}) ' ?? ' ')),
        DataCell((itemList[index].type == 'driver') ? Text('Driver') : Text('Provider')),
        DataCell(Text(Helper.pricePrint(itemList[index].cashCollected ?? ' '))),
        DataCell(Text(Helper.pricePrint(itemList[index].collectedTime ?? ' '))),
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
