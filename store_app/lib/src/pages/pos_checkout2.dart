import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

class PosCheckout extends StatefulWidget {
  @override
  _PosCheckoutState createState() => _PosCheckoutState();
}

class _PosCheckoutState extends State<PosCheckout>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool isSwitched = false;

  bool status = false;
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
    var size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                //color:Colors.white70,
                child: Container(
                    margin:
                        EdgeInsets.only(left: 20.0, right: 20, bottom: 10.0),
                    child: Column(children: [
                      Wrap(runSpacing: 20, children: [
                        Div(
                            colS: 12,
                            colM: 12,
                            colL: 8,
                            child: Column(children: [
                              Container(
                                  color: Theme.of(context).primaryColor,
                                  padding: EdgeInsets.only(
                                      top: 20, left: 10, right: 10, bottom: 20),
                                  margin: EdgeInsets.only(right: 10),
                                  child: Column(children: [
                                    Wrap(
                                        alignment: WrapAlignment.spaceBetween,
                                        children: [
                                          Div(
                                              colS: 6,
                                              colM: 6,
                                              colL: 6,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'BarbeQueen Restaurant',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline4,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text('location, id #5566D')
                                                  ])),
                                          Div(
                                            colS: 6,
                                            colM: 6,
                                            colL: 6,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                      height: 40,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                      child: TextField(
                                                        autofocus: false,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          hintText:  S.of(context).search,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.grey)),
                                                          border: UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .grey)),
                                                          hintStyle: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .caption
                                                              .merge(TextStyle(
                                                                  fontSize:
                                                                      14)),
                                                          suffixIcon: Icon(
                                                              Icons.search,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.transparent)),
                                                        ),
                                                      ))
                                                ]),
                                          ),
                                        ]),
                                  ])),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                height: 67,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 9,
                                    padding: EdgeInsets.only(right: 10),
                                    itemBuilder: (context, index) {
                                      return Container(
                                          padding: EdgeInsets.only(
                                            top: 15,
                                            bottom: 12,
                                            left: 12,
                                          ),
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  top: 5,
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 5),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12
                                                        .withOpacity(0.1),
                                                    blurRadius: 1.8,
                                                    spreadRadius: 1.1,
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                child: Container(
                                                    child: Text('Cool Drinks',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Touche W03 Regular',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w100))),
                                              )));
                                    }),
                              ),
                              ListView.builder(
                                itemCount: 1,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(
                                  top: 16,
                                ),
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Scrollbar(
                                      child: SingleChildScrollView(
                                          child: Column(children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                            right: size.width > 800 ? 10 : 0),
                                        child: Wrap(runSpacing: 10, children: [
                                          Div(
                                              colS: 12,
                                              colM: size.width > 1024 ? 12 : 12,
                                              colL: size.width > 1090 ? 6 : 8,
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                      right: size.width > 800
                                                          ? 5
                                                          : 0),
                                                  child: ProductBox2Widget())),
                                          Div(
                                              colS: 12,
                                              colM: size.width > 1024 ? 12 : 12,
                                              colL: size.width > 1090 ? 6 : 8,
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: size.width > 800
                                                          ? 5
                                                          : 0),
                                                  child: ProductBox2Widget())),
                                          Div(
                                              colS: 12,
                                              colM: size.width > 1024 ? 12 : 12,
                                              colL: size.width > 1090 ? 6 : 8,
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                      right: size.width > 800
                                                          ? 5
                                                          : 0),
                                                  child: ProductBox2Widget())),
                                          Div(
                                              colS: 12,
                                              colM: size.width > 1024 ? 12 : 12,
                                              colL: size.width > 1090 ? 6 : 8,
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: size.width > 800
                                                          ? 5
                                                          : 0),
                                                  child: ProductBox2Widget())),
                                          Div(
                                              colS: 12,
                                              colM: size.width > 1024 ? 12 : 12,
                                              colL: size.width > 1090 ? 6 : 8,
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                      right: size.width > 800
                                                          ? 5
                                                          : 0),
                                                  child: ProductBox2Widget())),
                                          Div(
                                              colS: 12,
                                              colM: size.width > 1024 ? 12 : 12,
                                              colL: size.width > 1090 ? 6 : 8,
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: size.width > 800
                                                          ? 5
                                                          : 0),
                                                  child: ProductBox2Widget())),
                                        ]))
                                  ])));
                                },
                              ),
                            ])),
                        Div(
                            colS: 12,
                            colM: 4,
                            colL: 4,
                            child: Container(
                                margin: EdgeInsets.only(
                                    left: size.width > 800 ? 10 : 0),
                                padding: EdgeInsets.only(
                                    left: size.width > 800 ? 10 : 0),
                                color: Theme.of(context).primaryColor,
                                height: size.height * 0.9,
                                width: double.infinity,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /*ListView.builder(
                                    itemCount:3,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(top: 16, right:size.width > 769 ? size.width * 0 : 0  , left: size.width > 769 ? size.width * 0 : 0),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return CheckoutProduct();
                                    },
                                  ),*/
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                              children:
                                                  List.generate(7, (index) {
                                            return CheckoutProduct();
                                          })),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ElevatedButton(
                                            child: Container(
                                                width: double.infinity,
                                                height: 50,
                                                child: Center(
                                                    child:
                                                        Text("200 RS DONE"))),
                                            onPressed: () => () {},
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.deepPurple,
                                              onPrimary: Colors.white70,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ]))),
                      ])
                    ])),
              ),
            ],
          ),
        ));
  }
}

class ProductBox2Widget extends StatefulWidget {
  @override
  _ProductBox2WidgetState createState() => _ProductBox2WidgetState();
}

class _ProductBox2WidgetState extends State<ProductBox2Widget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
        left: size.width > 800 ? 10 : 0,
        top: 5,
        right: size.width > 800 ? 10 : 0,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List<Widget>.generate(
          1,
          (index) {
            return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, right: 10),
                      child: Image(
                        image: AssetImage(
                          'assets/img/excel.png',
                        ),
                        fit: BoxFit.fitHeight,
                        width: 60,
                        height: 90,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 2, right: 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Text(
                                        'Ariel Complete Detergent Powder',
                                        overflow: TextOverflow.fade,
                                        maxLines: 2,
                                        softWrap: true,
                                      )),
                                  Wrap(
                                      alignment: WrapAlignment.spaceBetween,
                                      children: [
                                        Text('Rs.200',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, top: 4),
                                          child: Text(
                                            'Rs.250',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2
                                                .merge(TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough)),
                                          ),
                                        ),
                                      ]),
                                  SizedBox(height: 3),
                                  /*   Text(
                                    '${widget.choice..toString()} % ${S.of(context).offer}',
                                    style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(
                                    color: Theme.of(context).accentColor,
                                    )),
                                    ), */
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          AvailableQuantityHelper.exit(context);
                                        },
                                        child: Container(
                                            height: 30,
                                            width: 100,
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey[300],
                                                )),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('ddf'),
                                                Icon(Icons.arrow_drop_down,
                                                    size: 19,
                                                    color: Colors.grey)
                                              ],
                                            )),
                                      ),
                                      size.width > 769
                                          ? InkWell(
                                              onTap: () {},
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 10,
                                                    bottom: 7),
                                                child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    height: 30,
                                                    /*width: MediaQuery.of(context).size.width * 0.25,*/
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary
                                                          .withOpacity(1),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          S.of(context).add,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .transparent),
                                                        ),
                                                        Text( S.of(context).add,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle2
                                                                .merge(TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColorLight,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600))),
                                                        SizedBox(width: 5),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            5),
                                                                topRight: Radius
                                                                    .circular(
                                                                        5)),
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary,
                                                          ),
                                                          height:
                                                              double.infinity,
                                                          width: 30,
                                                          child: IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(
                                                                  Icons.add),
                                                              iconSize: 18,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorLight),
                                                        )
                                                      ],
                                                    )),
                                              ))
                                          : InkWell(
                                              onTap: () {},
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                ),
                                                child: Wrap(
                                                    alignment: WrapAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Icon(
                                                            Icons.remove_circle,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary,
                                                            size: 27),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.022,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5),
                                                        child: Text('1',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.022,
                                                      ),
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Icon(
                                                            Icons.add_circle,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary,
                                                            size: 27),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Text(
                                          S.of(context).customizable,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ]

                          /*       return _variantData.selected?*/

                          ),
                    ),
                  ),
                ]);
          },
        ),
      ),
    );
  }
}

class CheckoutProduct extends StatefulWidget {
  @override
  _CheckoutProductState createState() => _CheckoutProductState();
}

class _CheckoutProductState extends State<CheckoutProduct> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
        left: 10,
        top: 5,
        right: 10,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(top: 10, right: 10),
                  child: Image(
                    image: AssetImage(
                      'assets/img/excel.png',
                    ),
                    fit: BoxFit.fitHeight,
                    width: 60,
                    height: 80,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 2, right: 5),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text(
                                    'Ariel Complete Detergent Powder',
                                    overflow: TextOverflow.fade,
                                    maxLines: 2,
                                    softWrap: true,
                                  )),
                              Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  children: [
                                    Text('Rs.200',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 4),
                                      child: Text(
                                        'Rs.250',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .merge(TextStyle(
                                                decoration: TextDecoration
                                                    .lineThrough)),
                                      ),
                                    ),
                                  ]),
                              SizedBox(height: 3),
                              /*   Text(
                                    '${widget.choice..toString()} % ${S.of(context).offer}',
                                    style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(
                                    color: Theme.of(context).accentColor,
                                    )),
                                    ), */
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 100,
                                  ),
                                  size.width > 769
                                      ? InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 5,
                                                right: 5,
                                                top: 5,
                                                bottom: 5),
                                            child: Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                padding:
                                                    EdgeInsets.only(left: 7),
                                                height: 25,
                                                /*width: MediaQuery.of(context).size.width * 0.25,*/
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary
                                                      .withOpacity(1),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text( S.of(context).add,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2
                                                            .merge(TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColorLight,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600))),
                                                    SizedBox(width: 5),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            5),
                                                                topRight: Radius
                                                                    .circular(
                                                                        5)),
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                      ),
                                                      height: double.infinity,
                                                      width: 30,
                                                      child: IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(Icons.add),
                                                          iconSize: 13,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColorLight),
                                                    )
                                                  ],
                                                )),
                                          ))
                                      : InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                            ),
                                            child: Wrap(
                                                alignment:
                                                    WrapAlignment.spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Icon(
                                                        Icons.remove_circle,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                        size: 27),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.022,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text('1',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.022,
                                                  ),
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Icon(
                                                        Icons.add_circle,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                        size: 27),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ])
      ]),
    );
  }
}

class AvailableQuantityHelper {
  static exit(context) => showDialog(
      context: context, builder: (context) => AvailableQuantityPopup());
}

// ignore: must_be_immutable
class AvailableQuantityPopup extends StatefulWidget {
  @override
  _AvailableQuantityPopupState createState() => _AvailableQuantityPopupState();
}

class _AvailableQuantityPopupState extends State<AvailableQuantityPopup> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context, size),
      insetPadding: EdgeInsets.only(
        top: size.width > 769 ? size.height * 0.1 : size.height * 0.09,
        left: size.width > 769 ? size.width * 0.32 : size.width * 0.09,
        right: size.width > 769 ? size.width * 0.32 : size.width * 0.09,
        bottom: size.width > 769 ? size.height * 0.1 : size.width * 0.09,
      ),
    );
  }

  _buildChild(BuildContext context, Size size) => SingleChildScrollView(
        child: Container(
          height: size.width > 769 ? size.height * 0.3 : null,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(3))),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
                child: Text('Available Quantity',
                    style: TextStyle(
                        color: Theme.of(context).disabledColor,
                        fontWeight: FontWeight.w500)),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  )),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
                child: Text(
                  'gsg',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .merge(TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
              ListView.separated(
                itemCount: 2,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: () {},
                      padding: EdgeInsets.all(10),
                      color: Theme.of(context).backgroundColor.withOpacity(0.8),
                      child: RichText(
                        text: new TextSpan(children: [
                          TextSpan(
                            text: '1',
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .merge(TextStyle(
                                  color: Colors.white,
                                )),
                          ),
                          TextSpan(
                              text: 'ahg',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .merge(TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.lineThrough))),
                          TextSpan(
                              text: 'dn',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .merge(TextStyle(
                                    color: Colors.white,
                                  )))
                        ]),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      )),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
}
