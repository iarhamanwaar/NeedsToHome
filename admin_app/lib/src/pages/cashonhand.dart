import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/elements/CashOnHandWidget.dart';
import 'package:login_and_signup_web/src/models/cashonhand.dart';
import 'package:login_and_signup_web/src/pages/cinhistory.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

class CashOnHandPage extends StatefulWidget {
  @override
  _CashOnHandPageState createState() => _CashOnHandPageState();
}

class _CashOnHandPageState extends StateMVC<CashOnHandPage> with SingleTickerProviderStateMixin {




  List<CashOnHandModel> itemList = <CashOnHandModel>[];
  bool isSwitched = false;
  bool status = false;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 30.0, top: 25.0, right: 30, bottom: 10.0),
              child: Wrap(alignment: WrapAlignment.spaceBetween, children: [
                Div(
                    colS: 6,
                    colM: 6,
                    colL: 6,
                    child: Wrap(alignment: WrapAlignment.start, children: [
                      Text(
                        'Cash on Hand',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),

                      SizedBox(
                        width: 10,
                      ),
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CinHistory()));
                      }, icon: Icon(Icons.history_outlined),tooltip: 'S.of(context).history')
                    ])),
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.6)),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicatorWeight: 2.0,
                isScrollable: true,
                indicatorColor: Color(0xFF5e078e),
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.teal,
                tabs: [
                  Tab(
                      child: Container(
                        child: Text(S.of(context).driver, style: TextStyle(fontWeight: FontWeight.w600)),
                      )),
                  Tab(
                      child: Container(
                        child: Text(S.of(context).provider, style: TextStyle(fontWeight: FontWeight.w600)),
                      )),
                ],
              ),
            ),
            // tab bar view here
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  DriverCashOnHandWidget(pageType: 'driver'),
                  DriverCashOnHandWidget(pageType: 'provider'),
                ],
              ),
            ),
          ],
        ));
  }
}
