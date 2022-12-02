import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/src/models/addon.dart';
import '../models/cart_responce.dart';
import '../controllers/cart_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/helper.dart';


// ignore: must_be_immutable
class ProductBox3Widget extends StatefulWidget {
  ProductBox3Widget({Key key, this.con, this.productDetails}) : super(key: key);
  CartController con;
  CartResponce productDetails;

  @override
  _ProductBox3WidgetState createState() => _ProductBox3WidgetState();
}

class _ProductBox3WidgetState extends StateMVC<ProductBox3Widget> {
  @override
  void initState() {
    super.initState();
    print(widget.productDetails.image);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Container(
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl:   widget.productDetails.image,
                  placeholder: (context, url) => new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  fit: BoxFit.fitHeight,
                  width: 100,
                  height: 100,
                )

              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 2, right: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      top: 6,
                    ),
                    height: 40,
                    child: Text(widget.productDetails.product_name,
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                        softWrap: true,
                        style: TextStyle(color: Theme.of(context).backgroundColor.withOpacity(0.8))),
                  ),
                  SizedBox(height: 5),
                  Wrap(alignment: WrapAlignment.spaceBetween, children: [
                    Text(Helper.pricePrint(widget.productDetails.price), style: Theme.of(context).textTheme.headline3),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 4),
                      child: Text(
                        Helper.pricePrint(widget.productDetails.strike),
                        style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(decoration: TextDecoration.lineThrough)),
                      ),
                    ),

                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${widget.productDetails.quantity} ${widget.productDetails.unit}', style: Theme.of(context).textTheme.caption),

                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: Wrap(alignment: WrapAlignment.center, children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.con.decrementQty(widget.productDetails.id, widget.productDetails.variant);
                                });
                              },
                              iconSize: 27,
                              icon: Icon(Icons.remove_circle),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.022,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 13),
                              child: Text(widget.con.showQty(widget.productDetails.id, widget.productDetails.variant), style: Theme.of(context).textTheme.bodyText1),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.022,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.con.incrementQty(widget.productDetails.id, widget.productDetails.variant, widget.productDetails.variantData);
                                });
                              },
                              iconSize: 27,
                              icon: Icon(Icons.add_circle),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),

                  widget.productDetails.addon.length!=0?Wrap(children: List.generate(widget.productDetails.addon.length, (index){
                          AddonModel _addData = widget.productDetails.addon.elementAt(index);
                          return Container(
                              child:Text('${_addData.name}  ${Helper.pricePrint(_addData.price)}',style:Theme.of(context).textTheme.caption)
                          );})):Text(''),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
