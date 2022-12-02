
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/order_controller.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/models/order_list.dart';
import 'package:login_and_signup_web/src/repository/order_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:responsive_ui/responsive_ui.dart';

// ignore: must_be_immutable
class ManualDriverPopup extends StatefulWidget{
  ManualDriverPopup({Key key, this.con, this.orderId, this.orderDetails}) : super(key: key);
  OrderController con;
  String orderId;
  OrderList orderDetails;
  @override
  _ManualDriverPopupState createState() => _ManualDriverPopupState();
}

class _ManualDriverPopupState extends StateMVC<ManualDriverPopup> {

  String _value;
  List<DropDownModel> dropDownList = <DropDownModel>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      listenForDropdown('manual', 1, widget.orderId, widget.orderDetails,  widget.orderDetails.shopId, context);

  }

  @override
  Widget build(BuildContext context) {

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

            insetPadding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.2,
              left:MediaQuery.of(context).size.width * 0.09,
              right:MediaQuery.of(context).size.width * 0.09,
              bottom:MediaQuery.of(context).size.height * 0.2,
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

                                  Text('Assign Your Driver',
                                      style: Theme.of(context).textTheme.headline4
                                  ),
                                  Text('Your Nearest Driver',
                                      style: Theme.of(context).textTheme.subtitle1
                                  ),
                                  Form(

                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 18, left:18),
                                      child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:[


                                            SizedBox(height: 40),

                                            Text(
                                              '#${widget.orderId}',
                                              style: Theme.of(context).textTheme.bodyText1,
                                            ),
                                            SizedBox(height: 15),
                                            Padding(
                                              padding: EdgeInsets.only(top:10),
                                              child:Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Select Your Driver",
                                                    style:  Theme.of(context).textTheme.bodyText1.merge(TextStyle(color:Colors.grey)),
                                                  ),
                                                  DropdownButton(
                                                      value: _value,
                                                      isExpanded: true,
                                                      focusColor: Theme.of(context).colorScheme.secondary,
                                                      style:Theme.of(context).textTheme.subtitle1,
                                                      underline: Container(

                                                        height: 1,
                                                        color: Colors.grey,
                                                      ),
                                                      items: dropDownList.map((DropDownModel map) {
                                                        return new DropdownMenuItem(
                                                          value: map.id,
                                                          child: new Text(map.name, style: new TextStyle(color: Colors.black)),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _value = value;
                                                        });
                                                      }),
                                                ],
                                              ),

                                            ),

                                            SizedBox(height:40),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                // ignore: deprecated_member_use
                                                FlatButton(
                                                  onPressed: () {
                                                    widget.con.manualDriverStatusUpdate(widget.orderId,_value, widget.orderDetails, context);
                                                  },
                                                  padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                                                  color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                                  shape: StadiumBorder(),
                                                  child: Text(
                                                    S.of(context).submit,
                                                    style: Theme.of(context).textTheme.headline6.merge(
                                                        TextStyle(
                                                            color: Theme.of(context)
                                                                .primaryColorLight)),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(height:30),
                                          ]
                                      ),

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




  Future<void> listenForDropdown(type, driverState, orderID, orderDetailsData,vendorId, context) async {
    dropDownList.clear();
    final Stream<DropDownModel> stream = await getDriverData(type, driverState, orderID,vendorId);

    stream.listen((DropDownModel _list) {
      setState(() => dropDownList.add(_list));

    }, onError: (a) {
      print(a);

    }, onDone: () {
      print('load');
      print(dropDownList.length);
    });
  }

}
