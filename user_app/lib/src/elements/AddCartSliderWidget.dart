import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/controllers/product_controller.dart';
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/models/product_details2.dart';
import 'package:multisuperstore/src/models/variant.dart';
import 'package:multisuperstore/src/repository/vendor_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/searchisresult.dart';
import 'ClearCartWidget.dart';
import 'Productbox2Widget.dart';
import 'ProductsCarouselLoaderWidget.dart';
// ignore: must_be_immutable
class AddCartSliderWidget extends StatefulWidget {
  List<ProductDetails2> productList;
  final String shopId;
  final String shopName;
  final String subtitle;
  final String km;
  final int shopTypeID;
  final String latitude;
  final String longitude;
  Function callback;
  final int focusId;
  String searchType;
  ItemDetails itemData;
  bool homeLock = false;
  AddCartSliderWidget({Key key, this.productList,this.shopId, this.shopName, this.subtitle, this.km, this.shopTypeID
    ,this.latitude, this.longitude, this.callback, this.focusId, this.searchType, this.itemData, this.homeLock}) : super(key: key);

  bool loader;
  @override
  _AddCartSliderWidgetState createState() => _AddCartSliderWidgetState();
}

class _AddCartSliderWidgetState extends StateMVC<AddCartSliderWidget> {

  ProductController _con;
  _AddCartSliderWidgetState() : super(ProductController()) {
    _con = controller;

  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  widget.productList.isEmpty
        ? ProductsCarouselLoaderWidget()
        :Container(
        height:250,
        child:ListView.builder(
            shrinkWrap: true,
            itemCount: widget.productList.length,
             physics: widget.homeLock?NeverScrollableScrollPhysics():BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            scrollDirection: Axis.horizontal,
            primary: widget.homeLock?false:true,
            itemBuilder: (context, index) {
              ProductDetails2 _productDetails = widget.productList.elementAt(index);
              print('not found${ _productDetails.variant.length}');
              return Stack(
                  children:[


                    Container(
                        padding: EdgeInsets.only(left:10),
                        child: Column(
                            children: List<Widget>.generate(_productDetails.variant.length, (index) {
                              variantModel _variantData = _productDetails.variant.elementAt(index);
                              return Stack(
                                  clipBehavior: Clip.none, children:[
                                _variantData.selected ? Row(
                                    children: [
                                      Container(
                                        height:250,width:200,
                                        child: Padding(
                                            padding: EdgeInsets.only(bottom:0),
                                            child: InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5.0),
                                                      boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.05), blurRadius: 0.5)],
                                                      color: Theme.of(context).primaryColor),
                                                  child:  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Padding(
                                                              padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
                                                              child:FadeInImage.assetNetwork(
                                                                placeholder: 'assets/img/loading_trend.gif',
                                                                image:  _variantData.image,
                                                                height: 120, width: 150, fit: BoxFit.cover,
                                                                imageErrorBuilder: (c, o, s) => Image.asset('assets/img/loading_trend.gif', height: 120, width: 150, fit: BoxFit.cover),
                                                              )


                                                          ),
                                                        ],
                                                      ),

                                                      Container(
                                                          padding: EdgeInsets.only(left: 10, right: 10, top: 4,),
                                                          child: Text(_productDetails.product_name,
                                                            maxLines: 1,
                                                            softWrap: true,
                                                            style: TextStyle(color: Theme.of(context).backgroundColor.withOpacity(0.8)),
                                                          )
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.only(left: 5, right: 10, ),
                                                        child:InkWell(
                                                          onTap: (){
                                                            AvailableQuantityHelper.exit(context,_productDetails.variant, _productDetails.product_name, _variantData.selected).then((receivedLocation) {

                                                              if(receivedLocation!=null) {
                                                                _productDetails.variant.forEach((_l) {
                                                                  setState(() {
                                                                    if (_l.variant_id == receivedLocation) {
                                                                      _l.selected = true;
                                                                    } else {
                                                                      _l.selected = false;
                                                                    }
                                                                  });
                                                                });
                                                              }
                                                            });
                                                          },
                                                          child:Container(
                                                              height:30,
                                                              width:110,
                                                              padding:EdgeInsets.all(5),

                                                              child:Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text('${_variantData.quantity}${_variantData.unit}'),
                                                                  Icon(Icons.arrow_drop_down,size:19,color:Colors.grey)
                                                                ],
                                                              )),
                                                        ),
                                                      ),

                                                      Container(
                                                        padding: EdgeInsets.only(left: 10, right: 10, ),
                                                        child:Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children:[
                                                              Container(
                                                                width:size.width < 320 ? size.width * 0.17 :size.width * 0.20,
                                                                child:Text(  Helper.pricePrint(_variantData.sale_price),
                                                                  overflow: TextOverflow.ellipsis, maxLines: 1,
                                                                  style: Theme.of(context).textTheme.headline1.merge(TextStyle(fontWeight: FontWeight.w700)),
                                                                ),
                                                              ),

                                                          if (widget.searchType=='search'?Helper.shopOpenStatus(widget.itemData.vendor):Helper.shopOpenStatus(currentVendor.value) == true) ...[
                                                              1 ==  _con.checkProductIdCartVariant(_productDetails.id,_variantData.variant_id)
                                                                  ?  InkWell(
                                                                onTap: (){
                                                                  if(widget.searchType=='search'){
                                                                    currentVendor.value = widget.itemData.vendor;
                                                                  }
                                                                  _con.checkShopAdded(_productDetails, 'cart',_variantData, widget.shopId,ClearCartShow, widget.shopName,  widget.subtitle, widget.km, widget.shopTypeID, widget.latitude, widget.longitude, widget.callback, widget.focusId);
                                                                },
                                                                child:Padding(
                                                                  padding: EdgeInsets.only(left: 10,top:5),
                                                                  child:Container(
                                                                      height:31,
                                                                      padding: EdgeInsets.only(left: 5, right: 5,),
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(5.0),
                                                                        color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                                                      ),

                                                                      child:Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [

                                                                          Text(S.of(context).add,
                                                                              style: Theme.of(context).textTheme.subtitle2.
                                                                              merge(TextStyle(color:Theme.of(context).primaryColorLight,fontWeight: FontWeight.w600))
                                                                          ),







                                                                        ],
                                                                      )
                                                                  ),
                                                                ),
                                                              )
                                                                  : InkWell(
                                                                onTap: () {},
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(
                                                                    left:5,

                                                                  ),
                                                                  child: Wrap(
                                                                      alignment: WrapAlignment.spaceBetween,
                                                                      children: [
                                                                        InkWell(
                                                                          onTap: () {
                                                                            setState(() {
                                                                              _con.decrementQtyVariant(
                                                                                  _productDetails.id, _variantData.variant_id
                                                                              );
                                                                            });
                                                                          },

                                                                          child: Icon(Icons.remove_circle,color:Theme.of(context).colorScheme.secondary,size:27),

                                                                        ),
                                                                        SizedBox(
                                                                          width: MediaQuery.of(context).size.width *  0.01,
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsets.only(top: 5),
                                                                          child: Text( _con.showQtyVariant(_productDetails.id, _variantData.variant_id), style: Theme.of(context).textTheme.bodyText1),
                                                                        ),
                                                                        SizedBox(
                                                                          width: MediaQuery.of(context).size.width *  0.01,
                                                                        ),
                                                                        InkWell(
                                                                          onTap: () {
                                                                            setState(() {
                                                                              _con.incrementQtyVariant(_productDetails.id,_variantData.variant_id, _variantData);
                                                                            });
                                                                          },

                                                                          child: Icon(Icons.add_circle,color:Theme.of(context).colorScheme.secondary,size:27),
                                                                        ),
                                                                      ]),
                                                                ),
                                                              ),
                                                            ]
                                                        ]),
                                                      ),
                                                  widget.homeLock?Container(

                                                      padding:EdgeInsets.only(left:10,right:10),


                                                    child:Row(
                                                      children: [
                                                        Icon(Icons.star,size:15),
                                                        SizedBox(width:3),
                                                        Expanded(child:  Text(
                                                            widget.shopName,
                                                            overflow: TextOverflow.ellipsis,maxLines: 1,
                                                            style:Theme.of(context).textTheme.caption
                                                        ), )


                                                      ],
                                                    ) 
                                                  ):Container(),

                                                    ],
                                                  ),

                                                )
                                            )
                                        ),
                                      ),



                                    ]
                                ): Container(),
                                Positioned(
                                  top:0,left:15,
                                  child: _variantData.discount!='' && _variantData.discount!='0' &&   _variantData.selected ?Stack(
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
                                                    style: TextStyle(color:Theme.of(context).colorScheme.primary,fontSize: 10,fontWeight: FontWeight.w700
                                                    ),
                                                  ),
                                                  Text('OFF',
                                                    style: TextStyle(color:Theme.of(context).colorScheme.primary,fontSize: 10,fontWeight: FontWeight.w700
                                                    ),
                                                  )
                                                ]
                                            )
                                        )
                                    ),


                                  ]):Text(''),
                                )
                              ]
                              );
                            }
                            )
                        )

                    )
                  ]
              );

            }
        )
    );
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

                                _con.clearCart();
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
}


