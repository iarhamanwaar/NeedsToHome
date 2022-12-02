import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/models/bookingstatusmanage.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:intl/intl.dart';
class BookingTrackViewWidget extends StatefulWidget {
  final List<BookingStatusManage> bookingStatus;
  final String orderId;

  const BookingTrackViewWidget({Key key, this.bookingStatus, this.orderId}) : super(key: key);

  @override
  _BookingTrackViewWidgetState createState() => _BookingTrackViewWidgetState();
}

class _BookingTrackViewWidgetState extends State<BookingTrackViewWidget> {

  @override
  Widget build(BuildContext context) {

    return Container(
        alignment: Alignment.center,

        child: Div(
          colS: 12,
          colM: 8,
          colL: 7,
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
                width: double.infinity,
                height: 400,
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
                            'View Track',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.clear),
                            iconSize: 25,
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
                      children: [Text(widget.orderId)],
                    ),
                    SizedBox(height: 10),
                    Divider(
                      height: 20,
                      thickness: 1,
                      indent: 15,
                      endIndent: 15,
                    ),
                    Wrap(
                      children: List.generate(widget.bookingStatus.length, (index) {

    var time = widget.bookingStatus[index].time!='null'?DateTime.fromMillisecondsSinceEpoch(int.parse(widget.bookingStatus[index].time)):DateTime.now() ;
    final timeFormat = DateFormat('dd/MM/yyyy h:mm a', 'en_US').format(time);


                        return Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      border: Border.all(color: Colors.black54)
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(widget.bookingStatus[index].status ?? ''),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      border: Border.all(color: Colors.black54)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:Text(timeFormat?? ''),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                    ),

                  ],
                )),
          ),
        ));
  }
}
