
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/vendorwallet.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'EmptyOrdersWidget.dart';
import 'WalletDetailsViewWidget.dart';
//ignore: must_be_immutable
class WalletVendorTransactionListWidget extends StatefulWidget {

  String type;
  int vendorId;
  WalletVendorTransactionListWidget({Key key,  this.type,this.vendorId}) : super(key: key);

  @override
  _WalletVendorTransactionListWidgetState createState() => _WalletVendorTransactionListWidgetState();
}

class _WalletVendorTransactionListWidgetState extends StateMVC<WalletVendorTransactionListWidget> {
  SecondaryController _con;

  _WalletVendorTransactionListWidgetState() : super(SecondaryController()) {
    _con = controller;
  }
  List<VendorWallet> itemList=<VendorWallet>[];
  @override
  void initState() {
    print(widget.type);
    // TODO: implement initState
    super.initState();

    _con.listenForSVendorWallet(widget.type,widget.vendorId);
    itemList=_con.vendorWalletList;
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
          children:[
            Container(
              width:double.infinity,
              height: 45,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.6)),
              child: Div(
                colS:6,
                colM:6,
                colL:6,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[
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
                      ),


                    ]
                ),
              ),
            ),
            ( itemList.length == 0)
                ? EmptyOrdersWidget()
                : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                  color:Theme.of(context).primaryColor,
                  child:DataTable(
                      columns: [
                        DataColumn(
                          label: Text('S.No'),
                        ),
                        DataColumn(
                          label: Text(S.of(context).transaction_id),
                        ),
                        DataColumn(
                          label: Text(S.of(context).vendor_id),
                        ),
                        DataColumn(
                          label: Text(S.of(context).amount),
                        ),
                        DataColumn(
                          label: Text(S.of(context).status),
                        ),
                        DataColumn(
                          label: Text(S.of(context).requested_date),
                        ),
                        DataColumn(
                          label: Text(S.of(context).processed_date),
                        ),
                        DataColumn(
                          label: Text(S.of(context).options),
                        ),
                      ],
                      rows:
                      List.generate( itemList.length, (index) {
                        return DataRow(cells: [
                          DataCell(Text((index + 1).toString() ?? ' ')),
                          DataCell(Text(itemList[index].id??' ')),
                          DataCell(Text(itemList[index].vendorId??' ')),
                          DataCell(Text(Helper.pricePrint(
                              itemList[index].amount ?? ' '))),
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
                              itemList[index].reqDate ?? ' ')),
                          DataCell(Text(
                              itemList[index].processDate ?? ' ')),
                          DataCell(
                            // ignore: deprecated_member_use
                            FlatButton(
                                onPressed: () {
                                  showDialog(context: context,
                                      builder: (BuildContext context){
                                        return WalletDetailsViewWidget(con:_con,wallet: itemList[index],type: widget.type,);
                                      }
                                  );
                                },
                                color:Colors.green,

                                textColor:Colors.white,
                                child:Wrap(children:[
                                  Icon(Icons.edit,size:15,color:Colors.white),
                                  SizedBox(width:5),
                                  Text('Proceed',)
                                ])

                            ),),
                        ]);
                      }))),
            )
          ]
      ),
    );
  }
}
