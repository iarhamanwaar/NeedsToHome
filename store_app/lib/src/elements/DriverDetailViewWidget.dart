
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/components/padding_constants.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

// ignore: must_be_immutable
class DriverDetailViewWidget extends StatefulWidget {
  String orderId;
  DriverDetailViewWidget({Key key, this.orderId}) : super(key: key);

  @override
  _DriverDetailViewWidgetState createState() => _DriverDetailViewWidgetState();
}

class _DriverDetailViewWidgetState extends StateMVC<DriverDetailViewWidget> {
  // ignore: non_constant_identifier_names

  String id;

  SecondaryController _con;
  _DriverDetailViewWidgetState() : super(SecondaryController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.getDriverDetails(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PaddingConstants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          height: 350,
          padding: EdgeInsets.only(
              left: PaddingConstants.padding,
              top: PaddingConstants.avatarRadius + PaddingConstants.padding,
              right: PaddingConstants.padding,
              bottom: PaddingConstants.padding),
          margin: EdgeInsets.only(
              top: PaddingConstants.avatarRadius,
              left: size.width > 670
                  ? size.width * 0.27
                  : PaddingConstants.padding,
              right: size.width > 670
                  ? size.width * 0.27
                  : PaddingConstants.padding),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(PaddingConstants.padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                ),
              ]),
          child: SingleChildScrollView(
            child: _con.loaderData
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(S.of(context).driver_details,
                          style: Theme.of(context).textTheme.headline4),
                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).order_id,
                                style: Theme.of(context).textTheme.subtitle1),
                            Container(
                                width:
                                    size.width > 670 ? size.width * 0.2 : 140,
                                alignment: Alignment.topRight,
                                child: Text('#${widget.orderId}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.subtitle1)),
                          ]),
                      SizedBox(height: 5),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).driver_name,
                                style: Theme.of(context).textTheme.subtitle1),
                            Container(
                                width:
                                    size.width > 670 ? size.width * 0.2 : 140,
                                alignment: Alignment.topRight,
                                child: Text(_con.driverDetailsData.driverName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.subtitle1)),
                          ]),
                      SizedBox(height: 5),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).phone,
                                style: Theme.of(context).textTheme.subtitle1),
                            Container(
                                width:
                                    size.width > 670 ? size.width * 0.2 : 140,
                                alignment: Alignment.topRight,
                                child: Text(_con.driverDetailsData.phone,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.subtitle1)),
                          ]),
                      SizedBox(height: 5),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).status,
                                style: Theme.of(context).textTheme.subtitle1),
                            Container(
                                width:
                                    size.width > 670 ? size.width * 0.2 : 140,
                                alignment: Alignment.topRight,
                                child: Text(_con.driverDetailsData.status,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.subtitle1)),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).date,
                                style: Theme.of(context).textTheme.subtitle1),
                            Container(
                                width:
                                    size.width > 670 ? size.width * 0.2 : 140,
                                alignment: Alignment.topRight,
                                child: Text(_con.driverDetailsData.orderDate,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.subtitle1)),
                          ]),
                      SizedBox(height: 35),
                      Align(
                        alignment: Alignment.center,
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          padding: EdgeInsets.only(
                              top: 15, bottom: 15, left: 40, right: 40),
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(1),
                          shape: StadiumBorder(),
                          child: Text(
                            S.of(context).close,
                            style: Theme.of(context).textTheme.headline6.merge(
                                TextStyle(
                                    color:
                                        Theme.of(context).primaryColorLight)),
                          ),
                        ),
                      ),
                    ],
                  )
                : EmptyOrdersWidget(),
          ),
        ),
      ],
    );
  }
}
