import 'package:flutter/material.dart';
import 'package:multisuperstore/src/controllers/cart_controller.dart';
import 'package:multisuperstore/src/models/coupon.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import 'OfferDetailsWidget.dart';


// ignore: must_be_immutable
class OfferSliderWidget extends StatefulWidget {
  String shopId;
  OfferSliderWidget({Key key, this.shopId}) : super(key: key);
  @override
  _OfferSliderWidgetState createState() => _OfferSliderWidgetState();
}

class _OfferSliderWidgetState extends StateMVC<OfferSliderWidget> {
  CartController _con;

  _OfferSliderWidgetState() : super(CartController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
    _con.listenForCoupons('vendor',widget.shopId,currentUser.value.id);
  }


  @override
  Widget build(BuildContext context) {
    return  _con.couponList.isNotEmpty?Container(
        height: 75,
        padding: EdgeInsets.only(top:0),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _con.couponList.length,
          padding: EdgeInsets.only(left:10,right:20),
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (context, int index) {

            return  OfferSliderList(couponData:  _con.couponList[index],couponList:  _con.couponList,);
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 0);
          },
        )
    ):Container();
  }
}


// ignore: must_be_immutable
class OfferSliderList extends StatefulWidget {

  CouponModel couponData;
  List<CouponModel> couponList;
  OfferSliderList({Key key, this.couponData, this.couponList}) : super(key: key);
  @override
  _OfferSliderListState createState() => _OfferSliderListState();
}

class _OfferSliderListState extends State<OfferSliderList> {



  @override
  Widget build(BuildContext context) {

    return AspectRatio(aspectRatio:3.2,
      child: Container(
          decoration: BoxDecoration(
              color:Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(7.0),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).hintColor.withOpacity(0.3),
                  blurRadius: 2,
                  spreadRadius: 1,
                ),
              ]),
          margin: EdgeInsets.only( left:5,right:10,top: 2.0,bottom:10),
          child:Material(
              color: Colors.transparent,
              child:InkWell(
                onTap: () {
                  offerDetail(context,widget.couponList);
                },
                child: Container(
                    padding: EdgeInsets.only(left:5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),

                    ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left:10,),
                              child: Icon(Icons.play_circle_filled_sharp,color: Colors.deepOrangeAccent,),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left:10),
                                child:Text(widget.couponData.title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left:10,),
                          child: Text(widget.couponData.terms, overflow: TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 11))),
                        ),

                      ],
                    )
                ),

              )
          )
      ),
    );
  }
}
void offerDetail(context, couponList) {
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
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft:  Radius.circular(15)),
                ),
                child:Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(


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
                              S.of(context).offer_details,
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
                                OfferDetailsPart(pageType: 'vendor',couponList: couponList,),
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