import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/models/providerbooking.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

import '../helpers/helper.dart';
class HPaymentDetailsWidget extends StatefulWidget {

  const HPaymentDetailsWidget({Key key,this.providerBooking}) : super(key: key);
  final ProviderBooking providerBooking;

  @override
  _HPaymentDetailsWidgetState createState() => _HPaymentDetailsWidgetState();
}

class _HPaymentDetailsWidgetState extends State<HPaymentDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,

        child: Div(
          colS: 12,
          colM: 8,
          colL: 8,
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.1,
              left:MediaQuery.of(context).size.width * 0.09,
              right:MediaQuery.of(context).size.width * 0.09,
              bottom:MediaQuery.of(context).size.height * 0.02,
            ),
            child: SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.only(left: 10,right: 10,bottom: 20,top: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'View Payment Details',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.clear),
                              iconSize: 10,
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 20,
                        thickness: 1,
                        indent: 5,
                        endIndent: 5,
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    border: Border.all(color: Colors.black54)
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('User Name'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    border: Border.all(color: Colors.black54)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(widget.providerBooking.userName ?? ''),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black54)
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Bill Id'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black54)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(widget.providerBooking.bookId ?? ''),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    border: Border.all(color: Colors.black54)
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(S.of(context).date),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    border: Border.all(color: Colors.black54)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(widget.providerBooking.date ?? ''),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black54)
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(S.of(context).provider_name),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black54)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(widget.providerBooking.providerName ?? ''),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    border: Border.all(color: Colors.black54)
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(S.of(context).service_amount),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    border: Border.all(color: Colors.black54)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(Helper.pricePrint(widget.providerBooking.settlementValue) ?? ''),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    border: Border.all(color: Colors.black54)
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(S.of(context).commission_amount),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    border: Border.all(color: Colors.black54)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(Helper.pricePrint(widget.providerBooking.commissionAmount) ?? ''),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    border: Border.all(color: Colors.black54)
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(S.of(context).tax),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    border: Border.all(color: Colors.black54)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(Helper.pricePrint(widget.providerBooking.taxAmount) ?? ''),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black54)
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Total Amount'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color:  Colors.white,
                                    border: Border.all(color: Colors.black54)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(Helper.pricePrint(widget.providerBooking.totalAmount) ?? ''),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black54)
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(S.of(context).status),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black54)
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      color: (widget.providerBooking.status=='accepted')?Colors.green:Colors.red,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(widget.providerBooking.status??''),
                                      ),
                                    )
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black54)
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(S.of(context).commission_status),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black54)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: (widget.providerBooking.commissionStatus=='due')?Colors.red:Colors.green,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(widget.providerBooking.commissionStatus??''),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    border: Border.all(color: Colors.black54)
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(S.of(context).transaction_id),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    border: Border.all(color: Colors.black54)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(widget.providerBooking.transactionId ?? ''),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height:20),
                    ],
                  )),
            ),
          ),
        ));
  }
}

