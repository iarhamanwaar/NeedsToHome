
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../generated/l10n.dart';
import '../../controllers/user_controller.dart';
import '../../elements/EmptyOrdersWidget.dart';
import '../../models/register.dart';

// ignore: must_be_immutable
class RegisterFormStep3 extends StatefulWidget {
  RegisterFormStep3({Key key, this.registerData}) : super(key: key);
  Registermodel registerData;
  @override
  _RegisterFormStep3State createState() => _RegisterFormStep3State();
}

class _RegisterFormStep3State extends StateMVC<RegisterFormStep3> {

  String selectedRadio;
  UserController _con;

  _RegisterFormStep3State() : super(UserController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
    _con.listenForZone();
  }

  setSelectedRadio(String val) {
    setState(() {
      selectedRadio = val;
    });
    widget.registerData.zoneId = val;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            //color: Theme.of(context).primaryColorDark,
              image: DecorationImage(
                  image: AssetImage('assets/img/background_image.jpg',
                  ),
                  fit: BoxFit.fill
              )
          ),
          child: SafeArea(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only( left: 10.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color:Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 10.0),
                      Text(S.of(context).select_your_zone,
                        style: Theme.of(context).textTheme.headline4.merge(TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),


                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    width:double.infinity,
                    padding: EdgeInsets.only(left:20,right:20,top:20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              spreadRadius: 15
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Form(
                      key: _con.formKeys[2],
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[


                            Container(
                                child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child:Text(
                                             S.of(context).select_your_zone,
                                              style: Theme.of(context).textTheme.headline2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15,),
                                      _con.zoneList.isEmpty?EmptyOrdersWidget():Column(
                                        children: List.generate(_con.zoneList.length, (index) {
                                          return Container(
                                            padding: EdgeInsets.only(top:8,bottom:8),
                                            child:InkWell(
                                              onTap: (){
                                                setSelectedRadio( _con.zoneList[index].zoneId);
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.only(top: 10,right: 10,bottom:10),
                                                  decoration: BoxDecoration(
                                                      color:Theme.of(context).primaryColor,
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Theme.of(context).dividerColor.withOpacity(0.2),
                                                          blurRadius: 1,
                                                          spreadRadius: 1,
                                                        ),
                                                      ]
                                                  ),
                                                  child:Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,

                                                    children: [
                                                      Container(
                                                        child:Radio(
                                                            value: _con.zoneList[index].zoneId,
                                                            groupValue: selectedRadio,
                                                            activeColor: Colors.blue,
                                                            onChanged: (val) {

                                                              setSelectedRadio(val);

                                                            }),
                                                      ),
                                                      /* Align(
                                                    alignment: Alignment.topLeft,
                                                    child:Container(
                                                      margin:EdgeInsets.only(right:0,),
                                                      height:60,width:60,
                                                      child: Card(
                                                        child: new CircleAvatar(
                                                          backgroundImage: AssetImage('assets/img/loginbg.jpg'),
                                                          radius: 80.0,
                                                        ),
                                                        elevation: 2.0,
                                                        shape: CircleBorder(),
                                                        clipBehavior: Clip.antiAlias,
                                                      ),

                                                    ),
                                                  ), */
                                                      SizedBox(width:10),
                                                      Expanded(
                                                        child: Container(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(_con.zoneList[index].title,style: Theme.of(context).textTheme.headline1),


                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  )
                                              ),
                                            ),
                                          );
                                        }),
                                      ),


                                    ]
                                )
                            )









                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child:Container(
                      width: double.infinity,
                      height: 70,
                      color: Theme.of(context).primaryColor,
                      child:Container(
                          padding: EdgeInsets.only(left:10,right:10,top:10,bottom:10),
                          child:  MaterialButton(
                              onPressed:(){

                               if(widget.registerData.zoneId!='' && widget.registerData.zoneId!=null){
                                 _con.registrationNext(2,'step4', widget.registerData);
                               } else {
                                 // ignore: deprecated_member_use
                                 _con.scaffoldKey?.currentState?.showSnackBar(SnackBar(
                                   content: Text('Please select your zone'),
                                 ));
                               }


                              },
                              color: Theme.of(context).colorScheme.secondary,
                              child: Text(S.of(context).save_and_proceed,
                                style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).primaryColorLight)),
                              )
                          )
                      )
                  ),

                ),
              ],
            ),
          )
      ),
    );

  }
}
