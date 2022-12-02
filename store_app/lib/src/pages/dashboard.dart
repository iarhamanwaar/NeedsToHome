import 'package:fl_chart/fl_chart.dart';
import 'package:flip_panel/flip_panel.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:login_and_signup_web/src/controllers/home_controller.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/elements/topproductBoxWidget.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/dashboard.dart';
import 'package:login_and_signup_web/src/models/topproducts.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';
import 'dart:math';
import 'dart:math' as math;
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:vrouter/vrouter.dart';
import 'barcodepdf.dart';
class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends StateMVC<DashboardWidget> with TickerProviderStateMixin {

  HomeController _con;

  _DashboardWidgetState() : super(HomeController()) {
    _con = controller;
  }


  AnimationController animationController;
  bool expired = false;
  CountdownController countdownController ;
  @override
  void initState() {
    if(currentUser.value.profileComplete=='5' && currentUser.value.profileStatus) {
    if(int.parse(currentUser.value.expiredTime)*1000 <= (DateTime.now().millisecondsSinceEpoch)){
      expired = true;

    }else{
       countdownController =
      CountdownController(duration: Duration(seconds: int.parse(Helper.calculateTimeDifferenceBetween(endDate:DateTime.fromMillisecondsSinceEpoch(int.parse(currentUser.value.expiredTime) * 1000), startDate:DateTime.fromMicrosecondsSinceEpoch((DateTime.now().millisecondsSinceEpoch) * 1000)))), onEnd: () {
        print('onEnd');

      });
       countdownController.start();
    }

    }
    _con.listenForTopBar();
    _con.listenForTopProducts(currentUser.value.shopTypeId);

    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 10),
    );

    animationController.repeat();
    _con.listenForBarGraph();

    super.initState();

  }


  @override
  void dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }




  int hrscount=0;









  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  _con.barGraphList.isEmpty ? EmptyOrdersWidget():expired== true?EmptyOrdersWidget():Scrollbar(
        isAlwaysShown: true,
        child:ListView(
          scrollDirection: Axis.vertical,
          children: [
            Responsive(
                children:[

                  Div(
                    colS:12,
                    colM:12,
                    colL: 12,
                    child:Container(
                        margin: EdgeInsets.only(left:20,right:20, top: 35.0, bottom: 10.0),
                        child:SingleChildScrollView(
                          child:Column(
                            children: [


                              /**    currentUser.value.profileStatus?Container():Container(
                                  height: size.width > 670 ? 50: 70,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                  color:Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5.0),
                                  boxShadow: [
                                  BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 20.0,
                                  spreadRadius: 5.0,
                                  ),
                                  ]),
                                  child: Row(
                                  mainAxisSize: size.width > 670 ? MainAxisSize.max: MainAxisSize.min,
                                  mainAxisAlignment: size.width > 670 ?MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                                  children: [
                                  Container(
                                  child:Image(image:AssetImage('assets/img/success.gif'),
                                  height:size.width > 670 ? 40:40,
                                  width:size.width > 670 ? 60:50
                                  ),
                                  ),


                                  Container(
                                  padding: EdgeInsets.only(right:size.width * 0.02),
                                  width:size.width > 670 ? size.width * 0.37: size.width * 0.45,
                                  alignment: Alignment.center,
                                  child:Text('Thank you for register. Please complete your profile',style:size.width > 670 ?Theme.of(context).textTheme.subtitle1:Theme.of(context).textTheme.bodyText2),
                                  ),


                                  // ignore: deprecated_member_use

                                  Container(

                                  padding: EdgeInsets.only(right:size.width * 0.02),
                                  width:size.width > 670 ? 90: 65,
                                  // ignore: deprecated_member_use
                                  child:FlatButton(
                                  onPressed: () {
                                  VRouter.of(context).pushNamed('profile');

                                  },
                                  color: Theme.of(context).accentColor.withOpacity(1),
                                  shape: StadiumBorder(),
                                  child: Text(
                                  'Click',
                                  style: Theme.of(context).textTheme.subtitle2.merge(
                                  TextStyle(
                                  color: Theme.of(context)
                                  .primaryColorLight)),
                                  ),
                                  ),
                                  ),
                                  ],
                                  ),

                                  ), */
                              currentUser.value.profileStatus ? Container(

                                  child:Container(
                                      padding: EdgeInsets.all(size.width > 769 ? 15 : 7 ),
                                      width:double.infinity,
                                      decoration:BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 20.0,
                                              spreadRadius: 5.0,
                                            ),
                                          ]
                                      ),
                                      child:Stack(
                                          clipBehavior: Clip.none, children:[
                                        Positioned(
                                            top:-40,right:size.width > 769 ? size.width * 0.03: size.width * 0.03,
                                            child:Stack(
                                                children:[
                                                  !GetPlatform.isMobile? InkWell(
                                                    onTap:(){

                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                  BarCodePdf()));
                                                    },
                                                    child:Container(
                                                      width:80,height:90,
                                                      child:Image(image:AssetImage('assets/img/qrbarcode.png'))
                                                  ),):Container()



                                                ])
                                        ),
                                        Wrap(
                                            children:[
                                              Div(
                                                  colS:12,
                                                  colM:3,
                                                  colL:2,
                                                  child:Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children:[
                                                        Container(
                                                            child:Text(S.of(context).welcome,
                                                                style:Theme.of(context).textTheme.headline3
                                                            )
                                                        ),
                                                        Container(

                                                            child:Text(currentUser.value.shopName,
                                                                style:Theme.of(context).textTheme.headline1
                                                            )
                                                        )
                                                      ]
                                                  )
                                              ),
                                              Div(
                                                colS:12,
                                                colM:8,
                                                colL:6,
                                                child:Countdown(
                                                    countdownController: countdownController,
                                                    builder: (_, Duration time) {
                                                      return Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:CrossAxisAlignment.center,
                                                            children: [
                                                              (time.inDays==1 || time.inDays==0)?
                                                              FlipPanel.builder(
                                                                itemBuilder: (context, index) => Container(
                                                                    color: Colors.black,
                                                                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                                                    child:
                                                                    Text('0',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 50.0,
                                                                          color: Colors.white),
                                                                    )
                                                                ),
                                                                itemsCount:298765,//int.parse(Helper.calculateTimeDifferenceBetween(endDate:DateTime.fromMillisecondsSinceEpoch(int.parse(currentUser.value.expiredTime) * 1000), startDate:DateTime.fromMicrosecondsSinceEpoch((DateTime.now().millisecondsSinceEpoch) * 1000),type: 'mins')),
                                                                startIndex: 0,
                                                                period: const Duration(seconds: 60),
                                                                //loop: time.inMinutes % 60,
                                                              ):
                                                              FlipPanel.builder(
                                                                itemBuilder: (context, index) => Container(
                                                                  color: Colors.black,
                                                                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                                                  child: Text(
                                                                    '${time.inDays-1}'
                                                                    ,style: TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 50.0,
                                                                      color: Colors.white),
                                                                  ),
                                                                ),
                                                                itemsCount:900,
                                                                //startIndex: 0,
                                                                period: const Duration(days: 1),
                                                                //loop: 1,
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text('days')
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            children: [
                                                              (time.inHours % 24==1 || time.inHours % 24==0)?
                                                              FlipPanel.builder(
                                                                itemBuilder: (context, index) => Container(
                                                                    color: Colors.black,
                                                                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                                                    child:
                                                                    Text('0',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 50.0,
                                                                          color: Colors.white),
                                                                    )
                                                                ),
                                                                itemsCount:298765,//int.parse(Helper.calculateTimeDifferenceBetween(endDate:DateTime.fromMillisecondsSinceEpoch(int.parse(currentUser.value.expiredTime) * 1000), startDate:DateTime.fromMicrosecondsSinceEpoch((DateTime.now().millisecondsSinceEpoch) * 1000),type: 'mins')),
                                                                startIndex: 0,
                                                                period: const Duration(seconds: 60),
                                                                //loop: time.inMinutes % 60,
                                                              ):
                                                              FlipPanel.builder(
                                                                itemBuilder: (context, index) => Container(
                                                                    color: Colors.black,
                                                                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                                                    child:
                                                                    Text('${time.inHours%24-1}',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 50.0,
                                                                          color: Colors.white),
                                                                    )
                                                                ),
                                                                itemsCount:1000,
                                                                //startIndex:,
                                                                period: const Duration(minutes: 60),
                                                                //loop: 1000000,
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text('Hours')
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            children: [
                                                              (time.inMinutes % 60==1 || time.inMinutes % 60==0)?
                                                              FlipPanel.builder(
                                                                itemBuilder: (context, index) => Container(
                                                                    color: Colors.black,
                                                                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                                                    child:
                                                                    Text('0',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 50.0,
                                                                          color: Colors.white),
                                                                    )
                                                                ),
                                                                itemsCount:298765,//int.parse(Helper.calculateTimeDifferenceBetween(endDate:DateTime.fromMillisecondsSinceEpoch(int.parse(currentUser.value.expiredTime) * 1000), startDate:DateTime.fromMicrosecondsSinceEpoch((DateTime.now().millisecondsSinceEpoch) * 1000),type: 'mins')),
                                                                startIndex: 0,
                                                                period: const Duration(seconds: 60),
                                                                //loop: time.inMinutes % 60,
                                                              ):
                                                              FlipPanel.builder(
                                                                itemBuilder: (context, index) => Container(
                                                                    color: Colors.black,
                                                                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                                                    child:
                                                                    Text('${time.inMinutes % 60-1}',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 50.0,
                                                                          color: Colors.white),
                                                                    )
                                                                ),
                                                                itemsCount:298765,//int.parse(Helper.calculateTimeDifferenceBetween(endDate:DateTime.fromMillisecondsSinceEpoch(int.parse(currentUser.value.expiredTime) * 1000), startDate:DateTime.fromMicrosecondsSinceEpoch((DateTime.now().millisecondsSinceEpoch) * 1000),type: 'mins')),
                                                                startIndex: 0,
                                                                period: const Duration(seconds: 60),
                                                                //loop: time.inMinutes % 60,
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text('Minutes')
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            children: [
                                                              FlipPanel.builder(
                                                                itemBuilder: (context, index) => Container(
                                                                  color: Colors.black,
                                                                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                                                  child: Text(
                                                                    '${time.inSeconds % 60}',
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 50.0,
                                                                        color: Colors.white),
                                                                  ),
                                                                ),
                                                                itemsCount: 987654331,
                                                                //startIndex: 0,
                                                                period: const Duration(seconds: 1),
                                                                //loop: 525600,
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text('Seconds')
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                              ),
                                              size.width > 760 ? Div(
                                                  colS:12,
                                                  colM:6,
                                                  colL:4,
                                                  child:Container(
                                                      margin: EdgeInsets.only(top:45,),
                                                      child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children:[

                                                            !GetPlatform.isMobile?Container(
                                                                padding:EdgeInsets.only(right:20),
                                                                child:MaterialButton(
                                                                  onPressed: () {
                                                                  //  VRouter.of(context).push('/Barcode');
                                                                    Navigator.of(context).push(
                                                                        MaterialPageRoute(
                                                                            builder:
                                                                                (context) =>
                                                                                BarCodePdf()));
                                                                  },
                                                                  color:Theme.of(context).primaryColorDark,
                                                                  minWidth: 130,
                                                                  shape: StadiumBorder(),

                                                                  height: 40,
                                                                  padding: EdgeInsets.zero,
                                                                  child: Container(
                                                                      padding: EdgeInsets.only(top:0,left:10,right:5),
                                                                      child:Text(S.of(context).generate,
                                                                          textAlign: TextAlign.center,
                                                                          style:TextStyle(fontFamily:'Touche W03 Regular',fontWeight: FontWeight.w100,color: Theme.of(context).primaryColorLight)
                                                                      )
                                                                  ),

                                                                )
                                                            ):Container(),
                                                          ]
                                                      )



                                                  )
                                              ) : Container()
                                            ]
                                        )
                                      ]
                                      )
                                  )


                              ):Container(),

                              /* currentUser.value.profileStatus? Container(
                         
                         child:Container(
                             padding: EdgeInsets.all(size.width > 769 ? 15 : 7 ),
                             width:double.infinity,
                             decoration:BoxDecoration(
                                 color: Theme.of(context).accentColor,
                                 borderRadius: BorderRadius.circular(20)
                             ),
                             child:Stack(
                               overflow: Overflow.visible,
                                 children:[
                                   Positioned(
                                       top:-40,right:size.width > 769 ? size.width * 0.03: size.width * 0.03,
                                       child:Stack(
                                           children:[
                                             Container(
                                                 width:80,height:90,
                                                 child:Image(image:AssetImage('assets/img/qrbarcode.png'))
                                             ),
                                             


                                           ])
                                   ),
                                   Wrap(
                                       children:[
                                         Div(
                                             colS:3,
                                             colM:3,
                                             colL:2,
                                             child:Column(
                                                 crossAxisAlignment: CrossAxisAlignment.center,
                                                 children:[
                                                   Container(
                                                       child:Text('welcome',
                                                           style:Theme.of(context).textTheme.headline3.merge( TextStyle(color: Colors.white))
                                                       )
                                                   ),
                                                   Container(

                                                       child:Text(currentUser.value.shopName,
                                                           style:Theme.of(context).textTheme.headline1.merge( TextStyle(color: Colors.white))
                                                       )
                                                   )
                                                 ]
                                             )
                                         ),
                                         Div(
                                             colS:12,
                                             colM:8,
                                             colL:6,
                                             child:Container(
                                                 child:Row(
                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                   children: [
                                                     Column(
                                                       crossAxisAlignment:CrossAxisAlignment.center,
                                                       children: [
                                                         FlipPanel.builder(
                                                           itemBuilder: (context, index) => Container(
                                                             color: Colors.black,
                                                             padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                                             child: Text(
                                                               '${int.parse(Helper.calculateTimeDifferenceBetween(endDate:DateTime.fromMillisecondsSinceEpoch(int.parse(currentUser.value.expiredTime) * 1000), startDate:DateTime.fromMicrosecondsSinceEpoch((DateTime.now().millisecondsSinceEpoch) * 1000),type: 'day'))-index}'
                                                               ,style: TextStyle(
                                                                   fontWeight: FontWeight.bold,
                                                                   fontSize: 50.0,
                                                                   color: Colors.white),
                                                             ),
                                                           ),
                                                           itemsCount: 365,
                                                           startIndex: 0,
                                                           period: const Duration(days: 1),
                                                           loop: 1,
                                                         ),
                                                         SizedBox(
                                                           height: 10,
                                                         ),
                                                         Text('days')
                                                       ],
                                                     ),
                                                     SizedBox(
                                                       width: 10,
                                                     ),
                                                     Column(
                                                       children: [
                                                         FlipPanel.builder(
                                                           itemBuilder: (context, index) => Container(
                                                             color: Colors.black,
                                                             padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                                             child: Text(
                                                               '${int.parse(Helper.calculateTimeDifferenceBetween(endDate:DateTime.fromMillisecondsSinceEpoch(int.parse(currentUser.value.expiredTime) * 1000), startDate:DateTime.fromMicrosecondsSinceEpoch((DateTime.now().millisecondsSinceEpoch) * 1000),type: 'hrs'))-index}',
                                                               style: TextStyle(
                                                                   fontWeight: FontWeight.bold,
                                                                   fontSize: 50.0,
                                                                   color: Colors.white),
                                                             ),
                                                           ),
                                                           itemsCount: 60,
                                                           startIndex: 0,
                                                           period: const Duration(minutes: 60),
                                                           loop: 365,
                                                         ),
                                                         SizedBox(
                                                           height: 10,
                                                         ),
                                                         Text('Hours')
                                                       ],
                                                     ),
                                                     SizedBox(
                                                       width: 10,
                                                     ),
                                                     Column(
                                                       children: [
                                                         FlipPanel.builder(
                                                           itemBuilder: (context, index) => Container(
                                                             color: Colors.black,
                                                             padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                                             child: Text(
                                                               '${60-index}',
                                                               style: TextStyle(
                                                                   fontWeight: FontWeight.bold,
                                                                   fontSize: 50.0,
                                                                   color: Colors.white),
                                                             ),
                                                           ),
                                                           itemsCount: 60,
                                                           startIndex: 0,
                                                           period: const Duration(seconds: 60),
                                                           loop: 8760,
                                                         ),
                                                         SizedBox(
                                                           height: 10,
                                                         ),
                                                         Text('Minutes')
                                                       ],
                                                     ),
                                                     SizedBox(
                                                       width: 10,
                                                     ),
                                                     Column(
                                                       children: [
                                                         FlipPanel.builder(
                                                           itemBuilder: (context, index) => Container(
                                                             color: Colors.black,
                                                             padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                                             child: Text(
                                                               '${60-index}',
                                                               style: TextStyle(
                                                                   fontWeight: FontWeight.bold,
                                                                   fontSize: 50.0,
                                                                   color: Colors.white),
                                                             ),
                                                           ),
                                                           itemsCount: 60,
                                                           startIndex: 1,
                                                           period: const Duration(seconds: 1),
                                                           loop: 525600,
                                                         ),
                                                         SizedBox(
                                                           height: 10,
                                                         ),
                                                         Text('Seconds')
                                                       ],
                                                     ),
                                                   ],
                                                 )
                                             )
                                         ),
                                         size.width > 760 ? Div(
                                             colS:12,
                                             colM:6,
                                             colL:4,
                                             child:Container(
                                                margin: EdgeInsets.only(top:45,),
                                                 child: Column(
                                                     crossAxisAlignment: CrossAxisAlignment.end,
                                                     mainAxisAlignment: MainAxisAlignment.center,
                                                     children:[

                                                       Container(
                                                         padding:EdgeInsets.only(right:20),
                                                         child:MaterialButton(
                                                           onPressed: () {
                                                             VRouter.of(context).push('/Barcode');
                                                           },
                                                           color:Theme.of(context).primaryColorDark,
                                                           minWidth: 130,
                                                           shape: StadiumBorder(),

                                                           height: 40,
                                                           padding: EdgeInsets.zero,
                                                           child: Container(
                                                               padding: EdgeInsets.only(top:0,left:10,right:5),
                                                               child:Text('Generate',
                                                                   textAlign: TextAlign.center,
                                                                   style:TextStyle(fontFamily:'Touche W03 Regular',fontWeight: FontWeight.w100,color: Theme.of(context).primaryColorLight)
                                                               )
                                                           ),

                                                         )
                                                       )
                                                     ]
                                                 )



                                             )
                                         ) : Container()
                                       ]
                                   )
                                 ]
                             )
                         )

                         
                       ):Container(),*/
                              SizedBox(
                                height: 10,
                              ),

                              Wrap(
                                  children:[
                                    Div(
                                      colS: 12,
                                      colM: 12,
                                      colL: 3,

                                      child:  Container(
                                        margin: EdgeInsets.only(left:10, right:5,top: 35.0, bottom: 10.0),


                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [

                                            Expanded(
                                              child: ProjectProgressCard(
                                                color: Color(0xffFF4C60),
                                                projectName: S.of(context).new_order,
                                                percentComplete: '${_con.dashboardData.newOrdersPercent}%',
                                                progressIndicatorColor: Colors.redAccent[100],
                                                icon: Feather.box,
                                                showData: _con.dashboardData.newOrders,
                                                type: 'new_order',

                                              ),
                                            ),



                                          ],
                                        ),
                                      ),

                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 12,
                                      colL: 3,
                                      child:  Container(
                                        margin: EdgeInsets.only(left:10, right:5,  top: 35.0, bottom: 10.0),


                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [



                                            Expanded(
                                              child:ProjectProgressCard(
                                                color: Color(0xff6C6CE5),
                                                projectName: S.of(context).processing,
                                                percentComplete: '${_con.dashboardData.processingPercent}%',
                                                progressIndicatorColor: Colors.blue[200],
                                                icon: Feather.loader,
                                                showData: _con.dashboardData.processing,
                                                type: 'processing',
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 12,
                                      colL: 3,

                                      child:  Container(
                                        margin: EdgeInsets.only(left:10, right:5, top: 35.0, bottom: 10.0),


                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [

                                            Expanded(
                                              child: ProjectProgressCard(
                                                color: Color(0xffFF4C60),
                                                projectName: S.of(context).out_for_delivery,
                                                percentComplete: '${_con.dashboardData.outForDeliveryPercent}%',
                                                progressIndicatorColor: Colors.redAccent[100],
                                                icon: Icons.two_wheeler_outlined,
                                                showData: _con.dashboardData.outForDelivery,
                                                type: 'on_the_way',
                                              ),
                                            ),



                                          ],
                                        ),
                                      ),

                                    ),

                                    Div(
                                      colS: 12,
                                      colM: 12,
                                      colL: 3,
                                      child:  Stack(
                                          clipBehavior: Clip.none, children:[
                                        Positioned(
                                          top:0,right:-20,
                                          child:Container(

                                            alignment: Alignment.center,
                                            child: AnimatedBuilder(
                                              animation: animationController,
                                              child: Container(
                                                height: 250.0,
                                                width: 250.0,
                                                decoration: BoxDecoration(

                                                  shape: BoxShape.circle,
                                                ),
                                                child:ClipRRect(
                                                  borderRadius: BorderRadius.circular(150),
                                                  child: Image(
                                                    image: currentUser.value.shopTypeId==3?
                                                    AssetImage('assets/img/medpreview.png'):
                                                    AssetImage('assets/img/plate-food2.png'),

                                                    fit: BoxFit.fill,

                                                  ),
                                                ),

                                              ),
                                              builder: (BuildContext context, Widget _widget) {
                                                return Transform.rotate(
                                                  angle: animationController.value * 2 * pi,
                                                  child: _widget,
                                                );
                                              },
                                            ),


                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left:10, right:40, top: 35.0, bottom: 10.0),


                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [



                                              Expanded(
                                                child:ProjectProgressCard(
                                                  color: Color(0xffFAAA1E),
                                                  projectName: S.of(context).completed,
                                                  percentComplete: '${_con.dashboardData.completePercent}%',
                                                  progressIndicatorColor: Colors.amber[200],
                                                  icon: Icons.wifi_tethering,
                                                  showData: _con.dashboardData.completed,
                                                  type: 'completed',
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),

                                      ]
                                      ),
                                    ),


                                  ]
                              )
                            ],
                          ),
                        )

                    ),
                  ),




                  Div(
                    colS:12,
                    colM:12,
                    colL:12,
                    child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Wrap(
                              children:[

                                Div(
                                  colS:12,
                                  colM:12,
                                  colL:5,
                                  child:Padding(
                                      padding: EdgeInsets.only(top:20),


                                      child:SideCard(dashboardData: _con.dashboardData)

                                  ),
                                ),
                                Div(
                                    colS:12,
                                    colM:12,
                                    colL:7,
                                    child:Padding(
                                      padding: EdgeInsets.only(top:20,left:24,right:24),
                                      child:BarChartSample2(thisMonthSales: _con.dashboardData.thisMonthSales,con: _con,),
                                    )
                                )

                              ]
                          ),
                        ]
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width:double.infinity,
                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.only(left:20),
                            child: Text(
                              'Top Products',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          )),
                      Container(
                        color: Theme.of(context).primaryColor.withOpacity(0.6),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 220,
                                width: double.infinity,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _con.topProductList.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(top: 10, right: 10),
                                    itemBuilder: (context, index) {
                                      TopProduct _topproduct = _con.topProductList.elementAt(index);
                                      return ProductBoxWidget(
                                        topProduct: _topproduct,
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ]
            )
            // SideCard(),
          ],
        )
    );

  }
}

































class ProjectProgressCard extends StatefulWidget {
  final Color color;
  final Color progressIndicatorColor;
  final String projectName;
  final String percentComplete;
  final IconData icon;
  final int showData;
  final String type;
  ProjectProgressCard({
    this.color,
    this.progressIndicatorColor,
    this.percentComplete,
    this.projectName,
    this.icon,
    this.showData,
    this.type
  });
  @override
  _ProjectProgressCardState createState() => _ProjectProgressCardState();
}

class _ProjectProgressCardState extends State<ProjectProgressCard> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(widget.type=='new_order') {
          VRouter.of(context).push('/Order_new');
        } else if(widget.type=='processing'){
          VRouter.of(context).push('/Order_placed');
        }else if(widget.type=='on_the_way'){
          VRouter.of(context).push('/Order_shipped');
        }else if(widget.type=='completed'){
          VRouter.of(context).push('/Order_delivered');
        }
      },
      child: MouseRegion(
        onEnter: (value) {
          setState(() {
            hovered = true;
          });
        },
        onExit: (value) {
          setState(() {
            hovered = false;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 275),
          height: hovered ? 160.0 : 155.0,
          width: 200,
          decoration: BoxDecoration(
              color: hovered ? widget.color : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20.0,
                  spreadRadius: 5.0,
                ),
              ]),

          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),

              Row(
                children: [
                  SizedBox(
                    width: 18.0,
                  ),
                  Container(
                    height: 30.0,
                    width: 30.0,
                    child: Icon(
                      widget.icon,
                      color: !hovered ? Colors.grey : Colors.grey,
                      size: 16.0,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: hovered ?  Theme.of(context).scaffoldBackgroundColor : Colors.black
                    ),
                  ),
                  SizedBox(
                    width: 13.0,
                  ),
                  Container(
                    child: Text(
                      widget.projectName,
                      style:hovered ? Theme.of(context).textTheme.bodyText1.merge(TextStyle(color:Theme.of(context).primaryColorLight)) : Theme.of(context).textTheme.bodyText1,
                      /*style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: hovered ? Colors.white : Colors.black,
                      ),*/
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),

              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 18.0,
                  ),
                  Container(
                    height: 13.0,
                    width: 13.0,
                    child: Icon(
                      Feather.clock,
                      size: 13.0,
                      color: hovered ? Colors.white: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    child: Text(
                      '${widget.showData} ${S.of(context).orders}',
                      style:hovered ? Theme.of(context).textTheme.bodyText1.merge(TextStyle(color:Theme.of(context).primaryColorLight)) : Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 8.0, left: 135.0),
                child: Text(
                  widget.percentComplete,
                  style:hovered ? Theme.of(context).textTheme.caption.merge(TextStyle(color:Theme.of(context).primaryColorLight)) : Theme.of(context).textTheme.caption,
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 275),
                margin: EdgeInsets.only(top: 5.0),
                height: 6.0,
                width: 160.0,
                decoration: BoxDecoration(
                  color: hovered
                      ? widget.progressIndicatorColor
                      : Color(0xffF5F6FA),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 275),
                    height: 6.0,
                    width:
                    (double.parse(widget.percentComplete.substring(0, 1)) /
                        10) *
                        160.0,
                    decoration: BoxDecoration(
                      color: hovered ?  Theme.of(context).primaryColor : widget.color,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}





















class SideCard extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final Dashboard dashboardData;

  const SideCard({Key key, this.animationController, this.animation, this.dashboardData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 24, right: 24, top: 16, bottom: 18),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topRight: Radius.circular(68.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: FintnessAppTheme.grey.withOpacity(0.2),
                offset: Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding:
              const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                height: 48,
                                width: 2,
                                decoration: BoxDecoration(
                                  color: HexColor('#87A0E5')
                                      .withOpacity(0.5),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(4.0)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, bottom: 2),
                                      child: Text(
                                          "COD",
                                          textAlign: TextAlign.center,
                                          style:Theme.of(context).textTheme.bodyText1
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 28,
                                          height: 28,
                                          child: Image.asset(
                                              "assets/img/cod.png"),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              left: 4, bottom: 3),
                                          child: Text(
                                              Helper.pricePrint(dashboardData.totalEarnCod),
                                              textAlign: TextAlign.center,
                                              style:Theme.of(context).textTheme.bodyText1
                                          ),
                                        ),

                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                height: 48,
                                width: 2,
                                decoration: BoxDecoration(
                                  color: HexColor('#F56E98')
                                      .withOpacity(0.5),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(4.0)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, bottom: 2),
                                      child: Text(
                                          S.of(context).online,
                                          textAlign: TextAlign.center,
                                          style:Theme.of(context).textTheme.bodyText1
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 28,
                                          height: 28,
                                          child: Image.asset(
                                              "assets/img/online.gif"),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              left: 4, bottom: 3),
                                          child: Text(
                                              Helper.pricePrint(dashboardData.totalEarnOnline),
                                              textAlign: TextAlign.center,
                                              style:Theme.of(context).textTheme.bodyText1
                                          ),
                                        ),

                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Center(
                      child: Stack(
                        clipBehavior: Clip.none, children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(100.0),
                              ),
                              border: new Border.all(
                                  width: 4,
                                  color: FintnessAppTheme
                                      .nearlyDarkBlue
                                      .withOpacity(0.2)),
                            ),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  Helper.pricePrint(dashboardData.totalEarn),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily:
                                    FintnessAppTheme.fontName,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                    color: FintnessAppTheme
                                        .nearlyDarkBlue,
                                  ),
                                ),
                                Text(
                                    S.of(context).total_earn,
                                    textAlign: TextAlign.center,
                                    style:Theme.of(context).textTheme.bodyText1
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CustomPaint(
                            painter: CurvePainter(
                                colors: [
                                  FintnessAppTheme.nearlyDarkBlue,
                                  HexColor("#8A98E8"),
                                  HexColor("#8A98E8")
                                ],
                                angle: 140 +
                                    (360 - 140) *
                                        (1.0 - 0.2)),
                            child: SizedBox(
                              width: 108,
                              height: 108,
                            ),
                          ),
                        )
                      ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 8),
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  color: FintnessAppTheme.background,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            S.of(context).products,
                            textAlign: TextAlign.center,
                            style:Theme.of(context).textTheme.bodyText1
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Container(
                            height: 4,
                            width: 70,
                            decoration: BoxDecoration(
                              color:
                              HexColor('#87A0E5').withOpacity(0.2),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(4.0)),
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: ((70 / 1.2) * 0.2),
                                  height: 4,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      HexColor('#87A0E5'),
                                      HexColor('#87A0E5')
                                          .withOpacity(0.5),
                                    ]),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(4.0)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                              dashboardData.totalProducts.toString(),
                              textAlign: TextAlign.center,
                              style:Theme.of(context).textTheme.caption
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                S.of(context).category,
                                textAlign: TextAlign.center,
                                style:Theme.of(context).textTheme.bodyText1
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Container(
                                height: 4,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: HexColor('#F56E98')
                                      .withOpacity(0.2),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(4.0)),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: ((70 / 2) *
                                          0.2),
                                      height: 4,
                                      decoration: BoxDecoration(
                                        gradient:
                                        LinearGradient(colors: [
                                          HexColor('#F56E98')
                                              .withOpacity(0.1),
                                          HexColor('#F56E98'),
                                        ]),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                  dashboardData.totalCategory.toString(),
                                  textAlign: TextAlign.center,
                                  style:Theme.of(context).textTheme.caption
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                S.of(context).total_sales,
                                style:Theme.of(context).textTheme.bodyText1
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 0, top: 4),
                              child: Container(
                                height: 4,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: HexColor('#F1B440')
                                      .withOpacity(0.2),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(4.0)),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: ((70 / 2.5) *
                                          0.2),
                                      height: 4,
                                      decoration: BoxDecoration(
                                        gradient:
                                        LinearGradient(colors: [
                                          HexColor('#F1B440')
                                              .withOpacity(0.1),
                                          HexColor('#F1B440'),
                                        ]),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                  dashboardData.totalSales.toString(),
                                  textAlign: TextAlign.center,
                                  style:Theme.of(context).textTheme.caption
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

  }
}

class CurvePainter extends CustomPainter {
  final double angle;
  final List<Color> colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    // ignore: deprecated_member_use
    List<Color> colorsList = List<Color>();
    if (colors != null) {
      colorsList = colors;
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = new Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shdowPaintCenter = new Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.1);
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = new SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        new Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        paint);

    final gradient1 = new SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = new Paint();
    cPaint..shader = gradient1.createShader(rect);
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(new Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}









/* graph */

// ignore: must_be_immutable
class BarChartSample2 extends StatefulWidget {
  BarChartSample2({this.thisMonthSales, this.con});
  double thisMonthSales;
  HomeController con;
  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex;

  @override
  void initState() {




    /**final items = widget.con.barGraphList.map((BarGraphModel map) {

        makeGroupData(1, 10.0, 20.0);

        }).toList(); */

    final items = [
      makeGroupData(0, 0.0,0.0)
    ];

    widget.con.barGraphList.forEach((element) {
      items.add(makeGroupData(element.month, element.instance, element.schedule));
    });


    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AspectRatio(
      aspectRatio: 1.8,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: const Color(0xff2c4260),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  makeTransactionsIcon(),

                  SizedBox(
                    width: 38,
                  ),
                  Text(S.of(context).this_month_sales,
                      style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(
                        color:Theme.of(context).primaryColorLight,))
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Container(
                    width: size.width > 670 ? 120 : 80,
                    child:Text(
                        Helper.pricePrint(widget.thisMonthSales).toString(),
                        style: size.width > 670 ?Theme.of(context).textTheme.headline5.merge(TextStyle(color:Theme.of(context).primaryColorLight)):Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).primaryColorLight))),
                  ),


                ],
              ),
              const SizedBox(
                height: 38,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BarChart(
                    BarChartData(
                      maxY: 800,
                      barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: Colors.grey,
                            getTooltipItem: (_a, _b, _c, _d) => null,
                          ),
                          touchCallback: (response) {
                            if (response.spot == null) {
                              setState(() {
                                touchedGroupIndex = -1;
                                showingBarGroups = List.of(rawBarGroups);
                              });
                              return;
                            }

                            touchedGroupIndex = response.spot.touchedBarGroupIndex;

                            setState(() {
                              if (response.touchInput is PointerExitEvent ||
                                  response.touchInput is PointerUpEvent) {
                                touchedGroupIndex = -1;
                                showingBarGroups = List.of(rawBarGroups);
                              } else {
                                showingBarGroups = List.of(rawBarGroups);
                                if (touchedGroupIndex != -1) {
                                  double sum = 0;
                                  for (BarChartRodData rod
                                  in showingBarGroups[touchedGroupIndex].barRods) {
                                    sum += rod.y;
                                  }
                                  final avg =
                                      sum / showingBarGroups[touchedGroupIndex].barRods.length;

                                  showingBarGroups[touchedGroupIndex] =
                                      showingBarGroups[touchedGroupIndex].copyWith(
                                        barRods: showingBarGroups[touchedGroupIndex].barRods.map((rod) {
                                          return rod.copyWith(y: avg);
                                        }).toList(),
                                      );
                                }
                              }
                            });
                          }),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) =>
                          size.width > 600 ? Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).primaryColorLight)) :TextStyle(color:Theme.of(context).primaryColorLight,fontSize: 7.5,fontWeight: FontWeight.w800),
                          margin: 20,
                          getTitles: (double value) {
                            switch (value.toInt()) {
                              case 1:
                                return 'Jan';
                              case 2:
                                return 'Feb';
                              case 3:
                                return 'Mar';
                              case 4:
                                return 'Apr';
                              case 5:
                                return 'May';
                              case 6:
                                return 'Jun';
                              case 7:
                                return 'jul';
                              case 8:
                                return 'Aug';
                              case 9:
                                return 'Sep';
                              case 10:
                                return 'Oct';
                              case 11:
                                return 'Nov';
                              case 12:
                                return 'Dec';
                              default:
                                return '';
                            }
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                              color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                          margin: 32,
                          reservedSize: 14,
                          getTitles: (value) {
                            if (value == 0) {
                              return '1';
                            } else if (value == 500) {
                              return '500';
                            } else if (value == 1000) {
                              return '1K';
                            } else if (value == 1500) {
                              return '1.5K';
                            }else{
                              return '';
                            }

                          },
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: showingBarGroups,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }

  Widget makeTransactionsIcon() {
    const double width = 4.5;
    const double space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}



















class FintnessAppTheme {
  FintnessAppTheme._();
  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF2F3F8);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);

  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Roboto';

  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
}





class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}