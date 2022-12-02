import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

import '../elements/CheckoutProductWidget.dart';
import '../elements/ProductBox2Widget.dart';

class PosCheckout extends StatefulWidget {
  @override
  _PosCheckoutState createState() => _PosCheckoutState();
}

class _PosCheckoutState extends State<PosCheckout>
    with SingleTickerProviderStateMixin {

  bool isSwitched = false;



  bool status = false;
  @override
  void initState() {

    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Expanded(
              child:SingleChildScrollView(
                  child:Column(
                    children: [
                      Container(
                        child: Container(
                            margin: EdgeInsets.only(left:10.0, right: 10, bottom: 10.0),
                            child: Column(
                                children: [
                                  Wrap(
                                      runSpacing: 20,
                                      children: [
                                        /* Div(
                                      colS: 12,
                                      colM: 12,
                                      colL: 8,
                                      child: Container(
                                          padding: EdgeInsets.only(top: 20,bottom: 20),
                                          height: size.height,
                                          width: double.infinity,
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    color: Theme.of(context).primaryColor,
                                                    padding: EdgeInsets.only(top: 20, left: 10,right:10, bottom: 20),
                                                    child: Column(children: [
                                                      Wrap(
                                                          alignment: WrapAlignment.spaceBetween,
                                                          children: [
                                                            Div(
                                                                colS: 6,
                                                                colM: 6,
                                                                colL: 6,
                                                                child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Container(
                                                                        child: Text(
                                                                          'BarbeQueen Restaurant',
                                                                          style: Theme.of(context).textTheme.headline4,
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
                                                                        width: MediaQuery.of(context).size.width * 0.2,
                                                                        child: TextField(
                                                                          autofocus: false,
                                                                          decoration: InputDecoration(contentPadding: EdgeInsets.all(10),
                                                                            hintText:  S.of(context).search,
                                                                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey)),
                                                                            border: UnderlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey)),
                                                                            hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                                                                            suffixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.secondary),
                                                                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                                                          ),
                                                                        ))
                                                                  ]),
                                                            ),
                                                          ]),
                                                    ])),
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets.only(top: 20),
                                                            height: 67,
                                                            child: ListView.builder(
                                                                scrollDirection: Axis.horizontal,
                                                                itemCount: 9,
                                                                padding: EdgeInsets.only(right: 10),
                                                                itemBuilder: (context, index) {
                                                                  return Container(
                                                                      padding: EdgeInsets.only(top: 15, bottom: 12, left: 12,),
                                                                      child: Container(
                                                                          padding: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
                                                                          decoration: BoxDecoration(
                                                                            color: Theme.of(context).primaryColor,
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: Colors.black12.withOpacity(0.1),
                                                                                blurRadius: 1.8,
                                                                                spreadRadius: 1.1,
                                                                              ),
                                                                            ],
                                                                            borderRadius: BorderRadius.circular(20),
                                                                          ),
                                                                          child: Center(
                                                                            child: Container(
                                                                                child: Text('Cool Drinks', textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                        fontFamily: 'Touche W03 Regular', fontWeight: FontWeight.w100))),
                                                                          )
                                                                      )
                                                                  );
                                                                }),
                                                          ),
                                                          Container(
                                                            height: size.height * 0.98,
                                                            child: ListView.builder(
                                                              itemCount: 1,
                                                              shrinkWrap: true,
                                                              padding: EdgeInsets.only(top: 16,),
                                                              itemBuilder: (context, index) {
                                                                return Scrollbar(
                                                                    isAlwaysShown: true,
                                                                    controller: _scrollController,
                                                                    child: SingleChildScrollView(
                                                                        child: Column(children: [
                                                                          Container(
                                                                              child: Wrap(runSpacing: 10,
                                                                                  children: List.generate(8, (index) {
                                                                                    return Div(
                                                                                        colS: 12,
                                                                                        colM: size.width > 1024 ? 12 : 12,
                                                                                        colL: size.width > 1090 ? 6 : 8,
                                                                                        child: Container(
                                                                                            padding: EdgeInsets.only(
                                                                                                right: size.width > 800 ? 5 : 0),
                                                                                            child: ProductBox2Widget())
                                                                                    );
                                                                                  })
                                                                              ))
                                                                        ])));
                                                              },
                                                            ),
                                                          ),
                                                        ]
                                                    ),
                                                  ),
                                                ),

                                              ]))
                                  ),*/
                                        Div(
                                            colS: 12,
                                            colM: 12,
                                            colL: 8,
                                            child: Container(
                                                margin: EdgeInsets.only(left: size.width > 769 ? 0: 0),
                                                padding: EdgeInsets.only(left: size.width > 769 ? 10 : 0),
                                                height: size.height * 0.9,
                                                width: double.infinity,
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          color: Theme.of(context).primaryColor,
                                                          padding: EdgeInsets.only(top: 20, left: 10,right:10, bottom: 20),
                                                          child: Column(children: [
                                                            Wrap(
                                                                alignment: WrapAlignment.spaceBetween,
                                                                children: [
                                                                  Div(
                                                                      colS: 6,
                                                                      colM: 6,
                                                                      colL: 6,
                                                                      child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              child: Text(
                                                                                'BarbeQueen Restaurant',
                                                                                style: Theme.of(context).textTheme.headline4,
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
                                                                              width: MediaQuery.of(context).size.width * 0.2,
                                                                              child: TextField(
                                                                                autofocus: false,
                                                                                decoration: InputDecoration(contentPadding: EdgeInsets.all(10),
                                                                                  hintText:  S.of(context).search,
                                                                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey)),
                                                                                  border: UnderlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey)),
                                                                                  hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                                                                                  suffixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.secondary),
                                                                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                                                                ),
                                                                              ))
                                                                        ]),
                                                                  ),
                                                                ]),
                                                          ])),
                                                      Expanded(
                                                        child: SingleChildScrollView(
                                                          child: Column(
                                                              children: [
                                                                Container(
                                                                  margin: EdgeInsets.only(top: 20),
                                                                  height: 67,
                                                                  child: ListView.builder(
                                                                      scrollDirection: Axis.horizontal,
                                                                      itemCount: 9,
                                                                      padding: EdgeInsets.only(right: 10),
                                                                      itemBuilder: (context, index) {
                                                                        return Container(
                                                                            padding: EdgeInsets.only(top: 15, bottom: 12, left: 12,),
                                                                            child: Container(
                                                                                padding: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
                                                                                decoration: BoxDecoration(
                                                                                  color: Theme.of(context).primaryColor,
                                                                                  boxShadow: [
                                                                                    BoxShadow(
                                                                                      color: Colors.black12.withOpacity(0.1),
                                                                                      blurRadius: 1.8,
                                                                                      spreadRadius: 1.1,
                                                                                    ),
                                                                                  ],
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Container(
                                                                                      child: Text('Cool Drinks', textAlign: TextAlign.center,
                                                                                          style: TextStyle(
                                                                                              fontFamily: 'Touche W03 Regular', fontWeight: FontWeight.w100))),
                                                                                )
                                                                            )
                                                                        );
                                                                      }),
                                                                ),
                                                                Container(
                                                                    child: Wrap(runSpacing: 10,
                                                                        children: List.generate(20, (index) {
                                                                          return Div(
                                                                              colS: 12,
                                                                              colM: size.width > 1024 ? 12 : 12,
                                                                              colL: size.width > 1090 ? 6 : 8,
                                                                              child: Container(
                                                                                  padding: EdgeInsets.only(
                                                                                      right: size.width > 800 ? 5 : 0),
                                                                                  child: ProductBox2Widget())
                                                                          );
                                                                        })
                                                                    ))


                                                              ]
                                                          ),
                                                        ),
                                                      ),

                                                    ]))
                                        ),
                                        size.width> 769 ? CheckoutProduct():Container(),
                                      ]
                                  )
                                ]
                            )
                        ),
                      ),
                    ],
                  )
              )

          ),
          size.width > 769 ? Container():Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius:
                BorderRadius.circular(8),
              ),
              child: MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  elevation: 5.0,
                  minWidth: double.infinity,
                  height: 50,
                  color: Theme.of(context).primaryColorDark,
                  child: new Text('GOTO CHECKOUT',
                      style: Theme.of(context).textTheme.headline1.merge(TextStyle( color:Theme.of(context).primaryColorLight))
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CheckoutProduct()));
                  }

              ),


            ),
          )
        ],
      ),

    );
  }
}
