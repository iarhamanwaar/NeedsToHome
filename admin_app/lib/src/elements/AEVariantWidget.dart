import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_and_signup_web/src/controllers/product_controller.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/models/variant.dart';
import 'package:login_and_signup_web/src/repository/product_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

// ignore: must_be_immutable
class VariantPopupWidget extends StatefulWidget {
  ProductController con;
  variantModel variantDetails;
  String pageType;
  String productId;
  String functionType;
  VariantPopupWidget(
      {Key key,
      this.con,
      this.variantDetails,
      this.pageType,
      this.productId,
      this.functionType})
      : super(key: key);
  @override
  _VariantPopupWidgetState createState() => _VariantPopupWidgetState();
}

class _VariantPopupWidgetState extends StateMVC<VariantPopupWidget> {
  String itemType;
  String tax;
  List<DropDownModel> dropDownnoList = <DropDownModel>[];
  @override
  void initState() {
    // TODO: implement initState

    widget.con.variantData.product_id = widget.productId;
    super.initState();


    listenForNoDropdown('tax', 'tax');
    if (widget.pageType == 'edit') {


      widget.con.saleController.text = widget.variantDetails.sale_price;
      widget.con.strickPriceController.text =
          widget.variantDetails.strike_price;
      widget.con.discountController.text =
          widget.variantDetails.discount.toString();


      widget.con.variantData.uploadImage = 'no_change';
      widget.con.variantData.tax = widget.variantDetails.tax;
      if(widget.functionType!='product') {
        widget.con.variantData.foodType = widget.variantDetails.foodType;
        itemType = widget.variantDetails.foodType;
      } else{
        widget.con.variantData.foodType = 'no_type';
      }
    } else{
      widget.con.strickPriceController.text = '';
      widget.con.discountController.text = '';
      widget.con.saleController.text = '';
      if(widget.functionType!='product') {
        widget.con.variantData.foodType = 'Veg';
        itemType = 'Veg';
      } else{
        widget.con.variantData.foodType = 'no_type';
      }
    }
  }

  listenForNoDropdown(table, select) async {
    dropDownnoList.clear();
    final Stream<DropDownModel> stream = await getDropdownData(
      table,
      select,
    );

    stream.listen((DropDownModel _list) {
      setState(() => dropDownnoList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      if (widget.pageType == 'edit') {
        setState(() {  tax = widget.variantDetails.tax;});

      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Div(
          colS: 12,
          colM: 8,
          colL: 6,
          child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.06,
              left: MediaQuery.of(context).size.width * 0.09,
              right: MediaQuery.of(context).size.width * 0.09,
              bottom: MediaQuery.of(context).size.height * 0.05,
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
                          SizedBox(height: 20),
                          widget.pageType == 'add'
                              ? Text(S.of(context).add_variant,
                                  style: Theme.of(context).textTheme.headline4)
                              : Text('Edit_variant',
                                  style: Theme.of(context).textTheme.headline4),
                          Form(
                            key: widget.con.productFormKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 18, left: 18),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                            onChanged: (e) {
                                              widget.con.calculateDiscount();
                                            },
                                            onSaved: (input) => widget
                                                .con
                                                .variantData
                                                .strike_price = input,
                                            validator: (input) => input.length <
                                                    1
                                                ? S
                                                    .of(context)
                                                    .please_enter_your_strike_price
                                                : null,
                                            textAlign: TextAlign.left,
                                            controller: widget
                                                .con.strickPriceController,
                                            autocorrect: true,
                                            // ignore: deprecated_member_use

                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow( Helper.getDecimalPointLimit()),
                                            ],
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    decimal: true),
                                            decoration: InputDecoration(
                                              labelText:
                                                  S.of(context).strike_price,
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
                                    SizedBox(height: 40),
                                    Container(
                                        width: double.infinity,
                                        child: TextFormField(

                                            onSaved: (input) => widget
                                                .con
                                                .variantData
                                                .discount = double.parse(input),
                                            validator: (input) => input.length <
                                                    1
                                                ? S
                                                    .of(context)
                                                    .please_enter_your_sales_price
                                                : null,
                                            textAlign: TextAlign.left,
                                            controller:
                                                widget.con.discountController,
                                            onChanged: (e) {
                                              widget.con.calculateDiscount();
                                            },
                                            autocorrect: true,


                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^(\d+)?\.?\d{0,2}')
                                              ),
                                            ],
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    decimal: true),
                                            decoration: InputDecoration(
                                              labelText: S.of(context).discount,
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
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                              textAlign: TextAlign.left,
                                              autocorrect: true,
                                              enabled: false,
                                              controller:
                                                  widget.con.saleController,
                                              //initialValue: widget.variantDetails.sale_price,
                                              onSaved: (input) => widget
                                                  .con
                                                  .variantData
                                                  .sale_price = input,
                                              validator: (input) => input
                                                          .length <
                                                      1
                                                  ? S
                                                      .of(context)
                                                      .please_enter_your_sales_price
                                                  : null,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
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
                                    ),
                                    widget.functionType!='product'
                                        ? DropdownButtonFormField(
                                            value: itemType,
                                            isExpanded: true,
                                            focusColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                            validator: (value) => value == null
                                                ? 'Please select'
                                                : null,
                                            items: [
                                              DropdownMenuItem(
                                                child: Text('veg'),
                                                value: 'Veg',
                                              ),
                                              DropdownMenuItem(
                                                child: Text("NON Veg"),
                                                value: 'NON Veg',
                                              ),
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                itemType = value;
                                              });
                                              widget.con.variantData.foodType =
                                                  value;
                                            })
                                        : Container(),

                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                              textAlign: TextAlign.left,
                                              autocorrect: true,
                                              initialValue: widget
                                                  .variantDetails.quantity,
                                              onSaved: (input) => widget.con
                                                  .variantData.quantity = input,
                                              validator: (input) => input
                                                  .length <
                                                  1
                                                  ? S
                                                  .of(context)
                                                  .please_enter_your_quantity
                                                  : null,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                suffixIcon: Tooltip(message: 'Eg:1,2 ',
                                                    child:Icon(Icons.help,color:Colors.grey)
                                                ),
                                                labelText:
                                                S.of(context).quantity,
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
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                              textAlign: TextAlign.left,
                                              autocorrect: true,
                                              initialValue:
                                                  widget.variantDetails.unit,
                                              onSaved: (input) => widget
                                                  .con.variantData.unit = input,
                                              validator: (input) => input
                                                          .length <
                                                      1
                                                  ? S
                                                      .of(context)
                                                      .please_enter_your_unit_price
                                                  : null,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                suffixIcon: Tooltip(message: 'Eg: kg, ltr, piece, etc.. ',
                                                    child:Icon(Icons.help,color:Colors.grey)
                                                ),
                                                labelText: S.of(context).unit,
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
                                    ),

                                    SizedBox(height: 20),
                                    Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                            initialValue: widget
                                                .variantDetails.maxQty,
                                            onSaved: (input) =>
                                            widget.con
                                                .variantData.maxQty = input,
                                            validator: (input) => input
                                                .length <
                                                1
                                                ? 'Please enter the maximum limit'
                                                : null,
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              suffixIcon: Tooltip(message: 'Maximum Qty purchase',
                                                  child:Icon(Icons.help,color:Colors.grey)
                                              ),
                                              labelText:'Max Qty (0=unlimited)',
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
                                    Text(
                                      S.of(context).select_your_image,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        widget.pageType == 'add'
                                            ? Container(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Imagepickerbottomsheet();
                                                  },
                                                  child: _image == null
                                                      ? Image(
                                                          image: AssetImage(
                                                              'assets/img/category_15.jpg'),
                                                          height:
                                                              double.infinity,
                                                          width:
                                                              double.infinity,
                                                          fit: BoxFit.fill,
                                                        )
                                                      : GetPlatform.isWeb
                                                          ? Image.network(
                                                              _image.path)
                                                          : Image.file(_image),
                                                ),
                                              )
                                            : Container(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Imagepickerbottomsheet();
                                                  },
                                                  child: _image == null
                                                      ? Image(
                                                          image: NetworkImage(
                                                              widget
                                                                  .variantDetails
                                                                  .uploadImage),
                                                          height:
                                                              double.infinity,
                                                          width:
                                                              double.infinity,
                                                          fit: BoxFit.fill,
                                                        )
                                                      : GetPlatform.isWeb
                                                          ? Image.network(
                                                              _image.path)
                                                          : Image.file(_image),
                                                ),
                                              ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              S.of(context).tax,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(TextStyle(
                                                      color: Colors.grey)),
                                            ),
                                            DropdownButtonFormField(
                                                value: tax,
                                                isExpanded: true,
                                                focusColor: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                                validator: (value) =>
                                                    value == null
                                                        ? 'Please select'
                                                        : null,
                                                items: dropDownnoList
                                                    .map((DropDownModel map) {
                                                  return new DropdownMenuItem(
                                                    value: map.name,
                                                    child: new Text(map.name,
                                                        style: new TextStyle(
                                                            color:
                                                                Colors.black)),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    tax = value;

                                                    widget.con.variantData.tax =
                                                        value;
                                                  });
                                                }),
                                          ]),
                                    ),
                                    SizedBox(height: 20),
                                    2 == 2
                                        ? Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                            onSaved: (input) => widget.con.variantData.packingCharge = input,
                                            initialValue: widget.variantDetails.packingCharge,
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType:
                                            TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            decoration: InputDecoration(
                                              labelText:
                                              'Packing Charge',
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
                                            ))):Container(),
                                    SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                          onPressed: () {
                                            if (widget.functionType == 'product') {
                                              //  widget.con.variantCE(widget.pageType, widget.categoryDetails.id);
                                              if (widget.pageType == 'add') {
                                                widget.con.variantCE(
                                                    'variant_add',
                                                    widget.con.variantData
                                                        .product_id,
                                                    context,
                                                    'product');
                                              } else {
                                                widget.con.variantCE(
                                                    'variant_edit',
                                                    widget.con.variantData
                                                        .product_id,
                                                    context,
                                                    'product');
                                              }
                                            } else {
                                              if (widget.pageType == 'edit') {
                                                widget.con.variantCE(
                                                    'variant_edit',
                                                    widget.con.variantData
                                                        .product_id,
                                                    context,
                                                    'Itemproduct');
                                              } else {
                                                widget.con.variantCE(
                                                    'variant_add',
                                                    widget.con.variantData
                                                        .product_id,
                                                    context,
                                                    'Itemproduct');
                                              }
                                            }
                                          },
                                          padding: EdgeInsets.only(
                                              top: 15,
                                              bottom: 15,
                                              left: 40,
                                              right: 40),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(1),
                                          shape: StadiumBorder(),
                                          child: Text(
                                            S.of(context).submit,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .merge(TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColorLight)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                  ]),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ));
  }

  // ignore: non_constant_identifier_names
  Imagepickerbottomsheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new ListTile(
                  leading: new Icon(Icons.camera),
                  title: new Text(S.of(context).camera),
                  onTap: () => getImage(),
                ),
                new ListTile(
                  leading: new Icon(Icons.image),
                  title: new Text(S.of(context).gallery),
                  onTap: () => getImagegaller(),
                ),
              ],
            ),
          );
        });
  }

  File _image;
  int currStep = 0;
  final picker = ImagePicker();

  Future getImage() async {
    if (GetPlatform.isWeb || GetPlatform.isMobile) {
      final pickedFile = await picker.getImage(
          source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          widget.con.variantData.uploadImage = pickedFile;
          Navigator.of(context).pop();
        } else {
          print('No image selected.');
        }
      });
    } else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        widget.con.variantData.uploadImage = _image;
      });

      Navigator.of(context).pop();
    }
  }

  Future getImagegaller() async {
    if (GetPlatform.isWeb || GetPlatform.isMobile) {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          widget.con.variantData.uploadImage = pickedFile;

          Navigator.of(context).pop();
        } else {
          print('No image selected.');
        }
      });
    } else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        widget.con.variantData.uploadImage = _image;
      });

      Navigator.of(context).pop();
    }
  }
}
