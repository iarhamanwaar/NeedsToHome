import 'package:flutter/material.dart';
import 'package:multisuperstore/src/models/shop_type.dart';
import 'package:multisuperstore/src/pages/send_package.dart';
import 'package:multisuperstore/src/pages/stores.dart';
import 'package:multisuperstore/src/pages/subcategory.dart';
import 'package:multisuperstore/src/repository/home_repository.dart';
import 'package:multisuperstore/src/repository/hservice_repository.dart';
import 'package:responsive_ui/responsive_ui.dart';



// ignore: must_be_immutable
class CategoryShopType extends StatefulWidget {
  List<ShopType> shopType;
  CategoryShopType({Key key,this.shopType});
  @override
  _CategoryShopTypeState createState() => _CategoryShopTypeState();
}

class _CategoryShopTypeState extends State<CategoryShopType> {

int intState = 7;
bool openState =false;

  @override
  Widget build(BuildContext context) {

    return Container(
      width:double.infinity,
      margin:EdgeInsets.only(left:5,right:5),
      padding: EdgeInsets.only(top:10),
      child: Wrap(
        children: List.generate(widget.shopType.length, (index) {
          ShopType _shopTypeData = widget.shopType.elementAt(index);
           return Wrap(
              children:[
                index<intState?Div(
                  colL:3,
                  colM:3,
                  colS:3,
                  child:Container(
                    padding: EdgeInsets.only(bottom:10),
                    margin: EdgeInsets.only(left:5,right:5),
                    child:Column(
                        children:[
                        GestureDetector(
                        onTap: () {

                      ShopType shopTypeData = ShopType();

                      currentRecommendation.value.removeWhere((item) => item.id == _shopTypeData.id);
                          if(currentRecommendation.value.length>=7){

                            currentRecommendation.value.removeLast();
                          }

                            shopTypeData.id = _shopTypeData.id;
                            shopTypeData.shopType = _shopTypeData.shopType;
                            shopTypeData.coverImage = _shopTypeData.coverImage;
                            shopTypeData.previewImage = _shopTypeData.previewImage;
                            shopTypeData.title = _shopTypeData.title;
                            shopTypeData.homeShopType = _shopTypeData.homeShopType;


                          print( shopTypeData.previewImage);


                          currentRecommendation.value.insert(0, shopTypeData);
                         if(_shopTypeData.shopType=='7'){
                            currentBookDetail.value.categoryName = _shopTypeData.title;
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubCategory(id: _shopTypeData.id,)));
                          } else if(_shopTypeData.shopType=='2'){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SendPackage()));
                          }else{

                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                              return Stores(storeType: int.parse(_shopTypeData.homeShopType), pageTitle:  _shopTypeData.title,focusId: int.parse(_shopTypeData.id),
                                coverImage: _shopTypeData.coverImage,previewImage: _shopTypeData.previewImage,);
                            }));
                          }



                             },
                            child: Container(
                                width: double.infinity,
                                height: 85.0,
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(_shopTypeData.previewImage)
                                  )
                              )),
                        ),
                          SizedBox(height:5),
                          Container(
                            child: Text(
                              _shopTypeData.title,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ]
                    ),
                  ),

                ):index==intState ?Div(
                  colL:3,
                  colM:3,
                  colS:3,
                  child:Container(
                    padding: EdgeInsets.only(bottom:10),
                    child:Column(
                        children:[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if(openState) {
                                  intState = 7;
                                  openState = false;
                                } else{

                                  intState = widget.shopType.length - 1;
                                  openState = true;
                                }
                              });

                            },
                            child: Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                  color: Color(0xFFaeaeae).withOpacity(0.1),
                                ),
                              child:Center(child:openState?Icon(Icons.keyboard_arrow_up):Icon(Icons.keyboard_arrow_down))
                            ),
                          ),
                          SizedBox(height:5),
                          Container(
                            child: Text(
                              openState?'Less':'More',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ]
                    ),
                  ),

                ):Container(),
              ]
          );
        }),),
    );

  }
}
