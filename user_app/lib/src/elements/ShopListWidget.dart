import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/models/vendor.dart';
import 'package:multisuperstore/src/pages/grocerystore.dart';
import 'package:multisuperstore/src/pages/store_detail.dart';
import 'package:multisuperstore/src/repository/vendor_repository.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:toast/toast.dart';


class ShopList extends StatelessWidget {
  const ShopList({Key key, this.choice, this.shopType,this.focusId, this.previewImage}) : super(key: key);
  final Vendor choice;
  final int shopType;
  final int focusId;
  final String previewImage;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: choice.shopId,
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor)),
        ),
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {


              if( choice.openStatus) {


                currentVendor.value = choice;
                if (shopType == 1 || shopType == 3) {



                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          GroceryStoreWidget(shopDetails: choice,
                            shopTypeID: shopType,
                            focusId: focusId,)));
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          StoreViewDetails(shopDetails: choice,
                            shopTypeID: shopType,
                            focusId: focusId,)));
                }
              } else{
                Toast.show(S.of(context).sorry_this_shop_currently_closed, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM ,);
              }
            },
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Stack(
                            children:[
                              ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  !Helper.shopOpenStatus(choice)?Colors.black.withOpacity(0.91):Colors.black.withOpacity(0), // 0 = Colored, 1 = Black & White
                                  BlendMode.saturation,
                                ),
                                child:ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: choice.logo!='no_image'?FadeInImage.assetNetwork(
                                      placeholder: 'assets/img/loading_trend.gif',
                                      image: choice.logo,
                                      width: MediaQuery.of(context).size.width * 0.25,
                                      height: MediaQuery.of(context).size.width * 0.28, fit: BoxFit.cover,
                                      imageErrorBuilder: (c, o, s) => Image.asset('assets/img/loading_trend.gif', height: 120, width: 110, fit: BoxFit.cover),
                                    ):FadeInImage.assetNetwork(
                                      placeholder: 'assets/img/loading_trend.gif',
                                      image: previewImage,
                                      width: MediaQuery.of(context).size.width * 0.25,
                                      height: MediaQuery.of(context).size.width * 0.28, fit: BoxFit.cover,
                                      imageErrorBuilder: (c, o, s) => Image.asset('assets/img/loading_trend.gif', height: 120, width: 110, fit: BoxFit.cover),
                                    )),
                              ),

                              choice.openStatus?  Container():Positioned(
                                top:0,bottom:0,
                                child: Container(
                                    width: MediaQuery.of(context).size.width * 0.25,
                                    height: MediaQuery.of(context).size.height * 0.28,
                                    decoration: new BoxDecoration(
                                        color:Colors.black.withOpacity(0.6)

                                    ),
                                    child:Center(
                                      child:Container(
                                        padding: EdgeInsets.only(left:15,right:15,),
                                        child: Text(
                                            S.of(context).closed_now,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                                        ),

                                      ),
                                    )

                                ),

                              ),
                              choice.bestSeller?Positioned(
                                top:-10,
                                child: Align(
                                  alignment: Alignment.topCenter,

                                  child: Shimmer(
                                    // This is the ONLY required parameter
                                    child: Container(

                                      //width: MediaQuery.of(context).size.width * 0.20,
                                        width: 102,
                                        height:43,
                                        decoration: BoxDecoration(

                                          image: DecorationImage(
                                              image: AssetImage('assets/img/ribbion.png')
                                          ),

                                        ),

                                        child:Stack(
                                            alignment: Alignment.topCenter,
                                            children:[
                                              Positioned(
                                                  top:10,
                                                  child:Align(
                                                      alignment: Alignment.topCenter,
                                                      child:Center(
                                                          child:Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children:[
                                                                Text(S.of(context).best_seller,style:TextStyle(color:Theme.of(context).primaryColorLight,fontSize:10,fontWeight: FontWeight.w800))
                                                              ]
                                                          )

                                                      )
                                                  )
                                              )

                                            ]
                                        )
                                    ),
                                    // This is the default value
                                    duration: Duration(seconds: 3),
                                    // This is NOT the default value. Default value: Duration(seconds: 0)
                                    interval: Duration(seconds: 0),
                                    // This is the default value
                                    color: Colors.white,
                                    // This is the default value
                                    colorOpacity: 0.5,
                                    // This is the default value
                                    enabled: true,
                                    // This is the default value
                                    direction: ShimmerDirection.fromLTRB(),
                                  ),

                                ),
                              ):Container(),


                            ]),
                      ),

                   /* Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: choice.marketKey=='discount'?Container(
                            padding: EdgeInsets.all(3),
                            //width: MediaQuery.of(context).size.width * 0.20,
                            width: 100,
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
                              color: Colors.deepOrange[400],
                            ),

                            child:

                                 Wrap(alignment: WrapAlignment.center, children: [
                                  Text(
                                      '${choice.marketValue}% Off',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.white))
                                  )])

                          ):choice.marketKey=='offer'?Container(
                              padding: EdgeInsets.all(3),
                              //width: MediaQuery.of(context).size.width * 0.20,
                              width: 100,height:37,
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
                                color: Color(0xFFefbe0f),
                              ),

                              child:Column(children:[
                                Text('- UPTO -',style:TextStyle(fontSize:9,color:Theme.of(context).primaryColorLight)),
                                Wrap(alignment: WrapAlignment.center, children: [
                                  Text(
                                      '${Helper.pricePrint(choice.marketValue)}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                                  )])
                              ])



                          ):Container(),
                        ),
                      ), */
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(
                                choice.shopName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0, right: 15),
                                child:
                                Text(choice.subtitle, overflow: TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.caption),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0, right: 15),
                                child: Text(choice.locationMark,
                                    overflow: TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.caption),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Wrap(children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Icon(Icons.star, color: Colors.grey[500], size: 15),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text('${choice.ratingTotal}     ', style: Theme.of(context).textTheme.bodyText2),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(Helper.priceDistance(choice.distance), style: Theme.of(context).textTheme.bodyText2),
                                ),
                               /* Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text('     ${Helper.calculateTime(double.parse(choice.distance.replaceAll(',','')),int.parse(choice.handoverTime),false)}', style: Theme.of(context).textTheme.bodyText2),
                                ), */
                              ]),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              !Helper.shopOpenStatus(choice)? Container(

                                child: Text('Open at ${choice.openingTime}  to ${choice.closingTime}', style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.red))),
                              ):Container(),

                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}