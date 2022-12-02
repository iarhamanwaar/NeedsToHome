
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/vendorwallet.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'CustomPaginatedTableWidget.dart';
import 'EmptyOrdersWidget.dart';
import 'WalletDetailsViewWidget.dart';
//ignore: must_be_immutable
class WalletTransactionListWidget extends StatefulWidget {

  String type;
  int vendorId;
  WalletTransactionListWidget({Key key,  this.type,this.vendorId}) : super(key: key);

  @override
  _WalletTransactionListWidgetState createState() => _WalletTransactionListWidgetState();
}

class _WalletTransactionListWidgetState extends StateMVC<WalletTransactionListWidget> {
  SecondaryController _con;

  _WalletTransactionListWidgetState() : super(SecondaryController()) {
    _con = controller;
  }
  List<VendorWallet> itemList=<VendorWallet>[];
  int rowsperpage=10;
  @override
  void initState() {
    print(widget.type);
    // TODO: implement initState
    super.initState();
    _con.listenForVendorWallet(widget.type);

    itemList=_con.vendorWalletList;
  }

  @override
  Widget build(BuildContext context) {
    final _dtSource = UserDataTableSource(
      userData: itemList,
      type: widget.type,
      con: _con,
      context: context,
      setState: setState,
    );
    return  SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            itemList.isEmpty?EmptyOrdersWidget():Container(

              child: CustomPaginatedTable(
                actions: [
                  Padding(
                      padding:EdgeInsets.only(right:10),
                      child:Container(
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

                                itemList = _con.filterWallet( _con.vendorWalletListTemp, e);

                              });
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: S.of(context).search,
                              labelText:S.of(context).search,
                              hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                              labelStyle: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 14)),
                              suffixIcon: IconButton(
                                icon:Icon(Icons.search, color: Theme.of(context).colorScheme.secondary), onPressed: () {  },
                              ),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                            ),
                          ))
                  )
                ],
                dataColumns: [
                  DataColumn(
                    label: Text('S.No',style: Theme.of(context).textTheme.headline1),
                  ),
                  DataColumn(
                    label: Text(S.of(context).transaction_id,style: Theme.of(context).textTheme.headline1),
                  ),
                  DataColumn(
                    label: Text(S.of(context).vendor_id,style: Theme.of(context).textTheme.headline1),
                  ),
                  DataColumn(
                    label: Text(S.of(context).amount,style: Theme.of(context).textTheme.headline1),
                  ),
                  DataColumn(
                    label: Text(S.of(context).notes,style: Theme.of(context).textTheme.headline1),
                  ),
                  DataColumn(
                    label: Text(S.of(context).status,style: Theme.of(context).textTheme.headline1),
                  ),
                  DataColumn(
                    label: Text(S.of(context).requested_date,style: Theme.of(context).textTheme.headline1),
                  ),
                  DataColumn(
                    label: Text(S.of(context).processed_date,style: Theme.of(context).textTheme.headline1),
                  ),
                  DataColumn(
                    label: Text(S.of(context).options,style: Theme.of(context).textTheme.headline1),
                  ),
                ],
                header:  Text(widget.type),
                onRowChanged: (index) => setState(() {rowsperpage=index;}),
                rowsPerPage: rowsperpage,//_prosvider.rowsPerPage,
                showActions: true,
                source: _dtSource,
                //sortColumnIndex: _provider.sortColumnIndex,
                //sortColumnAsc: _provider.sortAscending,
              ),
            )
          ]
      ),
    );
  }
}

class UserDataTableSource extends DataTableSource {
  UserDataTableSource({
    List<VendorWallet> userData,
    bool isSwitched,
    BuildContext context,
    Function setState,
    SecondaryController con,
    String type

    //this.onRowSelect,
  })  : itemList = userData,
        context=context,
        isSwitched=isSwitched,
        setState=setState,
        _con=con,
        type=type,
        assert(userData != null);

  final List<VendorWallet> itemList;
  final context;
  SecondaryController _con;
  bool isSwitched;
  StateSetter setState;
  String type;

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
        DataCell(Text(itemList[index].id??' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(itemList[index].vendorId??' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(Helper.pricePrint(
            itemList[index].amount ?? ' '),style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(
            Text(itemList[index].notes ?? ' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Row(
          children: [
            Container(
                width: 60,
                height: 25,
                // ignore: deprecated_member_use
                child: FlatButton(
                    onPressed: () {
                      //AddCategoryHelper.exit(context,_con,_con.taxList[index], 'edit');
                    },
                    color: Colors.green,
                    shape: StadiumBorder(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8.0),
                      child: Text(
                        itemList[index].status,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .merge(TextStyle(
                            color: Theme.of(context)
                                .primaryColorLight)),
                      ),
                    ))),
            SizedBox(
              width: 5,
            ),
          ],
        )),
        DataCell(Text(
            itemList[index].reqDate ?? ' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(
            itemList[index].processDate ?? ' ',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(
          // ignore: deprecated_member_use
          FlatButton(
              onPressed: () {
                showDialog(context: context,
                    builder: (BuildContext context){
                      return WalletDetailsViewWidget(con:_con,wallet: itemList[index],type: type,);
                    }
                );
              },
              color:Colors.green,

              textColor:Theme.of(context).primaryColorLight,
              child:Wrap(children:[
                Icon(Icons.edit,size:15,color:Colors.white),
                SizedBox(width:5),
                Text('Proceed',)
              ])

          ),)
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
