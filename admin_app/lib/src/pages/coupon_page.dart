import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/elements/AECouponWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/models/coupon.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

import '../repository/settings_repository.dart';

class CouponPage extends StatefulWidget {
  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends StateMVC<CouponPage> {
  SecondaryController _con;
  _CouponPageState() : super(SecondaryController()) {
    _con = controller;
  }
  @override
  void initState(){
    //_tabController = TabController(length: 3, vsync: this);
    _con.listenForCoupon();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Theme.of(context).primaryColor.withOpacity(0.6),
      child: SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Div(
                colS: 12,
                colM: 12,
                colL: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 30.0, top: 25.0, right: 30, bottom: 10.0),
                      child:Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children:[
                            Div(
                                colS:6,
                                colM:6,
                                colL:6,
                                child:Wrap(
                                    children:[
                                      Text(
                                        S.of(context).coupon,
                                        style: Theme.of(context).textTheme.headline4,
                                      ),
                                      SizedBox(width:10),
                                      Container(
                                        height: 30.0,
                                        width: 30.0,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          color: Theme.of(context).primaryColorLight,
                                          icon: const Icon(Icons.add),
                                          iconSize: 30.0,
                                          //color: Palette.facebookBlue,
                                          onPressed: () {
                                            AECouponPopupHelper.exit(context,_con, Coupon(),'add');
                                          },
                                        ),
                                      )









                                    ]
                                )
                            ),

                            Div(
                              colS:6,
                              colM:6,
                              colL:6,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children:[
                                   /* Padding(
                                      padding:EdgeInsets.only(right:30),
                                      child:IconButton(
                                        onPressed:() async {

                                        },
                                        icon:Icon(Icons.search, color: Theme.of(context).colorScheme.secondary),
                                      ),
                                    ), */


                                  ]
                              ),
                            ),


                          ]
                      ),
                    ),


                    SizedBox(height: 20),
                    (_con.couponList.length==0)?
                    EmptyOrdersWidget():
                    Container(
                      margin: EdgeInsets.only(left:20, right: 20,bottom:30),
                      child: Wrap(
                        children: List.generate(_con.couponList.length, (index) {
                          return Div(
                            colS:12,
                            colM:6,
                            colL:4,
                            child:InkWell(
                              onTap: (){
                                imagePickerBottomSheet(_con.couponList[index].id, _con.couponList.elementAt(index));
                              },
                              child: Container(
                                  padding:EdgeInsets.only(left:10,right:10,top:10,bottom:10),
                                  child:Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image:AssetImage('assets/img/couponcurve1.png') ,
                                              fit: BoxFit.fill
                                          ),

                                          borderRadius: BorderRadius.circular(15.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 20.0,
                                              spreadRadius: 5.0,
                                            ),
                                          ]),
                                      child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:[
                                            Container(
                                              padding:EdgeInsets.only(top:20,left:20,right:20,bottom:20),
                                              child:Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:CrossAxisAlignment.start,
                                                      children: [
                                                        Wrap(
                                                          children: [
                                                            Container(
                                                              padding:EdgeInsets.only(top:2),
                                                              child:Icon(Icons.access_time,color:Colors.pink,size:15),
                                                            ),

                                                            SizedBox(width:7),
                                                            Text(_con.couponList[index].title,style:Theme.of(context).textTheme.subtitle1)
                                                          ],
                                                        ),
                                                        Container(
                                                            padding: EdgeInsets.only(top:10),
                                                            child:_con.couponList[index].couponType=='4'?
                                                            Wrap(
                                                                children:[
                                                                  Text('Free',style:TextStyle(fontSize:30)),
                                                                  SizedBox(width:2),
                                                                  Container(
                                                                      padding: EdgeInsets.only(top:15),
                                                                      child:Text('Delivery')
                                                                  )

                                                                ]
                                                            ):

                                                            Wrap(
                                                                children:[
                                                                  Text('${_con.couponList[index].discount}',style:TextStyle(fontSize:30)),
                                                                  SizedBox(width:2),
                                                                  Container(
                                                                      padding: EdgeInsets.only(top:15),
                                                                      child:_con.couponList[index].discountType=='%'?
                                                                      Text('%'):Text('${setting.value.defaultCurrency} OFF')
                                                                  )

                                                                ]
                                                            )
                                                        ),
                                                        Container(
                                                            padding: EdgeInsets.only(top:10),
                                                            child:Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Stack(clipBehavior: Clip.none, children: [
                                                                  Container(
                                                                      width: 60,
                                                                      height: 35,
                                                                      decoration: BoxDecoration(

                                                                        borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(0),
                                                                          topRight: Radius.circular(10),
                                                                          bottomRight: Radius.circular(10),
                                                                        ),
                                                                        color: Colors.orange[100],
                                                                      ),
                                                                      child: Icon(Icons.card_giftcard, color: Colors.deepOrange)),
                                                                  Container(
                                                                    margin: EdgeInsets.only(left: 55),
                                                                    width: 100,
                                                                    height: 35,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.only(
                                                                        topLeft: Radius.circular(10),
                                                                        topRight: Radius.circular(0),
                                                                        bottomLeft: Radius.circular(10),
                                                                      ),
                                                                      color: Colors.orange[100],
                                                                    ),
                                                                    child: Center(
                                                                        child: Text(
                                                                          _con.couponList[index].code,
                                                                          style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color:Theme.of(context).backgroundColor)),
                                                                        )),
                                                                  ),
                                                                ]),

                                                              ],
                                                            )

                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child:Column(
                                                      children: [
                                                        Container(
                                                            width:60,height:60,
                                                            child:Image(image:NetworkImage(_con.couponList[index].image),
                                                              width:60,
                                                            )
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets.only(top:6),
                                                          child:Text('Applied ${_con.couponList[index].currentApplied}/${_con.couponList[index].maximumLimit}')
                                                        )
                                                      ],
                                                    )
                                                  )
                                                ],
                                              ),
                                            ),

                                            Container(
                                              padding: EdgeInsets.only(left:20,top:10,bottom:20),
                                              child:Text(_con.couponList[index].terms,
                                                  overflow: TextOverflow.ellipsis,maxLines: 1,
                                                  style:Theme.of(context).textTheme.subtitle2),
                                            ),


                                            /*Container(
                                  width:double.infinity,
                                  height:2,
                                  child: DottedBorder(
                                    strokeCap: StrokeCap.butt,
                                    dashPattern: [1, 1],
                                    color: Colors.grey,
                                    strokeWidth: 1,
                                    child: Text(''),
                                  )
                                ),*/

                                          ]
                                      )
                                  )
                              ),
                            ),

                          );
                        }
                        ),
                      ),
                    ),







                  ],
                )),
          ],
        ),
      ),
    );
  }

  imagePickerBottomSheet(id, couponDetails) {
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
                  AECouponPopupHelper.exit(context,_con, couponDetails,'edit'),
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: ()  async{
                    await _con.delete('coupon',id);
                    Navigator.pop(context);
                    setState(() {_con.couponList.clear();});

                  },


                ),
              ],
            ),
          );
        });
  }

}

class AECouponPopupHelper {

  static exit(context,con,details, type) => showDialog(context: context, builder: (context) =>  AECouponWidget(con: con,couponDetails: details,pageType:type));
}
