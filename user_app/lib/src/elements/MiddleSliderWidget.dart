import 'package:flutter/material.dart';
import 'package:multisuperstore/src/pages/product_list.dart';
import 'package:multisuperstore/src/pages/stores_general.dart';
import 'package:multisuperstore/src/pages/subcategory.dart';
import 'package:multisuperstore/src/repository/hservice_repository.dart';
import 'package:multisuperstore/src/repository/product_repository.dart';
import '../models/slide.dart';
import 'HomeSliderLoaderWidget.dart';

class MiddleSliderWidget extends StatefulWidget {
  final List<Slide> slides;
  final pageType;
  final para1;
  final shopId;

  @override
  _MiddleSliderWidgetState createState() => _MiddleSliderWidgetState();

  MiddleSliderWidget({Key key, this.slides, this.pageType, this.para1,this.shopId}) : super(key: key);
}

class _MiddleSliderWidgetState extends State<MiddleSliderWidget> {


  @override
  Widget build(BuildContext context) {
    return widget.slides == null || widget.slides.isEmpty
        ? HomeSliderLoaderWidget()
        : Container(
      height: 180,
      padding: EdgeInsets.only(top:0),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.slides.length,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.only(left:3,right:3),
          itemBuilder: (context, index) {
            Slide _slideData = widget.slides.elementAt(index);
            return Container(
                child: AspectRatio(
                  aspectRatio: 1.65,

                  child:  Container(
                      decoration: BoxDecoration(
                        color:Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15.0),

                      ),
                      margin: EdgeInsets.only(left:5,right:5, top: 10.0,bottom:10),
                      child: ClipRRect(
                        //borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderRadius: BorderRadius.circular(15.0),
                          child:Material(
                            color: Colors.transparent,

                            child: InkWell(
                                onTap: (){
                                    if(widget.pageType=='vendor'){
                                      currentSearch.value.shopName = widget.para1;
                                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductList()));
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductList(pageType: 'offer',subcategory_Id:_slideData.superCategoryId,offer: _slideData.para,shopId: widget.shopId,)));
                                    }else{
                                      if(_slideData.superCategoryId!='2' && _slideData.superCategoryId!='7') {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) =>  StoresGeneral(superId: _slideData.superCategoryId, pageTitle: _slideData.slider_text,
                                              coverImage: _slideData.image, offer: _slideData.para, offerType: _slideData.redirect_type,shopTypeId: _slideData.shopTypeId,)));


                                      }  else if(_slideData.superCategoryId=='7'){
                                        currentBookDetail.value.categoryName = _slideData.slider_text;
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubCategory(id: _slideData.id,)));
                                      } else if(_slideData.superCategoryId=='2'){
                                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SendPackage()));
                                      }
                                    }
                                },
                                splashColor:Colors.grey[100].withOpacity(0.5),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/img/loading_trend.gif',
                                  image: _slideData.image,
                                  height: 120, width: 150, fit: BoxFit.fill,
                                  imageErrorBuilder: (c, o, s) => Image.asset('assets/img/loading_trend.gif', height: 120, width: 150, fit: BoxFit.cover),
                                )

                            ),))
                  ),

                )

            );
          }),
    );

  }
}
