import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:responsive_ui/responsive_ui.dart';

// ignore: must_be_immutable
class RechargePage extends StatefulWidget {

  @override
  _RechargePageState createState() => _RechargePageState();
}

class _RechargePageState extends State<RechargePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0)),
          ),
          child: SafeArea(child:Column(
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
                      color:Theme.of(context).primaryColorLight.withOpacity(0.8),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 10.0),
                    Text(S.of(context).recharge,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3.merge(TextStyle(color:Theme.of(context).primaryColorLight.withOpacity(0.8))),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(children: [
                            SizedBox(height: 10),
                            Container(
                              padding:  EdgeInsets.only(left: 15, right: 15, bottom: 15),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start, children: [
                                ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: 1,
                                    shrinkWrap: true,
                                    primary: false,
                                    padding: EdgeInsets.only(top: 10),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, int index) {
                                      return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                        Container(
                                            child:Row(
                                              mainAxisAlignment:MainAxisAlignment.center,
                                              children: [
                                                Text('10.0000',
                                                    style:Theme.of(context).textTheme.headline5
                                                ),
                                              ],
                                            )
                                        ),
                                        Container(
                                          padding:EdgeInsets.only(top:10),
                                          child:Text('Choose an amount',
                                              style:Theme.of(context).textTheme.headline1.merge(TextStyle(fontWeight: FontWeight.w700))
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.only(top:20,bottom: 20),
                                          child: Wrap(
                                            runSpacing:5,
                                           children: List.generate(6, (index) {
                                             return Div(
                                                 colS:4,
                                                 colM:4,
                                                 colL:4,
                                                 child:Container(
                                                   padding: EdgeInsets.all(6),
                                                     child:Container(
                                                       padding: EdgeInsets.all(8),
                                                       decoration: BoxDecoration(
                                                         borderRadius: BorderRadius.circular(12),
                                                         color:Theme.of(context).primaryColor,
                                                         boxShadow: [
                                                           BoxShadow(
                                                             color: Colors.grey.withOpacity(0.1),
                                                             spreadRadius: 2,
                                                             blurRadius: 1.5,
                                                             // changes position of shadow
                                                           ),
                                                         ],),
                                                       child: Column(
                                                           crossAxisAlignment: CrossAxisAlignment.center,
                                                           children:[
                                                             Container(
                                                                 padding: EdgeInsets.only(top:10),
                                                                 child:Image(
                                                                   image:AssetImage('assets/img/cash.png'),
                                                                   width: 70,height:70,
                                                                 )
                                                             ),
                                                             Container(
                                                               padding: EdgeInsets.only(bottom:10),
                                                               child: Text('Rp12.000',style: TextStyle(fontWeight: FontWeight.w700),),
                                                             )
                                                           ]
                                                       ),
                                                     )
                                                 )
                                             );
                                           }),
                                          )
                                        ),

                                            Container(
                                              height: 45,
                                              width: double.infinity,
                                              margin: EdgeInsets.only(left: 10, right: 10),
                                              decoration:BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                border:Border.all(
                                                  width: 1,color:Theme.of(context).dividerColor
                                                )
                                              ),
                                              // ignore: deprecated_member_use
                                              child: FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pushNamed('/topUp');
                                                },
                                                color: Theme.of(context).disabledColor.withOpacity(0.08),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: Wrap(
                                      children:[
                                        Container(
                                          padding:EdgeInsets.only(top:1),
                                          child:Icon(Icons.add_circle,color:Theme.of(context).disabledColor.withOpacity(0.3),size:18),
                                        ),

                                        SizedBox(width:5),
                                        Text(
                                            'or type the amount',
                                          style: TextStyle(fontWeight: FontWeight.w700,fontSize: 11),
                                        ),

                                      ]
                                      )
                                              ),
                                            ),



                                      ]);
                                    }),










                              ]),
                            ),


                          ]),
                        ]),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child:Container(
                  color:Theme.of(context).primaryColor,

                  child:Container(
                    height: 45,
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 5, right: 5,bottom:10),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: () {

                      },
                      color:Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                          'Continue',
                          style:Theme.of(context).textTheme.headline1.merge(TextStyle(color:Theme.of(context).primaryColorLight,fontWeight: FontWeight.bold,))

                      ),
                    ),
                  ),
                ),

                /*child: Padding(
                  padding: const EdgeInsets.only(left:0),
                  child:Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width:1,color: Colors.grey[200],
                          ),
                        )
                    ),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                        onPressed: () {

                        },
                        padding: EdgeInsets.all(15),
                        color: Colors.grey[200],
                        child: Text(
                          'Continue',
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .merge(TextStyle(color: Colors.deepOrange)),
                        )),
                  )
                ),*/
              ),
            ],
          ),)
        )
    );




  }
}















