import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/elements/OrderBoxLayoutTakeawayWidget.dart';
import 'package:login_and_signup_web/src/pages/searchbox_order.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/repository/secondary_repository.dart' as secondaryRepo;
import '../controllers/order_controller.dart';
import '../helpers/helper.dart';
import '../models/excel_export.dart';

class OrdersTakeaway extends StatefulWidget {
  @override
  _OrdersTakeawayState createState() => _OrdersTakeawayState();
}

class _OrdersTakeawayState extends StateMVC<OrdersTakeaway> with SingleTickerProviderStateMixin {
  TabController _tabController;
  OrderController _con;
  _OrdersTakeawayState() : super(OrderController()) {
    _con = controller;
  }
  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ExcelExportModel> excelProperty = <ExcelExportModel>[
      ExcelExportModel(title: S.of(context).order_id, columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).name, columnWidth: 20.82, bold: true),
      ExcelExportModel(title: S.of(context).status, columnWidth: 12.82, bold: true),
      ExcelExportModel(title: S.of(context).item_total, columnWidth: 12.82, bold: true),
      ExcelExportModel(title: S.of(context).total, columnWidth: 12.82, bold: true),
      ExcelExportModel(title: S.of(context).date, columnWidth: 15.82, bold: true),

    ];
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: 0),
      child: Column(
        children: [
          // give the tab bar a height [can change hheight to preferred height]

          Container(
            color: Theme.of(context).primaryColor.withOpacity(0.6),
            child: Container(
              margin: EdgeInsets.only(
                  left: 20.0, top: 40.0, right: 20, bottom: 10.0),
              child: Wrap(alignment: WrapAlignment.spaceBetween, children: [
                Div(
                    colS: 9,
                    colM: 8,
                    colL: 8,
                    child: Wrap(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(S.of(context).takeaway_orders,
                            style: Theme.of(context).textTheme.headline4),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () async {
                          int row =  _con.orderList.length;
                          int col = excelProperty.length;
                          // ignore: deprecated_member_use
                          var twoDList = List.generate(row, (i) => List(col), growable: false);
                          int i = 0;
                          _con.orderList.forEach((element) {
                            twoDList[i][0] = element.orderId;
                            twoDList[i][1] = element.username;
                            twoDList[i][3] = element.status;
                            twoDList[i][4] = element.itemTotal.toString();
                            twoDList[i][5] = Helper.pricePrint(element.price);
                            twoDList[i][6] = element.date;
                            i++;
                          });


                          secondaryRepo.createExcel(excelProperty, twoDList,'order','xl');
                        },
                        child: Padding(
                            padding: EdgeInsets.only(left: 8, top: 8),
                            child: Image(
                                image: AssetImage('assets/img/excel.png'),
                                width: 25,
                                height: 25)),
                      ),
                      SizedBox(width: 10),
                    ])),
                Div(
                  colS: 3,
                  colM: 4,
                  colL: 4,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Container(
                          padding: EdgeInsets.only(right: size.width > 769 ? 30 :0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SearchBoxOrder(pageType: 'takeaway',)));
                        },
                        icon: Icon(Icons.search,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ]),
                ),
              ]),
            ),
          ),

          Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.6),
            ),
            child: TabBar(
              controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicatorWeight: 2.0,
              isScrollable: true,
              indicatorColor: Color(0xFF5e078e),
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.teal,
              tabs: [
                // first tab [you can add an icon using the icon property]
                Tab(
                    child: Container(
                  child: Text(S.of(context).new_orders,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                )),

                // second tab [you can add an icon using the icon property]
                Tab(
                    child: Container(
                  child: Text(S.of(context).prepared,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                )),
                Tab(
                    child: Container(
                  child: Text(S.of(context).packed,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                )),

                // second tab [you can add an icon using the icon property]

                Tab(
                    child: Container(
                  child: Text(S.of(context).delivered,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                )),

                // second tab [you can add an icon using the icon property]
                Tab(
                    child: Container(
                  child: Text(S.of(context).cancelled,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                )),
              ],
            ),
          ),
          // tab bar view here
          SizedBox(height: 5),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                OrderBoxLayoutTakeawayWidget(tabTab: 'Placed', con: _con,),
                OrderBoxLayoutTakeawayWidget(tabTab: 'Accepted', con: _con),
                OrderBoxLayoutTakeawayWidget(tabTab: 'Packed', con: _con),
                OrderBoxLayoutTakeawayWidget(tabTab: 'Delivered', con: _con),
                OrderBoxLayoutTakeawayWidget(tabTab: 'Cancelled', con: _con),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
