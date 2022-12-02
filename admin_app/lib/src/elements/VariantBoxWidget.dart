
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/product_controller.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toast/toast.dart';
import '../models/variant.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'AEVariantWidget.dart';
// ignore: must_be_immutable
class VariantBoxWidget extends StatefulWidget {
  variantModel variantData;
  ProductController con;
  String functionType;
  VariantBoxWidget({Key key, this.variantData,this.con, this.functionType}) : super(key: key);
  @override
  _VariantBoxWidgetState createState() => _VariantBoxWidgetState();
}

class _VariantBoxWidgetState extends StateMVC<VariantBoxWidget> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        width:size.width > 769 ?200 :230,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:Theme.of(context).primaryColor.withOpacity(0.6),),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[

                Container(

                  child:ClipRRect(
                    //borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft:Radius.circular(0),
                        bottomRight:Radius.circular(0),

                      ),
                      child:Image(image:NetworkImage(widget.variantData.uploadImage),
                          width:double.infinity,
                          height:120,
                          fit:BoxFit.fill
                      )
                  ),
                ),

                SizedBox(height:10),
                Row(
                    children:[
                      2==2 ?  Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: widget.variantData.foodType=='Veg'?Colors.green: Colors.brown,
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(top: 0),
                          decoration: BoxDecoration(
                            color: widget.variantData.foodType=='Veg'?Colors.green: Colors.brown,
                            shape: BoxShape.circle,
                          ),
                          width: 6.0,
                          height: 6.0,
                        ),
                      ):Container(),
                      SizedBox(width:5),
                      Text(widget.variantData.name),


                    ]
                ),

                SizedBox(height:10),
                Wrap(
                    alignment: WrapAlignment.start,
                    children:[
                      Padding(
                        padding: const EdgeInsets.only(top:0),
                        child:Text(Helper.pricePrint(widget.variantData.sale_price),
                            style:Theme.of(context)
                                .textTheme
                                .bodyText2
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child:Text(Helper.pricePrint(widget.variantData.strike_price),
                          style:Theme.of(context)
                              .textTheme
                              .bodyText2
                              .merge(
                              TextStyle(decoration: TextDecoration.lineThrough)
                          ),

                        ),
                      ),

                      /**  Padding(
                          padding: const EdgeInsets.only(left: 10,right:8),
                          child:Container(


                          child: Text('${widget.variantDataData.quantity} ${widget.variantDataData.unit}',
                          style:Theme.of(context)
                          .textTheme
                          .bodyText2
                          .merge(TextStyle(color: Theme.of(context).accentColor,)
                          ),
                          ),

                          ),
                          ), */
                      SizedBox(height:20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Text('${widget.variantData.quantity} ${widget.variantData.unit}',textAlign:TextAlign.center),
                          ]),
                      SizedBox(height:30),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            // ignore: deprecated_member_use
                            FlatButton(
                              onPressed: () {

                                Imagepickerbottomsheet(widget.variantData.variant_id);
                              },
                              color:Colors.blue,
                              splashColor:Colors.blue,
                              textColor:Colors.white,
                              child:Text(S.of(context).option,style:Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.white))),
                            ),
                          ]
                      )

                    ]
                ),


        ]
      )
    );
  }

  // ignore: non_constant_identifier_names
  Imagepickerbottomsheet(id) {
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
                  leading: new Icon(Icons.edit),
                  title: new Text(S.of(context).edit),
                  onTap: () => {

                    Navigator.pop(context),
                  AddVariantHelper.exit(context, widget.con,widget.variantData, 'edit', widget.variantData.variant_id, widget.functionType),

                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: () => {

                 if(widget.con.variantList.length>1){
                   if(widget.functionType=='product'){
                     widget.con.delete('variant_2', widget.variantData.variant_id),

                   } else {
                     widget.con.delete('variant', widget.variantData.variant_id),

                   },
                      setState(() {
                        widget.con.variantList.clear();
                      }),
                      Navigator.pop(context),
                      Navigator.of(context).pop(),
                    }else {
          showToast(" Cannot be delete", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT),
                 }
                  },
                ),
              ],
            ),
          );
        });
  }
}
class AddVariantHelper {

  static exit(context, con, variantDetails, pageType, productID,functionType) => showDialog(context: context, builder: (context) =>  VariantPopupWidget(con: con,variantDetails: variantDetails,pageType: pageType, productId: productID,functionType: functionType, ));
}

void showToast(String msg,  context, {int duration, int gravity}) {
  Toast.show(msg, context, duration: duration, gravity: gravity ,);
}