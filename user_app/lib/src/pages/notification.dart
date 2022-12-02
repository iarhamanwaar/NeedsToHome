
import 'package:flutter/material.dart';


class NotificationPage extends StatefulWidget{
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<String> items = new List<String>.generate(2,(i)=>"Items ${i+1}");
  int dropDownValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        actions: [
          InkWell(
            onTap: (){},
            child: Container(
                padding: EdgeInsets.only(top:13,right:10),
                child:  Text('Mark as Read',style: Theme.of(context).textTheme.caption.merge(TextStyle(color:Colors.red)),)
            )
          )


        ],
      ),

      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 15,left:15),
              child: Text('Notifications',style: Theme.of(context).textTheme.headline3,),
            ),

            ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: 12,
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.only(top: 15,bottom:20),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) {
                return Container(
                    padding: EdgeInsets.only(left:15,right:15,top:10),
                    child:Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Container(
                                 height:40,width:40,
                                 child: Image(image: AssetImage('assets/img/china.png'),)
                             ),
                             Expanded(
                               child:Container(
                                   padding: EdgeInsets.only(left:15,right:15),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Container(
                                       padding: EdgeInsets.only(bottom: 5),
                                       child: Wrap(
                                         children: [
                                           Text('Delivery very fast',
                                               style:TextStyle(fontFamily:'Touche W03 Regular',fontWeight: FontWeight.w100,)
                                           ),
                                         ],
                                       )
                                     ),

                                     Text('Your order was deliver early.keep ordering for instant delivery',
                                         style:TextStyle(fontFamily:'Touche W03 Regular',fontWeight: FontWeight.w200,)
                                     ),
                                     Text('wednesday',style: Theme.of(context).textTheme.caption,)
                                   ],
                                 )
                               )

                             )
                           ],
                         )
                        ],
                      ),
                    ),
                  );


              },
              separatorBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(top:10),
                  decoration: BoxDecoration(
                    border:Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Theme.of(context).dividerColor
                      )
                    )
                  ),
                );
              },
            ),

          ],
        ),)
      ),
    );
  }

}