
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/product_controller.dart';
import 'package:login_and_signup_web/src/models/addon.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

// ignore: must_be_immutable
class AEAddonWidget extends StatefulWidget {
  AEAddonWidget(
      {Key key, this.con, this.pageType, this.productId, this.addonDetails})
      : super(key: key);
  ProductController con;
  String pageType;
  String productId;
  AddonModel addonDetails;

  @override
  _AEAddonWidgetState createState() => _AEAddonWidgetState();
}

class _AEAddonWidgetState extends StateMVC<AEAddonWidget> {
  String itemType;

  @override
  void initState() {

    widget.con.variantData.type = '2';
    // TODO: implement initState
    if (widget.pageType == 'add') {
      itemType = 'Veg';
      widget.con.addonData.productId = widget.productId;
      widget.con.addonData.foodType = 'Veg';
    } else {
      itemType = widget.addonDetails.foodType;
      widget.con.addonData.productId = widget.productId;
      widget.con.addonData.foodType = widget.addonDetails.foodType;
      itemType =  widget.addonDetails.foodType;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.con.addonFormKey,
      child: Container(
          alignment: Alignment.center,
          child: Div(
            colS: 12,
            colM: 8,
            colL: 6,
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 0,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.15,
                left: MediaQuery.of(context).size.width * 0.09,
                right: MediaQuery.of(context).size.width * 0.09,
                bottom: MediaQuery.of(context).size.height * 0.15,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      child: Scrollbar(
                        isAlwaysShown: true,
                        child: SingleChildScrollView(
                          child: Column(children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ]),
                            widget.pageType == "add"
                                ? Text(S.of(context).add_addon,
                                    style:
                                        Theme.of(context).textTheme.headline4)
                                : Text(S.of(context).edit_addon,
                                    style:
                                        Theme.of(context).textTheme.headline4),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 40, left: 40),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,
                                            initialValue:
                                                widget.addonDetails.name,
                                            onSaved: (input) => widget
                                                .con.addonData.name = input,
                                            validator: (input) =>
                                                input.length < 1
                                                    ? 'Please enter the name'
                                                    : null,
                                            decoration: InputDecoration(
                                              labelText: S.of(context).name,
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(TextStyle(
                                                      color: Colors.grey)),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ))),
                                    SizedBox(height: 10),
                                    Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            initialValue: widget
                                                .addonDetails.salesPrice
                                                ,
                                            onSaved: (input) => widget
                                                    .con.addonData.salesPrice =
                                                input,
                                            validator: (input) => input.length <
                                                    1
                                                ? 'Please enter the Sales Price'
                                                : null,
                                            inputFormatters: [FilteringTextInputFormatter.allow( RegExp(r'^(\d+)?\.?\d{0,3}')),],

                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    decimal: true),
                                            decoration: InputDecoration(
                                              labelText:
                                                  S.of(context).sales_price,
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(TextStyle(
                                                      color: Colors.grey)),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ))),
                                    SizedBox(height: 10),
                                    Text(S.of(context).food_type
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: DropdownButton(
                                          value: itemType,
                                          isExpanded: true,
                                          focusColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          underline: Container(
                                            color: Colors.grey[300],
                                            height: 1.0,
                                          ),
                                          items: [
                                            DropdownMenuItem(
                                              child: Text(S.of(context).veg),
                                              value: 'Veg',
                                            ),
                                            DropdownMenuItem(
                                              child: Text(S.of(context).non_veg),
                                              value: 'NON Veg',
                                            ),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              itemType = value;
                                            });
                                            widget.con.addonData.foodType =
                                                value;
                                          }),
                                    ),
                                  ]),
                            ),
                          ]),
                        ),
                      ),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ignore: deprecated_member_use
                        FlatButton(
                          onPressed: () {
                            widget.pageType == 'add'
                                ? widget.con
                                    .addonUpdate(context, 'addon_add', 'no')
                                : widget.con.addonUpdate(context,
                                    'addon_update', widget.addonDetails.id);
                          },
                          padding: EdgeInsets.only(
                              top: 15, bottom: 15, left: 40, right: 40),
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(1),
                          shape: StadiumBorder(),
                          child: Text(
                            S.of(context).submit,
                            style: Theme.of(context).textTheme.headline6.merge(
                                TextStyle(
                                    color:
                                        Theme.of(context).primaryColorLight)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
