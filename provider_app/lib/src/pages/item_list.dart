import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'Widget/custom_divider_view.dart';

// ignore: must_be_immutable
class ItemList extends StatefulWidget {
  DocumentSnapshot paymentData;
  ItemList({Key key, this.paymentData}) : super(key: key);
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  int dropDownValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.green),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(top: 27.0),
              child: Row(
                children: <Widget>[
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    child: Text(
                      S.of(context).items,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.headline4.merge(
                          TextStyle(
                              color:
                                  Theme.of(context).scaffoldBackgroundColor)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 40.0),
                      Padding(
                        padding: EdgeInsets.only(top: 16, right: 20, left: 20),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Theme.of(context).colorScheme.secondary),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 0, bottom: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      RichText(
                                        text: new TextSpan(
                                            text: 'RM. ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .merge(TextStyle(
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor)),
                                            children: [
                                              new TextSpan(
                                                text:
                                                    '${widget.paymentData['miscellaneousAmount']}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1
                                                    .merge(TextStyle(
                                                        color: Theme.of(context)
                                                            .scaffoldBackgroundColor)),
                                              )
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: Container(
                                          child: Text(
                                            '${widget.paymentData['date']}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .merge(TextStyle(
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor)),
                                          ),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: Container(
                                          child: Text(
                                            '#${widget.paymentData['bookingId']}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .merge(TextStyle(
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor)),
                                          ),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: Container(
                                          child: Text(
                                            '${widget.paymentData['miscellaneous'].length} Items',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .merge(TextStyle(
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor)),
                                          ),
                                        ))
                                  ],
                                ),
                              ]),
                        ),
                      ),
                      ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: widget.paymentData['miscellaneous'].length,
                        shrinkWrap: true,
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final element =
                              widget.paymentData['miscellaneous'][index];
                          return Container(
                              padding: EdgeInsets.only(
                                  top: 10, right: 20, left: 20, bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      child: Text(
                                    '${element[S.of(context).name]}',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  )),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          'RM ${element[S.of(context).price]}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 5),
                                        child: RichText(
                                          text: new TextSpan(
                                              text: 'X  ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                              children: [
                                                new TextSpan(
                                                    text: S.of(context).items,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2)
                                              ]),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ));
                        },
                        separatorBuilder: (context, index) {
                          return Column(
                            children: [
                              CustomDividerView(
                                dividerHeight: 10.0,
                                color: Colors.grey[200],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
