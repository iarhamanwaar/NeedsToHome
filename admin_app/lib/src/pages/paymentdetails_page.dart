
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/controllers/hservice_controller.dart';
import 'package:login_and_signup_web/src/elements/CustomPaginatedTableWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/elements/HPaymentDetailsViewWidget.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

import '../helpers/helper.dart';
class PaymentDetailsPage extends StatefulWidget {
  const PaymentDetailsPage({Key key}) : super(key: key);

  @override
  _PaymentDetailsPageState createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends StateMVC<PaymentDetailsPage> {
  HServiceController _con;
  int rowsperpage=10;
  _PaymentDetailsPageState() : super(HServiceController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForProviderBooking();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //_con.bookingDetailsList.length<10? rowsperpage=5:rowsperpage=10;
    final _dtSource = UserDataTableSource(
      con: _con,
      context: context,
    );
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.6),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Div(
                colS: 12,
                colM: 12,
                colL: 12,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  //SizedBox(height: 20),
                  /**Container(
                      width: size.width * 0.9,
                      margin: EdgeInsets.only(left: 30.0, top: 25.0, right: 30, bottom: 10.0),
                      child: Wrap(alignment: WrapAlignment.spaceBetween, children: [
                      Div(
                      colS: 6,
                      colM: 6,
                      colL: 6,
                      child: Wrap(children: [
                      Text(
                      S.of(context).payment_details,
                      style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(width: 10),
                      InkWell(
                      onTap:() async {
                      // ignore: deprecated_member_use
                      var url = '${GlobalConfiguration().getString('api_base_url')}api_admin/export_action/paymentdetails/${currentUser.value.id}';

                      if (await canLaunch(url)) {
                      await launch(
                      url,
                      forceSafariVC: false,
                      );
                      }
                      },
                      child: Padding(
                      padding:EdgeInsets.only(left:8,top:5),
                      child:Image(image:AssetImage('assets/img/excel.png'),
                      width:25,height:25
                      )
                      ),
                      ),
                      ])),
                      /*Container(
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
                      )*/
                      ]),
                      ),**/
                  //SizedBox(height: 10),
                  SizedBox(
                    height: 10,
                  ),
                  _con.bookingDetailsList.isEmpty?EmptyOrdersWidget():Container(
                    width: size.width,
                    child: CustomPaginatedTable(
                      actions:[
                        InkWell(
                          onTap:() async {
                            // ignore: deprecated_member_use
                            var url = '${GlobalConfiguration().getString('api_base_url')}api_admin/export_action/paymentdetails/${currentUser.value.id}';

                            if (await canLaunch(url)) {
                              await launch(
                                url,
                                forceSafariVC: false,
                              );
                            }
                          },
                          child: Padding(
                              padding:EdgeInsets.only(left:8,top:5),
                              child:Image(image:AssetImage('assets/img/excel.png'),
                                  width:25,height:25
                              )
                          ),
                        ),
                      ],
                      dataColumns: [
                        DataColumn(
                          label: Container(child: Text('No',style: Theme.of(context).textTheme.headline1,)),
                        ),
                        DataColumn(
                          label: Text(S.of(context).book_id,style: Theme.of(context).textTheme.headline1,),
                        ),
                        DataColumn(
                          label: Text(S.of(context).user_name,style: Theme.of(context).textTheme.headline1,),
                        ),
                        DataColumn(
                          label: Text(S.of(context).provider_name,style: Theme.of(context).textTheme.headline1,),
                        ),
                        DataColumn(
                          label: Text(S.of(context).service_amount,style: Theme.of(context).textTheme.headline1,),
                        ),

                        DataColumn(
                          label: Text(S.of(context).commission_amount,style: Theme.of(context).textTheme.headline1,),
                        ),
                        DataColumn(
                          label: Text(S.of(context).tax,style: Theme.of(context).textTheme.headline1,),
                        ),
                        DataColumn(
                          label: Text(S.of(context).total_amount,style: Theme.of(context).textTheme.headline1,),
                        ),
                        DataColumn(
                          label: Text(S.of(context).payment_status,style: Theme.of(context).textTheme.headline1,),
                        ),
                        DataColumn(
                          label: Text(S.of(context).commission_status,style: Theme.of(context).textTheme.headline1,),
                        ),
                        DataColumn(
                          label: Text(S.of(context).option,style: Theme.of(context).textTheme.headline1,),
                        ),

                      ],
                      header:  Text('Payment Details'),
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
}

class PaymentDetailsPopup {
  static exit(context, providerBooking) => showDialog(
      context: context,
      builder: (context) => HPaymentDetailsWidget(
        providerBooking: providerBooking,
      ));
}

class UserDataTableSource extends DataTableSource {
  UserDataTableSource({

    BuildContext context,

    HServiceController con,

    //this.onRowSelect,
  })  :
        context=context,

        _con=con;


  final context;
  HServiceController _con;


  //final OnRowSelect onRowSelect;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);


    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text((index + 1).toString())),
        DataCell(Text(_con.bookingDetailsList[index].bookId ?? '',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(_con.bookingDetailsList[index].userName ?? '',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(_con.bookingDetailsList[index].providerName ?? '',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(Helper.pricePrint(_con.bookingDetailsList[index].settlementValue )?? '',style: Theme.of(context).textTheme.subtitle2,)),

        DataCell(Text(Helper.pricePrint(_con.bookingDetailsList[index].commissionAmount) ?? '',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(Helper.pricePrint(_con.bookingDetailsList[index].taxAmount )?? '',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(Helper.pricePrint(_con.bookingDetailsList[index].totalAmount) ?? '',style: Theme.of(context).textTheme.subtitle2,)),


        DataCell(
          Container(
              width: 75,
              height: 25,
              child:
              // ignore: deprecated_member_use
              FlatButton(onPressed: (){},
                  color: (_con.bookingDetailsList[index].status=='accepted')?Colors.green:Colors.red,
                  shape: StadiumBorder(),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      _con.bookingDetailsList[index].status??'',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption.merge(
                          TextStyle(
                              color: Theme.of(context)
                                  .primaryColorLight)),
                    ),
                  )
              )
          ),
        ),
        DataCell(
          Container(
              width: 75,
              height: 25,
              child:
              // ignore: deprecated_member_use
              FlatButton(onPressed: (){},
                  color: (_con.bookingDetailsList[index].commissionStatus=='due')?Colors.red:Colors.green,
                  shape: StadiumBorder(),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      _con.bookingDetailsList[index].commissionStatus??'',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption.merge(
                          TextStyle(
                              color: Theme.of(context)
                                  .primaryColorLight)),
                    ),
                  )
              )
          ),
        ),
        DataCell(
          Container(
              width: 75,
              height: 25,
              child:
              // ignore: deprecated_member_use
              FlatButton(onPressed: (){
                PaymentDetailsPopup.exit(
                    context, _con.bookingDetailsList.elementAt(index));
              },
                  color: Colors.blue,
                  shape: StadiumBorder(),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      S.of(context).view_detail,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption.merge(
                          TextStyle(
                              color: Theme.of(context)
                                  .primaryColorLight)),
                    ),
                  )
              )
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _con.bookingDetailsList.length;

  @override
  int get selectedRowCount => 0;



}