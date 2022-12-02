
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/models/drecommendation.dart';
import 'package:login_and_signup_web/src/repository/product_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

import '../components/constants.dart';

// ignore: must_be_immutable
class AEDroupdownWidget extends StatefulWidget{
  SecondaryController con;
  DRecommendation shopType;
  String pageType;
  // create some values





  AEDroupdownWidget({Key key, this.con, this.shopType, this.pageType}) : super(key: key);
  @override
  _AEDroupdownWidgetState createState() => _AEDroupdownWidgetState();
}

class _AEDroupdownWidgetState extends StateMVC<AEDroupdownWidget> {

  String test;

  Color pickerColor ;
  Color currentColor ;
  void changeColor(Color color) {
    setState(() => currentColor = color);
    widget.con.shopTypeData.colorCode = color.value.toRadixString(16);

  }
  List<DropDownModel> dropDownList = <DropDownModel>[];
  var code = '443a49';
  String _value;
  // ignore: non_constant_identifier_names
  String _Type;
  bool supercategory=false;
  bool shopType=false;
  List<DropDownModel> dropDownListnc = <DropDownModel>[];
  String _svalue;
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    listenForDropdown('shop_focus', 'title', 'status', 'success');
    listenForDropdownnc('h_category', 'category_name');
  }
  Future<void> listenForDropdownnc(table, select) async {
    dropDownListnc.clear();
    final Stream<DropDownModel> stream = await getDropdownDataNC(table, select);

    stream.listen((DropDownModel _list) {


      setState(() => dropDownListnc.add(_list));

    }, onError: (a) {
      print(a);
    }, onDone: () {

    });
  }
  Future<void> listenForDropdown(table, select, column, para1) async {
    dropDownList.clear();
    final Stream<DropDownModel> stream = await getDropdownDataSC(table, select, column, para1);

    stream.listen((DropDownModel _list) {


      setState(() => dropDownList.add(_list));

    }, onError: (a) {
      print(a);
    }, onDone: () {

    });
  }
  @override
  Widget build(BuildContext context) {

    return Container(
        alignment: Alignment.center,
        child:Div(
          colS:12,
          colM:8,
          colL:6,


          child:Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
            ),

            elevation: 0,
            backgroundColor: Colors.transparent,

            insetPadding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.2,
              left:MediaQuery.of(context).size.width * 0.09,
              right:MediaQuery.of(context).size.width * 0.09,
              bottom:MediaQuery.of(context).size.height * 0.25,
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
                        child:Scrollbar(
                          isAlwaysShown: true,
                          child: SingleChildScrollView(
                            child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children:[
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                        )

                                      ]
                                  ),
                                  Text('Add D recommendation',
                                      style: Theme.of(context).textTheme.headline4
                                  ),

                                  Form(
                                      key: widget.con.generalFormKey,
                                      child: Padding(
                                          padding: const EdgeInsets.only(right: 40, left:40),
                                          child:Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:[
                                                Padding(
                                                  padding: EdgeInsets.only(top:10),
                                                  child:Container(
                                                    width: double.infinity,
                                                    child: DropdownButton(
                                                        value: _Type,
                                                        isExpanded: true,
                                                        focusColor: transparent,
                                                        underline: Container(
                                                          color: Colors.grey[300],
                                                          height: 1.0,
                                                        ),
                                                        items: [
                                                          DropdownMenuItem(
                                                            child: Text(S.of(context).handy_service),
                                                            value: '7',
                                                          ),
                                                          DropdownMenuItem(
                                                            child: Text(S.of(context).shop_type),
                                                            value: '3',
                                                          ),
                                                        ],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _Type = value;

                                                            if(_Type=='7'){
                                                              supercategory=true;
                                                              shopType=false;
                                                            }
                                                            else if(_Type=='3'){
                                                              shopType=true;
                                                              supercategory=false;
                                                            }
                                                            widget.con.drData.superId= value;
                                                          });
                                                        }),
                                                  ),
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets.only(top: 10),
                                                  child:Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children:[
                                                        (supercategory)?
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(S.of(context).select_your_super_category),
                                                  Container(
                                                    width: double.infinity,
                                                    child: DropdownButtonFormField(
                                                        value: _svalue, //
                                                        isExpanded: true,
                                                        focusColor: transparent,
                                                        validator: (value) => value == null ? S.of(context).please_select : null,
                                                        items: dropDownListnc.map((DropDownModel map) {
                                                          return new DropdownMenuItem(
                                                            value: map.id,
                                                            child: new Text(map.name, style: new TextStyle(color: Colors.black)),
                                                          );
                                                        }).toList(),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            widget.con.drData.shopTypeId = value;
                                                            _svalue = value;
                                                          });
                                                        }),
                                                  )
                                                          ],
                                                        ):
                                                            Container(),
                                                        SizedBox(height: 15),
                                                        (shopType)?
                                                        Container(
                                                          padding: const EdgeInsets.all(0),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text('S.of(context).please_select_yout_shop_variant_type'),
                                                              Container(
                                                                width: double.infinity,

                                                                child: DropdownButtonFormField(
                                                                    value: _value,
                                                                    isExpanded: true,
                                                                    validator: (value) => value == null ? S.of(context).please_select : null,
                                                                    focusColor: transparent,

                                                                    items: dropDownList.map((DropDownModel map) {
                                                                      return new DropdownMenuItem(
                                                                        value: map.id,
                                                                        child: new Text(map.name, style: new TextStyle(color: Colors.black)),
                                                                      );
                                                                    }).toList(),
                                                                    onChanged: (value) {
                                                                      setState(() {
                                                                        widget.con.drData.shopTypeId = value;
                                                                        _value = value;
                                                                      });
                                                                    }),
                                                              ),
                                                            ],
                                                          ),
                                                        ):
                                                            Container(),

                                                        SizedBox(height: 20),
                                                        // ignore: deprecated_member_use
                                                        SizedBox(height: 10),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            // ignore: deprecated_member_use
                                                            FlatButton(
                                                              onPressed: () {
                                                                widget.con.addEdrecommendation(context,'add');
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
                                                      ]
                                                  ),

                                                ),
                                              ]
                                          )
                                      )
                                  ),
                                ]
                            ),
                          ),),
                      )
                  ),




                ],
              ),
            ),
          ),

        )

    );

  }
}
