import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/search_controller.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/elements/UserBoxWidget.dart';
import 'package:login_and_signup_web/src/models/user_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
// ignore: must_be_immutable
class SearchBoxUser extends StatefulWidget {
  SearchBoxUser({this.searchType,this.userList, Key key}) : super(key: key);
  String searchType;
  List<UserModel> userList;
  @override
  _SearchBoxUserState createState() => _SearchBoxUserState();
}

class _SearchBoxUserState extends StateMVC<SearchBoxUser> {
  bool isSwitched = false;
  List<UserModel> itemList;
  bool status = false;
  SearchController _con;
  _SearchBoxUserState() : super(SearchController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemList = widget.userList;
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
                  itemList = _con.filterListUser(widget.userList, e);
                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: S.of(context).search,
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
        child:SingleChildScrollView(
        child:Column(
          children: [
           Container(
              margin: EdgeInsets.only(left:20, right: 20,bottom:30),
              child: Wrap(
                children: List.generate(itemList.length, (index) {
                  UserModel _userData = itemList.elementAt(index);
                  return UserBoxWidget(userData: _userData,);
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






