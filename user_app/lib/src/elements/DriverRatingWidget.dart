import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/models/driver_rating.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toast/toast.dart';
import '../controllers/order_controller.dart';
import '../repository/order_repository.dart' as repository;
class DriverRatingWidget extends StatefulWidget {
  final String orderId;
  final String driverName;
  final String driverId;
  const DriverRatingWidget({Key key, this.orderId, this.driverName, this.driverId}) : super(key: key);

  @override
  _DriverRatingWidgetState createState() => _DriverRatingWidgetState();
}

class _DriverRatingWidgetState extends StateMVC<DriverRatingWidget> {
  DriverRatingModel driverData =  new DriverRatingModel();
  OverlayEntry loader ;
  OrderController _con;

  _DriverRatingWidgetState() : super(OrderController()) {
    _con = controller;
  }
  @override
  void initState() {
    loader = Helper.overlayLoader(context);
    driverData.rate = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        color: Color(0xff737373),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 40),
                Image(image: AssetImage('assets/img/rating.png'), width: 100, height: 100),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                    right: 12,
                  ),
                  child: Text(
                    S.of(context).give_us_rating,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 21.0,
                    right: 21,
                  ),
                  child: Text('${S.of(context).rate_your_deliver_by} ${widget.driverName}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color: Theme.of(context).disabledColor))),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 17.0,
                    right: 17,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingBar.builder(
                        initialRating: 1,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 30,
                        itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                          driverData.rate = rating;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text('${S.of(context).booking_id}: ${widget.orderId}', style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: 10),
                Text(S.of(context).tell_us_about_the_service),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    right: 30,
                    top: 5,
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                        width: double.infinity,
                        height: 70,
                        child: TextField(
                            textAlign: TextAlign.left,
                            autocorrect: true,
                            onChanged: (e){
                              driverData.message = e;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: S.of(context).comments,
                              hintStyle: Theme.of(context).textTheme.caption,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300],
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                  width: 2.0,
                                ),
                              ),
                            ))),
                  ),
                ),
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: () {
                    driverData.orderId = widget.orderId;
                    driverData.driver = widget.driverId;
                    _con.updateOrderStatus(driverData.orderId, true);
                    submitDriverRating();
                  },
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 100),
                  color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                  shape: StadiumBorder(),
                  child: Text(
                    S.of(context).submit_rating,
                    style: Theme.of(context).textTheme.headline3.merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  submitDriverRating(){
    driverData.buyer = currentUser.value.id;
    Overlay.of(context).insert(loader);
    repository.updateDriverRating(driverData).then((value) {
      showToast("Your rating  is update successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
    }).catchError((e) {
      print(e);

    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }
}
