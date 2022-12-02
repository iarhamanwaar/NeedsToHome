import 'package:flutter/material.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/order_controller.dart';
import 'package:login_and_signup_web/src/controllers/product_controller.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/elements/productBoxWidget.dart';
import 'package:login_and_signup_web/src/models/product_details2.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
// ignore: must_be_immutable
class SearchBoxProduct extends StatefulWidget {
  List<ProductDetails2> productDetails;
  ProductController con;
  String pageType;
  Function callback;
  SearchBoxProduct(
      {Key key, this.productDetails, this.con, this.pageType, this.callback})
      : super(key: key);
  @override
  _SearchBoxProductState createState() => _SearchBoxProductState();
}

class _SearchBoxProductState extends StateMVC<SearchBoxProduct> {
  bool isSwitched = false;
  List<ProductDetails2> itemList;
  bool status = false;
  OrderController _con;
  _SearchBoxProductState() : super(OrderController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemList = widget.productDetails;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.6),
        elevation: 0,
        title: Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(color:Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5.0),
                boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.05), offset: Offset(0, 5), blurRadius: 1)],
                border:Border.all(
                    width: 1,
                    color:Theme.of(context).dividerColor
                )
            ),
            child: TextField(
              autofocus: true,
              onChanged: (e){
                setState((){
                  itemList = _con.filterProduct(widget.productDetails, e);
                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: 'Search',
                hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                suffixIcon: IconButton(
                  icon:Icon(Icons.search, color: Theme.of(context).colorScheme.secondary), onPressed: () {  },
                ),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
              ),
            )),
      ),
      body: (widget.productDetails.isEmpty)?
      EmptyOrdersWidget():
      Padding(
        padding: EdgeInsets.only(top:0),
        child:SingleChildScrollView(
            child:Responsive(
              children: [
                Div(
                  colS: 12,
                  colM: 12,
                  colL: 12,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Wrap(
                          children: List.generate(itemList.length, (index) {
                            ProductDetails2 _orderData = itemList.elementAt(index);
                            return  InkWell(
                              onTap: () {
                                imagePickerBottomSheet(
                                    widget.productDetails[index].id,
                                    widget.productDetails[index],
                                    widget.callback);
                              },
                              child: ProductBox(
                                choice: _orderData,
                                con: widget.con,
                                pageType: widget.pageType,
                                productDetails: widget.productDetails,
                              ),
                            );
                          }
                          ),
                        ),
                      ]
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

  imagePickerBottomSheet(id, details, callback) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new ListTile(
                  leading: new Icon(Icons.adjust_sharp),
                  title: new Text('ID: $id'),
                  onTap: () => {
                    Navigator.pop(context),
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: () async {
                    if (widget.pageType == 'product') {
                      await widget.con.delete('product', id);
                    } else {
                      await widget.con.delete('Itemproduct', id);
                    }
                    callback(details);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }
}






