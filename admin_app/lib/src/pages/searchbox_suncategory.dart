import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/search_controller.dart';
import 'package:login_and_signup_web/src/elements/SubCategoryBoxWidget.dart';
import 'package:login_and_signup_web/src/models/subcategory_List.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
// ignore: must_be_immutable
class SearchBoxSubcategory extends StatefulWidget {
  SearchBoxSubcategory({this.categoryList, Key key}) : super(key: key);
  List<SubCategoryListModel> categoryList;
  @override
  _SearchBoxSubcategoryState createState() => _SearchBoxSubcategoryState();
}

class _SearchBoxSubcategoryState extends StateMVC<SearchBoxSubcategory> {
  bool isSwitched = false;
  List<SubCategoryListModel> itemList;
  bool status = false;
  SearchController _con;
  _SearchBoxSubcategoryState() : super(SearchController()) {
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
    return
      Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.6),
          elevation: 0,
          title: Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(color:Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.05), offset: Offset(0, 5), blurRadius: 1)],
                  border:Border.all(
                      width: 1,
                      color:Theme.of(context).dividerColor
                  )
              ),
              child: TextField(
                autofocus: true,
                onChanged: (e){
                  setState((){
                    itemList = _con.filterListSubcategory(widget.categoryList, e);
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Search',
                  hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                  suffixIcon: IconButton(
                    icon:Icon(Icons.search, color: Theme.of(context).colorScheme.secondary), onPressed: () {  },
                  ),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                ),
              )),
        ),
        body: Padding(
          padding: EdgeInsets.only(top:0),
          child:
          SingleChildScrollView(
            child:Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left:20, right: 20,bottom:30),
                  child:
                  Wrap(
                    children: List.generate(itemList.length, (index) {
                      SubCategoryListModel _categoryData = itemList.elementAt(index);
                      return  Div(
                        colS: 6,
                        colM: 4,
                        colL: 2,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          height: 200.0,
                          child: SubCategoryBoxWidget(categoryData:_categoryData),
                        ),
                      );
                    }
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      );



  }
}






