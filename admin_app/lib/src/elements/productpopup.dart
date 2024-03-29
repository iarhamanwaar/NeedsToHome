
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/product_controller.dart';
import 'package:login_and_signup_web/src/models/product_details2.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:responsive_ui/responsive_ui.dart';

// ignore: must_be_immutable
class ProductPopup extends StatefulWidget {
  ProductController con;
  ProductDetails2 product;
  String shopType;
  ProductPopup({Key key, this.con, this.product, this.shopType}) : super(key: key);
  @override
  _ProductPopupState createState() => _ProductPopupState();
}

class _ProductPopupState extends StateMVC<ProductPopup> {
  // ignore: non_constant_identifier_names

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('feature ${widget.product.featuredProduct}');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      child: Div(
        colS: 12,
        colM: 8,
        colL: 6,
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            height: size.width > 769 ?200 :300,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Product setting',
                          style: Theme.of(context).textTheme.headline4),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ),
                widget.shopType!='2'?Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).today_deals,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Switch(
                        value: widget.product.todayDeal,
                        onChanged: (value) {
                          setState(() {
                            if (widget.product.todayDeal == true) {
                              //isswitch = false;
                              //value=false;
                              widget.product.todayDeal = false;
                            } else {
                              //isswitch = true;
                              //value=true;
                              widget.product.todayDeal = true;
                            }
                          });
                          widget.con.todayDealStatus(
                              widget.product.id,
                              widget.product.todayDeal.toString(),
                              'todaydeals', 'product');
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                    ],
                  ),
                ):Container(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Featured Product",
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Switch(
                        value: widget.product.featuredProduct,
                        onChanged: (value) {
                          setState(() {
                            if (widget.product.featuredProduct == true) {
                              //isswitch = false;
                              //value=false;
                              widget.product.featuredProduct = false;
                            } else {
                              //isswitch = true;
                              //value=true;
                              widget.product.featuredProduct = true;
                            }
                          });
                          widget.con.todayDealStatus(
                              widget.product.id,
                              widget.product.featuredProduct.toString(),
                              'featuredProduct', widget.shopType!='2'?'product':'Itemproduct');
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
