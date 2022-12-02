import 'package:flutter/material.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/elements/AECarWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/models/car_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

class CarType extends StatefulWidget {
  @override
  _CarTypeState createState() => _CarTypeState();
}

class _CarTypeState extends StateMVC<CarType>  {
  SecondaryController _con;
  _CarTypeState() : super(SecondaryController()) {
    _con = controller;
  }

  @override
  // ignore: must_call_super
  void initState()  {
    _con.listenForCarType();
  }

  callback(){
  }
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return Container(
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
                                          'S.of(context).cart_type',
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
                                              AddEdPopupHelper.exit(context, _con, CarTypeModel(), 'add');
                                            },
                                          ),
                                        ),

                                      ]
                                  )
                              ),


                            ]
                        ),
                      ),


                      _con.carTypeList.isEmpty?EmptyOrdersWidget():Container(
                          margin: EdgeInsets.only(top:20,left:20, right: 20,bottom:30),
                          child:Wrap(runSpacing: 20,
                              children:List.generate(_con.carTypeList.length, (index) {
                                return Div(
                                    colS:12,
                                    colM:12,
                                    colL:4,
                                    child:Container(
                                      padding: EdgeInsets.only(right: 10.0,),
                                      child:
                                      Container(
                                        padding: EdgeInsets.only(
                                            right: 10.0),
                                        child: Stack(
                                          alignment: Alignment.topLeft,
                                          children: <Widget>[
                                            Container(
                                              margin:EdgeInsets.only(top:20,left:size.width > 769 ? size.width * 0.05 : size.width * 0.15),
                                              height: 120,
                                              width:size.width > 769 ? size.width : size.width * 0.8,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color: Theme.of(context).primaryColor,
                                                borderRadius: BorderRadius.circular(20.0),

                                              ),
                                            ),

                                            size.width > 769 ? Positioned(
                                              left:-5,top:18,
                                              child:Container(
                                                alignment: Alignment.centerLeft,

                                                child:Container(
                                                  alignment: Alignment.centerLeft,
                                                  margin:EdgeInsets.only(right:size.width * 0.32),
                                                  child: Image(
                                                    image:NetworkImage(_con.carTypeList[index].uploadImage),

                                                    width: size.width > 769 ? 200 : 360,
                                                  ),
                                                ),
                                              ),
                                            ) :Align(
                                                alignment: Alignment.centerLeft,
                                                child:Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children:[
                                                      new Container(
                                                        margin: EdgeInsets.only(top:10),
                                                        alignment: Alignment.centerLeft,

                                                        child:Container(
                                                          alignment: Alignment.centerLeft,
                                                          margin:EdgeInsets.only(right:size.width * 0.32),
                                                          child: Image(
                                                            image: NetworkImage(_con.carTypeList[index].uploadImage),

                                                            width: 360,
                                                          ),
                                                        ),
                                                      ),

                                                    ]
                                                )

                                            ),
                                            Positioned(
                                              bottom:size.width > 769 ? 5 :size.width * 0.01,
                                              left: size.width > 769 ?size.width * 0.06 : size.width * 0.19,
                                              child: Container(
                                                  height: 30,

                                                  child: Text('${_con.carTypeList[index].cartype}',style:Theme.of(context).textTheme.caption)
                                              ),),

                                            Padding(
                                              padding: EdgeInsets.only(left: 20.0, right:25,top: size.width > 769 ? 50 :50.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Container(
                                                    alignment: Alignment.centerRight,
                                                    child:  Text('${_con.carTypeList[index].cartype}',

                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline2

                                                    ),
                                                  ),
                                                  Text('\$${_con.carTypeList[index].minimumfare} - \$${_con.carTypeList[index].basefare}',
                                                      style:TextStyle(
                                                          fontWeight:FontWeight.w600
                                                      )
                                                  ),


                                                  SizedBox(height:25.0),


                                                ],
                                              ),
                                            ),




                                          ],
                                        ),
                                      ),
                                    )
                                );
                              })
                          )
                      ),
                      SizedBox(height: 20),
                    ])),
          ],
        ),
      ),
    );



  }

  // ignore: non_constant_identifier_names
  Imagepickerbottomsheet(id, Details) {
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
                    AddEdPopupHelper.exit(context,_con, Details,'edit'),
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: ()  async{
                    await _con.delete('shopFocusType',id);

                    Navigator.pop(context);
                    setState(() {_con.shopTypeList.clear();});

                  },
                ),
              ],
            ),
          );
        });
  }
}




class AddEdPopupHelper {

  static exit(context,con,details, pageType) => showDialog(context: context, builder: (context) =>  AECarWidget(con: con,cardetails: details,pageType: pageType, ));
}