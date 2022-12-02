import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:login_and_signup_web/src/controllers/home_controller.dart';
import 'package:login_and_signup_web/src/elements/ProductBoxWidget.dart';
import 'package:login_and_signup_web/src/elements/VendorBox2Widget.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/dashboard.dart';
import 'package:login_and_signup_web/src/models/topproduct.dart';
import 'package:login_and_signup_web/src/pages/meals_list_view.dart';
import 'package:login_and_signup_web/src/repository/settings_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:vrouter/vrouter.dart';
import 'dart:math';
import 'dart:math' as math;
import '../models/top_vendor.dart';
class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends StateMVC<DashboardWidget> with SingleTickerProviderStateMixin{

  HomeController _con;

  _DashboardWidgetState() : super(HomeController()) {
    _con = controller;
  }



  int touchedIndex;









  AnimationController animationController;
  void initState() {
    super.initState();
    _con.listenForTopBar();
    _con.listenForTopVendor();
    _con.listenForBarGraph();
    _con.listenForDashboardCounter();
    _con.listenForTopProducts();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 10),
    );

    animationController.repeat();
  }
  @override
  void dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scrollbar(
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
                                                        image: AssetImage('assets/img/plate-food2.png'),

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
                                    colL:6,
                                    child:Padding(
                                      padding: EdgeInsets.all(10),
                                      child:SideCard(dashboardData: _con.dashboardData),
                                    )
                                ),
                                Div(
                                    colS:12,
                                    colM:12,
                                    colL:6,
                                    child:Padding(
                                        padding: EdgeInsets.only(top:35,),
                                        child:MealsListView(con:_con)
                                    )
                                ),

                      Container(
                        color:Theme.of(context).primaryColor.withOpacity(0.6),
                        child: SingleChildScrollView(
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width:double.infinity,
                                padding:EdgeInsets.only(left:20,top:20,bottom:20),
                                  child: Text(
                                    S.of(context).top_vendor,
                                      style: Theme.of(context).textTheme.headline1,
                                    ),
                                  ),
                              Container(
                                height: 220,
                                width: double.infinity,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _con.topVendorList.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(top: 10, right: 10),
                                    itemBuilder: (context, index) {
                                      TopVendor _topVendor =  _con.topVendorList.elementAt(index);
                                      return VendorBox2Widget(topVendor: _topVendor,);
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width:double.infinity,
                                      padding:EdgeInsets.only(left:20,top:20,bottom:20),
                                      child: Text(
                                        S.of(context).top_selling_products,
                                        style: Theme.of(context).textTheme.headline1,
                                      ),
                                    ),
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
                                Wrap(
                                    children:[
                                      Div(
                                          colS:12,
                                          colM:12,
                                          colL:6,
                                          child:Padding(
                                              padding: EdgeInsets.all(20),
                                              child: _con.barGraphList.isEmpty?Container():BarChartSample1(con: _con,)
                                          )
                                      ),
                                      /**Div(
                                          colS:12,
                                          colM:12,
                                          colL:6,
                                          child:Padding(
                                              padding: EdgeInsets.all(20),

                                              child:LineChartSample1()
                                          )
                                      ), */
                                    ]
                                ),





                              ]
                          )
                        ]
                    ),
                  )
                ]
            )
            // SideCard(),
          ],
        )
    );

  }
}












/* barchart 2 */

// ignore: must_be_immutable
class BarChartSample1 extends StatefulWidget {
  BarChartSample1({Key key, this.con,}) : super(key: key);
  HomeController con;
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: const Color(0xff81e5cd),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    S.of(context).this_year_sales,
                    style: TextStyle(
                        color: const Color(0xff0f4a3c), fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    Helper.pricePrint(widget.con.dashboardData.thisMonthEarn),
                    style: TextStyle(
                        color: const Color(0xff379982), fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: BarChart(
                        isPlaying ? randomData() : mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: const Color(0xff0f4a3c),
                  ),
                  onPressed: () {
                    setState(() {
                      isPlaying = !isPlaying;
                      if (isPlaying) {
                        refreshState();
                      }
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
      int x,
      double y, {
        bool isTouched = false,
        Color barColor = Colors.white,
        double width = 10,
        List<int> showTooltips = const [],
      }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 10,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }


  List<BarChartGroupData> showingGroups() => List.generate(widget.con.barGraphList.length, (i) {
    switch (i) {
      case 0:
        return makeGroupData(0, widget.con.barGraphList.elementAt(0).orders, isTouched: i == touchedIndex);
      case 1:
        return makeGroupData(1, widget.con.barGraphList.elementAt(1).orders, isTouched: i == touchedIndex);
      case 2:
        return makeGroupData(2, widget.con.barGraphList.elementAt(2).orders, isTouched: i == touchedIndex);
      case 3:
        return makeGroupData(3, widget.con.barGraphList.elementAt(3).orders, isTouched: i == touchedIndex);
      case 4:
        return makeGroupData(4, widget.con.barGraphList.elementAt(4).orders, isTouched: i == touchedIndex);
      case 5:
        return makeGroupData(5, widget.con.barGraphList.elementAt(5).orders, isTouched: i == touchedIndex);
      case 6:
        return makeGroupData(6, widget.con.barGraphList.elementAt(6).orders, isTouched: i == touchedIndex);
      case 7:
        return makeGroupData(7, widget.con.barGraphList.elementAt(7).orders, isTouched: i == touchedIndex);
      case 8:
        return makeGroupData(8, widget.con.barGraphList.elementAt(8).orders, isTouched: i == touchedIndex);
      case 9:
        return makeGroupData(9, widget.con.barGraphList.elementAt(9).orders, isTouched: i == touchedIndex);
      case 10:
        return makeGroupData(10, widget.con.barGraphList.elementAt(10).orders, isTouched: i == touchedIndex);
      case 11:
        return makeGroupData(11, widget.con.barGraphList.elementAt(11).orders, isTouched: i == touchedIndex);
      default:
        return throw Error();
    }
  });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Jan';
                  break;
                case 1:
                  weekDay = 'Feb';
                  break;
                case 2:
                  weekDay = 'Mar';
                  break;
                case 3:
                  weekDay = 'Apr';
                  break;
                case 4:
                  weekDay = 'May';
                  break;
                case 5:
                  weekDay = 'Jun';
                  break;
                case 6:
                  weekDay = 'Jul';
                  break;
                case 7:
                  weekDay = 'Aug';
                  break;

                case 7:
                  weekDay = 'Sep';
                  break;
                case 8:
                  weekDay = 'Oct';
                  break;
                case 10:
                  weekDay = 'Nov';
                  break;
                case 11:
                  weekDay = 'Dec';
                  break;


                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) =>
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'Jan';
              case 1:
                return 'Feb';
              case 2:
                return 'Mar';
              case 3:
                return 'Apr';
              case 4:
                return 'May';
              case 5:
                return 'Jun';
              case 6:
                return 'Jul';
              case 7:
                return 'Aug';
              case 8:
                return 'Sep';
              case 9:
                return 'Oct';
              case 10:
                return 'Nov';
              case 11:
                return 'Dec';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) =>
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'Jan';
              case 1:
                return 'Feb';
              case 2:
                return 'Mar';
              case 3:
                return 'Apr';
              case 4:
                return 'May';
              case 5:
                return 'Jun';
              case 6:
                return 'Jul';
              case 7:
                return 'Aug';
              case 8:
                return 'Sep';
              case 9:
                return 'Oct';
              case 10:
                return 'Nov';
              case 11:
                return 'Dec';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(12, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 1:
            return makeGroupData(1, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData(2, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 3:
            return makeGroupData(3, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 4:
            return makeGroupData(4, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 5:
            return makeGroupData(5, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 6:
            return makeGroupData(6, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 7:
            return makeGroupData(7, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 8:
            return makeGroupData(8, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 9:
            return makeGroupData(9, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 10:
            return makeGroupData(10, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 11:
            return makeGroupData(11, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);

          default:
            return throw Error();
        }
      }),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }
}
/* barchart 2 end */








/* start line chart */

class LineChartSample1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: [
              Color(0xff2c274c),
              Color(0xff46426c),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 37,
                ),
                 Text(
                  setting.value.appName,
                  style: TextStyle(
                    color: Color(0xff827daa),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Monthly Sales',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 37,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: LineChart(
                      isShowingMainData ? sampleData1() : sampleData2(),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
              ),
              onPressed: () {
                setState(() {
                  isShowingMainData = !isShowingMainData;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'SEPT';
              case 7:
                return 'OCT';
              case 12:
                return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 14,
      maxY: 4,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
      ],
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 2.8),
        FlSpot(7, 1.2),
        FlSpot(10, 2.8),
        FlSpot(12, 2.6),
        FlSpot(13, 3.9),
      ],
      isCurved: true,
      colors: [
        const Color(0xffaa4cfc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );
    final lineChartBarData3 = LineChartBarData(
      spots: [
        FlSpot(1, 2.8),
        FlSpot(3, 1.9),
        FlSpot(6, 3),
        FlSpot(10, 1.3),
        FlSpot(13, 2.5),
      ],
      isCurved: true,
      colors: const [
        Color(0xff27b6fc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
      lineChartBarData2,
      lineChartBarData3,
    ];
  }

  LineChartData sampleData2() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'SEPT';
              case 7:
                return 'OCT';
              case 12:
                return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
              case 5:
                return '6m';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 0,
      maxX: 14,
      maxY: 6,
      minY: 0,
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    return [
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 1.8),
          FlSpot(7, 5),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x444af699),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
        isCurved: true,
        colors: const [
          Color(0x99aa4cfc),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: true, colors: [
          const Color(0x33aa4cfc),
        ]),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, 3.8),
          FlSpot(3, 1.9),
          FlSpot(6, 5),
          FlSpot(10, 3.3),
          FlSpot(13, 4.5),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x4427b6fc),
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
    ];
  }
}


/* end linechart */






















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
                      '${widget.showData}',
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
  const SideCard(
      {Key key, this.animationController, this.animation, this.dashboardData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 28,
                                          height: 28,
                                          child: Image.asset(
                                              "assets/img/cod.png"),
                                        ),
                                        Container(
                                          width:size.width>769 ? 200 :90,
                                          padding: const EdgeInsets.only(
                                              left: 4, bottom: 3),
                                          child: Text(
                                              Helper.pricePrint(dashboardData.totalEarnCod),
                                              overflow: TextOverflow.fade,softWrap: true,
                                              maxLines: 1,
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
                                      fontSize: 12,
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
                            S.of(context).vendor,
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
                              dashboardData.vendorNew.toString(),
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
                                S.of(context).users,
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
                                  dashboardData.userNew.toString(),
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
                                S.of(context).driver,
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
                                  dashboardData.driverNew.toString(),
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
    bodyText1: body2,
    bodyText2: body1,
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






















