import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/elements/DriverDetailsViewWidget.dart';
import 'package:login_and_signup_web/src/models/driverregistermodel.dart';
import 'package:login_and_signup_web/src/repository/secondary_repository.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
// ignore: must_be_immutable
class DriverBoxWidget extends StatefulWidget {
  DriverRegistermodel driverData;
  DriverBoxWidget({Key key, this.driverData}) : super(key: key);
  @override
  _DriverBoxWidgetState createState() => _DriverBoxWidgetState();
}

class _DriverBoxWidgetState extends State<DriverBoxWidget> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Div(
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
                    spreadRadius: 1,
                  ),
                ]),
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
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                bottomLeft: Radius.circular(20),
                              )
                          ),
                          child:Center(
                              child:Text('Ng',
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
                              image:  widget.driverData.image=='no_image'?AssetImage("assets/img/userImage.png"): NetworkImage(widget.driverData.image),
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
                                    widget.driverData.firstname,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.headline3,
                                  ),

                                  Text(
                                    widget.driverData.mobile.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.caption,
                                  ),

                                  Text(
                                    '${widget.driverData.gender} - Age(${widget.driverData.age})',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  SizedBox(height:5),

                                  Wrap(
                                    children: [
                                      widget.driverData.status=='success'?Icon(Icons.verified_user,size:18,color:Colors.green):Icon(Icons.verified_user,size:18,color:Colors.red),
                                      SizedBox(width:5),
                                      Text(
                                        widget.driverData.status=='success'?S.of(context).verified_driver:'Not Verified driver',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height:10),
                                  Text(
                                    widget.driverData.address1.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: Theme.of(context).textTheme.caption,
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(width: 8),

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
                  padding: EdgeInsets.only(right:10),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      IconButton(
                        onPressed: (){
                          showDialog(context: context,
                              builder: (BuildContext context){
                                return DriverDetailsViewWidget(driverData: widget.driverData,);
                              }
                          );
                        },
                        icon: Icon(Icons.remove_red_eye),
                        color:Colors.grey,
                        iconSize: 20,
                      ),
                      Wrap(
                          children:[
                            Container(
                              padding:EdgeInsets.only(top:12),
                              child:  Text('Block'),
                            ),

                            GestureDetector(
                              onTap: () {},
                              child: Center(
                                child: Switch(
                                  value: widget.driverData.block,

                                  onChanged: (value){
                                    setState(() {
                                      isSwitched=value;
                                      widget.driverData.block = value;
                                      print(isSwitched);
                                    });
                                    statusUpdate('driver',widget.driverData.id,'block',widget.driverData.block);
                                  },
                                  activeTrackColor: Colors.lightGreenAccent,
                                  activeColor: Colors.green,

                                ),
                              ),

                            ),
                          ]
                      ),





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
