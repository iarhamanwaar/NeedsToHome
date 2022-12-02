import 'package:flutter/material.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/home_controller.dart';
import 'search_item.dart';



// ignore: must_be_immutable
class FeaturedProduct extends StatefulWidget {
  FeaturedProduct({Key key, this.shopType, this.focusId}) : super(key: key);
  int shopType;
  int focusId;
  @override
  _FeaturedProductState createState() => _FeaturedProductState();
}

class _FeaturedProductState extends StateMVC<FeaturedProduct> {
  HomeController _con;
  _FeaturedProductState() : super(HomeController()) {
    _con = controller;

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listenForFeatureProductList(widget.focusId, widget.shopType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 0, right: 0, top: 15),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Theme.of(context).primaryColorLight,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Featured Product',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.headline4.merge(TextStyle(
                  color: Theme.of(context).primaryColorLight,
                )),
              ),

              onTap: () {},
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    SearchItem(itemDetails: _con.featuredData,)

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

