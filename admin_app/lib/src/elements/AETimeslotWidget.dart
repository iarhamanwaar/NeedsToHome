


import 'package:flutter/material.dart';



import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

class AETimeslotWidget extends StatefulWidget{
  @override
  _AETimeslotWidgetState createState() => _AETimeslotWidgetState();
}

class _AETimeslotWidgetState extends StateMVC<AETimeslotWidget> {



  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
        child:Div(
                     colS:12,
                     colM:8,
                     colL:6,


                       child:Dialog(
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(16)
                         ),

                         elevation: 0,
                         backgroundColor: Colors.transparent,

                         insetPadding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.2,
                           left:MediaQuery.of(context).size.width * 0.09,
                           right:MediaQuery.of(context).size.width * 0.09,
                           bottom:MediaQuery.of(context).size.height * 0.2,
                         ),
                         child:Container(
                           width: double.infinity,
                           decoration: BoxDecoration(
                               color:Theme.of(context).primaryColor,
                               shape: BoxShape.rectangle,
                               borderRadius: BorderRadius.all(Radius.circular(12))
                           ),

                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                               Expanded(
                                 child:Container(
                                   child:Scrollbar(
                                     isAlwaysShown: true,
                               child: SingleChildScrollView(
                               child: Column(
                               children: [
                                 Row(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     children:[
                                       IconButton(
                                         icon: Icon(Icons.close),
                                         onPressed: (){
                                           Navigator.pop(context);
                                         },
                                       )

                                     ]
                                 ),
                                 Text('Add',
                                     style: Theme.of(context).textTheme.headline4
                                 ),

                                 Padding(
                                       padding: const EdgeInsets.only(right: 40, left:40),
                                       child:Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children:[
                                             SizedBox(height:10),
                                             Container(
                                                 width: double.infinity,

                                                 child: TextFormField(
                                                     textAlign: TextAlign.left,
                                                     autocorrect: true,
                                                     keyboardType: TextInputType.text,
                                                     decoration: InputDecoration(
                                                       labelText: 'Railway Time Id',
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
                                             SizedBox(height:5),
                                             Text('Eg.(3.00 PM to 6.00 PM) your time railway id is 18'),
                                             SizedBox(height:10),
                                             Container(
                                                 width: double.infinity,
                                                 child: TextFormField(
                                                     textAlign: TextAlign.left,
                                                     autocorrect: true,
                                                     keyboardType: TextInputType.text,
                                                     decoration: InputDecoration(
                                                       labelText: 'Time Slot',
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

                                             SizedBox(height:60),
                                       ]
                                   ),

                                 ),
                               ]
                               ),
                               ),),
                                 )
                               ),
                               Align(
                                 alignment: Alignment.bottomRight,
                                 child:Container(
                                   padding: EdgeInsets.only(bottom:10,right:10,left:10),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     children: [
                                       // ignore: deprecated_member_use
                                       FlatButton(
                                         onPressed: () {

                                         },
                                         padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                                         color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                         shape: StadiumBorder(),
                                         child: Text(
                                           'Save',
                                           style: Theme.of(context).textTheme.headline6.merge(
                                               TextStyle(
                                                   color: Theme.of(context)
                                                       .primaryColorLight)),
                                         ),
                                       ),
                                       SizedBox(width:10),
                                       // ignore: deprecated_member_use
                                       FlatButton(
                                         onPressed: () {

                                         },
                                         padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                                         color: Colors.black,
                                         shape: StadiumBorder(),
                                         child: Text(
                                           'Cancel',
                                           style: Theme.of(context).textTheme.headline6.merge(
                                               TextStyle(
                                                   color: Theme.of(context)
                                                       .primaryColorLight)),
                                         ),
                                       ),


                                     ],
                                   ),
                                 ),

                               ),



                             ],
                           ),
                       ),
                       ),

                   )

    );



  }








}
