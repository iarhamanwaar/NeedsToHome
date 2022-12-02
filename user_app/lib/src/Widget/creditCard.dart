
import 'package:flutter/material.dart';
import 'package:multisuperstore/src/components/light_color.dart';
import '../helpers/helper.dart';
import '../models/wallet.dart';
import 'package:multisuperstore/generated/l10n.dart';
// ignore: must_be_immutable
class CreditCard extends StatefulWidget {
  CreditCard({Key key, this.card}) : super(key: key);
  Wallet card;
  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left:15,right:15),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.245,
            color: LightColor.navyBlue1,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        S.of(context).total_balance,
                        style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).colorScheme.primary))
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          Helper.pricePrint(widget.card.balance),

                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w800,
                                color: LightColor.yellow2
                            )
                        ),

                      ],
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed('/topUp');
                      },
                      child: Container(
                          width: 85,
                          padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              border: Border.all(color: Colors.white, width: 1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.add,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                              SizedBox(width: 5),
                              Text(S.of(context).topup,
                                  style: TextStyle(color:Theme.of(context).colorScheme.primary)
                              ),
                            ],
                          )),
                    )
                  ],
                ),
                Positioned(
                  left: -170,
                  top: -170,
                  child: CircleAvatar(
                    radius: 130,
                    backgroundColor: LightColor.lightBlue2,
                  ),
                ),
                Positioned(
                  left: -160,
                  top: -190,
                  child: CircleAvatar(
                    radius: 130,
                    backgroundColor: LightColor.lightBlue1,
                  ),
                ),
                Positioned(
                  right: -170,
                  bottom: -170,
                  child: CircleAvatar(
                    radius: 130,
                    backgroundColor: LightColor.yellow2,
                  ),
                ),
                Positioned(
                  right: -160,
                  bottom: -190,
                  child: CircleAvatar(
                    radius: 130,
                    backgroundColor: LightColor.yellow,
                  ),
                )
              ],
            ),
          )),
    );
  }
}




