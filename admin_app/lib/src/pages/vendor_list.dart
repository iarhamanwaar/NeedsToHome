
import 'package:login_and_signup_web/src/repository/secondary_repository.dart' as secondaryRepo;
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/primaryuser_controller.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/elements/VendorRegisterWidget.dart';
import 'package:login_and_signup_web/src/elements/VendorTabsWidget.dart';
import 'package:login_and_signup_web/src/models/vendorAll.dart';
import 'package:login_and_signup_web/src/pages/searchbox_vendor.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:vrouter/vrouter.dart';
import '../../generated/l10n.dart';
import '../models/excel_export.dart';

class VendorList extends StatefulWidget {
  @override
  _VendorListState createState() => _VendorListState();
}

class _VendorListState extends StateMVC<VendorList>  with SingleTickerProviderStateMixin{
  //TabController _tabController;

  PrimaryUserController _con;
  _VendorListState() : super(PrimaryUserController()) {
    _con = controller;
  }
  bool status = false;
  @override
  void initState() {
    //_tabController = TabController(length: 3, vsync: this);
    super.initState();
    _con.listenForVendor();
  }

  tabMaker() {
    // ignore: deprecated_member_use
    List<Tab> tabs = List();

    _con.vendorList.forEach((element) {
      tabs.add(Tab(
        text: element.shopType,
      ));
    });
    return tabs;
  }


  @override
  void dispose() {
    super.dispose();
    //_tabController.dispose();

  }
  @override
  Widget build(BuildContext context) {
    List<ExcelExportModel> excelProperty = <ExcelExportModel>[
      ExcelExportModel(title: S.of(context).store_id, columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).shop_name, columnWidth: 20.82, bold: true),
      ExcelExportModel(title: S.of(context).shop_type, columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).rating, columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).subtitle, columnWidth: 18.82, bold: true),
      ExcelExportModel(title: S.of(context).email, columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).name, columnWidth: 20.82, bold: true),
      ExcelExportModel(title: S.of(context).company_legal_name, columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).mobile, columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).alter_mobile, columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).address, columnWidth: 30.82, bold: true),
      ExcelExportModel(title: S.of(context).landmark, columnWidth: 20.82, bold: true),
      ExcelExportModel(title: S.of(context).latitude, columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).longitude, columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).opening_time, columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).closing_time, columnWidth: 15.82, bold: true),
      ExcelExportModel(title: 'Business', columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).zone, columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).plan_id, columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).plan_name, columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).status, columnWidth: 12.82, bold: true)
    ];
    return _con.vendorList.isEmpty? EmptyOrdersWidget() : DefaultTabController(
    length:_con.vendorList.length,
     child: Padding(
      padding: EdgeInsets.only(top:0),
      child:Column(
        children: [
          // give the tab bar a height [can change hheight to preferred height]

          Container(
            //color:Colors.white70,
      color:Theme.of(context).primaryColor.withOpacity(0.6),
            child:Container(
              margin: EdgeInsets.only(left: 20.0, top: 40.0, right: 20, bottom: 10.0),

              child:Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children:[
                    Div(
                        colS:9,
                        colM:8,
                        colL:8,
                        child:Wrap(
                            children:[
                              Padding(
                                padding: EdgeInsets.only(top:7),
                                child:Text(
                                    S.of(context).vendor_list,
                                  style: Theme.of(context).textTheme.headline4
                                ),
                              ),
                              SizedBox(width:10),

                              SizedBox(width:10),
                InkWell(
                    onTap:() async {

                      int row =  _con.vendorList.length;
                      int col = excelProperty.length;
                      print('col${excelProperty.length}');
                      // ignore: deprecated_member_use
                      var twoDList = List.generate(row, (i) => List(col), growable: false);
                      int i = 0;
                      _con.vendorList.forEach((element) {
                        element.vendor.forEach((vendor) {
                          twoDList[i][0] = vendor.shopId.toString();
                          twoDList[i][1] = vendor.shopName;
                          twoDList[i][2] = element.shopType;
                          twoDList[i][3] = vendor.rating.toString();
                          twoDList[i][4] = vendor.general.subtitle;
                          twoDList[i][5] = vendor.general.email;
                          twoDList[i][6] = vendor.general.ownerName;
                          twoDList[i][7] = vendor.general.companyLegalName;
                          twoDList[i][8] = vendor.general.mobile;
                          twoDList[i][9] = vendor.general.alterMobile;
                          twoDList[i][10] = vendor.general.pickupAddress;
                          twoDList[i][11] = vendor.general.landmark;
                          twoDList[i][12] = vendor.general.latitude;
                          twoDList[i][13] = vendor.general.longitude;
                          twoDList[i][14] = vendor.general.openingTime;
                          twoDList[i][15] = vendor.general.closingTime;
                          twoDList[i][16] = vendor.general.business;
                          twoDList[i][17] = vendor.general.zoneId;
                          twoDList[i][18] = vendor.planId;
                          twoDList[i][19] = vendor.planName;
                          twoDList[i][20] = vendor.status.toString();
                        });

                        i++;
                      });

                         print(twoDList.length);
                      secondaryRepo.createExcel(excelProperty, twoDList,'vendor');

                    },
                    child: Padding(
                                  padding:EdgeInsets.only(left:8,top:5),
                                  child:Image(image:AssetImage('assets/img/excel.png'),
                                      width:25,height:25
                                  )
                              ),
                ),
                              SizedBox(
                                width: 10,
                              ),
                         /*   Container(
                                margin: EdgeInsets.only(left:10,top:5),
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
                                    AddVendorRegisterHelper.exit(context);
                                  },
                                ),
                              ), */

                              Container(
                                padding: EdgeInsets.only(left:10),
                                  child:IconButton(
                                onPressed: (){

                                  VRouter.of(context).to('/vendormap');
                                },
                                icon:Icon(Icons.location_on,color:Colors.redAccent)
                              ))
                            ]
                        )
                    ),
                    Div(
                      colS:3,
                      colM:4,
                      colL:4,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:[
                            Padding(
                              padding:EdgeInsets.only(right:30),
                              child:IconButton(
                                onPressed:() async {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchBoxVendor(con: _con,vendorList: _con.vendorsearchList,)));
                                },
                                icon:Icon(Icons.search, color: Theme.of(context).colorScheme.secondary),
                              ),
                            ),


                          ]
                      ),
                    ),

                  ]
              ),
            ),
          ),

          Container(
            width: double.infinity,
            height: 45,
            decoration:BoxDecoration(
              //color:Colors.white70,
                color:Theme.of(context).primaryColor.withOpacity(0.6)
            ),
            child: TabBar(
             // controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicatorWeight: 2.0,
              isScrollable: true,
              indicatorColor: Color(0xFF5e078e),
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.teal,
              tabs: tabMaker()
            ),
          ),
          // tab bar view here
          SizedBox(height:5),
          Expanded(
            child: TabBarView(
             // controller: _tabController,
              children: List.generate(
                _con.vendorList.length,
                    (index) {
                  VendorAllModel _vendorDetails =_con.vendorList.elementAt(index);

                  return  VendorTabsWidget(type: 1,vendorList: _vendorDetails.vendor,con: _con,);
                },
              ),

            ),
          ),
        ],
      ),
     ),
    );



  }



}
class AddVendorRegisterHelper {
  static exit(context) => showDialog(context: context, builder: (context) => VendorRegisterForm());
}


