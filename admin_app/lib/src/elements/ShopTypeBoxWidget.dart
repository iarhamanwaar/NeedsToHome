
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:login_and_signup_web/src/models/shop_type.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

// ignore: must_be_immutable
class ShopTypeBoxWidget extends StatefulWidget {
  ShopTypeBoxWidget({Key key, this.shopTypeData,}) : super(key: key);
  ShopTypeModel shopTypeData;
  @override
  _ShopTypeBoxWidgetState createState() => _ShopTypeBoxWidgetState();
}

class _ShopTypeBoxWidgetState extends StateMVC<ShopTypeBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child:Div(
        colS: 12,
        colM: 6,
        colL: 4,

        child:  Container(
          decoration: BoxDecoration(
              color: HexColor(widget.shopTypeData.colorCode),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                ),
              ]),
          margin: EdgeInsets.only(left:15,right:15, top: 10.0,bottom:10),

          child:Column(
              children:[
                Stack(
                    children:[
                      ClipRRect(
                        //borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft:Radius.circular(0),
                            bottomRight:Radius.circular(0),

                          ),
                          child:Image(image:widget.shopTypeData.coverImage=='no_image'?
                          AssetImage("assets/img/userImage5.jpeg"):NetworkImage(widget.shopTypeData.coverImage),
                              width:double.infinity,
                              height:190,
                              fit:BoxFit.fill
                          )
                      ),

                      ClipRRect(
                        //borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft:Radius.circular(0),
                          bottomRight:Radius.circular(0),

                        ),
                        child:Container(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                            Container(
                              height:180,
                              width: double.infinity,
                              child: Stack(
                                  children:[
                                    Container(
                                      alignment: Alignment.bottomLeft,

                                      /* background black light to dark gradient color */
                                      decoration: BoxDecoration(
                                        gradient: new LinearGradient(
                                          begin: const Alignment(0.0, -1.0),
                                          end: const Alignment(0.0, 0.6),
                                          colors: <Color>[
                                            const Color(0x8A000000).withOpacity(0.0),
                                            const Color(0x8A000000).withOpacity(0.9),
                                          ],
                                        ),
                                      ),

                                    ),

                                    Positioned(
                                        bottom:10,left:10,right:10,
                                        child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children :[
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 45,
                                                    width: 45,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: widget.shopTypeData.previewImage=='no_image'?
                                                          AssetImage("assets/img/userImage5.jpeg"):NetworkImage(widget.shopTypeData.previewImage),
                                                          fit: BoxFit.fill
                                                      ),
                                                      shape: BoxShape.circle, color: Colors.white, boxShadow:
                                                    [
                                                      BoxShadow(
                                                        color: Colors.grey,
                                                        blurRadius: 5.0,
                                                      ),
                                                    ],
                                                    ),
                                                  ),
                                                  SizedBox(width:10),
                                                  Expanded(
                                                      child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children:[
                                                            Text(widget.shopTypeData.focusTypeName,style:TextStyle(color:Colors.white)),

                                                          ]
                                                      )
                                                  )
                                                ],
                                              ),

                                            ]
                                        )
                                    )
                                  ]
                              ),
                            ),
                          ]
                          ),
                        ),
                      ),
                    ]
                ),

                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[


                      ClipRRect(
                        //borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft:Radius.circular(10),
                          bottomRight:Radius.circular(10),

                        ),
                        child:Container(
                          color:Theme.of(context).dividerColor,
                          width:double.infinity,
                          padding:EdgeInsets.only(bottom:10,top:10,left:15,right:15,),
                          child:Row(
                              mainAxisAlignment:MainAxisAlignment.center,
                              children:[
                                Text('${widget.shopTypeData.superCategory}',style: Theme.of(context).textTheme.bodyText1,)

                              ]
                          ),
                        ),
                      ),

                    ]
                )
              ]
          ),
        ),
      ),
    );
  }
}
