
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/product_controller.dart';
import 'package:login_and_signup_web/src/models/product_details2.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class AvailableTimePopup extends StatefulWidget{
  ProductController con;
  ProductDetails2 details;

  AvailableTimePopup({Key key,this.con,this.details});
  @override
  _AvailableTimePopupState createState() => _AvailableTimePopupState();
}

class _AvailableTimePopupState extends StateMVC<AvailableTimePopup> {

  TextEditingController timeinput = TextEditingController();
  TextEditingController closetime = TextEditingController();

  @override
  void initState() {
    super.initState();
    timeinput.text = widget.details.fromTime??'';
    closetime.text = widget.details.toTime??'';
    widget.con.productDetails2.fromTime=widget.details.fromTime??'';
    widget.con.productDetails2.toTime=widget.details.toTime??'';
    widget.con.productDetails2.product_name=widget.details.product_name??'';

  }
  _selectTime(type) async {
    TimeOfDay selectedTime = TimeOfDay(hour: int.parse(DateFormat('kk').format(DateTime.now())), minute: int.parse(DateFormat('mm').format(DateTime.now())));
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Theme.of(context).colorScheme.secondary,
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), colorScheme: ColorScheme.light(primary: Theme.of(context).colorScheme.secondary).copyWith(secondary: Theme.of(context).colorScheme.secondary),
            ),
            child: child,
          );
        });
    if (picked != null)
      setState(() {
        selectedTime = picked;


        if(type=='open') {
          widget.con.productDetails2.fromTime = picked.format(context);
          timeinput.text = picked.format(context);
        }else{
          widget.con.productDetails2.toTime = picked.format(context);
          closetime.text = picked.format(context);
        }

/*
        _setTime = timePicker.formatDate(
            DateTime(year, month, day, selectedTime.hour, selectedTime.minute), [timePicker.hh, ':', timePicker.nn, " ", timePicker.am]).toString();
        */
      });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.center,
        child:Div(
          colS:12,
          colM:8,
          colL:6,


          child:Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
            ),

            elevation: 0,
            backgroundColor: Colors.transparent,

            insetPadding: EdgeInsets.only(top:size.height * 0.18,
              left:size.width * 0.09,
              right:size.width * 0.09,
              bottom:size.height * 0.14,
            ),
            child:Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color:Theme.of(context).primaryColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(12))
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child:Container(
                        child:Scrollbar(
                          isAlwaysShown: true,
                          child: SingleChildScrollView(
                            child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children:[
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                        )

                                      ]
                                  ),


                                  SizedBox(height:10),

                                  Text(widget.details.product_name,
                                      style: Theme.of(context).textTheme.headline4
                                  ),
                                  SizedBox(height:20),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25, left:25),


                                    child: Container(
                                        width: double.infinity,

                                        child: TextFormField(
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            initialValue: widget.details.product_name??' ',
                                            onChanged: (input) =>  widget.con.productDetails2.product_name = input,
                                            validator: (input) => input.length < 1 ? S.of(context).please_enter_your_category : null,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              labelText: S.of(context).title,
                                              labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                ),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  Theme.of(context).colorScheme.secondary,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ))),
                                  ),

                                  SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.only(right: 25, left:25),
                                    child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[
                                          Text('Available Time',
                                              style: Theme.of(context).textTheme.headline4
                                          ),
                                          Container(
                                            padding:EdgeInsets.only(top:30),
                                            child:Text('Frome Time'),
                                          ),

                                          Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                              controller: timeinput,
                                              validator: (input) => input.length < 1 ? 'please enter the Opening time' : null,
                                              decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.timer),
                                                  suffixIcon: Tooltip(message: "Provide the details of your item  open time (HH : MM AM or PM )", child: Icon(Icons.help, color: Colors.grey)),
                                                  //icon of text field
                                                  labelText: 'Enter Time' //label text of field
                                              ),
                                              readOnly:
                                              true,
                                              //set it true, so that user will not able to edit text
                                              onTap:
                                                  () async {
                                                _selectTime('open');
                                              },
                                            ),
                                          ),
                                          Container(
                                            padding:EdgeInsets.only(top:20),
                                            child:Text('To Time'),
                                          ),
                                          SizedBox(height:10),
                                          Container(
                                            width: double.infinity,

                                            child: TextFormField(
                                              controller:
                                              closetime,
                                              //editing controller of this TextField
                                              validator: (input) => input.length < 1 ? 'Please enter the Closing time' : null,
                                              decoration: InputDecoration(
                                                  suffixIcon: Tooltip(message: "Provide the details of your item  close time  (HH : MM AM or PM )", child: Icon(Icons.help, color: Colors.grey)),
                                                  prefixIcon: Icon(Icons.timer),
                                                  //icon of text field
                                                  labelText: 'Enter Time' //label text of field
                                              ),
                                              readOnly: true,
                                              //set it true, so that user will not able to edit text
                                              onTap: () async {
                                                _selectTime('close');
                                              },
                                            ),
                                          ),
                                          SizedBox(height:40),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // ignore: deprecated_member_use
                                              FlatButton(
                                                onPressed: () {
                                                  widget.con.editAvailableTime(widget.details.id);
                                                },
                                                padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                                                color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                                shape: StadiumBorder(),
                                                child: Text(
                                                  'Update',
                                                  style: Theme.of(context).textTheme.headline6.merge(
                                                      TextStyle(
                                                          color: Theme.of(context)
                                                              .primaryColorLight)),
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height:20),
                                        ]
                                    ),

                                  ),

                                ]
                            ),
                          ),),
                      )
                  ),




                ],
              ),
            ),
          ),

        )

    );



  }


}
