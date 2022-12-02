import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/controllers/order_controller.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/payment_report.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';
class Report extends StatefulWidget {
  Report({Key key}) : super(key: key);
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends StateMVC<Report>  {
  OrderController _con;
  _ReportState() : super(OrderController()) {
    _con = controller;
  }





  int touchedIndex;
  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: _con.totalPaid,
            title: Helper.pricePrint(_con.summaryData.totalPaid),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColorLight),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: _con.totalDue,
            title: Helper.pricePrint(_con.summaryData.totalDue),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColorLight),
          );

        default:
          return null;
      }
    });
  }


  List<DatatableHeader> _headers = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Invoice ID",
        value: "invoiceID",
        show: true,
        flex: 2,
        sortable: true,
        editable:false,
        textAlign: TextAlign.left),
    DatatableHeader(
  text: "Item Amount",
  value: "itemAmount",
  show: true,
  sortable: true,
  textAlign: TextAlign.left,
      sourceBuilder: (value, row) {

        return Container(child:Text(Helper.pricePrint(value)));},
        ),

    DatatableHeader(
        text: "Settlement Value",
        value: "settlementAmount",
        show: true,
        sortable: true,

        sourceBuilder: (value, row) {

          return Container(child:Text(Helper.pricePrint(value)));},
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "Commission",
        value: "commission",
        show: true,
        sortable: true,
  sourceBuilder: (value, row) {

  return Container(child:Text(Helper.pricePrint(value)));},
        textAlign: TextAlign.left),
        
    DatatableHeader(
        text: "Payment Method",
        value: "paymentMethod",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Payment Status",
        value: "status",
        show: true,
        sortable: true,
        textAlign: TextAlign.left,
      sourceBuilder: (value, row) {

        return Container(

          child: Wrap(
            alignment: WrapAlignment.start,
            children: [
              Badge(
                toAnimate: false,
                shape: BadgeShape.square,
                badgeColor: value=='due'?Colors.red:Colors.green,
                borderRadius: BorderRadius.circular(8),
                badgeContent: Text(value, style: TextStyle(color: Colors.white)),
              ),

            ],
          ),
        );
      },),


    DatatableHeader(
        text: "Date",
        value: "date",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Transaction ID",
        value: "transactionID",
        show: true,
        sortable: false,
        textAlign: TextAlign.center),

  ];
  List<int> _perPages = [5, 10, 15, 100];
  int _total = 100;
  int _currentPerPage;
  int _currentPage = 1;
  bool _isSearch = false;
  //List<PaymentReport> _source = <PaymentReport>[];
  // ignore: deprecated_member_use

  // ignore: deprecated_member_use
  List<Map<String, dynamic>> _selecteds = List<Map<String, dynamic>>();


  String _sortColumn;
  bool _sortAscending = true;





  _initData() async {

   // _source.addAll(_generateData(n: 10)); //1000


  }

  @override
  void initState() {
    _con.listenForSummary(currentUser.value.id);
    _con.listenForInvoiceList(currentUser.value.id);
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(
        builder: (ctx, constrains){
      return Scaffold(
        body:Container(
          height: constrains.maxHeight,
          child:Scrollbar(
            isAlwaysShown: true,
          child:SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color:Color(0xFF464646),
                  width:double.infinity,
                  padding: EdgeInsets.only(left:20,top:10),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        children:[

                          Text('Your ${currentUser.value.focusName} Store',style:Theme.of(context).textTheme.caption.merge(TextStyle(color:Colors.white54))),

                          SizedBox(width:10),

                          GestureDetector(
                          onTap: () async{
                            var url;
                            final String _apiToken =
                                'api_token=${currentUser.value.apiToken}';
                            // ignore: deprecated_member_use
                            url = '${GlobalConfiguration().getString('api_base_url')}api_vendor/export_action/sales/${currentUser.value.id}?$_apiToken';
                            if (await canLaunch(url)) {
                            await launch(
                            url,
                            forceSafariVC: false,
                            );
                            }
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
                      ),

                      Text(currentUser.value.shopName,style:Theme.of(context).textTheme.headline5.merge(TextStyle(color:Colors.white))),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  color:Color(0xFF464646),
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:1,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top:20,left:30,bottom:20),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(left:40,right:40),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top:30,),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(S.of(context).todays_revenue,style:Theme.of(context).textTheme.caption.merge(TextStyle(color:Colors.white54))),
                                        SizedBox(height:10),
                                        Text(Helper.pricePrint(_con.summaryData.totalRevenue),style:Theme.of(context).textTheme.headline5.merge(TextStyle(color:Colors.white))),
                                        SizedBox(height:10),
                                        Text('${_con.summaryData.totalOrders} ORDERS',style:Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Colors.white))),

                                      ],
                                    ),
                                    SizedBox(width:70),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(S.of(context).this_month_so_far,style:Theme.of(context).textTheme.caption.merge(TextStyle(color:Colors.white54))),
                                        SizedBox(height:10),
                                        Text(Helper.pricePrint(_con.summaryData.thisMonthRevenue),style:Theme.of(context).textTheme.headline5.merge(TextStyle(color:Colors.white))),
                                        SizedBox(height:10),
                                        Text('${_con.summaryData.thisMonthOrders} ORDERS',style:Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Colors.white))),

                                      ],
                                    ),
                                    SizedBox(width:70),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(S.of(context).total_revenue,style:Theme.of(context).textTheme.caption.merge(TextStyle(color:Colors.white54))),
                                        SizedBox(height:10),
                                        Text(Helper.pricePrint(_con.summaryData.totalPaid),style:Theme.of(context).textTheme.headline5.merge(TextStyle(color:Colors.white))),
                                        SizedBox(height:10),
                                        Text('${_con.summaryData.totalPaidOrders} ORDERS',style:Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Colors.white))),

                                      ],
                                    ),
                                    SizedBox(width:70),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(S.of(context).due_amount,style:Theme.of(context).textTheme.caption.merge(TextStyle(color:Colors.white54))),
                                        SizedBox(height:10),
                                        Text(Helper.pricePrint(_con.summaryData.totalDue),style:Theme.of(context).textTheme.headline5.merge(TextStyle(color:Colors.white))),
                                        SizedBox(height:10),
                                        Text('${_con.summaryData.totalDueOrders} ORDERS',style:Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Colors.white))),

                                      ],
                                    ),

                                  ],
                                ),
                              ),


                              Container(
                                padding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.1),

                                child:Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width:170,height:170,
                                    child: PieChart(
                                      PieChartData(
                                          pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                                            setState(() {
                                              final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent &&
                                                  pieTouchResponse.touchInput is! PointerUpEvent;
                                              if (desiredTouch && pieTouchResponse.touchedSection != null) {
                                                // touchedIndex = pieTouchResponse.touchedSection.touchedSectionIndex;
                                              } else {
                                                touchedIndex = -1;
                                              }
                                            });
                                          }),
                                          borderData: FlBorderData(
                                            show: false,
                                          ),
                                          sectionsSpace: 0,
                                          centerSpaceRadius: 40,
                                          sections: showingSections()),
                                    ),
                                  ),
                                ),
                              ),




                            ],
                          ),
                        );


                      }),
                ),



                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(0),
                  constraints: BoxConstraints(
                    maxHeight: 700,
                  ),
                  child: Card(
                    elevation: 1,
                    shadowColor: Colors.black,
                    clipBehavior: Clip.none,
                    child: ResponsiveDatatable(

                      actions: [
                        if (_isSearch)
                          Expanded(
                              child: TextField(
                                onChanged: (e){


                                   setState((){
                                     _con.source = filterListReport(_con.originalSource, e);
                                   });
                                },
                                decoration: InputDecoration(
                                    prefixIcon: IconButton(
                                        icon: Icon(Icons.cancel),
                                        onPressed: () {
                                          setState(() {
                                            _isSearch = false;
                                          });
                                        }),
                                    suffixIcon: IconButton(
                                        icon: Icon(Icons.search), onPressed: () {})),
                              )),
                        if (!_isSearch)
                          IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                setState(() {
                                  _isSearch = true;
                                });
                              })
                      ],
                      headers: _headers,
                      source: _con.source,
                      selecteds: _selecteds,
                      autoHeight: false,
                      onTabRow: (data) {
                        print(data);
                      },
                      onSort: (value) {
                        setState(() {
                          _sortColumn = value;
                          _sortAscending = !_sortAscending;
                          if (_sortAscending) {
                            _con.source.sort((a, b) =>
                                b["$_sortColumn"].compareTo(a["$_sortColumn"]));
                          } else {
                            _con.source.sort((a, b) =>
                                a["$_sortColumn"].compareTo(b["$_sortColumn"]));
                          }
                        });
                      },
                      sortAscending: _sortAscending,
                      sortColumn: _sortColumn,
                      isLoading: _con.isLoading,

                      footers: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("Rows per page:"),
                        ),
                        if (_perPages != null)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: DropdownButton(
                                value: _currentPerPage,
                                items: _perPages
                                    .map((e) => DropdownMenuItem(
                                  child: Text("$e"),
                                  value: e,
                                ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _currentPerPage = value;
                                  });
                                }),
                          ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child:
                          Text("$_currentPage - $_currentPerPage of $_total"),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                          ),
                          onPressed: () {
                            setState(() {
                              _currentPage =
                              _currentPage >= 2 ? _currentPage - 1 : 1;
                            });
                          },
                          padding: EdgeInsets.symmetric(horizontal: 15),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios, size: 16),
                          onPressed: () {
                            setState(() {
                              _currentPage++;
                            });
                          },
                          padding: EdgeInsets.symmetric(horizontal: 15),
                        )
                      ],
                    ),
                  ),
                ),



              ],
            ),
          ),
        ),
      ),);

      }));


  }

  filterListReport( List<Map<String, dynamic>> list, String filterString) {

     List<PaymentReport> tempList = list.map<PaymentReport>((json)=>PaymentReport.fromJSON(json)).toList();


    List<PaymentReport> _list = tempList
        .where(( u) =>
    (u.paymentMethod.toLowerCase().contains(filterString.toLowerCase()) || u.invoiceID.toLowerCase().contains(filterString.toLowerCase()) || u.transactionID.toLowerCase().contains(filterString.toLowerCase())) ).toList();
   //  List<Map<String, dynamic>> _result =  _list.cast();
    List<Map<String, dynamic>> _result = _list.map<Map<String, dynamic>>((json)=> Map<String, dynamic>.from(json.toMap()) ).toList();
     print(_result.length);
    return _result;
  }
}
