
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/addon2.dart';

// ignore: must_be_immutable
class AddonViewWidget extends StatefulWidget {
  Addon2Model addonData;
  AddonViewWidget({Key key, this.addonData}) : super(key: key);
  @override
  _AddonViewWidgetState createState() => _AddonViewWidgetState();
}

class _AddonViewWidgetState extends State<AddonViewWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom:10),
        decoration: BoxDecoration(
          color: Theme
              .of(context)
              .primaryColor
              .withOpacity(0.6),),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child:Row(
                  children:[
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color:  widget.addonData.foodType=='Veg'?Colors.green:Colors.brown,
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
                    Expanded(
                      child:Container(
                        padding: EdgeInsets.only(left:10,right:10),
                        child: Text(widget.addonData.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Text(Helper.pricePrint(widget.addonData.price),
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2
                    ),

                  ]
                )
              ),
              /*ListTile(
                leading:Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.green,
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    width: 6.0,
                    height: 6.0,
                  ),
                ),
                title: Container(
                  child: Text('f',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                trailing:  IconButton(onPressed: () {


                },
                    icon: Icon(Icons.edit),
                    iconSize: 23

                )
              ),*/





            ])

    );
  }
}