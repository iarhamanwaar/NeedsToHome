import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/product_controller.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/elements/SubCategoryBoxWidget.dart';
import 'package:login_and_signup_web/src/elements/AESubCategoryWidget.dart';
import 'package:login_and_signup_web/src/models/subcategory_List.dart';
import 'package:login_and_signup_web/src/pages/searchbox_subcategory.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

class SubCategoryPage extends StatefulWidget {
  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends StateMVC<SubCategoryPage> {
  ProductController _con;
  _SubCategoryPageState() : super(ProductController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    _con.listenForSubCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.6),
      child: SingleChildScrollView(
        child: Column(
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
                      margin: EdgeInsets.only(
                          left: 30.0, top: 25.0, right: 30, bottom: 10.0),
                      child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Div(
                                colS: 9,
                                colM: 8,
                                colL: 8,
                                child: Wrap(children: [
                                  Text(
                                    S.of(context).sub_categories,
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    height: 30.0,
                                    width: 30.0,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      color: Colors.white,
                                      icon: const Icon(Icons.add),
                                      iconSize: 30.0,
                                      //color: Palette.facebookBlue,
                                      onPressed: () {
                                        AddSubCategoryHelper.exit(context, _con,
                                            SubCategoryListModel(), 'add');
                                      },
                                    ),
                                  )
                                ])),
                            Div(
                              colS: 3,
                              colM: 4,
                              colL: 4,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: size.width > 769 ? 30 :0),
                                      child: IconButton(
                                        onPressed: () async {
                                          var results =
                                              await Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SearchBoxSubCategory(
                                                            searchType:
                                                                'subcategory',
                                                            categoryList: _con
                                                                .subcategoryList,
                                                          )));

                                          if (results == null) {
                                            _con.listenForSubCategories();
                                          }
                                        },
                                        icon: Icon(Icons.search,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                      ),
                                    ),
                                  ]),
                            ),
                          ]),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20),
                      child: Stories(con: _con),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Stories extends StatefulWidget {
  ProductController con;
  Stories({Key key, this.con}) : super(key: key);
  @override
  _StoriesState createState() => _StoriesState();
}

class _StoriesState extends StateMVC<Stories> {
  @override
  Widget build(BuildContext context) {
    return widget.con.subcategoryList.isEmpty
        ? EmptyOrdersWidget()
        : Wrap(
            children: List.generate(widget.con.subcategoryList.length, (index) {
            return Div(
              colS: 6,
              colM: 4,
              colL: 2,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                height: 200.0,
                child: InkWell(
                  onTap: () {
                    Imagepickerbottomsheet(widget.con.subcategoryList[index].id,
                        widget.con.subcategoryList[index]);
                  },
                  child: SubCategoryBoxWidget(
                      categoryData:
                          widget.con.subcategoryList.elementAt(index)),
                ),
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
                        context, widget.con, categoryDetails, 'edit'),
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: () => {
                    widget.con.delete('subcategory', id),
                    Navigator.pop(context),
                    setState(() {
                      widget.con.subcategoryList.clear();
                    }),
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
      builder: (context) => StatefulBuilder(
          builder: (context, StateSetter setState) => AddSubCategoryPopup(
              con: con,
              categoryDetails: categoryDetails,
              pageType: pageType,
              setState: setState)));
}
