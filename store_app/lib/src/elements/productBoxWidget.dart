
import 'package:flutter/material.dart';

import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/controllers/product_controller.dart';
import 'package:login_and_signup_web/src/elements/AEAddonWidget.dart';
import 'package:login_and_signup_web/src/elements/productpopup.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/addon.dart';
import 'package:login_and_signup_web/src/models/product_details2.dart';
import 'package:login_and_signup_web/src/models/variant.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'AddonBoxWidget.dart';
import 'AvailabletimePopupWidget.dart';
import 'EmptyOrdersWidget.dart';
import 'VariantBoxWidget.dart';
import 'AEVariantWidget.dart';


class ProductBox extends StatefulWidget {
  final ProductController con;
  final ProductDetails2 choice;
  final String pageType;
  final List<ProductDetails2> productDetails;

  const ProductBox(
      {Key key, this.choice, this.con, this.pageType, this.productDetails})
      : super(key: key);
  @override
  _ProductBoxState createState() => _ProductBoxState();
}

class _ProductBoxState extends StateMVC<ProductBox> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Div(
        colS: 12,
        colM: 12,
        colL: 3,
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(width: 0.3, color: Colors.grey[200])),
          margin: EdgeInsets.only(left: 15, right: 15, top: 10.0, bottom: 10),
          child: Column(children: [
            Stack(children: [
              ClipRRect(
                  //borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  child: Image(
                      image: widget.choice.variant.uploadImage!=null?NetworkImage(widget.choice.variant.uploadImage):AssetImage('assets/img/image_placeholder.png'),
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.fill)),
              ClipRRect(
                //borderRadius: BorderRadius.all(Radius.circular(10)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                child: Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Container(
                          height: 150,
                          width: double.infinity,
                          child: Stack(children: [
                            Container(
                              alignment: Alignment.bottomLeft,

                              /* background black light to dark gradient color */
                              decoration: BoxDecoration(
                                gradient: new LinearGradient(
                                  begin: const Alignment(0.0, -1.0),
                                  end: const Alignment(0.0, 0.6),
                                  colors: <Color>[
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.transparent,
                                    const Color(0x8A000000).withOpacity(0.0),
                                    const Color(0x8A000000).withOpacity(0.3),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 10,
                                left: 15,
                                right: 15,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Imagepickerbottomsheet(
                                              widget.choice.id, widget.choice);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 9,
                                              right: 9,
                                              top: 3,
                                              bottom: 3),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                spreadRadius: 1,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                          ),
                                          child: Wrap(
                                              alignment: WrapAlignment.center,
                                              children: [
                                                Text(S.of(context).option,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .merge(TextStyle(
                                                            color:
                                                                Colors.white)))
                                              ]),
                                        ),
                                      ),
                                      Text(
                                          Helper.pricePrint(
                                              widget.choice.variant.sale_price),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              .merge(TextStyle(
                                                  fontWeight:
                                                      FontWeight.w800))),
                                    ]))
                          ]),
                        ),
                      ]),
                ),
              ),
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding:
                      EdgeInsets.only(left: 15, right: 10, top: 15, bottom: 5),
                  child: Row(children: [
                    currentUser.value.shopTypeId == 2
                        ? Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: widget.choice.variant.foodType == 'Veg'
                                    ? Colors.green
                                    : Colors.brown,
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(top: 0),
                              decoration: BoxDecoration(
                                color: widget.choice.variant.foodType == 'Veg'
                                    ? Colors.green
                                    : Colors.brown,
                                shape: BoxShape.circle,
                              ),
                              width: 6.0,
                              height: 6.0,
                            ),
                          )
                        : Container(),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(widget.choice.product_name,
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                          softWrap: true,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .merge(TextStyle(fontWeight: FontWeight.w600))),
                    ),
                  ])),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: 5,
                  left: 15,
                  right: 15,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: RichText(
                          text: new TextSpan(
                            text:
                                '${widget.choice.variant.quantity} ${widget.choice.variant.unit}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ),

                      // ignore: deprecated_member_use
                      FlatButton(
                        onPressed: () {
                          widget.con.listenForVariant(
                              widget.choice.id, alertBox, widget.pageType);
                        },
                        color: Colors.blue,
                        splashColor: Colors.blue,
                        textColor: Colors.white,
                        child: Text(S.of(context).variant,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .merge(TextStyle(color: Colors.white))),
                      ),
                    ]),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 1,
                  right: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 3, right: 3, bottom: 5),
                      child: GestureDetector(
                        onTap: () {},
                        child: Switch(
                          value: widget.choice.status,
                          onChanged: (value) {
                            setState(() {
                              if (widget.choice.status == true) {
                                widget.choice.status = false;
                              } else {
                                widget.choice.status = true;
                              }
                            });
                            widget.con.productStatus(widget.choice.id,
                                widget.choice.status.toString());
                          },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                      ),
                    ),

                    // ignore: deprecated_member_use
                    currentUser.value.shopTypeId == 2
                    // ignore: deprecated_member_use
                        ? FlatButton(
                            onPressed: () {
                              widget.con
                                  .listenForAddon(widget.choice.id, alertAddon);
                            },
                            color: Colors.blue,
                            splashColor: Colors.blue,
                            textColor: Colors.white,
                            child: Text(S.of(context).addon,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .merge(TextStyle(color: Colors.white))),
                          )
                        : Text(''),

                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        ProductSettingHelper.exit(
                            context, widget.con, widget.choice);
                      },
                    ),
                  ],
                ),
              ),
            ])
          ]),
        ),
      ),
    );
  }

  void alertBox(variantList) {
    var size = MediaQuery.of(context).size;
    double minwidth = size.width * 0.2;
    double maxwidth = size.width * 0.8;
    double minheight = size.width > 769 ? size.width * 0.2 :size.width * 0.24;
    double maxheight = size.width * 0.8;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: IntrinsicWidth(
          stepWidth: 56.0,
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

                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text(
                          S.of(context).add_variant,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () async {
                          var url;
                          final String _apiToken =
                              'api_token=${currentUser.value.apiToken}';
                          // ignore: deprecated_member_use
                          url =
                              '${GlobalConfiguration().getValue('api_base_url')}api_vendor/export_action/my_variantlist/${currentUser.value.id}/${currentUser.value.shopTypeId}?$_apiToken';

                          if (await canLaunch(url)) {
                            await launch(
                              url,
                              forceSafariVC: false,
                            );
                          }
                        },
                        child: Padding(
                            padding: EdgeInsets.only(left: 8, top: 8),
                            child: Image(
                                image: AssetImage('assets/img/excel.png'),
                                width: 25,
                                height: 25)),
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          color: Colors.white,
                          icon: const Icon(Icons.add),
                          iconSize: 30.0,
                          //color: Palette.facebookBlue,
                          onPressed: () {
                            AddVariantHelper.exit(
                                context,
                                widget.con,
                                variantModel(),
                                'add',
                                widget.choice.id,
                                widget.pageType);
                          },
                        ),
                      ),
                    ]),
                    SizedBox(height: 20),
                    variantList.isEmpty
                        ? EmptyOrdersWidget()
                        : Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children:
                                List.generate(variantList.length, (index) {
                              return VariantBoxWidget(
                                variantData: variantList.elementAt(index),
                                con: widget.con,
                                functionType: widget.pageType,
                              );
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

  void alertAddon(addonList) {
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
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text(
                          S.of(context).manage_addons,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () async {
                          var url;
                          final String _apiToken =
                              'api_token=${currentUser.value.apiToken}';
                          // ignore: deprecated_member_use
                          url =
                              '${GlobalConfiguration().getValue('api_base_url')}api_vendor/export_action/my_addons/${currentUser.value.id}/${currentUser.value.shopTypeId}?$_apiToken';

                          if (await canLaunch(url)) {
                            await launch(
                              url,
                              forceSafariVC: false,
                            );
                          }
                        },
                        child: Padding(
                            padding: EdgeInsets.only(left: 8, top: 8),
                            child: Image(
                                image: AssetImage('assets/img/excel.png'),
                                width: 25,
                                height: 25)),
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          color: Colors.white,
                          icon: const Icon(Icons.add),
                          iconSize: 30.0,
                          //color: Palette.facebookBlue,
                          onPressed: () {
                            AddAddonHelper.exit(context, widget.con,
                                AddonModel(), 'add', widget.choice.id);
                          },
                        ),
                      ),
                    ]),
                    SizedBox(height: 20),
                    addonList.isEmpty
                        ? EmptyOrdersWidget()
                        : Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: List.generate(addonList.length, (index) {
                              return AddonBoxWidget(
                                addonData: addonList.elementAt(index),
                                con: widget.con,
                              );
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

  // ignore: non_constant_identifier_names
  Imagepickerbottomsheet(id, details) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new ListTile(
                  leading: new Icon(Icons.adjust_sharp),
                  title: new Text('ID: $id'),
                  onTap: () => {
                    Navigator.pop(context),
                  },
                ),
                (widget.pageType=='Itemproduct')?
                ListTile(
                  leading: new Icon(Icons.edit),
                  title: new Text('Edit General Settings'),
                  onTap: () async {
                    AvailableTimePopupHelper.exit(context,widget.con,details);
                  },
                ):Container(),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: () async {
                    if (widget.pageType == 'product') {
                      await widget.con.delete('product', id);
                    } else {
                      await widget.con.delete('Itemproduct', id);
                    }
                    setState(() {
                      widget.productDetails.remove(details);
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }
}

class AddVariantHelper {
  static exit(
          context, con, variantDetails, pageType, productID, functionType) =>
      showDialog(
          context: context,
          builder: (context) => StatefulBuilder(
              builder: (BuildContext context, setState) => VariantPopupWidget(
                    con: con,
                    variantDetails: variantDetails,
                    pageType: pageType,
                    productId: productID,
                    functionType: functionType,
                  )));
}

class AddAddonHelper {
  static exit(context, con, addonDetails, pageType, productID) => showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (BuildContext context, setState) => AEAddonWidget(
                con: con,
                addonDetails: addonDetails,
                pageType: pageType,
                productId: productID,
              )));
}

class ProductSettingHelper {
  static exit(context, con, product) => showDialog(
      context: context,
      builder: (context) => ProductPopup(con: con, product: product));
}


class AvailableTimePopupHelper {
  static exit(context,con,details) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: AvailableTimePopup(
            con: con,
            details: details,
          )));
}