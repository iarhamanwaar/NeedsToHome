
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/hservice_controller.dart';
import 'package:login_and_signup_web/src/elements/AESupercategoryWidget.dart';
import 'package:login_and_signup_web/src/elements/CategoryBoxWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/models/supercategory.dart';
import 'package:login_and_signup_web/src/repository/secondary_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';



class SuperCategoryPage extends StatefulWidget {
  @override
  _SuperCategoryPageState createState() => _SuperCategoryPageState();
}

class _SuperCategoryPageState extends StateMVC<SuperCategoryPage> {
  HServiceController _con;
  _SuperCategoryPageState() : super(HServiceController()) {
    _con = controller;
  }

  bool isSwitched = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _con.listenForSuperCategories();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKeyState,
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
                                  colS:12,
                                  colM:12,
                                  colL:12,
                                  child:Wrap(
                                      children:[
                                        Text(
                                          S.of(context).super_category,
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
                                              AddCategoryHelper.exit(context,_con,SuperCategoryModel(), 'add');
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
                                   /**   Padding(
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
                      _con.supercategoryList.isEmpty?EmptyOrdersWidget():Container(
                          margin: EdgeInsets.only(left:20, right: 20,bottom:30),
                          child:SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                                child: DataTable(
                                  headingTextStyle: Theme.of(context).textTheme.headline1,
                                  dataTextStyle: Theme.of(context).textTheme.subtitle2,
                                  columnSpacing: 150,
                                    columns: [
                                      DataColumn(
                                        label: Text('ID'),
                                      ),
                                      DataColumn(
                                        label: Text(S.of(context).name),
                                      ),
                                      DataColumn(
                                        label: Text(S.of(context).sort_by),
                                      ),
                                      DataColumn(
                                        label: Text(S.of(context).options),
                                      ),
                                      DataColumn(
                                        label: Text(S.of(context).status),
                                      ),

                                    ],
                                    rows: List.generate(_con.supercategoryList.length, (index) {
                                      return DataRow(

                                          cells:
                                      [
                                        DataCell(Text((index+1).toString())),
                                        DataCell(Text(_con.supercategoryList[index].categoryName??' ')),
                                        DataCell(Text(_con.supercategoryList[index].sortBy??' ')),
                                        DataCell((_con.supercategoryList[index].categoryName=='Transport & logistics')?
                                        Container(
                                          height:20,
                                            width:100,
                                            decoration: BoxDecoration(
                                              color: Colors.blueGrey,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 2.0),
                                              child: Text('Coming Soon',textAlign: TextAlign.center,),
                                            )):Row(
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 25,
                                                // ignore: deprecated_member_use
                                              child: FlatButton(
                                      onPressed: (){
                                      AddCategoryHelper.exit(context,_con,_con.supercategoryList[index], 'edit');
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

                                                print('com id');
                                                print(_con.supercategoryList[index].id);

                                     _con.delete('supercategory',_con.supercategoryList[index].id);

                                      setState(() {
                                        _con.supercategoryList.clear();

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
                                        DataCell(Switch(
                                      value: _con.supercategoryList[index].status,
                                      onChanged: (value) {
                                        setState(() {
                                          _con.supercategoryList[index].status = value;

                                          if(value==true){
                                            isSwitched=false;
                                            _con.supercategoryList[index].status=true;
                                            statusUpdate('supercategory',_con.supercategoryList[index].id,'status','1');
                                          } else{
                                            isSwitched=true;
                                            _con.supercategoryList[index].status=false;
                                            //widget.details.status = false;
                                            statusUpdate('supercategory',_con.supercategoryList[index].id,'status','0');
                                          }


                                        });
                                      },
                                      activeTrackColor: Colors.lightGreenAccent,
                                      activeColor: Colors.green,
                                      ),
                                      )
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
  static exit(context, con, categoryDetails, pageType) => showDialog(context: context, builder: (context) =>  AESuperCategoryPopup(con: con,categoryDetails: categoryDetails,pageType: pageType ));
}










