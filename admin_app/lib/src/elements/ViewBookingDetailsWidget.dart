
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/models/bookingdetails.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
class ViewBookingDetailsWidget extends StatefulWidget {

  const ViewBookingDetailsWidget({Key key,this.bookingDetails}) : super(key: key);
  final List<BookingDetails> bookingDetails;

  @override
  _ViewBookingDetailsWidgetState createState() => _ViewBookingDetailsWidgetState();
}

class _ViewBookingDetailsWidgetState extends State<ViewBookingDetailsWidget> {
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
                              'View Booking Details',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.clear),
                              iconSize: 25
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
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text(widget.bookingDetails[0].bookId??'')],
                      ),
                      SizedBox(height: 10),
                      Divider(
                        height: 20,
                        thickness: 1,
                        indent: 15,
                        endIndent: 15,
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
                                  child: Text(S.of(context).user_name),
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
                                  child: Text(widget.bookingDetails[0].username ?? ''),
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
                                  child: Text(widget.bookingDetails[0].providerName ?? ''),
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
                                  child: Text(S.of(context).phone),
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
                                  child: Text(widget.bookingDetails[0].userMobile ?? ''),
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
                                  child: Text(S.of(context).date),
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
                                  child: Text(widget.bookingDetails[0].date ?? ''),
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
                                  child: Text(S.of(context).status),
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
                                  child: Text(widget.bookingDetails[0].status ?? ''),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
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
                                  child: Text(S.of(context).category_name),
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
                                  child: Text(widget.bookingDetails[0].categoryName ?? ''),
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
                                  child: Text(S.of(context).sub_category_name),
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
                                  child: Text(widget.bookingDetails[0].subcategoryName ?? ''),
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
                                  child: Text('Time'),
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
                                  child: Text(widget.bookingDetails[0].time ?? ''),
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
                                  child: Text(S.of(context).date),
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
                                  child: Text(widget.bookingDetails[0].date ?? ''),
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
                                height: 70,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    border: Border.all(color: Colors.black54)
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(S.of(context).address),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    border: Border.all(color: Colors.black54)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(widget.bookingDetails[0].address ?? ''),
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
                                  child: Text(S.of(context).description),
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
                                  child: Text(widget.bookingDetails[0].description ?? ''),
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
                                  child: Text(S.of(context).provider_name),
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
                                  child: Text(widget.bookingDetails[0].providerName ?? ''),
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
                                  child: Text('Provider Mobile'),
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
                                  child: Text(widget.bookingDetails[0].providerMobile ?? ''),
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
                                  child: Text('Booking Time'),
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
                                  child: Text(widget.bookingDetails[0].bookingTime ?? ''),
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
                                  child: Text('Service'),
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
                                  child: Text(widget.bookingDetails[0].service ?? ''),
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

