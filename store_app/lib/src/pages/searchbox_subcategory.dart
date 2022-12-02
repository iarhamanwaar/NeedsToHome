import 'package:flutter/material.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/search_controller.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/controllers/product_controller.dart';
import 'package:login_and_signup_web/src/elements/SubCategoryBoxWidget.dart';
import 'package:login_and_signup_web/src/elements/AESubCategoryWidget.dart';
import 'package:login_and_signup_web/src/models/subcategory_List.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

// ignore: must_be_immutable
class SearchBoxSubCategory extends StatefulWidget {
  SearchBoxSubCategory({this.searchType, this.categoryList, Key key})
      : super(key: key);
  String searchType;
  List<SubCategoryListModel> categoryList;
  @override
  _SearchBoxSubCategoryState createState() => _SearchBoxSubCategoryState();
}

class _SearchBoxSubCategoryState extends StateMVC<SearchBoxSubCategory> {
  bool isSwitched = false;
  List<SubCategoryListModel> itemList;
  bool status = false;
  SearchController _con;
  _SearchBoxSubCategoryState() : super(SearchController()) {
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
                  itemList = _con.filterListSubcategory(widget.categoryList, e);
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
  List<SubCategoryListModel> categoryList;
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
                    child: SubCategoryBoxWidget(
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
                    AddSubCategoryHelper.exit(
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
                        'subcategory', id, context, widget.categoryList);

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

class AddSubCategoryHelper {
  static exit(context, con, categoryDetails, pageType) => showDialog(
      context: context,
      builder: (context) => AddSubCategoryPopup(
          con: con, categoryDetails: categoryDetails, pageType: pageType));
}
