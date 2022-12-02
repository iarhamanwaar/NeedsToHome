import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/hservice_controller.dart';
import 'package:login_and_signup_web/src/elements/AECategoryWidget.dart';
import 'package:login_and_signup_web/src/elements/CategoryBoxWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/models/category.dart';
import 'package:login_and_signup_web/src/pages/searchbox_category.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';


class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends StateMVC<CategoryPage> {
  HServiceController _con;
  _CategoryPageState() : super(HServiceController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _con.listenForCategories();
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
                                  colS:6,
                                  colM:6,
                                  colL:6,
                                  child:Wrap(
                                      children:[
                                  Text(
                                    S.of(context).category,
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
                                              AECategoryHelper.exit(context,_con,CategoryModel(), 'add');



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
                                      Padding(
                                        padding:EdgeInsets.only(right:30),
                                        child:IconButton(
                                          onPressed:(){
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchBoxcategory(categoryList: _con.hcategoryList,)));
                                            //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchBoxUser(searchType: 'category',userList: _con.userList,)));
                                          },
                                          icon:Icon(Icons.search, color: Theme.of(context).colorScheme.secondary),
                                        ),
                                      ),
                                    ]
                                ),
                              ),

                            ]
                        ),
                      ),


                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(left: 20.0, right: 20),
                        child: Stories(con: _con, ),
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
               Imagepickerbottomsheet(widget.con.hcategoryList[index].id, widget.con.hcategoryList[index]);
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
                    AECategoryHelper.exit(context,widget.con, categoryDetails,'edit'),
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: ()  async{
               await widget.con.delete('h_category',id);

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












class AECategoryHelper {

 static exit(context, con, categoryDetails, pageType) => showDialog(context: context, builder: (context) =>  AECategoryPopup(con: con,categoryDetails: categoryDetails,pageType: pageType ));
}










