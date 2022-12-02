import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/repository/secondary_repository.dart' as secondaryRepo;
import 'package:login_and_signup_web/src/controllers/product_controller.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/elements/productTabWidget.dart';
import 'package:login_and_signup_web/src/models/product.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:vrouter/vrouter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import '../models/excel_export.dart';
import '../models/product.dart';
import 'searchbox_product.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends StateMVC<ProductList>
    with SingleTickerProviderStateMixin {
  ProductController _con;

  _ProductListState() : super(ProductController()) {
    _con = controller;
  }
  //TabController _tabController;
  bool isSwitched = false;

  bool status = false;
  @override
  void initState() {
    super.initState();
    _con.listenForProductsByCategory('product');
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
      ExcelExportModel(title: 'Product Id', columnWidth: 15.82, bold: true),
      ExcelExportModel(title: '${S.of(context).category} id', columnWidth: 20.82, bold: true),
      ExcelExportModel(title: S.of(context).category, columnWidth: 12.82, bold: true),
      ExcelExportModel(title: S.of(context).product_title, columnWidth: 12.82, bold: true),
      ExcelExportModel(title: S.of(context).description, columnWidth: 12.82, bold: true),

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
                                    child: Text(S.of(context).product,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4),
                                  ),
                                  SizedBox(width: 10),
                                  InkWell(
                                    onTap: () async {
                                      int row =  _con.category_products.length;
                                      int col = excelProperty.length;
                                      // ignore: deprecated_member_use
                                      var twoDList = List.generate(row, (i) => List(col), growable: false);
                                      int i = 0;
                                      _con.category_products.forEach((element) {
                                        twoDList[i][0] = element.id;
                                        twoDList[i][1] = element.categoryName;
                         element.productdetails.forEach((element1) {
                                          twoDList[i][3] = element1.product_name;
                                          twoDList[i][4] = element1.description;
                                        });
                                        i++;
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
                                        if(_con.category_products.length==int.parse(currentUser.value.productLimit)){
                                          return showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) => AlertDialog(
                                              title: const Text('Upgrade Your Plan',style: TextStyle(color: Colors.red),),
                                              content: const Text('You Have Reached Your Product Limit'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context, 'OK'),
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                        else{
                                          VRouter.of(context)
                                              .to('/add_product');
                                        }
                                      },
                                    ),
                                  )
                                ])),
                           /* Div(
                              colS: 6,
                              colM: 6,
                              colL: 6,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                    IconButton(
                                      onPressed: (){},
                                      icon: Icon(Icons.apps_outlined),
                                    ),
                                    IconButton(
                                      onPressed: (){},
                                      icon: Icon(Icons.list),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(right: 30),
                                      child: IconButton(
                                        onPressed: () {

                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SearchBoxProduct(con:_con,productDetails:_con.productSearchList,pageType: 'product',
                                                        callback: this.callback,)));
                                        },
                                        icon: Icon(Icons.search,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                      ),
                                    ),
                                  ]),
                            ), */
                            Div(
                              colS:6,
                              colM:6,
                              colL:6,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children:[

                                    Padding(
                                      padding:EdgeInsets.only(right:30),
                                      child:IconButton(
                                        onPressed:(){
                                          setState(() {
                                            _con.listenForProductsByCategory('product');
                                          });
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchBoxProduct(productDetails: _con.productSearchList,con:_con,pageType: 'product',)));
                                          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchBoxOrder()));
                                        },
                                        icon:Icon(Icons.search, color: Theme.of(context).colorScheme.secondary),
                                      ),
                                    ),


                                  ]
                              ),
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
                            pageType: 'product',
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
