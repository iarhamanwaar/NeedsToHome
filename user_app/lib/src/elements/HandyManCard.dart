import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';

class HandyManCard extends StatefulWidget {
  const HandyManCard({Key key}) : super(key: key);

  @override
  _HandyManCardState createState() => _HandyManCardState();
}

class _HandyManCardState extends State<HandyManCard> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return   Stack(
      clipBehavior: Clip.none, children: [
      Container(
          height: 130,
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.only(left:15,right:6,top:15,bottom:15),
          decoration: BoxDecoration(
              color:Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(9),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius:2.0,
                  spreadRadius: 1.0,
                ),
              ]
          ),
          child:Stack(
              children:[

                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[

                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Expanded(
                              child:Container(
                                padding:EdgeInsets.only(left:size.width * 0.20),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:[

                                      Text(S.of(context).handyservice,style: Theme.of(context).textTheme.headline1.merge(TextStyle(height: 1)),),
                                      Container(
                                        padding: EdgeInsets.only(top:3),
                                        child:Text(S.of(context).book_your_service_now, style: TextStyle(fontSize: 11),),),
                                      SizedBox(height:5),
                                      Container(
                                        padding: EdgeInsets.only(left:7,right:7),
                                        // ignore: deprecated_member_use
                                        child:FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pushNamed('/H_category');
                                          },
                                          color: Theme.of(context).colorScheme.secondary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Text(
                                              S.of(context).book_now,
                                              style:Theme.of(context).textTheme.caption.merge(TextStyle(height:1.0,color:Theme.of(context).primaryColorLight,))

                                          ),
                                        ),
                                      ),


                                    ]
                                ),


                              ),
                            ),



                          ]
                      ),




                    ]
                ),



              ]
          )

      ),
      Positioned(
          top:-23,
          left:25,
          child:Container(
              child: Image(image:AssetImage('assets/img/handyman.png'),width:80,height:105,
                fit: BoxFit.fitHeight,
              )
          )
      )

    ],
    );
  }
}
