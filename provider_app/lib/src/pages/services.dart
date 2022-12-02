import 'dart:convert';
import 'package:handy/generated/l10n.dart';
import 'package:dotted_border/dotted_border.dart';
import '/src/controllers/user_controller.dart';
import '/src/models/category.dart';
import '/src/models/select_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:mvc_pattern/mvc_pattern.dart';

class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends StateMVC<Services> {
  UserController _con;
  _ServicesState() : super(UserController()) {
    _con = controller;
  }
  int dropDownValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listenForCategory();
    _con.listenForService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        S.of(context).services,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4.merge(
                            TextStyle(
                                color: Theme.of(context).primaryColorLight)),
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
/* 1st image start */
                          SizedBox(height: 25.0),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20),
                            height: 230,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _con.categoryList.length,
                                itemBuilder: (context, index) {
                                  Category _categoryData =
                                      _con.categoryList.elementAt(index);
                                  return Row(
                                    children: <Widget>[
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 0, bottom: 10),
                                              child: Text(
                                                _categoryData.categoryName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.50,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5,
                                              margin:
                                                  EdgeInsets.only(bottom: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Theme.of(context)
                                                          .focusColor
                                                          .withOpacity(0.05),
                                                      offset: Offset(0, 5),
                                                      blurRadius: 1)
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 5),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text('S.cat',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600)),
                                                                  SizedBox(
                                                                    width: 2.0,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      _categoryData
                                                                          .subcategoryName,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .caption,
                                                                    ),
                                                                  ),
                                                                ]),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 0),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      S
                                                                          .of(
                                                                              context)
                                                                          .experience,
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600)),
                                                                  SizedBox(
                                                                    width: 2.0,
                                                                  ),
                                                                  Text(
                                                                    _categoryData
                                                                        .experience
                                                                        .toString(),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .caption,
                                                                  ),
                                                                ]),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 5),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      S
                                                                          .of(
                                                                              context)
                                                                          .price_per_hour,
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600)),
                                                                  SizedBox(
                                                                    width: 2.0,
                                                                  ),
                                                                  Text(
                                                                    _categoryData
                                                                        .chargePreHrs
                                                                        .toString(),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .caption,
                                                                  ),
                                                                ]),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 5),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      S
                                                                          .of(
                                                                              context)
                                                                          .quick_pitch,
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600)),
                                                                  SizedBox(
                                                                    width: 2.0,
                                                                  ),
                                                                  Text(
                                                                    _categoryData
                                                                        .quickPitch
                                                                        .toString(),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .caption,
                                                                  ),
                                                                ]),
                                                          ),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                IconButton(
                                                                  icon: new Icon(
                                                                      Icons
                                                                          .close),
                                                                  highlightColor:
                                                                      Colors
                                                                          .pink,
                                                                  onPressed:
                                                                      () {
                                                                    _con.popCategoryDynamic(
                                                                        _categoryData);
                                                                  },
                                                                ),
                                                              ]),
                                                        ]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                      SizedBox(
                                        width: 15,
                                      )
                                    ],
                                  );
                                }),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Center(
                              child: Container(
                                height: 130,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: DottedBorder(
                                    dashPattern: [8, 4],
                                    color: Colors.grey,
                                    strokeWidth: 1,
                                    child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Center(
                                          child: Column(children: [
                                            GestureDetector(
                                              onTap: () {
                                                categoryPopup(context, _con);
                                              },
                                              child: Icon(Icons.add_circle,
                                                  size: 40, color: Colors.blue),
                                            ),
                                            SizedBox(height: 10),
                                            Text(S.of(context).add_category,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w600,
                                                ))
                                          ]),
                                        ))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

void categoryPopup(context, con) {
  showDialog(
      context: context, builder: (context) => CategoryDetailsPopup(con: con));
}

// ignore: must_be_immutable
class CategoryDetailsPopup extends StatefulWidget {
  CategoryDetailsPopup({Key key, this.con}) : super(key: key);
  @override
  _CategoryDetailsPopupState createState() => _CategoryDetailsPopupState();
  UserController con;
}

class _CategoryDetailsPopupState extends State<CategoryDetailsPopup> {
  int dropDownValue = 0;
  String _value;
  String _subValue;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
      insetPadding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.09,
        left: MediaQuery.of(context).size.width * 0.09,
        right: MediaQuery.of(context).size.width * 0.09,
        bottom: MediaQuery.of(context).size.width * 0.09,
      ),
    );
  }

  _buildChild(BuildContext context) => SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  S.of(context).add_category,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: widget.con.categoryFormKey,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Column(children: [
                    Container(
                      width: double.infinity,
                      child: DropdownButton(
                          value: _value, //
                          isExpanded: true,
                          focusColor: Theme.of(context).colorScheme.secondary,
                          underline: Container(
                            color: Colors.grey[300],
                            height: 0.8,
                          ),
                          items: widget.con.categoryDropdown
                              .map((SelectDropdown map) {
                            return new DropdownMenuItem(
                              value: map.id,
                              child: new Text(map.name,
                                  style: new TextStyle(color: Colors.black)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _value = value;

                              widget.con.category.categoryId = value;
                              _subValue = null;
                              widget.con.categoryDropdown.forEach((element) {
                                if (element.id == value) {
                                  widget.con.category.categoryName =
                                      element.name;
                                }
                              });
                              _getCitiesList(value);
                            });
                          }),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: DropdownButton(
                          value: _subValue,
                          isExpanded: true,
                          focusColor: Theme.of(context).colorScheme.secondary,
                          underline: Container(
                            color: Colors.grey[300],
                            height: 1.0,
                          ),
                          items: subList?.map((item) {
                                return new DropdownMenuItem(
                                  value: item['id'].toString(),
                                  child: new Text(item['name'],
                                      style:
                                          new TextStyle(color: Colors.black)),
                                );
                              })?.toList() ??
                              [],
                          onChanged: (value) {
                            setState(() {
                              _subValue = value;
                              widget.con.category.subcategoryId = value;
                              subList.forEach((element) {
                                if (element['id'] == value) {
                                  widget.con.category.subcategoryName =
                                      element['name'];
                                }
                              });
                            });
                          }),
                    ),
                    SizedBox(height: 15),
                    Container(
                        width: double.infinity,
                        height: 70,
                        child: TextFormField(
                            textAlign: TextAlign.left,
                            autocorrect: true,
                            onSaved: (input) => widget.con.category.experience =
                                int.parse(input),
                            validator: (input) => input.length < 1
                                ? S.of(context).please_enter_your_experience
                                : null,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: S.of(context).experience,
                              hintStyle: Theme.of(context).textTheme.caption,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300],
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                  width: 1.0,
                                ),
                              ),
                            ))),
                    Container(
                        width: double.infinity,
                        height: 70,
                        child: TextFormField(
                            textAlign: TextAlign.left,
                            autocorrect: true,
                            keyboardType: TextInputType.number,
                            onSaved: (input) => widget
                                .con.category.chargePreHrs = int.parse(input),
                            validator: (input) => input.length < 1
                                ? S.of(context).please_enter_your_price
                                : null,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              hintText: S.of(context).price_per_hour,
                              hintStyle: Theme.of(context).textTheme.caption,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300],
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                  width: 1.0,
                                ),
                              ),
                            ))),
                    Container(
                        width: double.infinity,
                        height: 70,
                        child: TextFormField(
                            textAlign: TextAlign.left,
                            autocorrect: true,
                            onSaved: (input) => widget.con.category.quickPitch =
                                int.parse(input),
                            validator: (input) => input.length < 1
                                ? S.of(context).please_enter_your_quick_pitch
                                : null,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: S.of(context).quick_pitch,
                              hintStyle: Theme.of(context).textTheme.caption,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300],
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                  width: 1.0,
                                ),
                              ),
                            ))),
                    SizedBox(height: 20),
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () {
                        widget.con.pushCategoryDynamic();
                      },
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                      color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                      shape: StadiumBorder(),
                      child: Text(
                        S.of(context).done,
                        style: Theme.of(context).textTheme.headline3.merge(
                            TextStyle(
                                color: Theme.of(context).primaryColorLight)),
                      ),
                    ),
                    SizedBox(height: 20),
                  ]),
                ),
              ),
            ],
          ),
        ),
      );
  List subList;
  Future<String> _getCitiesList(value) async {
    await http.post(
        Uri.parse('${GlobalConfiguration().getValue('api_base_url')}Api_provider/subcategories/$value'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          "api_key": '25d55ad283aa400af464c76d713c07ad',
          "state_id": value,
        }).then((response) {
      var data = json.decode(response.body);
      setState(() {
        subList = data['data'];
      });
    });
    return 'true';
  }
}
