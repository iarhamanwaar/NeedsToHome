import 'package:flutter/material.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';

import '../models/main_category.dart';



// ignore: must_be_immutable
class FilterWidget extends StatefulWidget {
  final ValueChanged onFilter;
  List<MainCategoryModel> mainShopCategories;
  FilterWidget({Key key, this.onFilter, this.mainShopCategories}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String selectedRadio;

  @override
  void initState() {
    super.initState();

    if (currentUser.value.filterId != '' && currentUser.value.filterId != null) {
      selectedRadio = currentUser.value.filterId;
    } else {
      widget.mainShopCategories.forEach((element) {
        if (element.selected) {
          selectedRadio = element.id;
        }
      });
    }
  }


  setSelectedRadio(String val) {
    setState(() {
      selectedRadio = val;

    });


  }


  bool checkClick = false;
  @override
  Widget build(BuildContext context) {


    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20,top: 10,bottom:20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Shop Categories',
                    style: Theme.of(context).textTheme.headline1.merge(TextStyle(fontWeight: FontWeight.w700)),
                  ),
                 /* MaterialButton(
                    onPressed: () {},
                    child: Icon(Icons.delete_outline,color: Theme.of(context).colorScheme.secondary)
                  ) */

                ],
              ),
            ),
            Expanded(
              child: ListView(
                primary: true,
                shrinkWrap: true,
                children: <Widget>[


                  Column(

                    children:List.generate(widget.mainShopCategories.length, (index) {
                      MainCategoryModel _category = widget.mainShopCategories.elementAt(index);
                      return Container(
                          padding:EdgeInsets.only(left:15,right:15),
                          child:Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              Expanded(
                                child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[
                                      Container(
                                        padding: EdgeInsets.only(top:13,),
                                        child: Text(_category.name,style: Theme.of(context).textTheme.bodyText1,),
                                      ),
                                    ]
                                ),
                              ),
                              Radio(
                                  value: _category.id,
                                  groupValue: selectedRadio,
                                  activeColor: Colors.blue,

                                  onChanged: (val) {

                                    setSelectedRadio(val);
                                  }),
                            ],
                          )
                      );
                    })

                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(left:15,right:15),
              width: double.infinity,
              // ignore: deprecated_member_use
              child:RaisedButton(
              onPressed: () {
                currentUser.value.filterId = selectedRadio;
                setCurrentUserUpdate(currentUser.value);
                Navigator.pop(context);
              },
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              color: Theme.of(context).colorScheme.secondary,
              shape: StadiumBorder(),
              child: Text(
                'Apply filter',
                textAlign: TextAlign.start,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),),
            SizedBox(height: 15)
          ],
        ),
      ),
    );
  }
}