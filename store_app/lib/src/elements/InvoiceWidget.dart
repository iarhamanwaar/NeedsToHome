
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:login_and_signup_web/src/controllers/order_controller.dart';
import 'package:login_and_signup_web/src/elements/AddonViewWidget.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/addon2.dart';
import 'package:login_and_signup_web/src/models/cart_responce.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/pages/a4printer.dart';
import 'package:login_and_signup_web/src/pages/slip.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'EmptyOrdersWidget.dart';

// ignore: must_be_immutable
class InvoiceWidget extends StatefulWidget {
  InvoiceWidget({Key key, this.orderID}) : super(key: key);
  int orderID;
  @override
  _InvoiceWidgetState createState() => _InvoiceWidgetState();
}

class _InvoiceWidgetState extends StateMVC<InvoiceWidget> {
  OrderController _con;
  double addonPrice = 0;
  _InvoiceWidgetState() : super(OrderController()) {
    _con = controller;
  }

  int i = 0;
  String id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _con.listenForInvoiceDetails(widget.orderID);
  }

  @override
  Widget build(BuildContext context) {
    //  id = VRouter.of(context).pathParameters['id']??0;

    return _con.invoiceDetailsData.productDetails.isEmpty
        ? EmptyOrdersWidget()
        : Scrollbar(
            isAlwaysShown: true,
            child: ListView(scrollDirection: Axis.vertical, children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                child: Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20.0,
                          spreadRadius: 5.0,
                        ),
                      ]),
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back),
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(S.of(context).invoice,
                                  style: Theme.of(context).textTheme.headline6),
                            ),
                            Text('Order#${widget.orderID}')
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey[200])))),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(S.of(context).billed_to,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                  SizedBox(height: 4),
                                  Text(_con
                                      .invoiceDetailsData.addressShop.username),
                                  SizedBox(height: 4),
                                  Text(_con
                                      .invoiceDetailsData.addressShop.phone),
                                  SizedBox(height: 4),
                                  Text(_con.invoiceDetailsData.addressShop
                                      .addressSelect),
                                  SizedBox(height: 4),
                                ],
                              ),
                            )),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1),
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(S.of(context).shipped_to,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                    SizedBox(height: 4),
                                    Text(_con.invoiceDetailsData.addressUser
                                        .username),
                                    SizedBox(height: 4),
                                    Text(_con
                                        .invoiceDetailsData.addressUser.phone),
                                    SizedBox(height: 4),
                                    Text(
                                      _con.invoiceDetailsData.addressUser
                                          .addressSelect,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(S.of(context).payment_method,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                  SizedBox(height: 4),
                                  Text(_con.invoiceDetailsData.payment.method),
                                ],
                              ),
                            )),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(S.of(context).order_date,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                  SizedBox(height: 4),
                                  Text(_con.invoiceDetailsData.orderDate),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 40),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(S.of(context).order_summary,
                                style: Theme.of(context).textTheme.headline6),
                            SizedBox(height: 5),
                            Text(S.of(context).all_itmes_here_cannot_be_deleted,
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                        Row(children: [
                          Expanded(
                              child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            reverse: false,
                            child: DataTable(
                              showCheckboxColumn: true,
                              headingTextStyle:
                                  Theme.of(context).textTheme.bodyText1,
                              columns: [
                                DataColumn(label: Text('#')),
                                DataColumn(
                                  label: Text(S.of(context).item),
                                ),
                                DataColumn(label: Text('${S.of(context).variant} / ${S.of(context).addon}')),
                                DataColumn(label: Text(S.of(context).quantity)),
                                DataColumn(label: Text(S.of(context).total)),
                              ],
                              rows: _con.invoiceDetailsData.productDetails
                                  .map((CartResponce map) {

                                i++;


                                double itemTotal =
                                    double.parse(map.price) * map.qty +
                                        (addonPrice * map.qty);

                                return new DataRow(cells: [
                                  DataCell(Text(i.toString())),

                                  DataCell(

                                      Row(children:[
                                        SizedBox(height: 100,),
                                        Container(
                                            height: 50,width: 70,
                                            decoration:BoxDecoration(
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            padding:EdgeInsets.only(top:5,right: 10),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.network(map.image,
                                                height: 90,width: double.infinity,fit: BoxFit.fill,
                                              ),
                                            )
                                        ),
                                        Expanded(
                                            child:Container(
                                                child:Text('${map.product_name}')
                                            )
                                        )
                                      ])

                                  ),
                                  DataCell(
                                    Wrap(
                                      children:[

                                    Container(
                                      padding:EdgeInsets.only(top:12),
                                      child:currentUser.value.shopTypeId!=2?Text('${map.variantValue} ${map.unit}'):Text('${map.quantity} ${map.unit}',
                                       ),),
                                        map.addon.length>0?IconButton(
                                          onPressed: (){
                                            addonView(map.addon);
                                          },
                                          icon: Icon(Icons.lunch_dining,color:Colors.brown,size:18),
                                        ):Container(),
                                      ]
                                    ),

                                  ),
                                  DataCell(Text('x ${map.qty.toString()}')),
                                  DataCell(Text(Helper.pricePrint(itemTotal))),
                                ]);
                              }).toList(),
                            ),
                          ))
                        ]),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Responsive(children: [
                              Div(
                                  colS: 12,
                                  colM: 12,
                                  colL: 12,
                                  child: Column(children: [
                                    Wrap(
                                      children: [
                                        Div(
                                          colS: 5,
                                          colM: 5,
                                          colL: 7,
                                          child: Container(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                _con.invoiceDetailsData.couponData.title!=''?Text('Coupon applied! code ${_con.invoiceDetailsData.couponData.code}',style:Theme.of(context).textTheme.headline6.merge(TextStyle(color: Colors.green))):Container(),
                                                _con.invoiceDetailsData.couponData.title!=''? Text(_con.invoiceDetailsData.couponData.title,style:Theme.of(context).textTheme.caption):Container(),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Div(
                                          colS: 7,
                                          colM: 7,
                                          colL: 5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              /** Text('Subtotal',style:Theme.of(context).textTheme.caption),
                                                          Text(Helper.pricePrint(_con.invoiceDetailsData.payment.sub_total),
                                                              textDirection: TextDirection.rtl,
                                                              style:Theme.of(context).textTheme.headline1),
                                                          SizedBox(height:6),
                                                          Text('Shipping',style:Theme.of(context).textTheme.caption),
                                                          SizedBox(height:10),
                                                          Text(Helper.pricePrint(_con.invoiceDetailsData.payment.grand_total),
                                                              textDirection: TextDirection.rtl,
                                                              style:Theme.of(context).textTheme.headline1), */
                                              SizedBox(height: 10),
                                              Container(
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              width: 1,
                                                              color:
                                                                  Colors.grey[
                                                                      100])))),
                                              SizedBox(height: 10),

                                          Container(
                                            child:Wrap(
                                              children: [
                                                Text('Packaging charges',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption),
                                                SizedBox(width: 10),
                                                Text(
                                                    Helper.pricePrint(_con
                                                        .invoiceDetailsData
                                                        .payment
                                                        .packingCharge,
                                                    ),
                                                  style: Theme.of(context).textTheme.caption.merge(TextStyle(color:Theme.of(context).backgroundColor)),
                                                ),
                                              ],
                                            )
                                          ),
                                              SizedBox(height: 10),
                                              Container(
                                                  child:Wrap(
                                                    children: [
                                                      Text(S.of(context).delivery_fees,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .caption),
                                                      SizedBox(width: 10),
                                                      Text(
                                                          Helper.pricePrint(_con
                                                              .invoiceDetailsData
                                                              .payment
                                                              .delivery_fees),
                                                        style: Theme.of(context).textTheme.caption.merge(TextStyle(color:Theme.of(context).backgroundColor)),
                                                      ),
                                                    ],
                                                  )
                                              ),
                                              SizedBox(height: 10),
                                              Container(
                                                  child:Wrap(
                                                    children: [
                                                      Text(S.of(context).tips,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .caption),
                                                      SizedBox(width: 10),
                                                      Text(
                                                          Helper.pricePrint(_con
                                                              .invoiceDetailsData
                                                              .payment
                                                              .delivery_tips),
                                                        style: Theme.of(context).textTheme.caption.merge(TextStyle(color:Theme.of(context).backgroundColor)),
                                                      ),
                                                    ],
                                                  )
                                              ),



                                              SizedBox(height: 10),
                                              Container(
                                                  child:Wrap(
                                                    children: [
                                                      Text(S.of(context).tax,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .caption),
                                                      SizedBox(width: 10),
                                                      Text(
                                                          Helper.pricePrint(_con
                                                              .invoiceDetailsData
                                                              .payment
                                                              .tax),
                                                        style: Theme.of(context).textTheme.caption.merge(TextStyle(color:Theme.of(context).backgroundColor)),
                                                      ),
                                                    ],
                                                  )
                                              ),


                                              SizedBox(height: 10),
                                              Container(
                                                  child:Wrap(
                                                    children: [
                                                      Text(S.of(context).total,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .caption),
                                                      SizedBox(width: 10),
                                                     Container(

                                                       child: Text(
                                                          Helper.pricePrint(_con
                                                              .invoiceDetailsData
                                                              .payment
                                                              .grand_total),
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headline1),
                                        )
                                                    ],
                                                  )
                                              ),


                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1,
                                                    color: Colors.grey[100])))),
                                    SizedBox(height: 40),
                                    Wrap(
                                      alignment: WrapAlignment.spaceBetween,
                                        runSpacing: 10,
                                        children:[

                                          Div(
                                              colS:8,
                                              colM:8,
                                              colL:GetPlatform.isMobile?8:2,
                                              child: Container(
                                                width:70,

                                                // ignore: deprecated_member_use
                                                child:FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Slip(con: _con.invoiceDetailsData,)));
                                                    },
                                                    color:Colors.blue,
                                                    splashColor:Colors.blue,
                                                    textColor:Colors.white,
                                                    child:Wrap(children:[
                                                      Icon(Icons.payment,size:15,color:Colors.white),
                                                      SizedBox(width:3),
                                                      Text('Thermal Printer',style:Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.white))
                                                      ),
                                                    ])

                                                ),)
                                          ),
                                          Div(
                                              colS:4,
                                              colM:4,
                                              colL:4,
                                              child:Wrap(
                                                  alignment: WrapAlignment.end,
                                                  children:[
                                                    // ignore: deprecated_member_use
                                                    FlatButton(
                                                        onPressed: () {
                                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => A4printer(con: _con.invoiceDetailsData,)));
                                                        },
                                                        color:Colors.orange,
                                                        splashColor:Colors.orange,
                                                        textColor:Colors.white,
                                                        child:Wrap(children:[
                                                          Icon(Icons.print,size:15,color:Theme.of(context).primaryColorLight),
                                                          SizedBox(width:3),
                                                          Text('Print',style:Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                                                          ),
                                                        ])

                                                    ),
                                                  ]
                                              )



                                          ),

                                        ]
                                    )
                                  ])),
                            ]),
                          ],
                        ),
                      ])),
                ),
              ),
            ]));
  }


  void addonView(List<Addon2Model> addon) {
    double minwidth = MediaQuery.of(context).size.width * 0.2;
    double maxwidth = MediaQuery.of(context).size.width * 0.8;
    double minheight = MediaQuery.of(context).size.width * 0.2;
    double maxheight = MediaQuery.of(context).size.width * 0.8;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: IntrinsicWidth(
          stepWidth: 70.0,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: minwidth,
              maxWidth: maxwidth,
              minHeight: minheight,
              maxHeight: maxheight,
            ),
            child: Scrollbar(
              isAlwaysShown: true,
              child: SingleChildScrollView(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                      Container(
                        padding: EdgeInsets.only(left:20),

                        child:Text(S.current.addon,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),


                    ]),

                    SizedBox(height: 20),
                    Column(
                        children: List.generate(addon.length, (index) {
                          return AddonViewWidget(addonData: addon[index],);
                        })),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class AdonViewHelper {

  static exit(context) => showDialog(context: context, builder: (context) =>  AddonViewWidget());
}