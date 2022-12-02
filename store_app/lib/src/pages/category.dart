import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/product_controller.dart';
import 'package:login_and_signup_web/src/elements/CategoryBoxWidget.dart';
import 'package:login_and_signup_web/src/elements/AECategoryWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/models/category_List.dart';
import 'package:login_and_signup_web/src/pages/searchbox_category.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends StateMVC<CategoryPage> {
  ProductController _con;
  _CategoryPageState() : super(ProductController()) {
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
   var size = MediaQuery.of(context).size;
     return Scaffold(
      key: _con.scaffoldKeyState,
      body: Container(
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
                                    currentUser.value.shopTypeId != 2
                                        ? Text(
                                            S.of(context).category,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          )
                                        : Text(
                                            S.of(context).menu,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
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
                                          AddCategoryHelper.exit(context, _con,
                                              CategoryListModel(), 'add');

                                          /**Navigator.of(context).push(new MaterialPageRoute(builder:
                                                  (BuildContext context) => new GoogleLocation())); */
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
                                                await Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                        builder: (context) =>
                                                            SearchBoxCategory(
                                                              searchType:
                                                                  'category',
                                                              categoryList: _con
                                                                  .categoryList,
                                                            )));

                                            if (results == null) {
                                              _con.listenForCategories();
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
                        child: Stories(
                          con: _con,
                        ),
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
  ProductController con;
  Stories({Key key, this.con}) : super(key: key);
  @override
  _StoriesState createState() => _StoriesState();
}

class _StoriesState extends StateMVC<Stories> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    PaintingBinding.instance.imageCache.clear();
  }

  void evictImage() {
    final NetworkImage provider = NetworkImage(
        'https://optimaprotech.com/test/uploads/category_image/category_202.png');
    provider.evict().then<void>((bool success) {
      if (success) debugPrint('removed image!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.con.categoryList.isEmpty
        ? EmptyOrdersWidget()
        : Wrap(
            children: List.generate(widget.con.categoryList.length, (index) {
            return Div(
              colS: 6,
              colM: 4,
              colL: 2,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                height: 200.0,
                child: InkWell(
                    onTap: () {
                      Imagepickerbottomsheet(widget.con.categoryList[index].id,
                          widget.con.categoryList[index]);
                    },
                    child: CategoryBoxWidget(
                        categoryData:
                            widget.con.categoryList.elementAt(index))),
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
                        context, widget.con, categoryDetails, 'edit'),
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: () async {
                    await widget.con.delete('category', id);

                    Navigator.pop(context);
                    setState(() {
                      widget.con.categoryList.clear();
                    });
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
