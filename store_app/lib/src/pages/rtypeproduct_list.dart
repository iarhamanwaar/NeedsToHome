import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/product_controller.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/elements/productTabWidget.dart';
import 'package:login_and_signup_web/src/models/product.dart';
import 'package:login_and_signup_web/src/pages/searchbox_product.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:vrouter/vrouter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/excel_export.dart';
import '../models/product.dart';import 'package:login_and_signup_web/src/repository/secondary_repository.dart' as secondaryRepo;


class RTypeProductList extends StatefulWidget {
  @override
  _RTypeProductListState createState() => _RTypeProductListState();
}

class _RTypeProductListState extends StateMVC<RTypeProductList>
    with SingleTickerProviderStateMixin {
  ProductController _con;

  _RTypeProductListState() : super(ProductController()) {
    _con = controller;
  }
  //TabController _tabController;
  bool isSwitched = false;

  bool status = false;
  @override
  void initState() {
    super.initState();
    _con.listenForProductsByCategory('Itemproduct');
    // _tabController = TabController(length: 3, vsync: this);
  }

  tabMaker() {
    // ignore: deprecated_member_use
    List<Tab> tabs = List();

    _con.category_products.forEach((element) {
      tabs.add(Tab(
        text: element.categoryName,
      ));
    });
    return tabs;
  }

  @override
  void dispose() {
    super.dispose();
    // _tabController.dispose();
  }

  callback(details) {
    setState(() {
      _con.category_products.forEach((element) {
        element.productdetails.remove(details);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ExcelExportModel> excelProperty = <ExcelExportModel>[
      ExcelExportModel(title: 'Product Id', columnWidth: 12.82, bold: true),
      ExcelExportModel(title: S.of(context).category, columnWidth: 16.82, bold: true),
      ExcelExportModel(title: S.of(context).product_title, columnWidth: 30.82, bold: true),
      ExcelExportModel(title: S.of(context).from_time, columnWidth: 12.82, bold: true),
      ExcelExportModel(title: S.of(context).to_time, columnWidth: 12.82, bold: true),
    ];
    return _con.category_products.isEmpty
        ? EmptyOrdersWidget()
        : DefaultTabController(
            length: _con.category_products.length,
            child: Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: Column(
                children: [
                  // give the tab bar a height [can change hheight to preferred height]

                  Container(
                    color: Theme.of(context).primaryColor.withOpacity(0.6),
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 20.0, top: 40.0, right: 20, bottom: 10.0),
                      child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Div(
                                colS: 6,
                                colM: 6,
                                colL: 6,
                                child: Wrap(children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 7),
                                    child: Text(S.of(context).items,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4),
                                  ),
                                  SizedBox(width: 10),
                                  InkWell(
                                    onTap: () async {
                                      int row = 0;
                                      _con.category_products.forEach((element) {
                                        row += element.productdetails.length;

                                    });
                                      print('row$row');
                                      int col = excelProperty.length;
                                      // ignore: deprecated_member_use
                                      var twoDList = List.generate(row, (i) => List(col), growable: false);
                                      int i = 0;
                                      _con.category_products.forEach((element) {

                                        element.productdetails.forEach((element1) {
                                          twoDList[i][0] = element.id;
                                          twoDList[i][1] = element.categoryName;
                                          twoDList[i][2] = element1.product_name;
                                          twoDList[i][3] = element1.fromTime;
                                          twoDList[i][4] = element1.toTime;
                                          i++;
                                          print(i);
                                        });
                                      });


                                      secondaryRepo.createExcel(excelProperty, twoDList,'product','xl');
                                    },
                                    child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 8, top: 8),
                                        child: Image(
                                            image: AssetImage(
                                                'assets/img/excel.png'),
                                            width: 25,
                                            height: 25)),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    height: 30.0,
                                    width: 30.0,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      color: Colors.white,
                                      icon: const Icon(Icons.add),
                                      iconSize: 30.0,
                                      //color: Palette.facebookBlue,
                                      onPressed: () {
                                        // AddSubCategoryHelper.exit(context,_con,SubCategoryListModel(), 'add');

                                        VRouter.of(context).to('/add_item');
                                      },
                                    ),
                                  )
                                ])),
                            Div(
                              colS: 6,
                              colM: 6,
                              colL: 6,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 30),
                                      child: IconButton(
                                        onPressed: () {

                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchBoxProduct(productDetails: _con.productSearchList,con:_con,pageType: 'Itemproduct',)));
                                        },
                                        icon: Icon(Icons.search,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
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
                        color: Theme.of(context).primaryColor.withOpacity(0.6)),
                    child: TabBar(
                      // controller: _tabController,
                      // give the indicator a decoration (color and border radius)
                      indicatorWeight: 2.0,
                      isScrollable: true,
                      indicatorColor: Theme.of(context).colorScheme.secondary,
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.teal,
                      tabs: tabMaker(),
                    ),
                  ),
                  // tab bar view here
                  SizedBox(height: 5),
                  Expanded(
                    child: TabBarView(
                      // controller: _tabController,
                      children: List.generate(
                        _con.category_products.length,
                        (index) {
                          Product _productDetails =
                              _con.category_products.elementAt(index);

                          return ProductTabs(
                            productDetails: _productDetails.productdetails,
                            con: _con,
                            pageType: 'Itemproduct',
                            callback: this.callback,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
