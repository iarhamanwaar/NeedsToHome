
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_and_signup_web/src/controllers/order_controller.dart';
import 'package:login_and_signup_web/src/models/order_list.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:responsive_ui/responsive_ui.dart';

// ignore: must_be_immutable
class PrescriptionPopup extends StatefulWidget {
  OrderList orderDetails;
  String popType;
  OrderController con;
  PrescriptionPopup({Key key, this.orderDetails, this.popType, this.con})
      : super(key: key);
  @override
  _PrescriptionPopupState createState() => _PrescriptionPopupState();
}

class _PrescriptionPopupState extends State<PrescriptionPopup> {
  String amount;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.center,
        child: Div(
          colS: 12,
          colM: 8,
          colL: 6,
          child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.09,
              right: MediaQuery.of(context).size.width * 0.09,
              bottom: MediaQuery.of(context).size.height * 0.09,
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Container(
                    child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ]),
                          SizedBox(height: 10),
                          Text(S.of(context).image,
                              style: Theme.of(context).textTheme.headline4),
                          Form(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 18, left: 18),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20),
                                    Text(
                                      'ID ${widget.orderDetails.orderId}',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    SizedBox(height: 15),
                                    widget.popType == 'image'
                                        ? Container(
                                            width: size.width,
                                            height: size.height > 670
                                                ? size.height
                                                : size.height / 2,
                                            child: GestureDetector(
                                                onTap: () {},
                                                child: Image(
                                                  image: NetworkImage(widget
                                                      .orderDetails.pImage),
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                  fit: BoxFit.fill,
                                                )),
                                          )
                                        : TextField(
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            onChanged: (e) {
                                              setState(() {
                                                amount = e;
                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            decoration: InputDecoration(
                                              labelText:S.of(context).enter_the_total_amount_of_the_image,
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(TextStyle(
                                                      color: Colors.grey)),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  width: 1.0,
                                                ),
                                              ),
                                            )),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [

                                        widget.popType == 'image'
                                        // ignore: deprecated_member_use
                                            ? FlatButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                padding: EdgeInsets.only(
                                                    top: 15,
                                                    bottom: 15,
                                                    left: 40,
                                                    right: 40),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                    .withOpacity(1),
                                                shape: StadiumBorder(),
                                                child: Text(
                                                  S.of(context).close,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .merge(TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColorLight)),
                                                ),
                                                // ignore: deprecated_member_use
                                              )
                                        // ignore: deprecated_member_use
                                            : FlatButton(
                                                onPressed: () {
                                                  widget.con
                                                      .updateOrderAmountStatus(
                                                          widget.orderDetails
                                                              .orderId,
                                                          amount,
                                                          widget.orderDetails, context);
                                                },
                                                padding: EdgeInsets.only(
                                                    top: 15,
                                                    bottom: 15,
                                                    left: 40,
                                                    right: 40),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                    .withOpacity(1),
                                                shape: StadiumBorder(),
                                                child: Text(
                                                  S.of(context).update,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .merge(TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColorLight)),
                                                ),
                                              ),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                  ]),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ));
  }
}
