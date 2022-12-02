import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/models/vendor.dart';
import 'package:multisuperstore/src/pages/Widget/custom_divider_view.dart';
import 'package:multisuperstore/src/pages/grocerystore.dart';
import 'package:multisuperstore/src/pages/store_detail.dart';
import 'package:multisuperstore/src/repository/vendor_repository.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'CardsCarouselLoaderWidget.dart';
import 'NoShopFoundWidget.dart';

class ShopTopSlider extends StatefulWidget {
  final List<Vendor> vendorList;
  ShopTopSlider({ Key key, this.vendorList}) : super(key: key);
  @override
  _ShopTopSliderState createState() => _ShopTopSliderState();
}

class _ShopTopSliderState extends State<ShopTopSlider> {
// ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 240,
      padding: EdgeInsets.only(top:0),
      child:    widget.vendorList.isEmpty?CardsCarouselLoaderWidget():ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.vendorList.length,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.only(left:3,right:3),
          itemBuilder: (context, index) {
            Vendor _vendorData = widget.vendorList.elementAt(index);

            return _vendorData.shopId!='no_data'?Container(
                child: AspectRatio(
                  aspectRatio: 1.3,

                  child:  Container(
                    padding:EdgeInsets.only(bottom:0),
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.only(left:5,right:5, top: 10.0,),
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
                                  child: Material(
                                    color: Colors.transparent,

                                    child: InkWell(

                                        splashColor:Colors.grey[100].withOpacity(0.3),
                                        onTap: () {
                                          currentVendor.value = _vendorData;

                                          if(_vendorData.shopType=='1' || _vendorData.shopType=='3'){

                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  GroceryStoreWidget(shopDetails: _vendorData,shopTypeID: int.parse(_vendorData.shopType),focusId: int.parse(_vendorData.focusType),)));
                                          }else  {

                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  StoreViewDetails(shopDetails: _vendorData, shopTypeID: int.parse(_vendorData.shopType), focusId: int.parse(_vendorData.focusType),)));

                                          }
                                        },
                                        child:

                                        Ink.image(
                                            image:_vendorData.cover =='no_image' && _vendorData.shopType=='3'?AssetImage('assets/img/pharmacydefaultbg.jpg'):_vendorData.cover =='no_image' && _vendorData.shopType=='1'?AssetImage('assets/img/grocerydefaultbg.jpg',):_vendorData.cover =='no_image' && _vendorData.shopType=='2'?AssetImage('assets/img/resturentdefaultbg.jpg',):NetworkImage(_vendorData.cover),
                                            width:double.infinity,
                                            height:220,
                                            fit:BoxFit.fill
                                        )
                                    ),)),
                              ClipRRect(
                                //borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft:Radius.circular(10),
                                  bottomRight:Radius.circular(10),
                                ),
                                child:!Helper.shopOpenStatus(_vendorData)?Container(
                                color: Colors.black.withOpacity(0.7),
                                width: double.infinity,
                                height:220,
                              ):Container(),),
                          !Helper.shopOpenStatus(_vendorData)?Positioned(
                                  top:0,left:0,right:0,
                                  child:Stack(
                                      children:[
                                        Container(
                                          padding: EdgeInsets.only(top:5,bottom:5),
                                          height: 28,
                                          width:size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft:Radius.circular(0),
                                              bottomRight:Radius.circular(0),
                                            ),
                                          ),
                                          child:Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                child:Text('${S.of(context).opens_at} ${_vendorData.openingTime} to ${_vendorData.closingTime}',
                                                style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).colorScheme.primary)),
                                                )
                                              )
                                            ],
                                          )
                                        ),


                                      ]
                                  )
                              ):Container(),
                              Positioned(
                                  top:40,left:-10,
                                  child:Stack(
                                      children:[


                                        _vendorData.bestSeller?Shimmer(
                                            duration: Duration(seconds: 3),
                                            interval: Duration(seconds: 0),
                                            color: Colors.white,
                                            colorOpacity: 0.5,
                                            enabled: true,
                                            direction: ShimmerDirection.fromLTRB(),
                                            child:Container(
                                                width:130,
                                                decoration: BoxDecoration(
                                                    image:DecorationImage(
                                                        image: AssetImage('assets/img/yellow ribbion.png'),
                                                        fit: BoxFit.fitWidth
                                                    )
                                                ),
                                                child:Center(
                                                    child: Container(
                                                        padding: EdgeInsets.only(left:10,top:0.5),
                                                        child:Text(S.of(context).best_seller,
                                                            style:TextStyle(fontWeight: FontWeight.w800,color:Theme.of(context).colorScheme.background)
                                                        )
                                                    )

                                                )


                                            )
                                        ):Container(),


                                      ]
                                  )
                              ),

                              Positioned(
                                  bottom: 10,right:10,left:10,
                                  child:  ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      child: new BackdropFilter(
                                          filter: new ImageFilter.blur(sigmaX: 13.0, sigmaY: 13.0),
                                          child: Container(
                                              color: Colors.black26,
                                              child: Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    highlightColor: Colors.transparent,

                                                    borderRadius: BorderRadius.all(Radius.circular(10)
                                                    ),
                                                    onTap: (){
                                                      if(_vendorData.shopType=='1' || _vendorData.shopType=='3'){

                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  GroceryStoreWidget(shopDetails: _vendorData,shopTypeID: int.parse(_vendorData.shopType),focusId: int.parse(_vendorData.focusType),)));
                                                      }else  {

                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  StoreViewDetails(shopDetails: _vendorData, shopTypeID: int.parse(_vendorData.shopType), focusId: int.parse(_vendorData.focusType),)));

                                                      }
                                                    },
                                                    child:Container(
                                                        width:size.width,
                                                        margin: EdgeInsets.only(left:10,right:10),
                                                        padding: EdgeInsets.only(left:5,right:5,top:10,bottom:10),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(7),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey.withOpacity(0.2),
                                                              spreadRadius: 1,
                                                              blurRadius: 7,
                                                              offset: Offset(0, 3), // changes position of shadow
                                                            ),
                                                          ],

                                                        ),
                                                        child:Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(_vendorData.shopName,
                                                              style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).colorScheme.primary.withOpacity(0.9))),
                                                            ),
                                                            Text(_vendorData.subtitle,maxLines: 1,softWrap: true,
                                                              style: Theme.of(context).textTheme.caption.merge(TextStyle(color:Theme.of(context).colorScheme.primary.withOpacity(0.9))),
                                                            ),
                                                            Text(_vendorData.locationMark,maxLines: 1,softWrap: true,
                                                              style: Theme.of(context).textTheme.caption.merge(TextStyle(color:Theme.of(context).colorScheme.primary.withOpacity(0.9))),
                                                            ),
                                                            SizedBox(height: 10,),
                                                            CustomDividerView(dividerHeight: 1,),
                                                            SizedBox(height: 10,),
                                                            Wrap(
                                                              children: [
                                                                Container(
                                                                  padding: EdgeInsets.only(top:3),
                                                                  child:Div(
                                                                      colS:7,
                                                                      colM:7,
                                                                      colL:7,
                                                                      child:Wrap(
                                                                        children: [
                                                                          Icon(Icons.star,
                                                                            size: 18,
                                                                            color: Colors.orange,
                                                                          ),
                                                                          Container(
                                                                              padding: EdgeInsets.only(top:2,left:5),
                                                                              child: Text(_vendorData.ratingTotal,style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Theme.of(context).colorScheme.primary.withOpacity(0.9))))
                                                                          ),
                                                                          Container(
                                                                              padding: EdgeInsets.only(top:1,left:10),
                                                                              child: Text('${Helper.priceDistance(_vendorData.distance)}',style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Theme.of(context).colorScheme.primary.withOpacity(0.9))),)
                                                                          ),
                                                                        ],
                                                                      )
                                                                  ),
                                                                ),

                                                                Div(
                                                                    colS:4,
                                                                    colM:4,
                                                                    colL:4,
                                                                    child:Wrap(
                                                                      alignment: WrapAlignment.end,
                                                                      children: [

                                                                        Container(
                                                                            padding: EdgeInsets.only(left:5),
                                                                            child: Text(Helper.calculateTime(double.parse(_vendorData.distance.replaceAll(',','')),int.parse(_vendorData.handoverTime),false),style: Theme.of(context).textTheme.headline1.merge(TextStyle(color:Theme.of(context).colorScheme.primary.withOpacity(0.9))))
                                                                        ),
                                                                      ],
                                                                    )
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                    ),
                                                  )
                                              )
                                          )
                                      )
                                  )

                              )
                            ],
                          ),


                        ]
                    ),
                  ),


                )

            ):NoShopFoundWidget();
          }),
    );

  }
}
