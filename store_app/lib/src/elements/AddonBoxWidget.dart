
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/product_controller.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/addon.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toast/toast.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'AEAddonWidget.dart';

// ignore: must_be_immutable
class AddonBoxWidget extends StatefulWidget {
  AddonModel addonData;
  ProductController con;
  String functionType;
  AddonBoxWidget({Key key, this.addonData,this.con, this.functionType}) : super(key: key);
  @override
  _AddonBoxWidgetState createState() => _AddonBoxWidgetState();
}

class _AddonBoxWidgetState extends StateMVC<AddonBoxWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width:200,
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          color:Theme.of(context).primaryColor.withOpacity(0.6),),
        child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                width:180,
                child: Row(
                    children:[
                      Container(
                        margin: EdgeInsets.only(top:5),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: widget.addonData.foodType=='Veg'?Colors.green:Colors.brown,
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(top: 0),
                          decoration: BoxDecoration(
                            color: widget.addonData.foodType=='Veg'?Colors.green:Colors.brown,
                            shape: BoxShape.circle,
                          ),
                          width: 6.0,
                          height: 6.0,
                        ),
                      ),
                      SizedBox(width:5),
                      /*Text(widget.addonData.name),*/
                      Expanded(
                        child:Text(widget.addonData.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),



                    ]
                ),
              ),

              SizedBox(height:10),
              Row(
                children:[
                  Padding(
                    padding: const EdgeInsets.only(top:5,left:8),
                    child:Text(Helper.pricePrint(widget.addonData.salesPrice),
                        style:Theme.of(context)
                            .textTheme
                            .bodyText2
                    ),
                  ),
                  IconButton(onPressed: () {

                    Imagepickerbottomsheet(widget.addonData.id);
                  },
                      icon: Icon(Icons.edit),
                      iconSize:23

                  )
                ]
              )



            ])

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
                    print(widget.addonData.toMap()),
                    AddAddonHelper.exit(context, widget.con,widget.addonData, 'edit', widget.addonData.id),

                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: () => {

                 if(widget.con.addonList.length>1){

                     widget.con.delete('variant_2', widget.addonData.id),

                      setState(() {
                        widget.con.addonList.clear();
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
class AddAddonHelper {

  static exit(context, con, addonDetails, pageType, productID) => showDialog(context: context, builder: (context) =>  AEAddonWidget(con: con,addonDetails: addonDetails,pageType: pageType, productId: productID, ));
}

void showToast(String msg,  context, {int duration, int gravity}) {
  Toast.show(msg, context, duration: duration, gravity: gravity ,);
}