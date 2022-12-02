import 'package:flutter/material.dart';
import 'package:multisuperstore/src/elements/OfferDetailsWidget.dart';
import 'package:multisuperstore/src/repository/order_repository.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../controllers/cart_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';

class ApplyCoupon extends StatefulWidget {
  @override
  _ApplyCouponState createState() => _ApplyCouponState();
}

class _ApplyCouponState extends StateMVC<ApplyCoupon> {
  CartController _con;

  _ApplyCouponState() : super(CartController()) {
    _con = controller;
  }

  @override
  void initState() {
   _con.listenForCoupons('all',currentCheckout.value.shopId,currentUser.value.id);
    super.initState();
  }

  int dropDownValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
            iconTheme: IconThemeData(
              color:Theme.of(context).backgroundColor,
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            title: Text(
              S.of(context).apply_coupons,
              style: Theme.of(context).textTheme.bodyText1,
            )),
        body: Container(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Theme.of(context).dividerColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.only(left: 15.0, top: 2.0, bottom: 2.0, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).dividerColor,
                          ),
                          borderRadius: BorderRadius.circular(2.0),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                style: Theme.of(context).textTheme.subtitle2,
                                controller: _con.couponController,
                                onChanged: (e){

                                  if(e!='') {
                                    setState(() {
                                      _con.tempCouponList = _con.couponSearch(_con.couponList, e);
                                    });
                                  } else {
                                     setState(() {
                                    _con.tempCouponList = _con.couponList;
                                     });
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: S.of(context).enter_coupon_code,
                                  hintStyle: Theme.of(context).textTheme.bodyText2,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20), child: Text(S.of(context).available_coupons)),
                  ],
                ),
              ),
              _con.tempCouponList.isEmpty
                  ? EmptyOrdersWidget()
                  : OfferDetailsPart(couponList:  _con.tempCouponList,pageType: 'all')

            ],
          ),
        )));
  }
}
