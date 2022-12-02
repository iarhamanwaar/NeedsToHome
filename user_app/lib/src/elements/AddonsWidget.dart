// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import '../controllers/product_controller.dart';
import '../helpers/helper.dart';
import '../models/addon.dart';
import '../models/product_details2.dart';
import '../models/variant.dart';

// ignore: must_be_immutable
class AddonsPart extends StatefulWidget {
  ProductDetails2 product;
  ProductController con;
  AddonsPart({Key key, this.product, this.con}) : super(key: key);
  @override
  _AddonsPartState createState() => _AddonsPartState();
}

class _AddonsPartState extends State<AddonsPart> {
  // Declare this variable
  String selectedRadio ;
  String addon;
  bool firstLoad;
  @override
  void initState() {
    super.initState();

    widget.product.variant.forEach((_l) {
      setState(() {
        if(_l.selected==true) {
          selectedRadio = _l.quantity;
        }
      });
    });
    firstLoad = false;
  }

  setSelectedRadio(String val) {

    widget.product.variant.forEach((_l) {
      setState(() {
        if(_l.quantity==val) {
          selectedRadio = val;
          _l.selected= true;
        } else{
          _l.selected= false;
        }
      });
    });


    setState(() {
      selectedRadio = val;
    });
  }


  setSelectedaddon( val) {

    widget.product.variant.forEach((_l) {
      setState(() {
        if(_l.selected==val) {
          selectedRadio = val;
          _l.selected= true;
        } else{
          _l.selected= false;
        }
      });
    });


    setState(() {
      addon = val;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [

      SizedBox(height: 10),
      Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                '* ${S.of(context).quantity}',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.left,
              ),
            ),
            ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount:  widget.product.variant.length,
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.only(top: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) {
                variantModel _variantData = widget.product.variant.elementAt(index);


                return    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: _variantData.foodType=='Veg'?Colors.green:Colors.brown,
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: 0),
                      decoration: BoxDecoration(
                        color: _variantData.foodType=='Veg'?Colors.green:Colors.brown,
                        shape: BoxShape.circle,
                      ),
                      width: 6.0,
                      height: 6.0,
                    ),
                  ),

                 Radio(
                      value: _variantData.quantity,
                      groupValue: selectedRadio,
                      activeColor: Colors.blue,
                      onChanged: (val) {

                        setSelectedRadio(val);

                      }),
                  GestureDetector(
                    onTap: () {
                      setSelectedRadio(_variantData.quantity);
                    },
                    child: RichText(
                      text: new TextSpan(text: '${_variantData.quantity} ${_variantData.unit}', style: Theme.of(context).textTheme.subtitle2, children: [
                        new TextSpan(
                          text: '  ${Helper.pricePrint(_variantData.sale_price)}',
                          style: Theme.of(context).textTheme.subtitle2,
                        )
                      ]),
                    ),
                  ),
                ]);

              }, separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 5);
            },),

            widget.product.addon.length>0?Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                '* ${S.of(context).addons}',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.left,
              ),
            ):Container(),
            ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: widget.product.addon.length,
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.only(top: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) {

                AddonModel _addonData = widget.product.addon.elementAt(index);
                if(firstLoad==false) {
                  _addonData.selected = widget.con.checkRestaurantVariant(widget.product.id, _addonData.addon_id);

                }
                return    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: _addonData.foodType=='veg'?Colors.green:Colors.brown,
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: 0),
                      decoration: BoxDecoration(
                        color: _addonData.foodType=='veg'?Colors.green:Colors.brown,
                        shape: BoxShape.circle,
                      ),
                      width: 6.0,
                      height: 6.0,
                    ),
                  ),
                 Checkbox(
                      value: _addonData.selected,
                      activeColor: Colors.blue,
                      onChanged: (val) {

                      firstLoad = true;
                      setState(() {
                        if(val==false) {
                          _addonData.selected = false;
                        }else {
                          _addonData.selected = true;
                        }
                      });

                      }),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if( _addonData.selected==true){
                          _addonData.selected = false;
                        }else{
                          _addonData.selected = true;
                        }
                      });
                    },
                    child: RichText(
                      text: new TextSpan(text: _addonData.name, style: Theme.of(context).textTheme.subtitle2, children: [
                        new TextSpan(
                          text: '   ${Helper.pricePrint(_addonData.price)}',
                          style: Theme.of(context).textTheme.subtitle2,
                        )
                      ]),
                    ),
                  ),
                ]);

              }, separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 5);
            },),

          ])),

    ]);
  }
}