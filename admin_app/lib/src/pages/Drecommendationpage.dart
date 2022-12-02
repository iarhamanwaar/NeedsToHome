import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/elements/AEDropdownWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/models/drecommendation.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

class DRecommendationPage extends StatefulWidget {
  @override
  _DRecommendationPageState createState() => _DRecommendationPageState();
}

class _DRecommendationPageState extends StateMVC<DRecommendationPage>  {
  SecondaryController _con;
  _DRecommendationPageState() : super(SecondaryController()) {
    _con = controller;
  }
  bool isSwitched = false;
  @override
  // ignore: must_call_super
  void initState()  {
    _con.listenForDrec();
  }

  callback(){
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Container(
      color:Theme.of(context).primaryColor.withOpacity(0.6),
      child: SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Div(
                colS: 12,
                colM: 12,
                colL: 12,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 20),
                      Container(
                        width: size.width*0.9,
                        margin: EdgeInsets.only(left: 30.0, top: 25.0, right: 30, bottom: 10.0),
                        child:Wrap(
                            alignment: WrapAlignment.start,
                            children:[
                              Div(
                                  colS: GetPlatform.isMobile?  12 :8,
                                  colM:GetPlatform.isMobile?  12 :8,
                                  colL:GetPlatform.isMobile?  12 :8,
                            child:Row(
                                children:[
                                  Expanded(
                                    child:Wrap(
                                children:[
                                  Text(
                                    S.of(context).manage_default_recommandations,
                                    style: Theme.of(context).textTheme.headline4,
                                  ),
                                  SizedBox(width:10),
                              Container(
                              height: 30.0,
                              width: 30.0,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                color: Theme.of(context).primaryColorLight,
                                icon: const Icon(Icons.add),
                                iconSize: 30.0,
                                //color: Palette.facebookBlue,
                                onPressed: () {
                                  //AddEdPopupHelper.exit(context, _con, this.callback, ShopTypeModel(), 'add');
                                  AddEdPopupHelper.exit(context, _con, DRecommendation(), 'add');
                                },
                              ),
                            ),
                                ]
                            )
                                  ),



                                ]
                            )
                        ),

                            ]
                        ),
                      ),

                      SizedBox(height: 10),
                      SizedBox(
                        height: 10,
                      ),
                      _con.drList.isEmpty?EmptyOrdersWidget():Container(
                          margin: EdgeInsets.only(top:20,left:20, right: 20,bottom:30),
                          child:SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                                child: DataTable(
                                    headingTextStyle: Theme.of(context).textTheme.headline1,
                                    dataTextStyle: Theme.of(context).textTheme.subtitle2,
                                    columns: [
                                      DataColumn(
                                        label: Text('S.NO'),),
                                      DataColumn(
                                        label: Text(S.of(context).super_c),),
                                      DataColumn(
                                        label: Text(S.of(context).shop_type),
                                      ),

                                      /**DataColumn(
                                        label: Text('SortBy'),
                                      ), */
                                      DataColumn(
                                        label: Text(S.of(context).options),
                                      ),


                                    ],
                                    rows: List.generate(_con.drList.length, (index) {

                                      return DataRow(cells:
                                      [DataCell(Text((index+1).toString()??' ')),
                                        DataCell(Text(_con.drList[index].superId??' ')),
                                        DataCell(Text(_con.drList[index].shopTypeId??' ')),

                                       // DataCell(Text(_con.drList[index].sortBy??' ')),
                                        DataCell(Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              // ignore: deprecated_member_use
                                              FlatButton(
                                                onPressed: () {
                                                  Imagepickerbottomsheet(_con.drList[index].id, _con.drList[index]);
                                                },
                                                padding: EdgeInsets.only(left:10,right:10),
                                                color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                                shape: StadiumBorder(),
                                                child: Text(
                                                  S.of(context).option,
                                                  style: Theme.of(context).textTheme.headline1.merge(
                                                      TextStyle(height: 1.2,
                                                          color: Theme.of(context)
                                                              .primaryColorLight)),
                                                ),
                                              ),

                                            ],
                                          ),
                                        )),
                                      ]
                                      );
                                    }
                                    )
                                )
                            ),
                          )
                      )
                    ])),
          ],
        ),
      ),
    );



  }

  // ignore: non_constant_identifier_names
  Imagepickerbottomsheet(id, Details) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [


                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: ()  async{
                    await _con.delete('d_recommendation',id);

                    Navigator.pop(context);
                    setState(() {_con.drList.clear();});

                  },
                ),
              ],
            ),
          );
        });
  }
}




class AddEdPopupHelper {

  static exit(context,con, details, pageType) => showDialog(context: context, builder: (context) =>  AEDroupdownWidget(con: con,shopType: details, pageType: pageType, ));

}