import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';


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
    return Div(
        colS: 12,
        colM: 12,
        colL: 4,
        child: Container(
            margin: EdgeInsets.only(left: size.width > 769 ? 10 : 0),
            padding: EdgeInsets.only(left: size.width > 769 ? 10 : 0),
            color: Theme.of(context).primaryColor,
            height: size.height * 0.9,
            width: double.infinity,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          children:
                          List.generate(7, (index) {
                            return CheckoutProductList();
                          })),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child:  Container(
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
                          child: new Text('200 Rs',
                              style: Theme.of(context).textTheme.headline1.merge(TextStyle( color:Theme.of(context).primaryColorLight))
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CheckoutProduct()));
                          }

                      ),


                    ),
                  )
                ]))
    );
  }
}




class CheckoutProductList extends StatefulWidget {
  @override
  _CheckoutProductListState createState() => _CheckoutProductListState();
}

class _CheckoutProductListState extends State<CheckoutProductList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 10, top: 5, right: 10,
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
                                        style: Theme.of(context).textTheme.headline1),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 4),
                                      child: Text(
                                        'Rs.250',
                                        style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(decoration: TextDecoration.lineThrough)),
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
                                        padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                                        child: Container(
                                            alignment: Alignment.centerRight,
                                            padding: EdgeInsets.only(left: 7),
                                            height: 25,
                                            /*width: MediaQuery.of(context).size.width * 0.25,*/
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5.0),
                                              color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text( S.of(context).add,
                                                    style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color: Theme.of(context).primaryColorLight, fontWeight: FontWeight.w600))),
                                                SizedBox(width: 5),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                        bottomRight: Radius.circular(5),
                                                        topRight: Radius.circular(5)),
                                                    color: Theme.of(context).colorScheme.secondary,
                                                  ),
                                                  height: double.infinity,
                                                  width: 30,
                                                  child: IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(Icons.add),
                                                      iconSize: 13,
                                                      color: Theme.of(context).primaryColorLight),
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
                                                  color: Theme.of(context).colorScheme.secondary, size: 27),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.022,
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsets.only(top: 5),
                                              child: Text('1',
                                                  style: Theme.of(context).textTheme.bodyText1),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.022,
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Icon(
                                                  Icons.add_circle,
                                                  color: Theme.of(context).colorScheme.secondary,
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