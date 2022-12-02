
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/elements/UserViewDetailsWidget.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/user_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

// ignore: must_be_immutable
class UserBoxWidget extends StatefulWidget {
  UserModel userData;
  UserBoxWidget({Key key, this.userData}) : super(key: key);
  @override
  _UserBoxWidgetState createState() => _UserBoxWidgetState();
}

class _UserBoxWidgetState extends StateMVC<UserBoxWidget> {

  @override
  Widget build(BuildContext context) {
    return  Div(
      colS:12,
      colM:6,
      colL:3,
      child:Container(
          padding:EdgeInsets.only(left:10,right:10,top:10,bottom:10),
          child:Container(
            decoration: BoxDecoration(
                color:Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                  ),
                ]
            ),
            child:Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          width:37,
                          height:25,

                          decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                bottomLeft: Radius.circular(20),
                              )
                          ),
                          child:Center(
                              child:Text('NEW',
                                  style:TextStyle(color:Colors.white)
                              )
                          )
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:EdgeInsets.only(left:10,right:10,bottom:10),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: widget.userData.image=='no_image'?AssetImage("assets/img/userImage.png"):NetworkImage(widget.userData.image),
                              fit: BoxFit.fill
                          ),
                          shape: BoxShape.circle, color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5.0,),],
                        ),),
                      SizedBox(width:15),
                      Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                   widget.userData.userName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.headline3,
                                  ),

                                  Text(
                                    widget.userData.email,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  SizedBox(height:5),
                                  Wrap(
                                    children: [

                                      SizedBox(width:5),
                                      Text(
                                        widget.userData.phone,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height:10),
                                  Text(
                                    widget.userData.date,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                  SizedBox(height:10),
                                  Text(
                                    Helper.pricePrint( widget.userData.totalSale),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(color: Colors.orangeAccent),
                                  ),

                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ) ,


                ),
                SizedBox(height:10),
                //  CustomDividerView(dividerHeight: 1,),
                SizedBox(height:5),
                Padding(
                  padding: EdgeInsets.only(right:20),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Wrap(
                        children: [
                          IconButton(
                            onPressed: (){
                              showDialog(context: context,
                                  builder: (BuildContext context){
                                    return UserViewDetailsWidget(userData: widget.userData,);
                                  }
                              );
                            },
                            icon: Icon(Icons.remove_red_eye),
                            color:Colors.red,
                            iconSize: 20,
                          ),


                        ],
                      )
                    ],
                  ),
                ),


              ],
            ),


          )
      ),

    );
  }
}
