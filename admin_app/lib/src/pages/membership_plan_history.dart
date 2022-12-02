import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:login_and_signup_web/src/elements/CustomPaginatedTableWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/membership_plan_history.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
class MembershipPlanHistory extends StatefulWidget {
  @override
  _MembershipPlanHistoryState createState() => _MembershipPlanHistoryState();
}

class _MembershipPlanHistoryState extends StateMVC<MembershipPlanHistory> with SingleTickerProviderStateMixin {
  UserController _con;

  _MembershipPlanHistoryState() : super(UserController()) {
    _con = controller;
  }
  List<VendorPlanHistory> itemList=<VendorPlanHistory>[];
  int rowsperpage=10;
  @override
  void initState() {
    super.initState();
    _con.listenForPlanHistory();
    itemList=_con.vendorPlanList;
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    final _dtSource = UserDataTableSource(
      userData: itemList,
      context: context,
    );
    return SingleChildScrollView(
        child:Column(
          children: [
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
                        autofocus: false,
                        onChanged: (e){
                          setState((){

                            itemList =_con.filtermemberhistoryplan(_con.vendorPlanListTemp, e);

                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: S.of(context).search,
                          hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                          labelText: S.of(context).search,
                          labelStyle: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 14)),
                          suffixIcon: IconButton(
                            icon:Icon(Icons.search, color: Theme.of(context).colorScheme.secondary), onPressed: () {  },
                          ),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                        ),
                      ))
                ],
                dataColumns: [
                  DataColumn(
                    label: Text('S.No',style: Theme.of(context).textTheme.headline1,),
                  ),
                  DataColumn(
                    label: Text(S.of(context).history_id,style: Theme.of(context).textTheme.headline1,),
                  ),
                  DataColumn(
                    label: Text(S.of(context).plan_id,style: Theme.of(context).textTheme.headline1,),
                  ),
                  DataColumn(
                    label: Text(S.of(context).plan_name,style: Theme.of(context).textTheme.headline1,),
                  ),
                  DataColumn(
                    label: Text(S.of(context).vendor,style: Theme.of(context).textTheme.headline1,),
                  ),
                  DataColumn(
                    label: Text(S.of(context).plan_amount,style: Theme.of(context).textTheme.headline1,),
                  ),
                  DataColumn(
                    label: Text(S.of(context).created_date,style: Theme.of(context).textTheme.headline1,),
                  ),
                  DataColumn(
                    label: Text(S.of(context).expire_date,style: Theme.of(context).textTheme.headline1,),
                  ),
                ],

                header:  Text(S.of(context).membership_history),
                onRowChanged: (index) => setState(() {rowsperpage=index;}),
                rowsPerPage: rowsperpage,//_prosvider.rowsPerPage,
                showActions: true,
                source: _dtSource,
                //sortColumnIndex: _provider.sortColumnIndex,
                //sortColumnAsc: _provider.sortAscending,
              ),
            )
          ],
        ));
  }
}
class UserDataTableSource extends DataTableSource {
  UserDataTableSource({
    List<VendorPlanHistory> userData,
    BuildContext context,
  })  : itemList = userData,
        context=context,

        assert(userData != null);

  final List<VendorPlanHistory> itemList;
  final context;
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
        DataCell(Text(itemList [index].id ?? ' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(itemList [index].planId ?? ' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(itemList [index].planName ?? ' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text('${itemList [index].shopName} (${itemList [index].vendorId})' ?? ' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(Helper.pricePrint(itemList [index].planAmount ?? ' '),style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(itemList [index].createdDate ?? ' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(itemList [index].expireDate ?? ' ',style: Theme.of(context).textTheme.subtitle2,)),
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
