import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:login_and_signup_web/src/components/custome_switch2.dart';
import 'package:login_and_signup_web/src/elements/OrderBoxLayoutWidget.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/pages/searchbox_order.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/order_controller.dart';
import '../models/excel_export.dart';
import 'package:login_and_signup_web/src/repository/secondary_repository.dart' as secondaryRepo;

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends StateMVC<Orders> with SingleTickerProviderStateMixin {
  TabController _tabController;

  OrderController _con;
  _OrdersState() : super(OrderController()) {
    _con = controller;
  }

  @override

  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    if(GetPlatform.isDesktop){
      Helper.fireBaseDeskTopCon();
    }
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
                        child: Text(S.of(context).order,
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
                            twoDList[i][2] = element.status;
                            twoDList[i][3] = element.itemTotal.toString();
                            twoDList[i][4] = Helper.pricePrint(element.price);
                            twoDList[i][5] = element.date;
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

                      Container(
                          padding: EdgeInsets.only(left: 20, top:7),
                        child:AutoSwitch()
                      )
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
                              builder: (context) => SearchBoxOrder(pageType: 'Orders',)));
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
                  child: Text(S.of(context).shipped,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                )),
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
                OrderBoxLayoutWidget(tabTab: 'Placed', con: _con,),
                OrderBoxLayoutWidget(tabTab: 'Accepted', con: _con,),
                OrderBoxLayoutWidget(tabTab: 'Packed', con: _con,),
                OrderBoxLayoutWidget(tabTab: 'Shipped', con: _con,),
                OrderBoxLayoutWidget(tabTab: 'Delivered', con: _con,),
                OrderBoxLayoutWidget(tabTab: 'Cancelled', con: _con,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class AutoSwitch extends StatefulWidget {
  @override
  _AutoSwitchState createState() => _AutoSwitchState();
}

class _AutoSwitchState extends State<AutoSwitch>   {

  bool isSwitched = false;

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return CustomSwitch2(
      activeColor: Colors.black,
      value: currentUser.value.autoAssign,

      onChanged: (value) {
        if(currentUser.value.autoAssign){
          currentUser.value.autoAssign = false;
        } else {
          currentUser.value.autoAssign = true;
        }
        setCurrentUser(currentUser.value);


      },
    );
  }
}

