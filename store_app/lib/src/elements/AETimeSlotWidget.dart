
import 'package:flutter/material.dart';

import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:intl/intl.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

// ignore: must_be_immutable
class AETimeSlotWidget extends StatefulWidget {
  AETimeSlotWidget({Key key, this.con}) : super(key: key);
  SecondaryController con;
  @override
  _AETimeSlotWidgetState createState() => _AETimeSlotWidgetState();
}

class _AETimeSlotWidgetState extends StateMVC<AETimeSlotWidget> {
  _selectTime(type) async {
    TimeOfDay selectedTime = TimeOfDay(
        hour: int.parse(DateFormat('kk').format(DateTime.now())),
        minute: int.parse(DateFormat('mm').format(DateTime.now())));
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Theme.of(context).colorScheme.secondary,
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              colorScheme: ColorScheme.light(
                      primary: Theme.of(context).colorScheme.secondary)
                  .copyWith(secondary: Theme.of(context).colorScheme.secondary),
            ),
            child: child,
          );
        });
    if (picked != null)
      setState(() {
        selectedTime = picked;

        if (type == 'open') {
          widget.con.deliveryTimeSlotData.fromTime = picked.format(context);
          widget.con.openTime.text = picked.format(context);
        } else {
          widget.con.deliveryTimeSlotData.toTime = picked.format(context);
          widget.con.deliveryTimeSlotData.timeId =
              int.parse(DateFormat('kk').format(DateTime.now()));

          widget.con.closeTime.text = picked.format(context);
        }

        /**_setTime = timePicker.formatDate(
            DateTime(year, month, day, selectedTime.hour, selectedTime.minute), [timePicker.hh, ':', timePicker.nn, " ", timePicker.am]).toString();
         */
      });
  }

  @override
  Widget build(BuildContext context) {
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
              top: MediaQuery.of(context).size.height * 0.15,
              left: MediaQuery.of(context).size.width * 0.09,
              right: MediaQuery.of(context).size.width * 0.09,
              bottom: MediaQuery.of(context).size.height * 0.15,
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
                          Text(S.of(context).add_delivery_slot,
                              style: Theme.of(context).textTheme.headline4),
                          Form(
                            key: widget.con.formKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 40, left: 40),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,
                                            controller: widget.con.openTime,
                                            validator: (input) =>
                                                input.length < 1
                                                    ? S.of(context).select_your_from_time
                                                    : null,
                                            onTap: () {
                                              _selectTime('open');
                                            },
                                            decoration: InputDecoration(
                                              labelText:
                                                  S.of(context).from_time,
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
                                            ))),
                                    SizedBox(height: 10),
                                    Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            controller: widget.con.closeTime,
                                            validator: (input) =>
                                                input.length < 1
                                                    ?  S.of(context).select_your_to_time
                                                    : null,
                                            onTap: () {
                                              _selectTime('close');
                                            },
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              labelText: S.of(context).to_time,
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
                                            ))),
                                    SizedBox(height: 10),
                                  ]),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  )),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ignore: deprecated_member_use
                          FlatButton(
                            onPressed: () {
                              widget.con.addEddDeliverTimeSlot(context);
                            },
                            padding: EdgeInsets.only(
                                top: 15, bottom: 15, left: 40, right: 40),
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(1),
                            shape: StadiumBorder(),
                            child: Text(
                              S.of(context).save,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .merge(TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
