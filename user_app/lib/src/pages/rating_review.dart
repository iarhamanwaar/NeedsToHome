import 'package:flutter/material.dart';
import 'package:multisuperstore/src/controllers/product_controller.dart';
import 'package:multisuperstore/src/elements/EmptyOrdersWidget.dart';
import 'package:multisuperstore/src/elements/RatingReviewWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';

// ignore: must_be_immutable
class RatingReviews extends StatefulWidget {
  int vendorid;
  RatingReviews({Key key, this.vendorid}) : super(key: key);
  @override
  _RatingReviewsState createState() => _RatingReviewsState();
}

class _RatingReviewsState extends StateMVC<RatingReviews> {
  ProductController _con;
  _RatingReviewsState() : super(ProductController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    _con.listenForShopReview(widget.vendorid);
  }
  int dropDownValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).backgroundColor
        ),
        title: Text(S.of(context).reviews,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body:(_con.shopReviewList.isEmpty)?EmptyOrdersWidget():Container(
          child:SingleChildScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
                children:[
                  Container(
                      padding: EdgeInsets.only(top:20,left:15,right:15,bottom:20,),
                      child: RatingsReviewWidget(reviewList: _con.shopReviewList,)
                  ),

                ]
            ),
          )


      ),
    );
  }
}
