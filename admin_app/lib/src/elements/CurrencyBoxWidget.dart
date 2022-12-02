
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/models/currency.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';


// ignore: must_be_immutable
class CurrencyBoxWidget extends StatefulWidget {
  CurrencyBoxWidget({Key key, this.currencyDetails, this.con}) : super(key: key);
  Currency currencyDetails;
  SecondaryController con;
  @override
  _CurrencyBoxWidgetState createState() => _CurrencyBoxWidgetState();
}

class _CurrencyBoxWidgetState extends StateMVC<CurrencyBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Div(
      colS:12,
      colM:6,
      colL:4,
      child:Container(
          padding:EdgeInsets.only(left:10,right:10,top:10,bottom:10),
          child:Container(
              height:90,
              padding:EdgeInsets.only(left:10,right:10,top:20,bottom:10),
              decoration: BoxDecoration(
                  color:Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      spreadRadius: 1,
                    ),
                  ]),
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.currencyDetails.uploadImage),
                          fit: BoxFit.fill
                      ),
                      shape: BoxShape.circle, color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5.0,),],
                    ),),
                  SizedBox(width:15),
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.currencyDetails.currencySymbol,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.headline3,
                              ),

                              Text(
                                '${widget.currencyDetails.currencySymbol} 10',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            //Text('\$45.0', style: Theme.of(context).textTheme.subtitle1),
                            Text(
                              widget.currencyDetails.currencyName,
                              style: Theme.of(context).textTheme.headline3,
                            ),

                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
          )
      ),

    );
  }

  // ignore: non_constant_identifier_names

}



