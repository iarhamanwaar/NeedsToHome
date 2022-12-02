
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/product_controller.dart';
import 'package:login_and_signup_web/src/elements/productBoxWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/product_details2.dart';
import 'package:responsive_ui/responsive_ui.dart';


// ignore: must_be_immutable
class ProductTabs extends StatefulWidget {
  final List<ProductDetails2> productDetails;
  ProductController con;
  String pageType;
  Function callback;
  ProductTabs(
      {Key key, this.productDetails, this.con, this.pageType, this.callback})
      : super(key: key);
  @override
  _ProductTabsState createState() => _ProductTabsState();
}

class _ProductTabsState extends StateMVC<ProductTabs> {
  @override
  void initState() {
    super.initState();

    // _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
          child: Responsive(children: [
            Div(
                colS: 12,
                colM: 12,
                colL: 12,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        children: List.generate(widget.productDetails.length,
                                (index) {
                              return InkWell(
                                onTap: () {

                                },
                                child: ProductBox(
                                  choice: widget.productDetails[index],
                                  con: widget.con,
                                  pageType: widget.pageType,
                                  productDetails: widget.productDetails,
                                ),
                              );
                            }),
                      ),
                    ]))
          ]),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names

}
