import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../generated/l10n.dart';
import '../../controllers/user_controller.dart';
import '../../helpers/helper.dart';
import '../../models/category.dart';
import '../../models/register.dart';
import '../../models/select_dropdown.dart';
// ignore: must_be_immutable
class RegisterFormStep6 extends StatefulWidget {
  RegisterFormStep6({Key key, this.registerData, this.image, this.proofImage}) : super(key: key);
  Registermodel registerData;
  File image;
  File proofImage;

  @override
  _RegisterFormStep6State createState() => _RegisterFormStep6State();
}

class _RegisterFormStep6State extends StateMVC<RegisterFormStep6> {

  UserController _con;
  _RegisterFormStep6State() : super(UserController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
    _con.listenForCategory();

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _con.scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            //color: Theme.of(context).primaryColorDark,
              image: DecorationImage(
                  image: AssetImage('assets/img/background_image.jpg',
                  ),
                  fit: BoxFit.fill
              )
          ),
          child: SafeArea(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only( left: 10.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color:Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 10.0),
                      Text(S.of(context).category,
                        style: Theme.of(context).textTheme.headline4.merge(TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),


                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    width:double.infinity,
                    padding: EdgeInsets.only(left:20,right:20,top:20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              spreadRadius: 15
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 20),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 0),
                            height: 230,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _con.categoryList.length,
                                itemBuilder: (context, index) {
                                  Category _categoryData = _con
                                      .categoryList
                                      .elementAt(index);
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
                                                _categoryData
                                                    .categoryName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6,
                                              ),
                                            ),
                                            Container(
                                              width:
                                              MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.50,
                                              height:
                                              MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  5,
                                              margin: EdgeInsets.only(
                                                  bottom: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius
                                                    .circular(6),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Theme.of(
                                                          context)
                                                          .focusColor
                                                          .withOpacity(
                                                          0.05),
                                                      offset:
                                                      Offset(0, 5),
                                                      blurRadius: 1)
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.all(
                                                        10.0),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                    'S.cat',
                                                                    style:
                                                                    TextStyle(fontWeight: FontWeight.w600)),
                                                                SizedBox(
                                                                  width:
                                                                  2.0,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                  Text(
                                                                    _categoryData.subcategoryName,
                                                                    overflow:
                                                                    TextOverflow.ellipsis,
                                                                    maxLines:
                                                                    1,
                                                                    style:
                                                                    Theme.of(context).textTheme.caption,
                                                                  ),
                                                                ),
                                                              ]),
                                                          Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                    S.of(context).experience,
                                                                    style: TextStyle(fontWeight: FontWeight.w600)),
                                                                SizedBox(
                                                                  width:
                                                                  2.0,
                                                                ),
                                                                Text(
                                                                  _categoryData
                                                                      .experience
                                                                      .toString(),
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .caption,
                                                                ),
                                                              ]),
                                                          Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                    'Pricing Type',
                                                                    style: TextStyle(fontWeight: FontWeight.w600)),
                                                                SizedBox(
                                                                  width:
                                                                  2.0,
                                                                ),
                                                                Text(
                                                                  _categoryData
                                                                      .type
                                                                      .toString(),
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .caption,
                                                                ),
                                                              ]),
                                                          Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                    'Price',
                                                                    style: TextStyle(fontWeight: FontWeight.w600)),
                                                                SizedBox(
                                                                  width:
                                                                  2.0,
                                                                ),
                                                                Text(
                                                                  Helper.pricePrint(_categoryData
                                                                      .chargePreHrs
                                                                      .toString()),
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .caption,
                                                                ),
                                                              ]),
                                                          Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                    S.of(context).quick_pitch,
                                                                    style: TextStyle(fontWeight: FontWeight.w600)),
                                                                SizedBox(
                                                                  width:
                                                                  2.0,
                                                                ),
                                                                Text(
                                                                  _categoryData
                                                                      .quickPitch
                                                                      .toString(),
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .caption,
                                                                ),
                                                              ]),
                                                          Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                              children: [
                                                                IconButton(
                                                                  icon:
                                                                  new Icon(Icons.close),
                                                                  highlightColor:
                                                                  Colors.pink,
                                                                  onPressed:
                                                                      () {
                                                                    _con.popCategory(_categoryData);
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
                            height: MediaQuery.of(context).size.height *
                                0.02,
                          ),
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20),
                              child: Center(
                                child: Container(
                                  height: 130,
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.4,
                                  child: DottedBorder(
                                      dashPattern: [8, 4],
                                      color: Colors.grey,
                                      strokeWidth: 1,
                                      child: Padding(
                                          padding:
                                          const EdgeInsets.all(20),
                                          child: Center(
                                            child: Column(children: [
                                              GestureDetector(
                                                onTap: () {
                                                  _con.categoryDropdown
                                                      .forEach(
                                                          (element) {
                                                        print(element
                                                            .toMap());
                                                      });
                                                  categoryPopup(
                                                      context, _con);
                                                },
                                                child: Icon(
                                                    Icons.add_circle,
                                                    size: 40,
                                                    color: Colors.blue),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                  S
                                                      .of(context)
                                                      .add_category,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ))
                                            ]),
                                          ))),
                                ),
                              ),
                            ),
                          ]),
                        ])
                  ),
                ),

                Align(
                  alignment: Alignment.bottomRight,
                  child:Container(
                      width: double.infinity,
                      height: 70,
                      color: Theme.of(context).primaryColor,
                      child:Container(
                          padding: EdgeInsets.only(left:10,right:10,top:10,bottom:10),
                          child:  MaterialButton(
                              onPressed:(){
                if (_con.categoryList.length == 0) {
    // ignore: deprecated_member_use
                _con.scaffoldKey?.currentState?.showSnackBar(SnackBar(
                  content: Text('Add your category'),
                  ));
              } else{
                    _con.register(widget.image,   widget.proofImage,widget.registerData);
              }
                              },
                              color:Theme.of(context).colorScheme.secondary,
                              child: Text(S.of(context).save_and_proceed,
                                style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).primaryColorLight)),
                              )
                          )
                      )
                  ),

                ),
              ],
            ),
          )
      ),
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
  String _type = 'Fixed';
  @override
  void initState() {
    widget.con.category.type = 'Fixed';
  }

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
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              S.of(context).add_category,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

                SizedBox(height: 15),
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
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: DropdownButton(
                      value: _type,
                      isExpanded: true,
                      focusColor: Theme.of(context).colorScheme.secondary,
                      underline: Container(
                        color: Colors.grey[300],
                        height: 1.0,
                      ),
                      items: [
                        DropdownMenuItem(
                          child: Text("Fixed Pricing"),
                          value: 'Fixed',
                        ),
                        DropdownMenuItem(
                          child: Text("Hourly Pricing"),
                          value: 'Hour',
                        ),


                      ],
                      onChanged: (value) {
                        setState(() {
                          _subValue = value;
                          widget.con.category.type = value;
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
                          hintText: 'Price',
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
                    widget.con.pushCategory();
                  },
                  padding:
                  EdgeInsets.symmetric(vertical: 14, horizontal: 70),
                  color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                  shape: StadiumBorder(),
                  child: Text(
                    S.of(context).done,
                    style: Theme.of(context).textTheme.headline6.merge(
                        TextStyle(
                            color:
                            Theme.of(context).scaffoldBackgroundColor)),
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
    print(
        '${GlobalConfiguration().getValue('api_base_url')}Api_provider/subcategories/$value');
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
        print('load sub');
        print(data['data']);
        subList = data['data'];
      });
    });
    return 'true';
  }
}