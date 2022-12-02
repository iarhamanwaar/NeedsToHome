import 'package:flutter/material.dart';
import 'package:multisuperstore/src/elements/AddCartSliderWidget.dart';
import 'package:multisuperstore/src/elements/NoShopFoundWidget.dart';
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/models/searchisresult.dart';
import 'package:multisuperstore/src/pages/store_detail.dart';
import 'package:multisuperstore/src/repository/vendor_repository.dart';

import '../elements/AddRestaurantSliderWidget.dart';
import 'grocerystore.dart';


class SearchItem extends StatefulWidget {
  final List<ItemDetails> itemDetails;
  const SearchItem({Key key, this.itemDetails}) : super(key: key);

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {

  @override
  void initState() {


    // TODO: implement initState
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return widget.itemDetails.isNotEmpty?SingleChildScrollView(child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: widget.itemDetails.length,
            scrollDirection: Axis.vertical,
            primary: false,
            itemBuilder: (context, index) {
              ItemDetails _itemData = widget.itemDetails.elementAt(index);

              return _itemData.vendor.shopId==null?NoShopFoundWidget():Column(
                  children:[
                    Container(
                        padding: EdgeInsets.only(left:20,right:20),
                        child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              CircleAvatar(
                                // ignore: deprecated_member_use
                                backgroundImage: NetworkImage(_itemData.vendor.logo),
                                maxRadius: 20,

                              ),

                              Expanded(
                                  child:Container(
                                      padding: EdgeInsets.only(left:10,),
                                      child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:[
                                            Container(
                                                child:Text(_itemData.vendor.shopName,
                                                  style:Theme.of(context).textTheme.subtitle1,
                                                )
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(top:5,),
                                                child:Wrap(
                                                    children:[
                                                      Icon(Icons.access_time,size:15),
                                                      SizedBox(width:3),
                                                      Text(Helper.priceDistance(_itemData.vendor.distance),style:Theme.of(context).textTheme.bodyText2.merge(TextStyle(
                                                          color:Theme.of(context).disabledColor.withOpacity(0.8)
                                                      ))),
                                                      SizedBox(width:6),
                                                      Icon(Icons.circle,color:Colors.green,size:15),
                                                      SizedBox(width:3),
                                                      Text(Helper.calculateTime(double.parse(_itemData.vendor.distance.replaceAll(',','')),0,false))
                                                    ]
                                                )
                                            )
                                          ]
                                      )
                                  )
                              ),
                              Align(
                                  child:Container(
                                      padding: EdgeInsets.only(left:10),
                                      child:IconButton(
                                          onPressed: (){
                                            currentVendor.value = _itemData.vendor;
                                            _itemData.vendor.shopType=='2'?
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  StoreViewDetails(shopDetails: _itemData.vendor, shopTypeID: int.parse(_itemData.vendor.shopType), focusId: int.parse(_itemData.vendor.focusType),))):

                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  GroceryStoreWidget(shopDetails: _itemData.vendor,shopTypeID: int.parse(_itemData.vendor.shopType),focusId: int.parse(_itemData.vendor.focusType),)));


                                          },
                                          icon:Icon(Icons.arrow_forward_outlined)
                                      )
                                  )
                              )
                            ]
                        )
                    ),

                    SizedBox(height:5),

                    _itemData.vendor.shopType=='2'?AddRestaurantSliderWidget(itemData: _itemData,homeLock: false,):
                     AddCartSliderWidget(productList: _itemData.productList, shopId: _itemData.vendor.shopId, shopName:_itemData.vendor.shopName ,subtitle: _itemData.vendor.subtitle,km: _itemData.vendor.distance,latitude: _itemData.vendor.latitude,longitude: _itemData.vendor.longitude,focusId: int.parse(_itemData.vendor.focusType),searchType: 'search',
                    itemData: _itemData,homeLock: false,),
                  ]
              );

            }
        ),
      ],
    )):Container();
  }
}
