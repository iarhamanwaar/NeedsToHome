
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/order_controller.dart';
import 'package:login_and_signup_web/src/elements/AssignDriverPopup.dart';
import 'package:login_and_signup_web/src/elements/AutoAssignWidget.dart';
import 'package:login_and_signup_web/src/elements/PrescriptionPopup.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/order_list.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'InvoiceWidget.dart';
import 'DriverDetailViewWidget.dart';
// ignore: must_be_immutable
class OrderBoxSearchWidget extends StatefulWidget {
  OrderList orderDetails;
  //String tabTab;
  OrderController con;
  OrderBoxSearchWidget({Key key, this.orderDetails,this.con}) : super(key: key);
  @override
  _OrderBoxSearchWidgetState createState() => _OrderBoxSearchWidgetState();
}

class _OrderBoxSearchWidgetState extends State<OrderBoxSearchWidget> {
  @override
  void initState() {
    super.initState();
    //widget.con.getSingleValue(widget.orderDetails.orderId);
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child:Div(
        colS: 12,
        colM: 12,
        colL: 6,
        child: Container(
          decoration: BoxDecoration( color:Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
                spreadRadius: 1.0,
              ),
            ],
            borderRadius: BorderRadius.circular(15.0),),
          margin: EdgeInsets.only(left:15,right:15, top: 10.0,bottom:10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none, alignment: Alignment.topLeft,
                  children: [
                    Positioned.fill(
                      left:-15,
                      top:-10,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child:Container(
                          margin:EdgeInsets.only(top:30,left:1),
                          child: Image(image: widget.orderDetails.status=='Placed'?AssetImage('assets/img/waiting.png'):
                          widget.orderDetails.status=='Accepted'?AssetImage('assets/img/preparing.png'):
                          widget.orderDetails.status=='Packed'?AssetImage('assets/img/ready.png'):
                          widget.orderDetails.status=='Shipped'?AssetImage('assets/img/shipped.png'):
                          widget.orderDetails.status=='Delivered'?AssetImage('assets/img/completed.png'):
                          AssetImage('assets/img/cancelled.png'),
                              fit: BoxFit.fitWidth,
                              width:84,height:45),

                        ),),),
                    Container(
                      padding: EdgeInsets.only(left:18, right: 18, bottom: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Wrap(children: [
                                    Padding(
                                      padding: EdgeInsets.only(left:70),
                                      child: Text('ID -${widget.orderDetails.orderId}'),
                                    ),

                                  ])),
                              SizedBox(width: 5),
                              Padding(
                                padding: EdgeInsets.only(top:20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Wrap(
                                        children:[
                                          widget.orderDetails.orderType=='2'?Tooltip(message: widget.orderDetails.deliverSlot,
                                            child:IconButton(

                                              onPressed:(){},
                                              icon:Icon(Icons.timer),

                                            ),
                                          ):Text(''),

                                          // ignore: deprecated_member_use
                                          widget.orderDetails.pImage=='no_image'?  FlatButton(
                                            onPressed: () {
                                              //  VRouter.of(context).pushNamed('invoice', pathParameters: {'id':'1'});
                                        print(widget.orderDetails.orderId);

                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => InvoiceWidget(orderID: widget.orderDetails.orderId,)));
                                            },
                                            shape: Border.all(width: 1.0, color: Colors.blue),
                                            padding: EdgeInsets.all(15),
                                            child: Text(
                                              S.of(context).view_detail,
                                              style: Theme.of(context).textTheme.caption.merge(TextStyle(
                                                color: Colors.blue,
                                              )),
                                            ),
                                            // ignore: deprecated_member_use
                                          ):FlatButton(
                                            onPressed: () {
                                              if( widget.orderDetails.price=='0') {
                                                AddPrescriptionPopupHelper.exit(context, widget.orderDetails, 'amount',widget.con);
                                              }
                                            },
                                            shape: Border.all(width: 1.0, color: Colors.blue),
                                            padding: EdgeInsets.all(15),
                                            child: Text(
                                              'Update Amount',
                                              style: Theme.of(context).textTheme.caption.merge(TextStyle(
                                                color: Colors.blue,
                                              )),
                                            ),
                                          ),
                                        ]
                                    ),

                                    SizedBox(height: 10,),
                                    Container(child: Text(widget.orderDetails.date))
                                  ],
                                ),
                              ),


                            ],
                          ),

                          Row(
                            children: [
                              widget.orderDetails.pImage=='no_image'  ? Container(
                                height: 35,
                                width: 35,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: NetworkImage(widget.orderDetails.itemImage), fit: BoxFit.fill),
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5.0
                                    ),
                                  ],
                                ),
                              ):Container(),
                              SizedBox(
                                width: 13.0,
                              ),
                              Expanded(
                                child: Wrap(
                                  children: [
                                    widget.orderDetails.pImage=='no_image'? Container(
                                      padding:EdgeInsets.only(top:10),
                                      child: Text(
                                        '${ widget.orderDetails.itemName} + ${widget.orderDetails.itemTotal}',
                                      ),
                                    ):Text(''),
                                    widget.orderDetails.pImage!='no_image'? IconButton(
                                        onPressed: (){
                                          AddPrescriptionPopupHelper.exit(context,widget.orderDetails, 'image', widget.con);
                                        },
                                        icon:Icon(Icons.description)
                                    ):Container(),
                                  ],
                                ),

                              ),
                              Text(
                                widget.orderDetails.paymentType,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey[200])))),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(children: [
                            Expanded(
                                child: Container(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text(
                                        Helper.pricePrint(widget.orderDetails.price),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        '${S.of(context).contact}: ${widget.orderDetails.username} - ${widget.orderDetails.contact}',
                                      ),
                                    ]))),
                            SizedBox(width: 10),
                            Wrap(children: [
                              // ignore: deprecated_member_use
                              1==2?   FlatButton(
                                onPressed: () {
                                  widget.con.updateOrderStatus(widget.orderDetails.orderId, 'Cancelled', widget.orderDetails );
                                },
                                padding: EdgeInsets.all(8),
                                color:   Colors.red,
                                shape: StadiumBorder(),
                                child: Text(
                                  S.of(context).reject,
                                  style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  )),
                                ),
                              ):Container(),
                              widget.orderDetails.status=='Cancelled'?
                              InkWell(
                                child: Icon(Icons.announcement_rounded),
                                onTap: (){
                                  setState(() {
                                    //widget.con.getSingleValue(widget.orderDetails.orderId);

                                    //print("terms:${widget.con.terms}");
                                    //dialog(widget.orderDetails.orderId,widget.con.terms);
                                  });
                                },
                              ):Container(),
                              SizedBox(width: 10),
                              // ignore: deprecated_member_use
                              widget.orderDetails.status=='Placed'?FlatButton(
                                onPressed: () {
                                  widget.con.updateOrderStatus(widget.orderDetails.orderId, 'Accepted', widget.orderDetails);
                                },
                                padding: EdgeInsets.all(8),
                                color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                shape: StadiumBorder(),
                                child: Text(
                                  S.of(context).confirm,
                                  style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.white)),
                                ),
                              ):
                              // ignore: deprecated_member_use
                              widget.orderDetails.status=='Accepted'?FlatButton(
                                onPressed: () {
                                  widget.con.updateOrderStatus(widget.orderDetails.orderId, 'Packed', widget.orderDetails);
                                },
                                padding: EdgeInsets.all(8),
                                color: Colors.black87,
                                shape: StadiumBorder(),
                                child: Text(
                                  S.of(context).ready,
                                  style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.white)),
                                ),
                                // ignore: deprecated_member_use
                              ):widget.orderDetails.status=='Packed'?FlatButton(
                                onPressed: () {
                                  // widget.con.updateOrderStatus(widget.orderDetails.orderId, 'Shipped', widget.orderDetails);
                                  if(false!=true && false != true) {
                                    AutoAssignPopupHelper.exit(context, widget.con, widget.orderDetails.orderId, widget.orderDetails);

                                  } else {
                                    AssignDriverPopupHelper.exit(context, widget.con, widget.orderDetails.orderId, widget.orderDetails);
                                  }
                                },
                                padding: EdgeInsets.all(8),
                                color: Colors.green,
                                shape: StadiumBorder(),
                                child: Text(
                                  'Ready to ship',
                                  style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.white)),
                                ),
                                // ignore: deprecated_member_use
                              ):widget.orderDetails.status=='Delivered'?FlatButton(
                                onPressed: () {
                                  widget.con.updateOrderStatus(widget.orderDetails.orderId, 'Delivered', widget.orderDetails);

                                },
                                padding: EdgeInsets.all(8),
                                color: Colors.green,
                                shape: StadiumBorder(),
                                child: Text(
                                  'Deliver',
                                  style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.white)),
                                ),
                              ):  widget.orderDetails.status=='Delivered'?Text(''):widget.orderDetails.status!='Cancelled'?Wrap(
                                  children:[
                                    Icon(Icons.electric_bike),
                                    SizedBox(width:10),
                                    // ignore: deprecated_member_use
                                    FlatButton(
                                      onPressed: () {
                                        // widget.con.updateOrderStatus(widget.orderDetails.orderId, 'Shipped', widget.orderDetails);

                                        DriverDetailsPopupHelper.exit(context, widget.con, widget.orderDetails.orderId);

                                      },
                                      padding: EdgeInsets.all(8),
                                      color: Colors.green,
                                      shape: StadiumBorder(),
                                      child: Text(
                                        'Driver Details',
                                        style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ]
                              ):Container(),
                            ])
                          ]),
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  dialog(id,message){
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  new Row(
                      children:[
                        Text('ID:'),
                        Text(id),
                      ]
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text('Reason:'),
                      Text(message??''),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class AssignDriverPopupHelper {

  static exit(context, con, orderId, details) => showDialog(context: context, builder: (context) =>  ManualDriverPopup(con: con,orderId: orderId,orderDetails: details));
}

class AddPrescriptionPopupHelper {

  static exit(context, orderDetail, popType, con) => showDialog(context: context, builder: (context) =>  PrescriptionPopup(orderDetails: orderDetail,popType: popType,con: con,));
}

class AutoAssignPopupHelper {

  static exit(context, con, orderId, details) => showDialog(context: context, barrierDismissible: false, builder: (context) =>  AutoAssignWidget(con: con,orderId: orderId,orderDetails: details,));
}

class DriverDetailsPopupHelper {

  static exit(context, con, orderId) => showDialog(context: context, barrierDismissible: false, builder: (context) =>  DriverDetailViewWidget(orderId: orderId,));
}