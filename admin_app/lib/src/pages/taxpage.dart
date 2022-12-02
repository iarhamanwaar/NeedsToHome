import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/hservice_controller.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/elements/AETaxWidget.dart';
import 'package:login_and_signup_web/src/elements/CategoryBoxWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/models/taxmodel.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';


class TaxPage extends StatefulWidget {
  @override
  _TaxPageState createState() => _TaxPageState();
}

class _TaxPageState extends StateMVC<TaxPage> {
  SecondaryController _con;
  _TaxPageState() : super(SecondaryController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _con.listenForTax();
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      //key: _con.,
      body: Container(
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
                                          S.of(context).tax,
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
                                              AddCategoryHelper.exit(context,_con,TaxModel(), 'add');
                                            },
                                          ),
                                        )
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
                      _con.taxList.isEmpty?EmptyOrdersWidget():Container(
                          margin: EdgeInsets.only(left:20, right: 20,bottom:30),
                          child:SingleChildScrollView(
                            scrollDirection: size.width > 769 ? Axis.vertical : Axis.horizontal,
                            child: Container(
                                color: Theme.of(context).primaryColor,
                                width: size.width,
                                child: DataTable(
                                    headingTextStyle: Theme.of(context).textTheme.headline1,
                                    dataTextStyle: Theme.of(context).textTheme.subtitle2,
                                    columns: [
                                      DataColumn(
                                        label: Text('ID'),
                                      ),
                                      DataColumn(
                                        label: Text(S.of(context).tax),
                                      ),
                                      DataColumn(
                                        label: Text(S.of(context).date),
                                      ),
                                      DataColumn(
                                        label: Text(S.of(context).options),
                                      ),

                                    ],
                                    rows: List.generate(_con.taxList.length, (index) {
                                      return DataRow(cells:
                                      [
                                        DataCell(Text((index+1).toString()??' ')),
                                        DataCell(Text(_con.taxList[index].tax??' ')),
                                        DataCell(Text(_con.taxList[index].date??' ')),
                                        DataCell(Row(
                                          children: [
                                            Container(
                                                width: 60,
                                                height: 25,
                                                // ignore: deprecated_member_use
                                                child: FlatButton(
                                                    onPressed: (){
                                                      AddCategoryHelper.exit(context,_con,_con.taxList[index], 'edit');
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
                                            Container(
                                                width: 75,
                                                height: 25,
                                                child:
                                                // ignore: deprecated_member_use
                                                FlatButton(onPressed: (){
                                                  _con.delete('tax',_con.taxList[index].id);

                                                  setState(() {
                                                    _con.taxList.clear();
                                                  });
                                                },
                                                    color: Colors.red,
                                                    shape: StadiumBorder(),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(bottom: 8.0),
                                                      child: Text(
                                                        S.of(context).delete,
                                                        textAlign: TextAlign.center,
                                                        style: Theme.of(context).textTheme.caption.merge(
                                                            TextStyle(
                                                                color: Theme.of(context)
                                                                    .primaryColorLight)),
                                                      ),
                                                    )
                                                )
                                            )
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

// ignore: must_be_immutable
class Stories extends StatefulWidget {
  HServiceController con;
  Stories({Key key, this.con}) : super(key: key);
  @override
  _StoriesState createState() => _StoriesState();
}

class _StoriesState extends StateMVC<Stories> {

  @override
  Widget build(BuildContext context) {
    return widget.con.hcategoryList.isEmpty? EmptyOrdersWidget()
        :Wrap(
        children: List.generate(widget.con.hcategoryList.length, (index)
        {

          return Div(
            colS: 6,
            colM: 4,
            colL: 2,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              height: 200.0,
              child: InkWell(
                  onTap: () {
                    //Imagepickerbottomsheet(widget.con.hcategoryList[index].id, widget.con.categoryList[index]);
                  },child:CategoryBoxWidget(categoryData:widget.con.hcategoryList.elementAt(index))
              ),
            ),
          );
        }
        )
    );



  }
  // ignore: non_constant_identifier_names
  Imagepickerbottomsheet(id, categoryDetails) {
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
                new ListTile(
                  leading: new Icon(Icons.edit),
                  title: new Text(S.of(context).edit),
                  onTap: () => {
                    Navigator.pop(context),
                    //AddCategoryHelper.exit(context,widget.con, categoryDetails,'edit'),
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: ()  async{
                    //await widget.con.delete('category',id);

                    Navigator.pop(context);
                    setState(() {widget.con.hcategoryList.clear();});

                  },
                ),
              ],
            ),
          );
        });
  }
}












class AddCategoryHelper {
  static exit(context, con, categoryDetails, pageType) => showDialog(context: context, builder: (context) =>  AETaxWidget(con: con,taxDetails: categoryDetails,pageType: pageType ));
}










