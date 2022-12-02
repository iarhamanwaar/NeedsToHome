
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/order_list.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:vrouter/vrouter.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
// ignore: must_be_immutable
class OrderBoxWidget extends StatefulWidget {
  OrderList orderDetails;
  String tabTab;
  OrderBoxWidget({Key key, this.orderDetails, this.tabTab}) : super(key: key);
  @override
  _OrderBoxWidgetState createState() => _OrderBoxWidgetState();
}

class _OrderBoxWidgetState extends State<OrderBoxWidget> {
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
                          child: Image(image: widget.tabTab=='Placed'?AssetImage('assets/img/waiting.png'):
                          widget.tabTab=='Accepted'?AssetImage('assets/img/preparing.png'):
                          widget.tabTab=='Packed'?AssetImage('assets/img/ready.png'):
                          widget.tabTab=='Shipped'?AssetImage('assets/img/shipped.png'):
                          widget.tabTab=='Delivered'?AssetImage('assets/img/completed.png'):
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
                                    // ignore: deprecated_member_use
                                    FlatButton(
                                      onPressed: () {
                                        // ignore: deprecated_member_use
                                        VRouter.of(context).pushNamed('invoice', pathParameters: {'id':'1'});
                                      },
                                      shape: Border.all(width: 1.0, color: Colors.blue),
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                        S.of(context).view_detail,
                                        style: Theme.of(context).textTheme.caption.merge(TextStyle(
                                          color: Colors.blue,
                                        )),
                                      ),
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
                              Container(
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
                              ),
                              SizedBox(
                                width: 13.0,
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                   '${ widget.orderDetails.itemName} x ${widget.orderDetails.itemTotal}',
                                  ),
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
                              widget.tabTab=='Placed'?   FlatButton(
                                onPressed: () {},
                                padding: EdgeInsets.all(8),
                                color: Theme.of(context).dividerColor,
                                shape: StadiumBorder(),
                                child: Text(
                                  S.of(context).reject,
                                  style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  )),
                                ),
                              ):Container(),
                              SizedBox(width: 10),
                              // ignore: deprecated_member_use
                              widget.tabTab=='Placed'?FlatButton(
                                onPressed: () {},
                                padding: EdgeInsets.all(8),
                                color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                shape: StadiumBorder(),
                                child: Text(
                                  S.of(context).confirm,
                                  style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.white)),
                                ),
                              ):
                              // ignore: deprecated_member_use
                              widget.tabTab=='Accepted'?FlatButton(
                                onPressed: () {},
                                padding: EdgeInsets.all(8),
                                color: Colors.black87,
                                shape: StadiumBorder(),
                                child: Text(
                                  S.of(context).ready,
                                  style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.white)),
                                ),
                              // ignore: deprecated_member_use
                              ):widget.tabTab=='Packed'?FlatButton(
                                onPressed: () {},
                                padding: EdgeInsets.all(8),
                                color: Colors.green,
                                shape: StadiumBorder(),
                                child: Text(
                                  S.of(context).shipped,
                                  style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.white)),
                                ),
                              ): Container(),
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
}
