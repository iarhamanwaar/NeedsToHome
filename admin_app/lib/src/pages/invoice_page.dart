import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:vrouter/vrouter.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
class InvoicePage extends StatefulWidget {
  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {

  @override
  Widget build(BuildContext context) {
    final id = VRouter.of(context).pathParameters['id']??0;
    return Scrollbar(
      isAlwaysShown: true,
      child:ListView(
          scrollDirection:Axis.vertical,
          children:[
            Padding(
              padding:EdgeInsets.only(left:20,right:20,top:20,bottom:20),
              child: Container(
                padding:EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color:Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20.0,
                        spreadRadius: 5.0,
                      ),
                    ]),

                child:SingleChildScrollView(
                    child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Invoice12$id',style:Theme.of(context).textTheme.headline6),
                              Text('Order1#$id')
                            ],
                          ),
                          SizedBox(height:20),
                          Container(
                              decoration:BoxDecoration(
                                  border:Border(
                                      bottom: BorderSide(
                                          width:1,
                                          color:Colors.grey[200]
                                      )
                                  )
                              )
                          ),
                          SizedBox(height:20),
                          Row(
                            children: [
                              Expanded(
                                  child:Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Text(S.of(context).billed_to,style:Theme.of(context).textTheme.subtitle1),
                                        SizedBox(height:4),
                                        Text('Sethrollines'),
                                        SizedBox(height:4),
                                        Text('6408 Cut Class Ct'),
                                        SizedBox(height:4),
                                        Text('Wendell'),
                                        SizedBox(height:4),
                                        Text('NC, 26983 USA'),


                                      ],
                                    ),
                                  )
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(S.of(context).shipped_to,style:Theme.of(context).textTheme.subtitle1),
                                    SizedBox(height:4),
                                    Text('Becky Lynch'),
                                    SizedBox(height:4),
                                    Text('197 N 200t E'),
                                    SizedBox(height:4),
                                    Text('Rexburg Id'),
                                    SizedBox(height:4),
                                    Text('Spring USA'),


                                  ],
                                ),
                              )
                            ],
                          ),

                          SizedBox(height:20),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child:Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Text(S.of(context).payment_method,style:Theme.of(context).textTheme.subtitle2),
                                        SizedBox(height:4),
                                        Text('Visa ending ****5685'),
                                        SizedBox(height:4),
                                        Text('test@example.com'),



                                      ],
                                    ),
                                  )
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(S.of(context).order_date,style:Theme.of(context).textTheme.subtitle2),
                                    SizedBox(height:4),
                                    Text('june 11, 2021'),


                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height:40),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(S.of(context).order_summary,style:Theme.of(context).textTheme.headline6),
                              SizedBox(height:5),
                              Text(S.of(context).all_itmes_here_cannot_be_deleted,style:Theme.of(context).textTheme.caption),





                            ],
                          ),

                          Row(
                              children:[
                                Expanded(
                                    child:SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      reverse: false,
                                      child:DataTable(
                                        showCheckboxColumn: true,
                                        headingTextStyle: Theme.of(context).textTheme.bodyText1,
                                        columns: [
                                          DataColumn(

                                              label:Text('#')
                                          ),
                                          DataColumn(label:Text(S.of(context).items),),
                                          DataColumn(label:Text(S.of(context).price)),
                                          DataColumn(label:Text(S.of(context).quantity)),
                                          DataColumn(label:Text(S.of(context).total)),
                                        ],
                                        rows: [
                                          DataRow(

                                              cells: [
                                                DataCell(Text('1')),
                                                DataCell(Text('Mouse')),
                                                DataCell(Text('100')),
                                                DataCell(Text('1')),
                                                DataCell(Text('100')),
                                              ]),
                                          DataRow(cells: [
                                            DataCell(Text('2')),
                                            DataCell(Text('Keyboard')),
                                            DataCell(Text('200')),
                                            DataCell(Text('1')),
                                            DataCell(Text('200')),
                                          ]),
                                          DataRow(

                                              cells: [
                                                DataCell(Text('1')),
                                                DataCell(Text('Mouse')),
                                                DataCell(Text('100')),
                                                DataCell(Text('1')),
                                                DataCell(Text('100')),
                                              ]),
                                          DataRow(cells: [
                                            DataCell(Text('2')),
                                            DataCell(Text('Keyboard')),
                                            DataCell(Text('200')),
                                            DataCell(Text('1')),
                                            DataCell(Text('200')),
                                          ]),
                                          DataRow(

                                              cells: [
                                                DataCell(Text('1')),
                                                DataCell(Text('Mouse')),
                                                DataCell(Text('100')),
                                                DataCell(Text('1')),
                                                DataCell(Text('100')),
                                              ]),
                                          DataRow(
                                              cells: [
                                            DataCell(Text('2')),
                                            DataCell(Text('Keyboard')),
                                            DataCell(Text('200')),
                                            DataCell(Text('1')),
                                            DataCell(Text('200')),
                                          ]),


                                        ],
                                      ),

                                    )
                                )
                              ]
                          ),

                          SizedBox(height:20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Responsive(
                                children:[
                                  Div(
                                      colS: 12,
                                      colM:12,
                                      colL:12,
                                      child:Column(
                                        children:[
                                          Wrap(
                                            children: [
                                              Div(
                                                colS:8,
                                                colM:8,
                                                colL:8,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(S.of(context).payment_method,style:Theme.of(context).textTheme.headline6),
                                                    Text("the payment method that we provide is to make it easier for you to invoices",style:Theme.of(context).textTheme.caption),
                                                  ],
                                                ),
                                              ),
                                              Div(
                                                colS:4,
                                                colM:4,
                                                colL:4,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(S.of(context).subtotal,style:Theme.of(context).textTheme.caption),
                                                    Text('\$640.0',style:Theme.of(context).textTheme.headline1),
                                                    SizedBox(height:6),
                                                    Text(S.of(context).shipping,style:Theme.of(context).textTheme.caption),
                                                    SizedBox(height:10),
                                                    Text('\$1.0',style:Theme.of(context).textTheme.headline1),
                                                    SizedBox(height:10),
                                                    Container(
                                                      decoration:BoxDecoration(
                                                        border: Border(
                                                          bottom:BorderSide(
                                                            width:1,
                                                            color:Colors.grey[100]
                                                          )
                                                        )
                                                      )
                                                    ),
                                                    SizedBox(height:10),
                                                    Text(S.of(context).total,style:Theme.of(context).textTheme.caption),
                                                    SizedBox(height:10),
                                                    Text('\$641.0',style:Theme.of(context).textTheme.headline1),
                                                  ],
                                                ),
                                              ),


                                            ],
                                          ),
                                          SizedBox(height:20),
                                          Container(
                                              decoration:BoxDecoration(
                                                  border: Border(
                                                      bottom:BorderSide(
                                                          width:1,
                                                          color:Colors.grey[100]
                                                      )
                                                  )
                                              )
                                          ),
                                          SizedBox(height:40),

                                        Wrap(
                                          runSpacing: 10,
                                          children:[

                                            Div(
                                                colS:8,
                                                colM:8,
                                                colL:6,
                                                child:Wrap(
                                                    runSpacing: 10,
                                                    children:[
                                                      // ignore: deprecated_member_use
                                                      FlatButton(
                                                          onPressed: () {},
                                                          color:Colors.blue,
                                                          splashColor:Colors.blue,
                                                          textColor:Colors.white,
                                                          child:Wrap(children:[
                                                            Icon(Icons.payment,size:15,color:Colors.white),
                                                            SizedBox(width:3),
                                                            Text(S.of(context).process_payment,style:Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.white))
                                                            ),
                                                          ])

                                                      ),
                                                      SizedBox(width:5),
                                                      // ignore: deprecated_member_use
                                                      FlatButton(
                                                          onPressed: () {},
                                                          color:Colors.red,
                                                          splashColor:Colors.red,
                                                          textColor:Colors.white,
                                                          child:Wrap(children:[
                                                            Icon(Icons.close,size:15,color:Colors.white),
                                                            SizedBox(width:3),
                                                            Text(S.of(context).cancel,style:Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.white))
                                                            ),
                                                          ])

                                                      ),
                                                    ]
                                                )
                                            ),
                                            Div(
                                                colS:4,
                                                colM:4,
                                                colL:6,
                                                child:Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children:[
                                                      // ignore: deprecated_member_use
                                                      FlatButton(
                                                          onPressed: () {},
                                                          color:Colors.orange,
                                                          splashColor:Colors.orange,
                                                          textColor:Colors.white,
                                                          child:Wrap(children:[
                                                            Icon(Icons.print,size:15,color:Colors.white),
                                                            SizedBox(width:3),
                                                            Text(S.of(context).print,style:Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.white))
                                                            ),
                                                          ])

                                                      ),
                                                    ]
                                                )



                                            ),

                                          ]
                                        )

                                        ]
                                      )
                                  ),


                                ]
                              ),






                            ],
                          ),

                        ]
                    )
                ),

              ),
            ),
          ]
      )
    );
  }
}


