import 'package:flutter/material.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/search_controller.dart';
import 'package:login_and_signup_web/src/elements/AECategoryWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/controllers/product_controller.dart';
import 'package:login_and_signup_web/src/elements/CategoryBoxWidget.dart';
import 'package:login_and_signup_web/src/models/category_List.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

// ignore: must_be_immutable
class SearchBoxCategory extends StatefulWidget {
  SearchBoxCategory({this.searchType, this.categoryList, Key key})
      : super(key: key);
  String searchType;
  List<CategoryListModel> categoryList;
  @override
  _SearchBoxCategoryState createState() => _SearchBoxCategoryState();
}

class _SearchBoxCategoryState extends StateMVC<SearchBoxCategory> {
  bool isSwitched = false;
  List<CategoryListModel> itemList;
  bool status = false;
  SearchController _con;
  _SearchBoxCategoryState() : super(SearchController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemList = widget.categoryList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.6),
        elevation: 0,
        title: Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).focusColor.withOpacity(0.05),
                      offset: Offset(0, 5),
                      blurRadius: 1)
                ],
                border: Border.all(
                    width: 1, color: Theme.of(context).dividerColor)),
            child: TextField(
              autofocus: true,
              onChanged: (e) {
                setState(() {
                  itemList = _con.filterList(widget.categoryList, e);
                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText:  S.of(context).search,
                hintStyle: Theme.of(context)
                    .textTheme
                    .caption
                    .merge(TextStyle(fontSize: 14)),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search,
                      color: Theme.of(context).colorScheme.secondary),
                  onPressed: () {},
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
              ),
            )),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
                child: Stories(
                  con: _con,
                  categoryList: itemList,
                ),
              ),

              /* product box */
              /*Container(
              //color:Colors.white70,
              padding: EdgeInsets.only(left:20,right:20,top:30),
              child:Wrap(

                children: List.generate(20, (index) {
                  return InkWell(
                    child:Div(
                      colS: 12,
                      colM: 4,
                      colL: 3,

                      child:  Container(
                        decoration: BoxDecoration(
                            color:Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                              ),
                            ]),
                        margin: EdgeInsets.only(left:15,right:15, top: 10.0,bottom:10),

                        child:Column(
                            children:[
                              Stack(
                                  children:[
                                    ClipRRect(
                                      //borderRadius: BorderRadius.all(Radius.circular(10)),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft:Radius.circular(0),
                                          bottomRight:Radius.circular(0),

                                        ),
                                        child:Image(image:AssetImage('assets/img/userImage5.jpeg'),
                                            width:double.infinity,
                                            height:150,
                                            fit:BoxFit.fill
                                        )
                                    ),

                                    ClipRRect(
                                      //borderRadius: BorderRadius.all(Radius.circular(10)),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft:Radius.circular(0),
                                        bottomRight:Radius.circular(0),

                                      ),
                                      child:Container(
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                          Container(
                                            height:150,
                                            width: double.infinity,
                                            child: Stack(
                                                children:[
                                                  Container(
                                                    alignment: Alignment.bottomLeft,

                                                    /* background black light to dark gradient color */
                                                    decoration: BoxDecoration(
                                                      gradient: new LinearGradient(
                                                        begin: const Alignment(0.0, -1.0),
                                                        end: const Alignment(0.0, 0.6),
                                                        colors: <Color>[
                                                          const Color(0x8A000000).withOpacity(0.0),
                                                          const Color(0x8A000000).withOpacity(0.9),
                                                        ],
                                                      ),
                                                    ),

                                                  ),

                                                  Positioned(
                                                      bottom:10,left:15,right:15,
                                                      child:Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children:[
                                                            Container(
                                                              padding: EdgeInsets.only(left:9,right:9,top:3,bottom:3),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(7),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors.grey.withOpacity(0.2),
                                                                    spreadRadius: 1,
                                                                    blurRadius: 7,
                                                                    offset: Offset(0, 3), // changes position of shadow
                                                                  ),
                                                                ],
                                                                color: Colors.blue,
                                                              ),
                                                              child: Wrap(alignment: WrapAlignment.center, children: [
                                                                Text(
                                                                    'open',
                                                                    overflow: TextOverflow.ellipsis,
                                                                    maxLines: 1,
                                                                    style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.white))
                                                                )
                                                              ]),
                                                            ),
                                                            Text('\$4040',style:TextStyle(color:Colors.white)),
                                                          ]
                                                      )
                                                  )
                                                ]
                                            ),
                                          ),
                                        ]
                                        ),
                                      ),
                                    ),
                                  ]
                              ),

                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    Padding(
                                      padding:EdgeInsets.only(left:15,right:10,top:15,bottom:5),
                                      child:Text('French Restaurant hgdhgd djdjhdjdjhdhj d'),
                                    ),


                                    Container(
                                      width:double.infinity,
                                      padding:EdgeInsets.only(top:5,left:15,right:15,),
                                      child:Wrap(
                                          alignment:WrapAlignment.spaceBetween,
                                          children:[
                                            Div(
                                              colS:6,
                                              colM:6,
                                              colL:6,
                                              child:Row(
                                                  children:[
                                                    Padding(
                                                      padding:EdgeInsets.only(top:5),
                                                      child:Text('50 pieces'),),



                                                  ]
                                              ),

                                            ),

                                            Div(
                                              colS:6,
                                              colM:6,
                                              colL:6,
                                              child:Padding(
                                                padding:EdgeInsets.only(top:0),
                                                child:Div(
                                                  colS:7,
                                                  colM:10,
                                                  colL:8,
                                                  child:FlatButton(
                                                    onPressed: () {
                                                      alertBox();
                                                    },
                                                    color:Colors.blue,
                                                    splashColor:Colors.blue,
                                                    textColor:Colors.white,
                                                    child:Text('Variant',style:Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.white))),
                                                  ),
                                                ),

                                              ),
                                            ),



                                          ]
                                      ),
                                    ),

                                    Padding(
                                      padding:EdgeInsets.only(left:3,right:3,bottom:5),
                                      child:GestureDetector(
                                        onTap: () {},
                                        child: Switch(
                                          value: isSwitched,
                                          onChanged: (value){
                                            setState(() {
                                              isSwitched=value;
                                              print(isSwitched);
                                            });
                                          },
                                          activeTrackColor: Colors.lightGreenAccent,
                                          activeColor: Colors.green,

                                        ),
                                      ),
                                    ),

                                  ]
                              )
                            ]
                        ),
                      ),
                    ),
                  );
                }
                ),
              ),

            ),*/

              // tab bar view here
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Stories extends StatefulWidget {
  SearchController con;
  List<CategoryListModel> categoryList;
  Stories({Key key, this.con, this.categoryList}) : super(key: key);
  @override
  _StoriesState createState() => _StoriesState();
}

class _StoriesState extends StateMVC<Stories> {
  ProductController _con;
  _StoriesState() : super(ProductController()) {
    _con = controller;
  }
  @override
  Widget build(BuildContext context) {
    return widget.categoryList.isEmpty
        ? EmptyOrdersWidget()
        : Wrap(
            children: List.generate(widget.categoryList.length, (index) {
            return Div(
              colS: 6,
              colM: 4,
              colL: 2,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                height: 200.0,
                child: InkWell(
                    onTap: () {
                      Imagepickerbottomsheet(widget.categoryList[index].id,
                          widget.categoryList[index]);
                    },
                    child: CategoryBoxWidget(
                        categoryData: widget.categoryList.elementAt(index))),
              ),
            );
          }));
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
                    AddCategoryHelper.exit(
                        context, _con, categoryDetails, 'edit'),
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: () async {
                    setState(() {
                      widget.categoryList.removeWhere((item) => item.id == id);
                    });
                    await widget.con.deleteSearch(
                        'category', id, context, widget.categoryList);

                    Navigator.pop(context);
                    //setState(() {widget.categoryList.clear();});
                  },
                ),
              ],
            ),
          );
        });
  }
}

class AddCategoryHelper {
  static exit(context, con, categoryDetails, pageType) => showDialog(
      context: context,
      builder: (context) => AddCategoryPopup(
          con: con, categoryDetails: categoryDetails, pageType: pageType));
}
