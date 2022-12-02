// ignore: must_be_immutable

import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/controllers/cart_controller.dart';
import 'package:multisuperstore/src/elements/TermsPopupWidget.dart';
import 'package:multisuperstore/src/models/coupon.dart';
import 'package:multisuperstore/src/repository/order_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/settings_repository.dart';
import 'RectangleLoaderWidget.dart';

// ignore: must_be_immutable
class OfferDetailsPart extends StatefulWidget {
  String pageType;
  List<CouponModel> couponList;
  OfferDetailsPart({Key key, this.pageType, this.couponList}) : super(key: key);
  @override
  _OfferDetailsPartState createState() => _OfferDetailsPartState();
}

class _OfferDetailsPartState extends StateMVC<OfferDetailsPart> {

  CartController _con;

  _OfferDetailsPartState() : super(CartController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return   widget.couponList.isEmpty?RectangleLoaderWidget():Column(children: [

      SizedBox(height: 10),
      Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount:  widget.couponList.length,
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.only(top: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) {

              CouponModel _coupon = widget.couponList.elementAt(index);
                return Container(child:Container(
                    padding:EdgeInsets.only(left:0,right:0,top:10,bottom:10),
                    child:Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/img/couponcurve1.png'),
                                fit: BoxFit.fill
                            ),

                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 15.0,
                                spreadRadius: 1.0,
                              ),
                            ]),
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Container(
                                padding:EdgeInsets.only(top:20,left:20,right:20),
                                child:Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                            children:[
                                              Wrap(
                                                children: [
                                                  Container(
                                                    padding:EdgeInsets.only(top:2),
                                                    child:Icon(Icons.access_time,color:Colors.pink,size:15),
                                                  ),

                                                  SizedBox(width:7),
                                                  Text(_coupon.title,style:Theme.of(context).textTheme.subtitle1)
                                                ],
                                              ),
                                             widget.pageType!='vendor' && _coupon.minimumPurchasedAmount <= currentCheckout.value.sub_total?Container(
                                               child:InkWell(
                                                 onTap: (){

                                                   _con.applyCoupon(_coupon, 'direct');
                                                 },
                                                 child: Text(S.of(context).apply,
                                                 style: Theme.of(context).textTheme.headline1.merge(TextStyle(color:Theme.of(context).primaryColorDark,fontWeight: FontWeight.w800)),
                                                 ),
                                               )
                                             ):widget.pageType!='vendor'?InkWell(
                                               onTap: (){

                                               },
                                               child: Text(S.of(context).apply,
                                                 style: Theme.of(context).textTheme.headline1.merge(TextStyle(color:Colors.grey.withOpacity(0.5),fontWeight: FontWeight.w800)),
                                               ),
                                             ):Container(),

                                            ]
                                          ),

                                          Container(
                                              padding: EdgeInsets.only(top:30),
                                              child:Row(
                                                  children:[
                                                    Container(
                                                      color:Colors.transparent,
                                                      child:Expanded(
                                                      child:Wrap(
                                                        children:[
                                                          _coupon.couponType!='4'?Text('${_coupon.discount.toInt()}',style:TextStyle(fontSize:25)):Text(''),
                                                          SizedBox(width:2),
                                                          _coupon.couponType!='4'?Container(
                                                              padding: EdgeInsets.only(top:15),
                                                              child:  _coupon.discountType=='%'?
                                                              Text('%'):
                                                              Text('${setting.value.defaultCurrency} OFF')
                                                          ):Container(
                                                              padding: EdgeInsets.only(top:15),
                                                              child:
                                                              Text(S.of(context).free_delivery)
                                                          ),
                                                        ]
                                                      )
                                                    ),),


                                                    Container(
                                                      padding: EdgeInsets.only(left:10),
                                                      alignment: Alignment.topLeft,
                                                      child:Stack(
                                                          alignment: Alignment.topLeft,
                                                          clipBehavior: Clip.none, children: [
                                                      Container(
                                                          width: 30,
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(0),
                                                              topRight: Radius.circular(10),
                                                              bottomRight: Radius.circular(10),
                                                            ),
                                                            color: Colors.orange[100],
                                                          ),
                                                          child: Icon(Icons.card_giftcard, size:15,color: Theme.of(context).colorScheme.secondary)),
                                                      Container(
                                                        margin: EdgeInsets.only(left: 25),
                                                        width: 70,
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(10),
                                                            topRight: Radius.circular(0),
                                                            bottomLeft: Radius.circular(10),
                                                          ),
                                                          color: Colors.orange[100],
                                                        ),
                                                        child: Center(
                                                            child: Text(
                                                              _coupon.code,
                                                              style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Theme.of(context).backgroundColor)),
                                                            )),
                                                      ),
                                                    ]),),

                                                  ]
                                              )
                                          )

                                        ],
                                      ),
                                    ),
                                    Container(
                                        width:60,height:60,
                                        child:Image(image:NetworkImage(_coupon.image),
                                          width:60,
                                        )
                                    )
                                  ],
                                ),
                              ),




                              Row(
                                children:[
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left:27,top:10,bottom:20,right:27),
                                      child:Text( _coupon.terms,
                                          overflow: TextOverflow.ellipsis,maxLines: 2,
                                          style:Theme.of(context).textTheme.caption),
                                    ),
                                  ),
                                  Align(
                                    child: Container(
                                      padding:EdgeInsets.only(right:10),
                                      child: IconButton(
                                        onPressed:(){
                                          TermsPopupHelper.exit(context,_coupon.terms);
                                        },

                                        icon:Icon(Icons.remove_red_eye,color:Theme.of(context).disabledColor)
                                      )
                                    ),
                                  )
                                ]
                              )



                            ]
                        )
                    )
                ),);

              }, separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 5);
            },),


          ])),

    ]);
  }
}



class TermsPopupHelper {

  static exit(context,content ) => showDialog(context: context, builder: (context) =>  TermsPopup(content: content,));
}
