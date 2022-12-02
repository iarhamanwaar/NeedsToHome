import 'package:flutter/material.dart';

import '../../generated/l10n.dart';


class NoticeBoard extends StatefulWidget {

  @override
  _NoticeBoardState createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard>  with SingleTickerProviderStateMixin {




  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top:80),
            height: 100,width:100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/wait.png'),
                    fit: BoxFit.cover)),
          ),


          Container(
            alignment:Alignment.center,
            padding: EdgeInsets.only(top:20,left:25,right: 25),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Waiting for approval',
                  style: TextStyle(
                      color:Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  S.of(context).please_wait_your_document_is_under_review,
                  style:Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.center,
                ),
              ],
            ),),

          SizedBox(
            height: size.height * 0.1,
          ),







          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              MaterialButton(
                onPressed:(){},
                focusColor: Colors.transparent,
                child: Text("Thanks!",),
              ),


            ],
          ),



        ],
      ),)
    );
  }


}
