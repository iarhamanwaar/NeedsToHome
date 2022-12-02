import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/elements/SearchResultsWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/home_controller.dart';
import '../elements/FilterWidget.dart';
import 'ProfilePage.dart';
import 'booking_track1.dart';
import 'vendor_map.dart';
import '../elements/DrawerWidget.dart';
import '../helpers/helper.dart';
import '../pages/home.dart';
import 'orders.dart';

// ignore: must_be_immutable
class PagesWidget extends StatefulWidget  {
  dynamic currentTab;

  Widget currentPage = HomeWidget();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  PagesWidget({
    Key key,
    this.currentTab,
  });
  @override
  _PagesWidgetState createState() {
    return _PagesWidgetState();
  }
}

class _PagesWidgetState extends StateMVC<PagesWidget>{
  initState() {
    super.initState();
    _selectTab(widget.currentTab);
    _con.listenForShopCategories();
  }

  HomeController _con;
  _PagesWidgetState() : super(HomeController()) {
    _con = controller;

  }

  @override
  void didUpdateWidget(PagesWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage = VendorMapWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 1:
          widget.currentPage = SearchResultWidget(parentScaffoldKey: widget.scaffoldKey,pageType: 'bottom');
          break;
        case 2:
          widget.currentPage = HomeWidget(parentScaffoldKey: widget.scaffoldKey,selectTab: _selectTab);
          break;
        case 3:
          widget.currentPage = OrdersWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 4:
          widget.currentPage = ProfilePage();
          break;
        case 5:
          widget.currentPage = BookingTrack1();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,

      child: Scaffold(
        key: widget.scaffoldKey,
        drawer: DrawerWidget(),
        endDrawer: FilterWidget(onFilter: (filter) {
          Navigator.of(context)
              .pushReplacementNamed('/Pages', arguments: widget.currentTab);
        }, mainShopCategories: _con.mainShopCategories, ),

        //backgroundColor: Colors.transparent,
        body: widget.currentPage,
          bottomNavigationBar: StyleProvider(

              style: Style(

              ),
              child:ConvexAppBar(
                height: 75,

            activeColor: widget.currentTab!=2?Theme.of(context).primaryColorDark:Colors.transparent,
                style: TabStyle.custom,
                initialActiveIndex: widget.currentTab,
                  elevation: 0.5,

            backgroundColor: Theme.of(context).primaryColor,
              color:Theme.of(context).hintColor,

            onTap: (int i) {
              this._selectTab(i);
            },
            items: [

              TabItem(

                  icon: Icon(Icons.location_on_outlined,color:widget.currentTab==0? Theme.of(context).primaryColorLight : Theme.of(context).backgroundColor.withOpacity(0.6)),
                  // ignore: deprecated_member_use
                  title: S.of(context).map
              ),
              TabItem(
                  icon: Icon(Icons.search,color:widget.currentTab==1? Theme.of(context).primaryColorLight : Theme.of(context).backgroundColor.withOpacity(0.6)),
                  title: S.of(context).search,
              ),
              TabItem(
                icon: Image(image:AssetImage('assets/img/logo.png'),
                  width:10,height:10,
                ),
                title: S.of(context).home,
              ),
              TabItem(

                  icon:  Icon(Icons.shopping_bag_outlined,color:widget.currentTab==3? Theme.of(context).primaryColorLight : Theme.of(context).backgroundColor.withOpacity(0.6)),
                  title: S.of(context).my_orders
              ),
              TabItem(
                icon: new Icon(Feather.user,color:widget.currentTab==4? Theme.of(context).primaryColorLight : Theme.of(context).backgroundColor.withOpacity(0.6)),
                title:S.of(context).profile,

              ),
            ],



          )
      ),
      ),
    );
  }

}







class Style extends StyleHook {
  @override
  double get activeIconSize => 28;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 20;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(color: color);
  }

}