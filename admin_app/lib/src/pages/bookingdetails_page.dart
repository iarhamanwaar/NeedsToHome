
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/hservice_controller.dart';
import 'package:login_and_signup_web/src/elements/BookingTrackViewWidget.dart';
import 'package:login_and_signup_web/src/elements/CustomPaginatedTableWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/elements/ViewBookingDetailsWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../helpers/helper.dart';

class BookingDetailsPage extends StatefulWidget {
  const BookingDetailsPage({Key key}) : super(key: key);

  @override
  _BookingDetailsPageState createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends StateMVC<BookingDetailsPage> {
  HServiceController _con;
  int rowsperpage=10;
  _BookingDetailsPageState() : super(HServiceController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForProviderBooking();
    super.initState();
  }
  //_con.bookingDetailsList.length<10? rowsperpage=5:rowsperpage=10;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                      S.of(context).booking_details,
                      style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(width: 10),
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
                      )**/
                  //SizedBox(height: 10),
                  SizedBox(
                    height: 10,
                  ),
                  _con.bookingDetailsList.isEmpty?EmptyOrdersWidget():Container(
                    width: size.width,
                    child: CustomPaginatedTable(
                      actions: <IconButton>[
                        IconButton(
                          splashColor: Colors.transparent,
                          icon: const Icon(Icons.refresh),
                          onPressed: () {
                            _con.listenForProviderBooking();
                            //_provider.fetchData();
                            //_showSBar(context, DataTableConstants.refresh);
                          },
                        ),
                      ],
                      dataColumns: [
                        DataColumn(
                          label: Text('No',style: Theme.of(context).textTheme.headline1,),
                        ),
                        DataColumn(
                          label: Text(S.of(context).book_id,style: Theme.of(context).textTheme.headline1,),
                        ),
                        DataColumn(
                          label: Text(S.of(context).type,style: Theme.of(context).textTheme.headline1,),
                        ),
                        DataColumn(
                          label: Text(S.of(context).amount,style: Theme.of(context).textTheme.headline1,),
                        ),
                        DataColumn(
                          label: Text(S.of(context).user_name,style: Theme.of(context).textTheme.headline1,),
                        ),
                        DataColumn(
                          label: Text(S.of(context).provider_name,style: Theme.of(context).textTheme.headline1,),
                        ),
                        DataColumn(
                          label: Text(S.of(context).phone,style: Theme.of(context).textTheme.headline1,),
                        ),
                        DataColumn(
                          label: Text(S.of(context).date,style: Theme.of(context).textTheme.headline1,),
                        ),
                        DataColumn(
                          label: Text(S.of(context).status,style: Theme.of(context).textTheme.headline1,),
                        ),
                        DataColumn(
                          label: Text(S.of(context).option,style: Theme.of(context).textTheme.headline1,),
                        ),

                      ],
                      header:  Text('Booking Details'),
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

class ViewTrackPopup {
  static exit(context, trackViewList, orderId) => showDialog(
      context: context,
      builder: (context) => BookingTrackViewWidget(
        bookingStatus: trackViewList,
        orderId: orderId,
      ));
}

class ViewBookingDetailsPopup {
  static exit(context, bookingDetails) => showDialog(
      context: context,
      builder: (context) => ViewBookingDetailsWidget(
        bookingDetails: bookingDetails,
      ));
}
class UserDataTableSource extends DataTableSource {
  UserDataTableSource({
    BuildContext context,

    HServiceController con,

    //this.onRowSelect,
  })  :context=context,
        _con=con;


  final context;
  HServiceController _con;
  String _typeStatus = '1';

  //final OnRowSelect onRowSelect;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text((index + 1).toString())),
        DataCell(Text(_con.bookingDetailsList[index].bookId ?? '',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(_con.bookingDetailsList[index].type ?? '',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(Helper.pricePrint(_con.bookingDetailsList[index].totalAmount) ?? '',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(_con.bookingDetailsList[index].userName ?? '',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(_con.bookingDetailsList[index].providerName ?? '',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(_con.bookingDetailsList[index].phone ?? '',style: Theme.of(context).textTheme.subtitle2,)),
        DataCell(Text(_con.bookingDetailsList[index].date ?? '',style: Theme.of(context).textTheme.subtitle2,)),

        DataCell(
          Container(
              width: 75,
              height: 25,
              child:
              // ignore: deprecated_member_use
              FlatButton(onPressed: (){},
                  color: Colors.green,
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
        DataCell(Row(
          children: [
            _con.bookingDetailsList[index].type=='Fixed'?IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => statusUpdateData(),
                  );
                },
                icon: Icon(Icons.strikethrough_s_sharp,color: Colors.red,)):Container(),
            Container(
                width: 75,
                height: 25,
                child:
                // ignore: deprecated_member_use
                FlatButton(onPressed: ()
                {
                  ViewTrackPopup.exit(
                      context, _con.bookingDetailsList[index].bookingStatusManage, _con.bookingDetailsList[index].bookId);
                },
                    color: Colors.blue,
                    shape: StadiumBorder(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Track',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption.merge(
                            TextStyle(
                                color: Theme.of(context)
                                    .primaryColorLight)),
                      ),
                    )
                )
            ),
            SizedBox(
              width: 10,
            ),
            Container(
                width: 75,
                height: 25,
                child:
                // ignore: deprecated_member_use
                FlatButton(onPressed: (){ViewBookingDetailsPopup.exit(context, _con.bookingDetailsList[index].bookingDetails);},
                    color: Colors.teal,
                    shape: StadiumBorder(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        S.of(context).profile,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption.merge(
                            TextStyle(
                                color: Theme.of(context)
                                    .primaryColorLight)),
                      ),
                    )
                )
            ),



          ],
        )),
      ],
    );
  }

  statusUpdateData() {
    return AlertDialog(
      title: Text(S.of(context).confirm),
      content: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return Container(
          width: double.infinity,
          child: DropdownButton(
              value: _typeStatus,
              isExpanded: true,
              focusColor: Theme.of(context).colorScheme.secondary,
              underline: Container(
                color: Colors.grey[300],
                height: 1.0,
              ),
              items: [
                DropdownMenuItem(
                  child: Text('Force Deliver'),
                  value: '1',
                ),
                DropdownMenuItem(
                  child: Text('Cancelled'),
                  value: '2',
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _typeStatus = value;

                  //widget.con.orderData.status = value;
                });

                // widget.con.bannerData.type = value;
              }),
        );
      }),
      actions: <Widget>[
        // ignore: deprecated_member_use
        FlatButton(
            onPressed: () {
              // widget.con.editOrderStatus(widget.orderDetails.orderId, widget.tabTab);
            },
            child: Text(S.of(context).update)),
        // ignore: deprecated_member_use
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(S.of(context).cancel),
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
