import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/elements/AEBannerWidget.dart';
import 'package:login_and_signup_web/src/elements/WalletTranscationListWidget.dart';
import 'package:login_and_signup_web/src/models/vendorwallet.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
class WalletWidget extends StatefulWidget {
  @override
  _WalletWidgetState createState() => _WalletWidgetState();
}

class _WalletWidgetState extends StateMVC<WalletWidget>
    with SingleTickerProviderStateMixin {


  TabController _tabController;
  bool isSwitched = false;
  bool status = false;
  List<VendorWallet> vendorList=<VendorWallet>[];
  List<VendorWallet> providerList=<VendorWallet>[];
  List<VendorWallet> driverList=<VendorWallet>[];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 30.0, top: 25.0, right: 30, bottom: 10.0),
            child:Wrap(
                alignment: WrapAlignment.spaceBetween,
                children:[
                  Div(
                      colS:6,
                      colM:6,
                      colL:6,
                      child:Wrap(
                          alignment: WrapAlignment.start,
                          children:[
                            Text(
                              S.of(context).vendor_wallet,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            SizedBox(width:10),
                          ]
                      )
                  ),
                ]
            ),
          ),

          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.6)),
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
                      child: Text(S.of(context).vendor_transaction,
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    )),
                Tab(
                    child: Container(
                      child: Text(S.of(context).provider_transaction,
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    )),
                Tab(
                    child: Container(
                      child: Text(S.of(context).driver_transaction,
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
                WalletTransactionListWidget(type: 'vendor'),

                WalletTransactionListWidget(type: 'provider'),
                WalletTransactionListWidget(type: 'driver'),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddBannerHelper {
  static exit(context, con, details, pageType) => showDialog(
      context: context,
      builder: (context) => AEBannerWidget(
        con: con,
        details: details,
        pageType: pageType,
      ));
}

class ProjectProgressCard extends StatefulWidget {
  final Color color;
  final Color progressIndicatorColor;
  final String projectName;
  final String percentComplete;
  final IconData icon;
  ProjectProgressCard({
    this.color,
    this.progressIndicatorColor,
    this.percentComplete,
    this.projectName,
    this.icon,
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
          width: 200,
          padding: EdgeInsets.only(top:20,bottom:20,right:18,left:18),
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [



                  Expanded(
                    child:Container(
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text(
                                widget.projectName,
                                style:hovered ? Theme.of(context).textTheme.bodyText1.merge(TextStyle(fontWeight:FontWeight.w700,color:Theme.of(context).primaryColorLight)) : Theme.of(context).textTheme.bodyText1.merge(TextStyle(fontWeight:FontWeight.w700,)),
                                /*style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: hovered ? Colors.white : Colors.black,
                      ),*/
                              ),

                              Text('8599957',
                                style: hovered ? Theme.of(context).textTheme.caption.merge(TextStyle(color:Theme.of(context).primaryColorLight)) : Theme.of(context).textTheme.caption,
                              )
                            ]
                        )

                    ),),
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
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                  children:[
                    Expanded( child:RichText(
                      text: new TextSpan(text: '12.220. ',
                          style:hovered ? Theme.of(context).textTheme.bodyText1.merge(TextStyle(color:Theme.of(context).primaryColorLight)) : Theme.of(context).textTheme.bodyText1,
                          children: [
                            new TextSpan(
                              text: '56 \$',
                              style:hovered ? Theme.of(context).textTheme.caption.merge(TextStyle(color:Theme.of(context).primaryColorLight)) : Theme.of(context).textTheme.caption,
                            )
                          ]),
                    ),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child:InkWell(
                            child:Icon(Icons.more_vert,color:Theme.of(context).disabledColor)
                        )
                    )

                  ]
              ),


            ],
          ),

        ),
      ),
    );
  }
}
