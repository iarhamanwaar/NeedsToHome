import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';


class ProductBoxWidget4 extends StatefulWidget {
  @override
  _ProductBoxWidget4State createState() => _ProductBoxWidget4State();
}

class _ProductBoxWidget4State extends StateMVC<ProductBoxWidget4> {
   final bool onSelect = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(top:10),
      child: Wrap(
        children: List.generate(10, (index) {
          return Wrap(
              children:[
                Div(
                  colL:6,
                  colM:6,
                  colS:6,
                  child:Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border:Border.all(
                              width: 0.2,color:Colors.grey
                          )
                      ),
                      child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children:[

                            Container(
                              height:240,
                              alignment: Alignment.center,
                              child: Padding(
                                  padding: EdgeInsets.only(bottom:0),
                                  child: InkWell(
                                      onTap: () {},
                                      child: Container(

                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5.0),
                                            boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.05), blurRadius: 0.5)],
                                            color: Theme.of(context).primaryColor),
                                        child:  Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child:  Container(
                                                    padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
                                                    alignment: Alignment.center,
                                                    child:Center(
                                                        child:Image.asset(
                                                          'assets/img/restaurant.png',
                                                          width:size.width,
                                                          height: 120,
                                                          fit: BoxFit.fill,

                                                        )
                                                    ),


                                                  ),
                                                ),

                                              ],
                                            ),

                                            Container(
                                                padding: EdgeInsets.only(left: 8, right: 8, top: 4,),
                                                child: Text('Briyani restaurant Brbequeen',
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(color: Theme.of(context).backgroundColor.withOpacity(0.8)),
                                                )
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(left: 4, right:8, ),
                                              child:InkWell(
                                                onTap: (){

                                                },
                                                child:Container(
                                                    height:30,
                                                    width:110,
                                                    padding:EdgeInsets.all(5),

                                                    child:Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text('44'),
                                                        Icon(Icons.arrow_drop_down,size:19,color:Colors.grey)
                                                      ],
                                                    )),
                                              ),
                                            ),

                                            Container(
                                              padding: EdgeInsets.only(left: 8, right: 8, ),
                                              child:Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children:[
                                                    Container(
                                                      width:size.width < 320 ? size.width * 0.1 :size.width * 0.13,
                                                      child:Text( '\$356',
                                                        overflow: TextOverflow.ellipsis, maxLines: 1,
                                                        style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(fontWeight: FontWeight.w700)),
                                                      ),
                                                    ),

                                                    1 ==  1
                                                        ?  InkWell(
                                                      onTap: (){
                                                      },
                                                      child:Padding(
                                                        padding: EdgeInsets.only(top:10,left:10),
                                                        child:Container(
                                                          width: 60,
                                                          height:31,
                                                          padding: EdgeInsets.only(left: 5, right: 5,),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5.0),
                                                            color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                                          ),

                                                          child:Center(
                                                            child: Text('ADD',
                                                                style: Theme.of(context).textTheme.subtitle2.
                                                                merge(TextStyle(color:Theme.of(context).primaryColorLight,fontWeight: FontWeight.w600))
                                                            ),
                                                          ),







                                                        ),
                                                      ),
                                                    ):Container()
                                                    /*: InkWell(
                                                                              onTap: () {},
                                                                              child: Padding(
                                                                                padding: EdgeInsets.only(
                                                                                  left:5,

                                                                                ),
                                                                                child: Wrap(
                                                                                    alignment: WrapAlignment.spaceBetween,
                                                                                    children: [
                                                                                      InkWell(
                                                                                        onTap: () {

                                                                                        },

                                                                                        child: Icon(Icons.remove_circle,color:Theme.of(context).backgroundColor,size:27),

                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: MediaQuery.of(context).size.width *  0.01,
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsets.only(top: 5),
                                                                                        child: Text( 'fff', style: Theme.of(context).textTheme.bodyText1),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: MediaQuery.of(context).size.width *  0.01,
                                                                                      ),
                                                                                      InkWell(
                                                                                        onTap: () {

                                                                                        },

                                                                                        child: Icon(Icons.add_circle,color:Theme.of(context).backgroundColor,size:27),
                                                                                      ),
                                                                                    ]),
                                                                              ),
                                                                            ),*/
                                                  ]
                                              ),
                                            ),

                                          ],
                                        ),

                                      )
                                  )
                              ),
                            ),


                            Positioned(
                              top:0,left:15,
                              child: Stack(
                                  clipBehavior: Clip.none, children:[
                                Container(
                                    width:30,height:70,
                                    child:Image(image:AssetImage('assets/img/toplable.png'))
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child:Container(
                                        margin: EdgeInsets.only(top:18,left:3),
                                        alignment: Alignment.center,
                                        child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children:[
                                              Text('dd',
                                                style: TextStyle(color:Theme.of(context).primaryColorLight,fontSize: 10,fontWeight: FontWeight.w700
                                                ),
                                              ),
                                              Text('OFF',
                                                style: TextStyle(color:Theme.of(context).primaryColorLight,fontSize: 10,fontWeight: FontWeight.w700
                                                ),
                                              )
                                            ]
                                        )
                                    )
                                ),


                              ]),
                            )
                          ]
                      )
                  ),
                ),




              ]
          );
        }
        ),
      ),
    );
  }
}
