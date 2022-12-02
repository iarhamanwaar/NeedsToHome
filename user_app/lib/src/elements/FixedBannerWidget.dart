import 'package:flutter/material.dart';
import 'package:multisuperstore/src/models/slide.dart';
import 'package:multisuperstore/src/pages/stores_general.dart';
import 'package:multisuperstore/src/pages/subcategory.dart';
import 'package:multisuperstore/src/repository/hservice_repository.dart';

class FixedBannerWidget extends StatefulWidget {
 final List<Slide> fixedSlider;
  FixedBannerWidget({Key key,this.fixedSlider});


  @override
  _FixedBannerWidgetState createState() => _FixedBannerWidgetState();
}

class _FixedBannerWidgetState extends State<FixedBannerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children:List.generate(widget.fixedSlider.length, (index) {
          Slide slider = widget.fixedSlider.elementAt(index);
          return index==0?InkWell(
            onTap: (){
              if(slider.superCategoryId!='2' && slider.superCategoryId!='7') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>  StoresGeneral(superId: slider.superCategoryId, pageTitle: slider.slider_text,
                      coverImage: slider.image, offer: slider.para, offerType: slider.redirect_type,shopTypeId: slider.shopTypeId,)));


              }  else if(slider.superCategoryId=='7'){
                currentBookDetail.value.categoryName = slider.slider_text;
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubCategory(id: slider.id,)));
              } else if(slider.superCategoryId=='2'){
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SendPackage()));
              }
            },
            child: Container(
                margin: EdgeInsets.only(bottom:10),
                child:Container(
                    padding:EdgeInsets.only(left:15,right:15),
                    height:100,width:double.infinity,
                    child:  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child:Image.network(slider.image,
                        fit: BoxFit.fill,
                      ),)
                )
            ),
          ):Container();
        })


    );
  }
}
