import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_and_signup_web/src/controllers/product_controller.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/repository/settings_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:intl/intl.dart';
// ignore: must_be_immutable
class AddItem extends StatefulWidget {
  String shopType;
  int shopId;
  AddItem(
      {Key key, this.shopType, this.shopId})
      : super(key: key);
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends StateMVC<AddItem> {
  ProductController _con;
  _AddItemState() : super(ProductController()) {
    _con = controller;
  }

  String itemType = 'Veg';
  String category;
  String tax;
  @override
  void initState() {
    _con.listenForDropdown(
        'category', 'category_name', 'data_vendors', widget.shopId);
    // TODO: implement initState
    super.initState();
    _con.productData.itemType = 'Veg';
    _con.listenForNoDropdown('tax', 'tax');
  }
  TextEditingController timeinput = TextEditingController();
  TextEditingController closetime = TextEditingController();
  bool isSwitched = false;
  _selectTime(type) async {

    TimeOfDay selectedTime =
    TimeOfDay(hour: int.parse(DateFormat('kk','en-US').format(DateTime.now())), minute: int.parse(DateFormat('mm','en-US').format(DateTime.now())));

    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,

        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(

              primaryColor: Theme.of(context).colorScheme.secondary,
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), colorScheme: ColorScheme.light(primary: Theme.of(context).colorScheme.secondary).copyWith(secondary: Theme.of(context).colorScheme.secondary),

            ),
            child: child,
          );
        });
    if (picked != null)
      setState(() {
        selectedTime = picked;

        if (type == 'from') {
          print('from time');
         if(setting.value.mobileLanguage.value.languageCode=='en') {
           _con.productData.fromTime = picked.format(context);
           timeinput.text = picked.format(context);
         } else {
           _con.productData.fromTime = Helper.tConvert(picked.hour, picked.minute.toString());
           timeinput.text = Helper.tConvert(picked.hour, picked.minute.toString());
         }
        } else {
          if(setting.value.mobileLanguage.value.languageCode=='en') {
            _con.productData.toTime = picked.format(context);
            closetime.text = picked.format(context);
          } else {
            _con.productData.toTime = Helper.tConvert(picked.hour, picked.minute.toString());
            closetime.text = Helper.tConvert(picked.hour, picked.minute.toString());
          }
        }

        /**_setTime = timePicker.formatDate(
            DateTime(year, month, day, selectedTime.hour, selectedTime.minute), [timePicker.hh, ':', timePicker.nn, " ", timePicker.am]).toString();
         */
      });
  }


  bool status = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scrollbar(
        isAlwaysShown: true,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  Container(
                    padding: EdgeInsets.only(top:20,left:20),
                    child:IconButton(onPressed: (){

                        Navigator.pop(context);


                    },
                        icon:Icon(Icons.arrow_back)
                    ),
                  ),

                ]
            ),
            Responsive(children: [
              Padding(
                  padding: EdgeInsets.all(24),
                  child: Div(
                      colS: 12,
                      colM: 12,
                      colL: 12,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Div(
                              colS: 12,
                              colM: 6,
                              colL: 6,
                              child: Container(
                                padding: EdgeInsets.all(27),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Form(
                                  key: _con.productFormKey,
                                  child: Column(
                                    children: [
                                      Text('Add Item',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4),
                                      SizedBox(height: 20),
                                      Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                              onSaved: (input) => _con
                                                  .productData
                                                  .productTitle = input,
                                              validator: (input) => input
                                                          .length <
                                                      1
                                                  ? S
                                                      .of(context)
                                                      .please_enter_your_product
                                                  : null,
                                              textAlign: TextAlign.left,
                                              autocorrect: true,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                labelText:
                                                    S.of(context).product_title,
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
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                S.of(context).category,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: Colors.grey)),
                                              ),
                                              DropdownButtonFormField(
                                                  value: category,
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
                                                  items: _con.dropDownList
                                                      .map((DropDownModel map) {
                                                    return new DropdownMenuItem(
                                                      value: map.name,
                                                      child: new Text(map.name,
                                                          style: new TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      category = value;
                                                    });
                                                    _con.dropDownList
                                                        .forEach((element) {
                                                      if (element.name ==
                                                          value) {
                                                        _con.productData
                                                                .category =
                                                            element.id;
                                                      }
                                                    });
                                                  }),
                                            ]),
                                      ),
                                      SizedBox(height: 20),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'item type',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(TextStyle(
                                                      color: Colors.grey)),
                                            ),
                                            DropdownButtonFormField(
                                                value: itemType,
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
                                                items: [
                                                  DropdownMenuItem(
                                                    child: Text('veg'),
                                                    value: 'Veg',
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text('non_veg'),
                                                    value: 'NON Veg',
                                                  ),
                                                ],
                                                onChanged: (value) {
                                                  setState(() {
                                                    itemType = value;
                                                  });
                                                  _con.productData.itemType =
                                                      value;
                                                }),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                              onChanged: (e) {
                                                _con.calculateDiscount();
                                              },
                                              controller:
                                                  _con.strickPriceController,
                                              onSaved: (input) =>
                                                  _con.productData.strikePrice =
                                                      double.parse(input),
                                              validator: (input) => input
                                                          .length <
                                                      1
                                                  ? S
                                                      .of(context)
                                                      .please_enter_your_strike_price
                                                  : null,
                                              textAlign: TextAlign.left,
                                              autocorrect: true,


                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(
                                                    RegExp(r'^(\d+)?\.?\d{0,3}')
                                                ),
                                              ],
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
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
                                              onSaved: (input) =>
                                                  _con.productData.discount =
                                                      double.parse(input),
                                              validator: (input) => input
                                                          .length <
                                                      1
                                                  ? S
                                                      .of(context)
                                                      .please_enter_your_sales_price
                                                  : null,
                                              textAlign: TextAlign.left,
                                              controller:
                                                  _con.discountController,
                                              onChanged: (e) {
                                                _con.calculateDiscount();
                                              },
                                              autocorrect: true,

                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(
                                                    RegExp(r'^(\d+)?\.?\d{0,2}')
                                                ),
                                              ],
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),
                                              decoration: InputDecoration(
                                                labelText:
                                                    S.of(context).discount,
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
                                              onSaved: (input) =>
                                                  _con.productData.salePrice =
                                                      double.parse(input),
                                              validator: (input) => input
                                                          .length <
                                                      1
                                                  ? S
                                                      .of(context)
                                                      .please_enter_your_sales_price
                                                  : null,
                                              textAlign: TextAlign.left,
                                              autocorrect: true,
                                              controller: _con.saleController,
                                              enabled: false,
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
                                      SizedBox(height: 20),
                                      Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                              onSaved: (input) => _con
                                                  .productData.quantity = input,
                                              validator: (input) => input
                                                          .length <
                                                      1
                                                  ? S
                                                      .of(context)
                                                      .please_enter_your_quantity_price
                                                  : null,
                                              textAlign: TextAlign.left,
                                              autocorrect: true,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                suffixIcon: Tooltip(message: 'Eg 1,2',
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
                                      SizedBox(height: 40),
                                      Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                              onSaved: (input) =>
                                                  _con.productData.unit = input,
                                              validator: (input) => input
                                                          .length <
                                                      1
                                                  ? S
                                                      .of(context)
                                                      .please_enter_your_unit_price
                                                  : null,
                                              textAlign: TextAlign.left,
                                              autocorrect: true,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                labelText: S.of(context).unit,
                                                suffixIcon: Tooltip(message: 'Eg: kg, ltr, piece, etc.. ',
                                                    child:Icon(Icons.help,color:Colors.grey)
                                                ),
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
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Div(
                                              colL: 12,
                                              colS: 12,
                                              colM: 12,
                                              child: Container(
                                                child: Text('available_time',
                                                    style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.grey))),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Wrap(children: [
                                              Text('${'from time'}:'),
                                              Container(
                                                width: double.infinity,
                                                child: TextFormField(
                                                  controller: timeinput,
                                                  validator: (input) => input.length < 1 ? 'please enter the available time' : null,
                                                  readOnly: true,
                                                  //set it true, so that user will not able to edit text
                                                  onTap: () async {
                                                    _selectTime('from');
                                                  },
                                                ),
                                              ),
                                              Text('${'to time'}:'),
                                              Container(
                                                width: double.infinity,
                                                child: TextFormField(
                                                  controller: closetime,
                                                  //editing controller of this TextField
                                                  validator: (input) => input.length < 1 ? 'please enter the available time' : null,
                                                  readOnly: true,
                                                  onTap: () async {
                                                    _selectTime('to');
                                                  },
                                                ),
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 100,
                                        child: GestureDetector(
                                          onTap: () {
                                            Imagepickerbottomsheet();
                                          },
                                          child: _image == null
                                              ? Image(
                                                  image: AssetImage(
                                                      'assets/img/category_15.jpg'),
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                  fit: BoxFit.fill,
                                                )
                                              : GetPlatform.isWeb
                                                  ? Image.network(_image.path)
                                                  : Image.file(_image),
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Theme.of(context).dividerColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextFormField(
                                            onSaved: (input) => _con.productData
                                                .description = input,
                                            maxLines: 5,
                                            decoration:
                                                InputDecoration.collapsed(
                                              hintText:
                                                  S.of(context).description,
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(TextStyle(
                                                      color: Colors.grey)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                      Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                              onSaved: (input) => _con
                                                  .productData.stock = input,
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
                                                    S.of(context).current_stock,
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
                                                  items: _con.dropDownnoList
                                                      .map((DropDownModel map) {
                                                    return new DropdownMenuItem(
                                                      value: map.name,
                                                      child: new Text(map.name,
                                                          style: new TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      tax = value;

                                                      _con.productData.tax =
                                                          value;
                                                      print(
                                                          _con.productData.tax);
                                                    });
                                                  }),
                                            ]),
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                              onSaved: (input) => _con
                                                  .productData.packingCharge = input,
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
                                                'packing_charge',
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
                                      InkWell(
                                          onTap: () {},
                                          child: Container(
                                            color:
                                                Theme.of(context).primaryColor,
                                            padding: EdgeInsets.only(
                                                left: size.width * 0.05,
                                                right: size.width * 0.05),
                                            child: Container(
                                              width: double.infinity,
                                              height: 45.0,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              // ignore: deprecated_member_use
                                              child: FlatButton(
                                                onPressed: () {
                                                  _con.addEditProductItem(context, widget.shopType, widget.shopId);
                                                },
                                                child: Center(
                                                    child: Text(
                                                  S.of(context).submit,
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )),
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]))),
            ])
            // SideCard(),
          ],
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
          _con.productData.uploadImage = pickedFile;
          Navigator.of(context).pop();
        } else {
          print('No image selected.');
        }
      });
    } else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        _con.productData.uploadImage = _image;
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
          _con.productData.uploadImage = pickedFile;

          Navigator.of(context).pop();
        } else {
          print('No image selected.');
        }
      });
    } else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        _con.productData.uploadImage = _image;
      });

      Navigator.of(context).pop();
    }
  }
}
