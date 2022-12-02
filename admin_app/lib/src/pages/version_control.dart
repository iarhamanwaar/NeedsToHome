import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/elements/VersionControlWidgets.dart';
import 'package:login_and_signup_web/src/models/version_control.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';


class VersionControlWidget extends StatefulWidget {
  @override
  _VersionControlWidgetState createState() => _VersionControlWidgetState();
}

class _VersionControlWidgetState extends StateMVC<VersionControlWidget> {

  SecondaryController _con;

  _VersionControlWidgetState() : super(SecondaryController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listenForVersionList();
  }


  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      //key: _con.,
      body: Container(
        color:Theme.of(context).primaryColor.withOpacity(0.6),
        height: double.infinity,
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
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 30.0, top: 25.0, right: 30, bottom: 10.0),
                        child:Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children:[
                              Div(
                                  colS:6,
                                  colM:6,
                                  colL:6,
                                  child:Wrap(
                                      children:[
                                        Text(
                                         'Version Control',
                                          style: Theme.of(context).textTheme.headline4,
                                        ),
                                        SizedBox(width:10),

                                      ]
                                  )
                              ),


                              Div(
                                colS:6,
                                colM:6,
                                colL:6,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children:[
                                    /**  Padding(
                                        padding:EdgeInsets.only(right:30),
                                        child:IconButton(
                                          onPressed:() async {
                                            /**var results = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchBoxCategory(searchType: 'category',categoryList: _con.categoryList,)));

                                                if(results == null){

                                                //  _con.listenForCategories();
                                                } */
                                          },
                                          icon:Icon(Icons.search, color: Theme.of(context).accentColor),
                                        ),
                                      ), */


                                    ]
                                ),
                              ),

                            ]
                        ),
                      ),


                      SizedBox(height: 20),
                      _con.versionList.isEmpty?EmptyOrdersWidget():Container(
                          margin: EdgeInsets.only(left:20, right: 20,bottom:30),
                    width: double.infinity,
                          child:SingleChildScrollView(
                            scrollDirection: size.width > 769 ? Axis.vertical : Axis.horizontal,
                            child: Container(
                                color: Theme.of(context).primaryColor,

                                child: DataTable(
                                  columnSpacing: 10,
                                    headingTextStyle: Theme.of(context).textTheme.headline1,
                                    dataTextStyle: Theme.of(context).textTheme.subtitle2,
                                    columns: [
                                      DataColumn(
                                        label: Text('ID'),
                                      ),
                                      DataColumn(
                                        label: Text(S.of(context).app),
                                      ),
                                      DataColumn(
                                        label: Text(S.of(context).app_name),
                                      ),
                                      DataColumn(
                                        label: Text(S.of(context).version),
                                      ),
                                      DataColumn(
                                        label: Text(S.of(context).link),
                                      ),
                                      DataColumn(
                                        label: Text(S.of(context).options),
                                      ),

                                    ],
                                    rows: List.generate(_con.versionList.length, (index) {
                                      VersionControl _version = _con.versionList.elementAt(index);
                                      return DataRow(cells:
                                      [
                                        DataCell(Text((index+1).toString()??' ')),
                                        DataCell(Text(_version.app)),
                                        DataCell(Text(_version.appName)),
                                        DataCell(Text(_version.version)),
                                        DataCell(Text(_version.appLink)),
                                        DataCell(Row(
                                          children: [
                                            Container(
                                                width: 60,
                                                height: 25,
                                                // ignore: deprecated_member_use
                                                child: FlatButton(
                                                    onPressed: (){
                                                      VersionControlPopupHelper.exit(context, _con, _version);
                                                    },
                                                    color: Colors.green,
                                                    shape: StadiumBorder(),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(bottom: 8.0),
                                                      child: Text(
                                                        S.of(context).edit,
                                                        style: Theme.of(context).textTheme.caption.merge(
                                                            TextStyle(
                                                                color: Theme.of(context)
                                                                    .primaryColorLight)),
                                                      ),
                                                    )
                                                )
                                            )
                                            ,
                                            SizedBox(
                                              width: 5,
                                            ),

                                          ],
                                        )),
                                      ]
                                      );
                                    }
                                    )
                                )
                            ),
                          )
                      )

                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}













class VersionControlPopupHelper {
  static exit(context,con, details) => showDialog(context: context, builder: (context) =>  VersionControlPopupWidget(con: con,details: details,));
}










