import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/repository/secondary_repository.dart' as secondaryRepo;
import 'package:login_and_signup_web/src/elements/OrderBoxLayoutTakeawayWidget.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/order_controller.dart';
import '../elements/ordersearch_box.dart';
import '../helpers/helper.dart';
import '../models/excel_export.dart';

class OrdersListTakeaway extends StatefulWidget {
  String pageType;
  OrdersListTakeaway({Key key, this.pageType}) : super(key: key);
  @override
  _OrdersListTakewayState createState() => _OrdersListTakewayState();
}

class _OrdersListTakewayState extends StateMVC<OrdersListTakeaway>{

  OrderController _con;
  _OrdersListTakewayState() : super(OrderController()) {
    _con = controller;
  }


  @override
  void initState() {


    super.initState();
  }

  @override
  void dispose() {
    super.dispose();


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

    return Padding(
      padding: EdgeInsets.only(top:0),
      child:SingleChildScrollView(
        child: Column(
          children: [
            // give the tab bar a height [can change hheight to preferred height]

            Container(
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
                                      '${S.of(context).takeaway} -  (${widget.pageType})',
                                      style: Theme.of(context).textTheme.headline4
                                  ),
                                ),
                                SizedBox(width:10),


                                InkWell(
                                  onTap: () async{
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
                                  child:Padding(
                                      padding:EdgeInsets.only(left:8,top:8),
                                      child:Image(image:AssetImage('assets/img/excel.png'),
                                          width:25,height:25
                                      )
                                  ),
                                ),
                                SizedBox(width:10),


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
                                  onPressed:(){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchBoxOrder(pageType: 'takeaway',)));
                                    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchBoxOrder()));
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




                  SizedBox(height:5),
                  OrderBoxLayoutTakeawayWidget(tabTab: widget.pageType,con: _con),






          ],
        ),
      ),
    );



  }
}
