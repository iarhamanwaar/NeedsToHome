
import 'dart:io';

import 'package:file_picker/file_picker.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/coupon.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

import '../components/constants.dart';
import '../components/custom_divider_view.dart';
import '../models/Dropdown.dart';
import '../repository/product_repository.dart';
// ignore: must_be_immutable
class AECouponWidget extends StatefulWidget{
  SecondaryController con;
  Coupon couponDetails;
  String pageType;
  AECouponWidget({Key key, this.con, this.couponDetails, this.pageType}) : super(key: key);
  @override
  _AECouponWidgetState createState() => _AECouponWidgetState();
}

class _AECouponWidgetState extends StateMVC<AECouponWidget> {

  // ignore: non_constant_identifier_names
  String couponType;
  String discountType;
  String zone;
  List<DropDownModel> dropDownList = <DropDownModel>[];
  List<DropDownModel> shopList = <DropDownModel>[];

  DateTime pickedDate;
  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    listenForDropdown('zone', 'title',);
    listenForShop();
    if(widget.pageType=='edit') {
      setState(() =>  discountType = widget.couponDetails.discountType);
      setState(() =>  couponType = widget.couponDetails.couponType);
      widget.con.couponData.startDate = widget.couponDetails.startDate;
      widget.con.couponData.endDate = widget.couponDetails.endDate;
      widget.con.couponData.image ='no_change';
      widget.con.couponData.couponType = widget.couponDetails.couponType;
      widget.con.couponData.discountType = widget.couponDetails.discountType;
      widget.con.couponData.zone =  widget.couponDetails.zone;
    } else {
      couponType = '1';
      widget.con.couponData.discountType = 'amount';
      widget.con.couponData.couponType = '1';
      widget.couponDetails.discountType = 'amount';
      widget.con.couponData.startDate = '${pickedDate.day}-${pickedDate.month}-${pickedDate.year}';
      widget.con.couponData.endDate = '${pickedDate.day}-${pickedDate.month}-${pickedDate.year}';

    }

  }
  Future<void> listenForDropdown(table, select) async {
    dropDownList.clear();
    final Stream<DropDownModel> stream = await getDropdownDataNC(table, select);
    stream.listen((DropDownModel _list) {
     setState(() => dropDownList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      if(widget.pageType=='edit') {
       setState(() =>  zone = widget.couponDetails.zone);
      }
    });
  }

  Future<void> listenForShop() async {
    shopList.clear();
    final Stream<DropDownModel> stream = await getDropdownDataSC('vendor', 'display_name','status','approved');
    stream.listen((DropDownModel _list) {
      setState(() => shopList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      if(widget.pageType!='add') {
       setState(() =>  widget.con.couponData.shopId = widget.couponDetails.shopId);
       print('Shop${widget.con.couponData.shopId}');
      }

    });
  }

  _pickDate(selectType) async {

    DateTime date = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 70),
        lastDate: DateTime(DateTime.now().year + 1),
        initialDate: pickedDate,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Theme.of(context).colorScheme.secondary,
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), colorScheme: ColorScheme.light(primary: Theme.of(context).colorScheme.secondary).copyWith(secondary: Theme.of(context).colorScheme.secondary),
            ),
            child: child,
          );
        });
    if (date != null)
      setState(() {
        pickedDate = date;
        if(selectType =='open') {
            widget.con.couponData.startDate  ='${pickedDate.day}-${pickedDate.month}-${pickedDate.year}';
        } else {
          widget.con.couponData.endDate  = '${pickedDate.day}-${pickedDate.month}-${pickedDate.year}';
        }
      });
  }






  @override
  Widget build(BuildContext context) {
    var color = Colors.grey[300];
    var size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.center,
        child:Div(
          colS:12,
          colM:12,
          colL:11,


          child:Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
            ),

            elevation: 0,
            backgroundColor: Colors.transparent,

            insetPadding: EdgeInsets.only(top:size.height * 0.1,
              left:size.width * 0.05,
              right:size.width * 0.05,
              bottom:size.height * 0.05,
            ),
            child:Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color:Theme.of(context).primaryColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(12))
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child:Container(

                        child: SingleChildScrollView(
                          child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[

                                      Container(
                                        padding: EdgeInsets.only(left:30,top:20),
                                        child:Text( widget.pageType=='add'?'Add ${S.of(context).coupon}':S.of(context).edit_coupon,
                                        style: Theme.of(context).textTheme.headline4,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                      )

                                    ]
                                ),
                                    Form(
                                      key: widget.con.registerFormKey,
                                  child: Container(
                                    padding: EdgeInsets.only(right: size.width > 769 ? 25: 18, left:size.width > 769 ? 25: 18),
                                    child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[
                                          Wrap(

                                            children: [
                                              Div(
                                                  colS:12,
                                                  colM:12,
                                                  colL:6,
                                                  child:Column(
                                                      children:[
                                                        Container(
                                                          padding: EdgeInsets.only(top:10,left:size.width > 769 ? 10 :0,right:size.width > 769 ? 10 :0),


                                                          child: Container(
                                                              width: double.infinity,

                                                              child: TextFormField(
                                                                  textAlign: TextAlign.left,
                                                                  autocorrect: true,
                                                                  initialValue: widget.couponDetails.title,
                                                                  onSaved: (input) =>  widget.con.couponData.title = input,
                                                                  validator: (input) => input.length < 1 ? S.of(context).please_enter_the_title : null,
                                                                  keyboardType: TextInputType.text,
                                                                  decoration: InputDecoration(
                                                                    labelText: S.of(context).coupon_title,
                                                                    labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                                    enabledBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: Colors.grey,
                                                                        width: 1.0,
                                                                      ),
                                                                    ),
                                                                    focusedBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color:
                                                                        Theme.of(context).colorScheme.secondary,
                                                                        width: 1.0,
                                                                      ),
                                                                    ),
                                                                  ))),
                                                        ),
                                                      ]
                                                  )
                                              ),
                                              Wrap(

                                                children: [

                                                  Div(
                                                      colS:12,
                                                      colM:12,
                                                      colL:6,
                                                      child:Column(
                                                          children:[

                                                            Container(
                                                              padding: EdgeInsets.only(top:20,left:size.width > 769 ? 10 :0,right: size.width > 769 ? 10 :0),
                                                              child:Container(
                                                                width: double.infinity,
                                                                child: DropdownButtonFormField(
                                                                  value: zone,
                                                                  isExpanded: true,
                                                                  onChanged: (value) {
                                                                    setState(() {
                                                                      zone = value;
                                                                      widget.con.couponData.zone = value;
                                                                    });
                                                                  },
                                                                  focusColor: transparent,
                                                                  hint: Text(S.of(context).select_your_zone),

                                                                  items:  dropDownList.map((DropDownModel map) {
                                                                    return new DropdownMenuItem(
                                                                      value: map.id,
                                                                      child: new Text(map.name, style: new TextStyle(color: Colors.black)),
                                                                    );
                                                                  }).toList(),

                                                                ),
                                                              ),
                                                            ),
                                                          ]
                                                      )
                                                  )
                                                ],
                                              ),
                                              Div(
                                                  colS:12,
                                                  colM:12,
                                                  colL:6,
                                                  child:Column(
                                                      children:[

                                                        Container(
                                                          padding: EdgeInsets.only(top:20,left:size.width > 769 ? 10 :0,right: size.width > 769 ? 10 :0),
                                                          child:Container(
                                                            width: double.infinity,
                                                            child: DropdownButtonFormField(
                                                                value: couponType,
                                                                isExpanded: true,

                                                                focusColor: transparent,
                                                                hint: Text('Coupon Type'),
                                                                items: [
                                                                  DropdownMenuItem(
                                                                    child: Text("Default"),
                                                                    value: '1',
                                                                  ),
                                                                  DropdownMenuItem(
                                                                    child: Text("Shop Wise"),
                                                                    value: '2',
                                                                  ),
                                                                  DropdownMenuItem(
                                                                    child: Text("First Order"),
                                                                    value: '3',
                                                                  ),
                                                                  DropdownMenuItem(
                                                                    child: Text("Free Delivery"),
                                                                    value: '4',
                                                                  ),

                                                                ],
                                                              onChanged: (e){
                                                                setState(() {
                                                                  widget.con.couponData.couponType = e;
                                                                  widget.couponDetails.couponType = e;
                                                                });
                                                              },
                                                                ),

                                                          ),
                                                        ),
                                                      ]
                                                  )
                                              )
                                            ],
                                          ),
                                        //coupon type //
                                          widget.couponDetails.couponType=='2'?Wrap(

                                            children: [

                                              Div(
                                                  colS:12,
                                                  colM:12,
                                                  colL:6,
                                                  child:Column(
                                                      children:[

                                                        Container(
                                                          padding: EdgeInsets.only(top:20,left:size.width > 769 ? 10 :0,right: size.width > 769 ? 10 :0),
                                                          child:Container(
                                                            width: double.infinity,
                                                            child: DropdownButtonFormField(
                                                              value:  widget.con.couponData.shopId,
                                                              isExpanded: true,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  widget.con.couponData.shopId = value;
                                                                });
                                                              },
                                                              focusColor:transparent,
                                                              hint: Text('Select your shop'),

                                                              items:  shopList.map((DropDownModel map) {
                                                                return new DropdownMenuItem(
                                                                  value: map.id,
                                                                  child: new Text(map.name, style: new TextStyle(color: Colors.black)),
                                                                );
                                                              }).toList(),

                                                            ),
                                                          ),
                                                        ),
                                                      ]
                                                  )
                                              )
                                            ],
                                          ):Container(),
                                     Wrap(
                                            children: [

                                              widget.couponDetails.couponType!='4' &&    widget.couponDetails.couponType!='5'?Div(
                                                  colS:12,
                                                  colM:12,
                                                  colL:6,
                                                  child:Column(
                                                      children:[
                                                        Container(
                                                          padding: EdgeInsets.only(top:20,left:size.width > 769 ? 10 :0,right: size.width > 769 ? 10 :0),
                                                          child:Container(
                                                            width: double.infinity,
                                                            child: DropdownButton(
                                                                value: widget.couponDetails.discountType,
                                                                isExpanded: true,
                                                                focusColor: transparent,
                                                                hint: Text(S.of(context).distance_type),
                                                                underline: Container(
                                                                  color: Colors.grey[300],
                                                                  height: 1.0,
                                                                ),
                                                                onChanged: (e)
                                                                {
                                                                  setState(() {
                                                                    widget.con.couponData.discountType = e;
                                                                    widget.couponDetails.discountType =e;
                                                                  });
                                                                },
                                                                items: [
                                                                   DropdownMenuItem(
                                                                      child: Text("Amount"),
                                                                      value: 'amount',
                                                                      ),
                                                                  DropdownMenuItem(
                                                                    child: Text("Percentage"),
                                                                    value: '%',
                                                                  ),
                                                                ],

                                                                ),
                                                          ),
                                                        ),

                                                      ]
                                                  )
                                              ):Container(),
                                              widget.couponDetails.couponType!='4' &&   widget.couponDetails.couponType!='5'?Div(
                                                  colS:12,
                                                  colM:12,
                                                  colL:6,
                                                  child:Column(
                                                      children:[
                                                        Container(
                                                          padding: EdgeInsets.only(top:10,left:size.width > 769 ? 10 :0,right: size.width > 769 ? 10 :0),
                                                          child: Container(
                                                              width: double.infinity,

                                                              child: TextFormField(
                                                                  textAlign: TextAlign.left,
                                                                  autocorrect: true,
                                                                  initialValue: widget.couponDetails.discount,
                                                                  onSaved: (input) =>  widget.con.couponData.discount = input,
                                                                  validator: (input) => input.length < 1 ? S.of(context).please_enter_the_discount : null,
                                                                  inputFormatters: [
                                                                    FilteringTextInputFormatter.allow(
                                                                        RegExp(r'^(\d+)?\.?\d{0,2}')
                                                                    ),
                                                                  ],
                                                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                                  decoration: InputDecoration(
                                                                    labelText: S.of(context).discount,
                                                                    labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                                    enabledBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: Colors.grey,
                                                                        width: 1.0,
                                                                      ),
                                                                    ),
                                                                    focusedBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color:
                                                                        Theme.of(context).colorScheme.secondary,
                                                                        width: 1.0,
                                                                      ),
                                                                    ),
                                                                  ))),
                                                        ),
                                                      ]
                                                  )
                                              ):Container(),
                                            ],
                                          ),




                                          Wrap(
                                            children: [
                                              Div(
                                                  colS:12,
                                                  colM:12,
                                                  colL:6,
                                                  child:Column(
                                                      children:[
                                                        Container(
                                                          padding: EdgeInsets.only(top:10,left:size.width > 769 ? 10 :0,right: size.width > 769 ? 10 :0),
                                                          child: Container(
                                                              width: double.infinity,

                                                              child: TextFormField(
                                                                  textAlign: TextAlign.left,
                                                                  autocorrect: true,
                                                                  initialValue: widget.couponDetails.minimumPurchasedAmount,
                                                                  onSaved: (input) =>  widget.con.couponData.minimumPurchasedAmount= input,
                                                                  validator: (input) => input.length < 1 ? S.of(context).minimum_purchased_amount : null,
                                                                  inputFormatters: [
                                                                    FilteringTextInputFormatter.allow(
                                                                        Helper.getDecimalPointLimit()
                                                                    ),
                                                                  ],
                                                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                                  decoration: InputDecoration(
                                                                    labelText: S.of(context).minimum_purchased_amount,
                                                                    labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                                    enabledBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: Colors.grey,
                                                                        width: 1.0,
                                                                      ),
                                                                    ),
                                                                    focusedBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color:
                                                                        Theme.of(context).colorScheme.secondary,
                                                                        width: 1.0,
                                                                      ),
                                                                    ),
                                                                  ))),
                                                        ),
                                                      ]
                                                  )
                                              ),
                                              Div(
                                                  colS:12,
                                                  colM:12,
                                                  colL:6,
                                                  child:Column(
                                                      children:[


                                                        Container(
                                                          padding: EdgeInsets.only(top:10,left:size.width > 769 ? 10 :0,right: size.width > 769 ? 10 :0),
                                                          child: Container(
                                                              width: double.infinity,

                                                              child: TextFormField(
                                                                  textAlign: TextAlign.left,
                                                                  autocorrect: true,
                                                                  initialValue: widget.couponDetails.terms,
                                                                  onSaved: (input) =>  widget.con.couponData.terms= input,
                                                                  validator: (input) => input.length < 1 ? S.of(context).please_enter_terms : null,
                                                                  keyboardType: TextInputType.text,
                                                                  decoration: InputDecoration(
                                                                    labelText: S.of(context).terms,
                                                                    labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                                    enabledBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: Colors.grey,
                                                                        width: 1.0,
                                                                      ),
                                                                    ),
                                                                    focusedBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color:
                                                                        Theme.of(context).colorScheme.secondary,
                                                                        width: 1.0,
                                                                      ),
                                                                    ),
                                                                  ))),
                                                        ),
                                                      ]
                                                  )
                                              )
                                            ],
                                          ),

                                          Wrap(
                                            children: [
                                              Div(
                                                  colS:12,
                                                  colM:12,
                                                  colL:6,
                                                  child:Column(
                                                      children:[
                                                        Container(
                                                          padding: EdgeInsets.only(top:10,left:size.width > 769 ? 10 :0,right: size.width > 769 ? 10 :0),
                                                          child: Container(
                                                              width: double.infinity,

                                                              child: TextFormField(
                                                                  textAlign: TextAlign.left,
                                                                  autocorrect: true,
                                                                  initialValue: widget.couponDetails.code,
                                                                  onSaved: (input) =>  widget.con.couponData.code = input,
                                                                  validator: (input) => input.length < 1 ? S.of(context).please_enter_your_code : null,
                                                                  keyboardType: TextInputType.text,
                                                                  decoration: InputDecoration(
                                                                    labelText: S.of(context).code,
                                                                    labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                                    enabledBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: Colors.grey,
                                                                        width: 1.0,
                                                                      ),
                                                                    ),
                                                                    focusedBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color:
                                                                        Theme.of(context).colorScheme.secondary,
                                                                        width: 1.0,
                                                                      ),
                                                                    ),
                                                                  ))),
                                                        ),
                                                      ]
                                                  )
                                              ),
                                              widget.couponDetails.couponType!='3'?  Div(
                                                  colS:12,
                                                  colM:12,
                                                  colL:6,
                                                  child:Column(
                                                      children:[
                                                        Container(
                                                          padding: EdgeInsets.only(top:10,left:size.width > 769 ? 10 :0,right: size.width > 769 ? 10 :0),
                                                          child: Container(
                                                              width: double.infinity,

                                                              child: TextFormField(
                                                                  textAlign: TextAlign.left,
                                                                  autocorrect: true,
                                                                  initialValue: widget.couponDetails.limit,
                                                                  onSaved: (input) =>  widget.con.couponData.limit = input,
                                                                  validator: (input) => input.length < 1 ? S.of(context).please_enter_your_limit : null,
                                                                  inputFormatters: [
                                                                    FilteringTextInputFormatter.allow(
                                                                        Helper.getDecimalPointLimit()
                                                                    ),
                                                                  ],
                                                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                                  decoration: InputDecoration(
                                                                    labelText: S.of(context).limit,
                                                                    labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                                    enabledBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: Colors.grey,
                                                                        width: 1.0,
                                                                      ),
                                                                    ),
                                                                    focusedBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color:
                                                                        Theme.of(context).colorScheme.secondary,
                                                                        width: 1.0,
                                                                      ),
                                                                    ),
                                                                  ))),
                                                        ),


                                                      ]
                                                  )
                                              ):Container(),
                                            ],
                                          ),

                                          Div(
                                              colS:12,
                                              colM:12,
                                              colL:6,
                                              child:Column(
                                                  children:[
                                                    Container(
                                                      padding: EdgeInsets.only(top:10,left:size.width > 769 ? 10 :0,right: size.width > 769 ? 10 :0),
                                                      child: Container(
                                                          width: double.infinity,

                                                          child: TextFormField(
                                                              textAlign: TextAlign.left,
                                                              autocorrect: true,
                                                              initialValue: widget.couponDetails.maximumLimit,
                                                              onSaved: (input) =>  widget.con.couponData.maximumLimit = input,
                                                              validator: (input) => input.length < 1 ? S.of(context).please_enter_your_limit : null,
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter.allow(
                                                                    Helper.getDecimalPointLimit()
                                                                ),
                                                              ],
                                                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                              decoration: InputDecoration(
                                                                labelText: 'Maximum limit/user',
                                                                labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                                enabledBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                    color: Colors.grey,
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                                focusedBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                    color:
                                                                    Theme.of(context).colorScheme.secondary,
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                              ))),
                                                    ),


                                                  ]
                                              )
                                          ),

                                          Wrap(
                                            children: [
                                              Div(
                                                  colS:12,
                                                  colM:12,
                                                  colL:6,
                                                  child:Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children:[
                                                        Container(
                                                          padding: EdgeInsets.only(top:20,left:size.width > 769 ? 10 :0,right: size.width > 769 ? 10 :0),
                                                          child: Text(S.of(context).start_date,
                                                            style: Theme.of(context).textTheme.subtitle1,
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets.only(top:20,left:size.width > 769 ? 10 :0,right: size.width > 769 ? 10 :0),
                                                          child:InkWell(
                                                            onTap:
                                                                () async {
                                                              _pickDate('open');
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Text(
                                                            widget.con.couponData.startDate,
                                                                  style: Theme.of(context).textTheme.headline1,
                                                                ),
                                                                Icon(Icons.arrow_drop_down)
                                                              ],
                                                            ),
                                                          ),),
                                                        Container(
                                                            padding: EdgeInsets.only(left:10,right:10,top:5,bottom:20),
                                                            child:CustomDividerView(dividerHeight: 1,color:color)
                                                        ),
                                                      ]
                                                  )
                                              ),
                                              Div(
                                                  colS:12,
                                                  colM:12,
                                                  colL:6,
                                                  child:Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children:[
                                                        Container(
                                                          padding: EdgeInsets.only(top:20,left:size.width > 769 ? 10 :0,right: size.width > 769 ? 10 :0),
                                                          child: Text(S.of(context).expire_date,
                                                            style: Theme.of(context).textTheme.subtitle1,
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets.only(top:20,left:size.width > 769 ? 10 :0,right: size.width > 769 ? 10 :0),
                                                          child:InkWell(
                                                            onTap:
                                                                () async {
                                                              _pickDate('end');
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  widget.con.couponData.endDate,
                                                                  style: Theme.of(context).textTheme.headline1,
                                                                ),
                                                                Icon(Icons.arrow_drop_down)
                                                              ],
                                                            ),
                                                          ),),
                                                        Container(
                                                            padding: EdgeInsets.only(left:10,right:10,top:5,bottom:20),
                                                            child:CustomDividerView(dividerHeight: 1,color:color)
                                                        ),
                                                      ]
                                                  )
                                              )
                                            ],
                                          ),













                                          Container(
                                            padding: EdgeInsets.only(top:10,left:size.width > 769 ? 10 :0,right: size.width > 769 ? 10 :0),
                                            child: Text(S.of(context).upload_image,
                                              style: Theme.of(context).textTheme.subtitle1,
                                            ),
                                          ),

                                          widget.pageType == 'add' ? Container(
                                            color: Theme
                                                .of(context)
                                                .primaryColor,
                                            width: 150,
                                            height: 150,
                                            child: GestureDetector(
                                              onTap: () {
                                                Imagepickerbottomsheet();
                                              },
                                              child: _image == null ? Image(image: AssetImage(
                                                  'assets/img/image_placeholder.png'),
                                                height: double.infinity,
                                                width: double.infinity,
                                                fit: BoxFit.fill,
                                              ) : GetPlatform.isWeb?Image.network(_image.path):Image.file(_image),),
                                          ): Container(
                                            color: Theme
                                                .of(context)
                                                .primaryColor,
                                            width: 150,
                                            height: 150,
                                            child: GestureDetector(
                                              onTap: () {
                                                Imagepickerbottomsheet();
                                              },
                                              child: _image == null ? Image(
                                                image: NetworkImage(
                                                    widget.couponDetails.image),
                                                height: double.infinity,
                                                width: double.infinity,
                                                fit: BoxFit.fill,
                                              ) : GetPlatform.isWeb?Image.network(_image.path):Image.file(_image),),
                                          ),



                                          SizedBox(height:20),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              // ignore: deprecated_member_use
                                              FlatButton(
                                                onPressed: () {
                                                  widget.con.addEdCoupon(context,widget.couponDetails.id,widget.pageType);
                                                },
                                                padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                                                color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                                shape: StadiumBorder(),
                                                child: Text(
                                                 S.of(context).submit,
                                                  style: Theme.of(context).textTheme.headline6.merge(
                                                      TextStyle(
                                                          color: Theme.of(context)
                                                              .primaryColorLight)),
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height:30),
                                        ]
                                    ),

                                  ),
                                ),
                              ]
                          ),
                        ),
                      )
                  ),




                ],
              ),
            ),
          ),

        )

    );



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
          widget.con.couponData.image = pickedFile;
          Navigator.of(context).pop();
        } else {
          print('No image selected.');
        }
      });
    } else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        widget.con.couponData.image = _image;
      });

      Navigator.of(context).pop();
    }
  }

  Future getImagegaller() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.con.couponData.image = pickedFile;
        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
  }


}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
