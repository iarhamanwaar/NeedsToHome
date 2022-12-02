import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/controllers/order_controller.dart';
import 'package:multisuperstore/src/elements/DriverRatingWidget.dart';
import 'package:multisuperstore/src/elements/EmptyOrdersWidget.dart';
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/models/addon.dart';
import 'package:multisuperstore/src/models/cart_responce.dart';
import 'package:multisuperstore/src/pages/takeaway_map.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../repository/settings_repository.dart';
import 'cancel.dart';
import 'map.dart';

// ignore: must_be_immutable
class OrderDetails extends StatefulWidget {
  String orderId;
  OrderDetails({Key key, this.orderId}) : super(key: key);
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends StateMVC<OrderDetails> {

  OrderController _con;

  _OrderDetailsState() : super(OrderController()) {
    _con = controller;
  }


  void initState() {
    // TODO: implement initState
    super.initState();

  _con.listenForInvoiceDetails(widget.orderId);


  }

  @override
  Widget build(BuildContext context) {
    var greenColor = Colors.green;
    var greyColor =  Colors.grey[200];
    var amberColor = Colors.amber;
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(
              color: Theme.of(context).backgroundColor
          ),
          title:Container(
              width: double.infinity,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(
                          '${S.of(context).order_ID} #${widget.orderId}',
                          style: Theme.of(context).textTheme.caption.merge(TextStyle(color:Theme.of(context).backgroundColor,
                          )),
                          textAlign: TextAlign.left,
                        ),

                      ]),
                    ),

                  ],
                ),
                _con.invoiceDetailsData.status!=null? Text(
                  '${_con.invoiceDetailsData.status} | ${S.of(context).items} ${Helper.pricePrint(_con.invoiceDetailsData.payment.grand_total)}',
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.left,
                ):Text(''),
              ])
          ),
        ),
        body: _con.invoiceDetailsData.productDetails.isEmpty? EmptyOrdersWidget():Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(children: [
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start, children: [
                                ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: 1,
                                    shrinkWrap: true,
                                    primary: false,
                                    padding: EdgeInsets.only(top: 10),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, int index) {
                                      return Column(children: [
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.only(bottom: 20),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:EdgeInsets.only(top:6),
                                                  child: CircleAvatar(
                                                    // ignore: deprecated_member_use
                                                    backgroundImage: NetworkImage("${GlobalConfiguration().getString('base_upload')}/uploads/vendor_image/vendor_${_con.invoiceDetailsData.addressShop.id}.png"),
                                                    maxRadius: 23,

                                                  ),
                                                ),


                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                    Text(_con.invoiceDetailsData.addressShop.username, style: Theme.of(context).textTheme.bodyText1),
                                                    Text(
                                                      _con.invoiceDetailsData.addressShop.addressSelect,
                                                      style: Theme.of(context).textTheme.caption,
                                                      textAlign: TextAlign.left,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                  ]),
                                                ),
                                              ]),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.only(bottom: 20),
                                          decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                  color: Theme.of(context).dividerColor,
                                                  width: 1,
                                                )),
                                          ),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                            Padding(
                                              padding:EdgeInsets.only(top:6),
                                              child:  CircleAvatar(
                                                // ignore: deprecated_member_use
                                                backgroundImage: AssetImage("assets/img/location_mark.png"),
                                                maxRadius: 23,

                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                Text(currentUser.value.name, style: Theme.of(context).textTheme.bodyText1),
                                                Text(
                                                    _con.invoiceDetailsData.addressUser.addressSelect,
                                                  style: Theme.of(context).textTheme.caption,
                                                  textAlign: TextAlign.left,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ]),
                                            ),
                                          ]),
                                        ),
                                      ]);
                                    }),




                                _con.invoiceDetailsData.status=='Delivered'?   Container(
                                    padding: EdgeInsets.only(top:20),
                                    width: double.infinity,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:EdgeInsets.only(top:6),
                                            child: Icon(Icons.check, color: Theme.of(context).colorScheme.secondary),
                                          ),
                                          Expanded(
                                            child:Padding(
                                              padding: EdgeInsets.only(top:3,left:8,right:20),
                                              child: Text(
                                                'Order delivered on  ${timeago.format(DateTime.fromMillisecondsSinceEpoch(int.parse(_con.invoiceDetailsData.deliveryTime)*1000))} by ${_con.invoiceDetailsData.driverName}',
                                                style: Theme.of(context).textTheme.bodyText2,
                                                textAlign: TextAlign.left,
                                              ),
                                            ),

                                          ),


                                        ],
                                      ),

                                    ])
                                ):Container(),





                              ]),
                            ),
                            Container(
                                padding: EdgeInsets.only(top:20),
                                width: double.infinity,
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                     SizedBox(width: 10,),
                                      Expanded(
                                        child:Padding(
                                          padding: EdgeInsets.only(top:3,left:8,right:20),
                                          child: Text(_con.invoiceDetailsData.orderType=='1'?
                                          S.of(context).your_order_type_is_instant_delivery:_con.invoiceDetailsData.orderType=='2'?
                                           'Your Order type is Scheduled Delivery (${_con.invoiceDetailsData.deliverySlot})':'Your Order type is Takeaway',
                                            style: Theme.of(context).textTheme.bodyText2,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),

                                      ),


                                    ],
                                  ),

                                ])
                            ),
                            Container(
                                width:double.infinity,
                                decoration: BoxDecoration(
                                    color:Theme.of(context).dividerColor
                                ),
                                padding: EdgeInsets.all(20),
                                child:Text(S.of(context).bill_details)
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start, children: [

                                ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: _con.invoiceDetailsData.productDetails.length,
                                    shrinkWrap: true,
                                    primary: false,
                                    padding: EdgeInsets.only(top: 10),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, int index) {
                                      CartResponce _orderDetails = _con.invoiceDetailsData.productDetails.elementAt(index);


                                      return Container(
                                        padding: EdgeInsets.only(top:10,bottom:15),
                                        width:double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                color: Theme.of(context).dividerColor,
                                                width: 1,
                                              )),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            _con.invoiceDetailsData.shopTypeId=='2'? Padding(
                                              padding:EdgeInsets.only(top:10),
                                              child:  Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1,
                                                    color: greenColor,
                                                  ),
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: greenColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  width: 6.0,
                                                  height: 6.0,
                                                ),
                                              ),
                                            ):Container(),
                                            Expanded(
                                              child:Padding(
                                                  padding: EdgeInsets.only(top:3,left:10),
                                                  child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children:[
                                                        Text(
                                                          ' ${_orderDetails.product_name} ${_orderDetails.quantity} ${_orderDetails.unit} x ${_orderDetails.qty}',
                                                          style: Theme.of(context).textTheme.bodyText1,
                                                          textAlign: TextAlign.left,
                                                        ),
                                                        Column(

                                                          children: List.generate( _orderDetails.addon.length, (index) {
                                                            AddonModel _adddon = _orderDetails.addon.elementAt(index);
                                                            return Container(
                                                              child:_orderDetails.addon.length!=0?Text('${_adddon.name}  ${Helper.pricePrint(_adddon.price)}',
                                                                style: Theme.of(context).textTheme.bodyText2,
                                                                textAlign: TextAlign.left,
                                                              ):Text('')
                                                            );
                                                          }),
                                                        )
                                                      ]
                                                  )
                                              ),

                                            ),

                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Padding(
                                                  padding: EdgeInsets.only(top:10,),
                                                  child: Text(Helper.pricePrint(_orderDetails.price))
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ]),),
                            Container(
                                padding: EdgeInsets.only(left: 15, right: 15,),
                                width: double.infinity,
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [





                                  Container(
                                    padding: EdgeInsets.only(top:20),
                                    child:Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child:Text(S.of(context).item_total,style: Theme.of(context).textTheme.subtitle2,),
                                            ),
                                            SizedBox(width:10),
                                            Text(Helper.pricePrint(_con.invoiceDetailsData.payment.sub_total),style: Theme.of(context).textTheme.subtitle2,),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        _con.invoiceDetailsData.shopTypeId=='2'?Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child:Text('Packaging charges',style: Theme.of(context).textTheme.caption,),
                                            ),
                                            SizedBox(width:10),
                                            Text(Helper.pricePrint(_con.invoiceDetailsData.payment.packingCharge),style: Theme.of(context).textTheme.caption,),
                                          ],
                                        ):Container(),

                                        SizedBox(height: 5,),
                                        _con.invoiceDetailsData.shopTypeId=='2'?Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child:Text(S.of(context).discount,style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Colors.green)),),
                                            ),
                                            SizedBox(width:10),
                                            Text('-${Helper.pricePrint(_con.invoiceDetailsData.payment.discount)}',style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Colors.green)),),
                                          ],
                                        ):Container(),
                                        SizedBox(height: 5,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child:Text(S.of(context).delivery_partner_fee,style: Theme.of(context).textTheme.subtitle2,),
                                            ),
                                            SizedBox(width:10),
                                            Text(Helper.pricePrint(_con.invoiceDetailsData.payment.delivery_fees),style: Theme.of(context).textTheme.subtitle2,),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child:Text(S.of(context).delivery_partner_tips,style: Theme.of(context).textTheme.subtitle2,),
                                            ),
                                            SizedBox(width:10),
                                            Text(Helper.pricePrint(_con.invoiceDetailsData.payment.delivery_tips),style: Theme.of(context).textTheme.subtitle2,),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child:Text(S.of(context).tax,style: Theme.of(context).textTheme.subtitle2,),
                                            ),
                                            SizedBox(width:10),
                                            Text(Helper.pricePrint(_con.invoiceDetailsData.payment.tax),style: Theme.of(context).textTheme.subtitle2,),
                                          ],
                                        ),
                                        SizedBox(height: 5,),

                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.only(top:10),
                                          decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                  color: Theme.of(context).dividerColor,
                                                  width: 1,
                                                )),
                                          ),
                                        ),
                                        SizedBox(height:10),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child:Text('${S.of(context).to_pay} ${_con.invoiceDetailsData.payment.method}',style: Theme.of(context).textTheme.subtitle2,),
                                            ),
                                            SizedBox(width:10),
                                            Text('${S.of(context).bill_total} ${Helper.pricePrint(_con.invoiceDetailsData.payment.grand_total)}',style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(fontWeight: FontWeight.w600)),),
                                          ],
                                        ),
                                        SizedBox(height:20),
                                        _con.invoiceDetailsData.status=='Delivered'? InkWell(
                                      onTap: (){
                                        if( _con.invoiceDetailsData.rating=='0'){
                                          Navigator.of(context).pushNamed('/ShopRating', arguments: _con.invoiceDetailsData);
                                        }

                                      },
                                       child: Column(
                                         children:[
                                           ListTile(
                                             contentPadding: EdgeInsets.all(0),
                                             leading: Container(
                                               child: CircleAvatar(
                                                 // ignore: deprecated_member_use
                                                 backgroundImage: NetworkImage("${GlobalConfiguration().getString('base_upload')}/uploads/vendor_image/vendor_${_con.invoiceDetailsData.addressShop.id}.png"),
                                                 maxRadius: 23,

                                               ),

                                             ),
                                             title:Container(
                                               child: Column(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   children:[
                                                     Text(_con.invoiceDetailsData.addressShop.username,
                                                       style: Theme.of(context).textTheme.subtitle1,
                                                     ),
                                                     Text( _con.invoiceDetailsData.rating=='0'?S.of(context).give_your_rating:S.of(context).rating,
                                                       style: Theme.of(context).textTheme.caption,
                                                     ),

                                                   ]
                                               ),
                                             ),
                                           ),
                                           

                                           
                                           
                                           RatingBar.builder(
                                             initialRating: double.parse(_con.invoiceDetailsData.rating),
                                             minRating: 1,
                                             ignoreGestures: true,
                                             tapOnlyMode: true,
                                             direction: Axis.horizontal,
                                             allowHalfRating: false,
                                             itemCount: 5,
                                             itemSize: 25,
                                             itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                             itemBuilder: (context, _) => Icon(
                                               Icons.star,
                                               color:amberColor,
                                             ),
                                             onRatingUpdate: (rating) {
                                               print(rating);
                                             },

                                           ),
                                         ]
                                       )

                                    ):Container(),


                                        SizedBox(height:25),
                                    _con.invoiceDetailsData.status=='Delivered'&& _con.invoiceDetailsData.orderType!='3'? InkWell(
                                      onTap: (){
                                        if( _con.invoiceDetailsData.driverRating=='0'){
                                          ratingModel(context,  widget.orderId, _con.invoiceDetailsData.driverName,  _con.invoiceDetailsData.driverId);
                                        }

                                      },
                                      child: Column(
                                          children:[
                                          ListTile(
                                            contentPadding: EdgeInsets.all(0),
                                            leading: Container(
                                              child: CircleAvatar(
                                                // ignore: deprecated_member_use
                                                backgroundImage: AssetImage("assets/img/delivery_boy.png"),
                                                maxRadius: 26,

                                              ),

                                            ),
                                            title:Container(
                                              child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children:[
                                                    Text('im ${_con.invoiceDetailsData.driverName}, your delivery partner',
                                                      style: Theme.of(context).textTheme.subtitle1,
                                                    ),
                                                    Text(_con.invoiceDetailsData.rating=='0'?S.of(context).give_your_rating:S.of(context).rating,
                                                      style: Theme.of(context).textTheme.caption,
                                                    ),

                                                  ]
                                              ),
                                            ),
                                          ),

                                        RatingBar.builder(
                                          initialRating: double.parse(_con.invoiceDetailsData.driverRating),
                                          minRating: 1,
                                          ignoreGestures: true,
                                          tapOnlyMode: true,
                                          direction: Axis.horizontal,
                                          allowHalfRating: false,
                                          itemCount: 5,
                                          itemSize: 25,
                                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: amberColor,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },

                                        ),],)):Container(),

                                      ],
                                    ),
                                  ),

                                ])
                            ),

                           setting.value.scheduleCancellation && (_con.invoiceDetailsData.orderType=='2' || _con.invoiceDetailsData.orderType=='3')?Container(
                                width:double.infinity,
                                decoration: BoxDecoration(
                                    color:Theme.of(context).dividerColor
                                ),child:Container(

                                padding: EdgeInsets.only(top:10,bottom:10,left: 15, right: 15,),

                                child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                      Expanded(
                                        child:Container(
                                            child:Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:[
                                                  Text('cancel your order?',
                                                    style:Theme.of(context).textTheme.subtitle2.merge(TextStyle(fontWeight: FontWeight.w400)),
                                                  ),
                                                  InkWell(
                                                    onTap: (){
                                                      Navigator.of(context).pushNamed('/policy',arguments: 'Return Policy');
                                                    },
                                                    child: Text('Read Policy',
                                                        style:Theme.of(context).textTheme.caption
                                                    ),
                                                  )


                                                ]
                                            )
                                        ),
                                      ),
                                      Align(
                                        child:Container(
                                          child: Container(
                                              height: 35,
                                              width:130,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(22),
                                              ),
                                              child:Material(  //Wrap with Material
                                                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
                                                //elevation:_category.selected?3:1,
                                                color: Helper.checkCancellationStatus(_con.invoiceDetailsData.orderDate,int.parse(_con.invoiceDetailsData.orderType=='2'?setting.value.scheduleCancellationTimeLimit:setting.value.takeawayCancellationTimeLimit)) && _con.invoiceDetailsData.status!='cancelled'?Theme.of(context).primaryColorDark:Theme.of(context).primaryColorDark.withOpacity(0.5),
                                                clipBehavior: Clip.antiAlias, // Add This
                                                child: MaterialButton(
                                                  child: Center(
                                                    child:Container(

                                                        child:Text('Cancel',
                                                            textAlign: TextAlign.center,
                                                            style:Theme.of(context).textTheme.caption.merge(TextStyle(height:1.2,color: Theme.of(context).primaryColorLight))
                                                        )
                                                    ),

                                                  ),
                                                  onPressed: () {
                                                   if(Helper.checkCancellationStatus(_con.invoiceDetailsData.orderDate,int.parse( setting.value.scheduleCancellationTimeLimit)) && _con.invoiceDetailsData.status!='cancelled') {
                                                     FirebaseFirestore.instance
                                                         .collection(
                                                         'orderDetails')
                                                         .doc(widget.orderId)
                                                         .update({
                                                       'status': 'cancelled'
                                                     }).catchError((e) {
                                                       print(e);
                                                     });
                                                     Navigator.of(context).push(
                                                         MaterialPageRoute(
                                                             builder: (
                                                                 context) =>
                                                                 CancelPage(
                                                                   paymentData: _con
                                                                       .invoiceDetailsData
                                                                       .payment,
                                                                   shopName: _con
                                                                       .invoiceDetailsData
                                                                       .addressShop
                                                                       .username,
                                                                   orderId: widget
                                                                       .orderId,
                                                                   shopId: _con
                                                                       .invoiceDetailsData
                                                                       .addressShop
                                                                       .id,)));
                                                   }
                                                    },
                                                ),)
                                          ),


                                        )
                                      )
                                    ]
                                )
                            ),):Container(),
                            SizedBox(height:40),
                          ]),
                        ]),
                  ),
                ),

              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left:0),
                  child: _con.invoiceDetailsData.status!='Delivered'?Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width:1,color:greyColor,
                          ),
                        )
                    ),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                        onPressed: () {
                          if(_con.invoiceDetailsData.status!='cancelled' &&  _con.invoiceDetailsData.status!='Delivered') {

                            if(_con.invoiceDetailsData.orderType!='3') {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      MapWidget(orderId: widget.orderId,
                                        pageType: 'viewDetails',)));
                            } else{
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      TakeawayWidget(orderId: widget.orderId,
                                       )));
                            }
                            }
                        },
                        padding: EdgeInsets.all(15),
                        color: greyColor,
                        child: Text(
                          _con.invoiceDetailsData.status??'',
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .merge(TextStyle(color: Colors.deepOrange)),
                        )),
                  ): _con.invoiceDetailsData.status=='Delivered' ?
                      Container(
                        width:double.infinity,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Container(
                              child:Image.asset('assets/img/complete.png',
                              height: 60,width:60,
                              ),
                            ),

                            Text(
                              _con.invoiceDetailsData.status,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3

                            )

                          ]
                        )
                      )
                  /*FlatButton(
                      onPressed: () {

                      },
                      padding: EdgeInsets.all(15),
                      color: Colors.grey[200],
                      child: Text(
                        _con.invoiceDetailsData.status,
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .merge(TextStyle(color: Colors.deepOrange)),
                      ))*/
                      :Container()
                ),
              ),
            ],
          ),
        )
    );




  }
  void ratingModel(context, orderID,driverName, driverId) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return DriverRatingWidget(orderId: orderID,driverName: driverName,driverId: driverId,);
        });
  }
}















