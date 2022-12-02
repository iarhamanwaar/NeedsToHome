import 'package:flutter/material.dart';
import 'package:multisuperstore/src/models/vendor.dart';




// ignore: must_be_immutable
class StoreTimingWidgets extends StatefulWidget {
  Vendor shopDetails;
  StoreTimingWidgets({Key key, this.shopDetails}) : super(key: key);
  @override
  _StoreTimingWidgetsState createState() => _StoreTimingWidgetsState();
}

class _StoreTimingWidgetsState extends State<StoreTimingWidgets> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left:10,top:10),
        child:Row(
            children:[
              Expanded(
                  child:Container(
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                         Container(
                           child:Text('Opens at ${widget.shopDetails.openingTime}',
                           style: Theme.of(context).textTheme.headline2,
                           )
                         ),
                        Container(
                            child:Text('This outlet usually opens for delivery from ${widget.shopDetails.openingTime} to ${widget.shopDetails.closingTime}',
                              style: Theme.of(context).textTheme.caption,
                            )
                        ),



                      ]
                    )
                  )
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 100,height:80,
                  child: Image.asset('assets/img/closednow.png',
                  fit: BoxFit.fill,
                  ),
                )
              )
            ]
        )
    );
  }
}