import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/repository/vendor_repository.dart';
import '../models/vendor.dart';
import '../repository/order_repository.dart';
import '../models/product_details2.dart';
import '../models/variant.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/helper.dart';
import '../controllers/product_controller.dart';
import '../elements/ClearCartWidget.dart';
import 'AddonsWidget.dart';


// ignore: must_be_immutable
class RestaurantSearchProductBox extends StatefulWidget {
  RestaurantSearchProductBox({Key key,this.popperShow, this.choice, this.con, this.shopId, this.shopName, this.subtitle, this.km, this.shopTypeID, this.latitude, this.longitude, this.callback, this.focusId, this.shopDetails}) : super(key: key);
  final ProductDetails2 choice;
  final ProductController con;
  Vendor shopDetails;
  final String shopId;
  final String shopName;
  final String subtitle;
  final String km;
  final int shopTypeID;
  final String latitude;
  final String longitude;
  final int focusId;
  bool popperShow;
  Function callback;

  @override
  _RestaurantSearchProductBoxState createState() => _RestaurantSearchProductBoxState();
}

class _RestaurantSearchProductBoxState extends StateMVC<RestaurantSearchProductBox> {



  @override
  void initState() {
    super.initState();

  }


// ignore: non_constant_identifier_names
  void ProductDescriptionBottomSheet(variantModel variant,ProductDetails2 productDetails, ProductController con) {

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.54,
              color: Color(0xff737373),
              child: Container(

                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close),
                              color: Theme.of(context).primaryColorLight,
                            ),
                          ]
                      ),

                      Expanded(
                          child:Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft:  Radius.circular(15)),
                            ),

                            child:SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:Theme.of(context).primaryColor,
                                            ),
                                            margin: EdgeInsets.only( left:15,right:15,top: 10.0,bottom:10),
                                            child:ClipRRect(
                                              //borderRadius: BorderRadius.all(Radius.circular(10)),
                                                borderRadius: BorderRadius.circular(18),
                                                child:Material(
                                                    color: Colors.transparent,
                                                    child:InkWell(
                                                        onTap: () {

                                                        },
                                                        child:Container(
                                                          padding:EdgeInsets.only(bottom:10,),
                                                          child:Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children:[
                                                                Stack(
                                                                  children: [
                                                                    ClipRRect(
                                                                      //borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                        borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(10),
                                                                          topRight: Radius.circular(10),
                                                                          bottomLeft:Radius.circular(10),
                                                                          bottomRight:Radius.circular(10),
                                                                        ),
                                                                        child:Image(image:NetworkImage(variant.image),
                                                                            width:double.infinity,
                                                                            height:247,
                                                                            fit:BoxFit.fill
                                                                        )
                                                                    ),


                                                                  ],
                                                                ),

                                                                Container(
                                                                    margin:EdgeInsets.only(top:10),
                                                                    child:Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children:[
                                                                          Row(
                                                                            children: [
                                                                              Wrap(
                                                                                  children:[
                                                                                    Container(
                                                                                        margin:EdgeInsets.only(top:5),
                                                                                        decoration:BoxDecoration(
                                                                                          color: Colors.white,
                                                                                          border:Border.all(
                                                                                              width: 1,
                                                                                              color: variant.foodType=='Veg'?Colors.green:Colors.brown
                                                                                          ),

                                                                                        ),
                                                                                        child:Icon(Icons.circle,size:14,color:variant.foodType=='Veg'?Colors.green:Colors.brown)
                                                                                    ),
                                                                                    currentVendor.value.bestSeller?Container(
                                                                                        padding: EdgeInsets.only(left:5,top:3),
                                                                                        child:Icon(Icons.star,size:19,color:Colors.orange)
                                                                                    ):Container(),
                                                                                    currentVendor.value.bestSeller?Container(
                                                                                        padding: EdgeInsets.only(left:5,top:5),
                                                                                        child:Text('Best Seller',style: TextStyle(color:Colors.orange),)
                                                                                    ):Container(),

                                                                                  ]
                                                                              ),

                                                                            ],
                                                                          ),

                                                                          Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children:[
                                                                                Expanded(
                                                                                  child: Container(
                                                                                    padding:EdgeInsets.only(top:3),
                                                                                    child:Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children:[
                                                                                          Text(productDetails.product_name,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                              maxLines: 2,
                                                                                              style:Theme.of(context).textTheme.subtitle1
                                                                                          ),
                                                                                          Container(
                                                                                              padding:EdgeInsets.only(right:13),
                                                                                              child:Text(Helper.pricePrint(variant.sale_price),
                                                                                                style: Theme.of(context).textTheme.headline1.merge(TextStyle(fontWeight: FontWeight.w700)),
                                                                                              )
                                                                                          ),
                                                                                        ]
                                                                                    ),
                                                                                  ),
                                                                                ),




                                                                              ]
                                                                          ),


                                                                          Container(
                                                                            padding:EdgeInsets.only(top:3),
                                                                            child:Text(productDetails.description,

                                                                                style:Theme.of(context).textTheme.caption
                                                                            ),
                                                                          ),




                                                                        ]
                                                                    )),
                                                              ]
                                                          ),
                                                        )

                                                    )
                                                )
                                            )
                                        )]),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          )
                      ),


                    ],

                  )
              ),
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
        children:[


          Container(

            padding: EdgeInsets.only(left:10),
            child: Column(


        children: List<Widget>.generate(widget.choice.variant.length, (index) {
          variantModel _variantData = widget.choice.variant.elementAt(index);
          return Stack(
            children: [
              _variantData.selected ? Container(
                height:150,width:size.width * 0.93,
                  child:Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:MainAxisAlignment.start,
                  children: [

                     InkWell(
                        onTap: () {
                          // widget.con.view_product(widget.choice);
                          ProductDescriptionBottomSheet(_variantData,widget.choice, widget.con);
                        },
                        child:ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Helper.itemAvailableStatus(widget.choice)?Colors.black.withOpacity(0):Colors.black.withOpacity(0.91), // 0 = Colored, 1 = Black & White
                            BlendMode.saturation,
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(top: 10, right: 10),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/img/loading_trend.gif',
                                image:  _variantData.image,
                                height: 120, width: 110, fit: BoxFit.cover,
                                imageErrorBuilder: (c, o, s) => Image.asset('assets/img/loading_trend.gif', height: 120, width: 110, fit: BoxFit.cover),
                              )
                          ),),
                      ),


                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 2, right: 5),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:MainAxisAlignment.start,
                                  children: [

                                    Container(
                                      padding: const EdgeInsets.only(top: 6),
                                      height: 35,
                                      child: Text(widget.choice.product_name,
                                          overflow: TextOverflow.fade,
                                          maxLines: 2,
                                          softWrap: true,
                                          style: TextStyle(color: Theme
                                              .of(context)
                                              .backgroundColor
                                              .withOpacity(0.8))),
                                    ),


                                    Wrap(alignment: WrapAlignment.start,
                                        children: [
                                          Container(
                                              margin:EdgeInsets.only(top:5,right:5),
                                              decoration:BoxDecoration(
                                                color: Theme.of(context).primaryColor,
                                                border:Border.all(
                                                    width: 1,
                                                    color: _variantData.foodType=='Veg'?Colors.green:Colors.brown
                                                ),

                                              ),
                                              child:Icon(Icons.circle,size:11,color:_variantData.foodType=='Veg'?Colors.green:Colors.brown)
                                          ),
                                          Text(Helper.pricePrint(_variantData.sale_price), style: Theme
                                              .of(context)
                                              .textTheme
                                              .headline3),
                                          Container(
                                            width: 80,
                                            padding: const EdgeInsets.only(left: 8, top: 4),
                                            child:_variantData.discount!='' && _variantData.discount!='0'? Text(
                                              Helper.pricePrint(_variantData.strike_price),
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  .merge(TextStyle(decoration: TextDecoration.lineThrough)),
                                            ):Container(),
                                          ),

                                        ]),
                                    SizedBox(height: 3),
                                    /**    Text(
                                        '${widget.choice..toString()} % ${S.of(context).offer}',
                                        style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(
                                        color: Theme.of(context).accentColor,
                                        )),
                                        ), */
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(

                                          onTap: () {

                                            if(currentCheckout.value.shopId==widget.shopId || currentCheckout.value.shopId==null) {


                                              variantPop(
                                                  widget.choice,
                                                  widget.choice.product_name,
                                                  widget.con,
                                                  widget.shopName,
                                                  widget.subtitle,
                                                  widget.km,
                                                  widget.shopTypeID,
                                                  widget.latitude, widget.longitude, widget.focusId);
                                            }else{
                                              ClearCartShow();
                                            }



                                            /**  AvailableQuantityHelper.exit(context, widget.choice.variant, widget.choice.product_name, _variantData.selected).then((receivedLocation) {
                                                print('success${receivedLocation}');
                                                if(receivedLocation!=null) {
                                                widget.choice.variant.forEach((_l) {
                                                setState(() {
                                                if (_l.variant_id == receivedLocation) {
                                                _l.selected = true;
                                                } else {
                                                _l.selected = false;
                                                }
                                                });
                                                });
                                                }
                                                }); */

                                          },
                                          child: Container(
                                              height: 30,
                                              width: 100,
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4),
                                                  border: Border.all(
                                                    width: 1, color: Colors.grey[300],
                                                  )
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width:60,
                                                    child:Text('${_variantData.quantity} ${_variantData.unit}',
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),

                                                  Icon(Icons.arrow_drop_down, size: 19, color: Colors.grey)
                                                ],
                                              )

                                          ),
                                        ),
                                        if ( Helper.shopOpenStatus(widget.shopDetails) == true) ...[
                                          if(Helper.itemAvailableStatus(widget.choice))...[
                                            1 == widget.con.checkProductIdCartVariant(widget.choice.id, _variantData.variant_id)
                                                ? InkWell(
                                                onTap: () {
                                                  if(currentCheckout.value.shopId==widget.shopId || currentCheckout.value.shopId==null) {


                                                    variantPop(widget.choice, widget.choice.product_name, widget.con, widget.shopName, widget.subtitle, widget.km,
                                                        widget.shopTypeID, widget.latitude, widget.longitude, widget.focusId);
                                                  }else{
                                                    ClearCartShow();
                                                  }
                                                  //   widget.con.checkShopAdded(widget.choice, 'cart',_variantData, widget.shopId,ClearCartShow);


                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 10,right:10),
                                                  child: Container(
                                                      padding: EdgeInsets.only(left: 10,right:10),
                                                      alignment: Alignment.centerRight,
                                                      height: 30,
                                                      /*width: MediaQuery.of(context).size.width * 0.25,*/
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5.0),
                                                        color: Theme
                                                            .of(context)
                                                            .colorScheme.secondary
                                                            .withOpacity(1),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [

                                                          Text(S.of(context).add,
                                                              style: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .subtitle2
                                                                  .merge(TextStyle(color: Theme
                                                                  .of(context)
                                                                  .primaryColorLight, fontWeight: FontWeight.w600))),
                                                          SizedBox(width: 5),

                                                        ],
                                                      )),
                                                ))
                                                : InkWell(
                                              onTap: () {},
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                ),
                                                child: Wrap(alignment: WrapAlignment.spaceBetween, children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {

                                                        widget.con.decrementQtyVariant(
                                                            widget.choice.id, _variantData.variant_id
                                                        );
                                                      });
                                                    },

                                                    child: Icon(Icons.remove_circle,color:Theme.of(context).colorScheme.secondary,size:27),

                                                  ),
                                                  SizedBox(
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.022,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 5),
                                                    child: Text(widget.con.showQtyVariant(widget.choice.id, _variantData.variant_id), style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodyText1),
                                                  ),
                                                  SizedBox(
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.022,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        widget.con.incrementQtyVariant(widget.choice.id, _variantData.variant_id, _variantData);
                                                      });
                                                    },

                                                    child: Icon(Icons.add_circle,color:Theme.of(context).colorScheme.secondary,size:27),

                                                  ),
                                                ]),
                                              ),
                                            ),
                                          ]else ...[
                                            Wrap(
                                              alignment:WrapAlignment.end,
                                              children: [
                                                Container(
                                                  padding:EdgeInsets.only(right:0),
                                                  child:Column(
                                                      children:[
                                                        Text('Available',style: Theme.of(context).textTheme.caption,textAlign: TextAlign.end,),
                                                        Text('${widget.choice.fromTime} to ${widget.choice.toTime}',style: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 10)),textAlign: TextAlign.end,)
                                                      ]
                                                  ),

                                                ),

                                              ],
                                            )
                                          ]
                                        ]

                                      ] ,
                                    ),
                                    widget.choice.variant.length>1?Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:EdgeInsets.only(right:0),
                                          child:Text(S.of(context).customizable,style: Theme.of(context).textTheme.caption,textAlign: TextAlign.end,),
                                        ),

                                      ],
                                    ):Container(),

                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),

                            ]

                          /*       return _variantData.selected?*/

                        ),
                      ),

                    ),
                  ]
              ) ): Container(),

              _variantData.discount!='' && _variantData.discount!='0'? Positioned(
                  top:0,left:15,
                  child:Stack(
                      clipBehavior: Clip.none, children:[
                    Container(
                        width:30,height:70,
                        child:Image(image:AssetImage('assets/img/toplable.png'))
                    ),
                    Align(
                        alignment: Alignment.center,
                        child:Container(
                            margin: EdgeInsets.only(top:18,left:3),
                            alignment: Alignment.center,
                            child:Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:[
                                  Text('${_variantData.discount}%',
                                    style: TextStyle(color:Theme.of(context).primaryColorLight,fontSize: 10,fontWeight: FontWeight.w700
                                    ),
                                  ),
                                  Text('OFF',
                                    style: TextStyle(color:Theme.of(context).primaryColorLight,fontSize: 10,fontWeight: FontWeight.w700
                                    ),
                                  )
                                ]
                            )
                        )
                    ),


                  ])
              ):Container(),

            ],
          );
        },
        ),


      ),
    )
    ]);

  }

  // ignore: non_constant_identifier_names
  void ClearCartShow() {
    var size = MediaQuery.of(context)
        .size;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: size.height * 0.3,
            color: Color(0xff737373),
            child: Container(

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
                      padding: EdgeInsets.only(left:size.width * 0.05,right:size.width * 0.05),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClearCart(),
                            ]),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left:size.width * 0.05,right:size.width * 0.05,top: 5, bottom: 5),
                      child:Row(
                        children: [
                          Container(
                            width: size.width * 0.44,
                            height: 45.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: Colors.grey[200],
                                    width:1
                                )
                              /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                            ),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Center(
                                  child: Text(
                                    S.of(context).cancel,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(width:size.width * 0.02),
                          Container(
                            width: size.width * 0.44,
                            height: 45.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(30),
                              /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                            ),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: () {

                                widget.con.clearCart();
                              },
                              child: Center(
                                  child: Text(
                                    S.of(context).clear_cart,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),

                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }



  void variantPop(product, title, con, shopName, subtitle, km, shopTypeId,latitude,longitude, focusId) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              color: Color(0xff737373),
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,

                  ),
                  child:Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).dividerColor,
                            shape: BoxShape.rectangle,
                            border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey[200],
                                  width: 1,
                                ))),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                title,
                                style: Theme.of(context).textTheme.headline1,
                                textAlign: TextAlign.left,
                              ),
                            )),
                      ),
                      Expanded(
                          child:Container(
                            child:SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AddonsPart(product: product,con: con,),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          )
                      ),
                      Helper.shopOpenStatus(widget.shopDetails) &&
                          Helper.itemAvailableStatus(widget.choice)? Align(
                        alignment: Alignment.bottomCenter,
                        child:Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                          child: Container(
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: () {

                                setState(() {
                                  // ignore: unnecessary_statements
                                  widget.choice.variant;

                                });

                                currentVendor.value = widget.shopDetails;
                                widget.con.addToCartRestaurant(widget.choice, 'cart',widget.choice.variant, widget.shopId, widget.choice.addon, shopName, subtitle, km, shopTypeId, latitude,longitude,this.callback, widget.focusId);


                              },
                              padding: EdgeInsets.all(15),
                              color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Container(
                                  child: new RichText(
                                    text: new TextSpan(
                                        text:S.of(context).item_total,
                                        style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: Theme.of(context).primaryColorLight)),
                                        children: [
                                          new TextSpan(
                                            text: ' ${Helper.pricePrint(widget.con.calculateAmount())}',
                                            style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: Theme.of(context).primaryColorLight)),
                                          )
                                        ]),
                                  ),
                                ),
                                Container(
                                    child: Text(
                                      S.of(context).add_item,
                                      style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: Theme.of(context).primaryColorLight)),
                                    )),
                              ]),
                            ),
                          ),
                        ),
                      ):Container(),
                    ],

                  )
              ),
            ),
          );
        });
  }


void callback(bool nextPage){

}

}


















