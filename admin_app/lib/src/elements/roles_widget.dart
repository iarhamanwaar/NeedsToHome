import 'package:flutter/material.dart';

import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

class RolesWidget extends StatefulWidget {
  @override
  _RolesWidgetState createState() => _RolesWidgetState();
}

class _RolesWidgetState extends StateMVC<RolesWidget>  with SingleTickerProviderStateMixin{
  UserController _con;
  bool isSwitched = false;
  int dropDownValue = 0;

  bool status = false;
  _RolesWidgetState() : super(UserController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
    _con.listenForRoles();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scrollbar(
        isAlwaysShown: true,
        child:ListView(
          scrollDirection: Axis.vertical,
          children: [
            Responsive(
                children:[
                  Padding(
                      padding: EdgeInsets.all(24),
                      child: Div(
                          colS:12,
                          colM:12,
                          colL:12,
                          child:Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:[

                                Div(
                                  colS:12,
                                  colM:6,
                                  colL:6,
                                  child:Container(

                                    padding: EdgeInsets.all(27),
                                    decoration:BoxDecoration(
                                        color:Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Add Roles',style:Theme.of(context).textTheme.headline4),
                                          ],
                                        ),

                                        SizedBox(height:20),
                                        Container(
                                            width: double.infinity,

                                            child: TextField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.text,
                                                onChanged:(input)=> _con.rolePermissionModel.name=input,
                                                decoration: InputDecoration(
                                                  labelText: 'Name',
                                                  labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                  enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                      Theme.of(context).colorScheme.secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                        SizedBox(height: 20),

                                        Text('Description',style: Theme.of(context).textTheme.headline1,),
                                        SizedBox(height: 10),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            color: Theme.of(context).dividerColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextField(
                                              maxLines: 5,
                                              onChanged:(input)=> _con.rolePermissionModel.description=input,
                                              decoration: InputDecoration.collapsed(
                                                hintText: 'Description',
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(color: Colors.grey)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height:20),
                                        Text('Permissions',style: Theme.of(context).textTheme.headline1,),
                                        Wrap(
                                            children:
                                            List.generate(_con.rolesList.length, (index) {
                                              return ListTile(
                                                contentPadding: EdgeInsets.only(left:0),
                                                leading: Text(_con.rolesList[index].name,style: Theme.of(context).textTheme.headline1),
                                                trailing: Padding(
                                                  padding:EdgeInsets.only(left:3,right:3,bottom:5),
                                                  child:GestureDetector(
                                                    onTap: () {},
                                                    child: Switch(
                                                      value: _con.rolesList[index].switchPermission,
                                                      onChanged: (value){
                                                        setState(() {
                                                          _con.rolesList[index].switchPermission=value;
                                                          _con.rolePermissionModel.permission.add(_con.rolesList[index].id);
                                                        });
                                                      },
                                                      activeTrackColor: Colors.lightGreenAccent,
                                                      activeColor: Colors.green,

                                                    ),
                                                  ),
                                                ),
                                              );
                                            })
                                        ),
                                        SizedBox(height:40),
                                        InkWell(
                                            onTap: () {



                                            },
                                            child: Container(
                                              color: Theme.of(context).primaryColor,
                                              padding:EdgeInsets.only(left:size.width * 0.05,right:size.width * 0.05),
                                              child: Container(
                                                width: double.infinity,
                                                height: 45.0,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).colorScheme.secondary,
                                                  borderRadius: BorderRadius.circular(30),
                                                  /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                                                ),
                                                // ignore: deprecated_member_use
                                                child: FlatButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _con.addRolePermission();
                                                    });
                                                  },
                                                  child: Center(
                                                      child: Text(
                                                        'Submit',
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            ))




                                      ],
                                    ),

                                  ),
                                ),







                              ]
                          )

                      )
                  ),

                ]
            )
            // SideCard(),
          ],
        ));


  }
}


