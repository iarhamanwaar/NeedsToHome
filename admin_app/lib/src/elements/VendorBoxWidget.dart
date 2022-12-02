
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/primaryuser_controller.dart';
import 'package:login_and_signup_web/src/models/vendor.dart';
import 'package:login_and_signup_web/src/pages/profile_view.dart';
import 'package:login_and_signup_web/src/repository/secondary_repository.dart';
import 'package:responsive_ui/responsive_ui.dart';

class VendorBoxWidget extends StatefulWidget {
  final PrimaryUserController con;
  final VendorModel details;
  final int type;
  const VendorBoxWidget({Key key, this.details, this.con, this.type}) : super(key: key);
  @override
  _VendorBoxWidgetState createState() => _VendorBoxWidgetState();
}

class _VendorBoxWidgetState extends State<VendorBoxWidget> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child:Div(
        colS: 12,
        colM: 12,
        colL: 4,

        child:  Container(
          decoration: BoxDecoration(
              color:Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                ),
              ]),
          margin: EdgeInsets.only(left:15,right:15, top: 10.0,bottom:10),

          child:Column(
              children:[
                Stack(
                    children:[
                      ClipRRect(
                        //borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft:Radius.circular(0),
                            bottomRight:Radius.circular(0),

                          ),
                          child:Image(image: widget.details.coverImage =='no_image' && widget.type==1? AssetImage('assets/img/grocerydefaultbg.jpg'):
                          widget.details.coverImage =='no_image' && widget.type==2?AssetImage('assets/img/resturentdefaultbg.jpg'):
                          widget.details.coverImage =='no_image' && widget.type==3?AssetImage('assets/img/pharmacydefaultbg.jpg'):NetworkImage(widget.details.coverImage),
                              width:double.infinity,
                              height:150,
                              fit:BoxFit.fill
                          )
                      ),

                      ClipRRect(
                        //borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft:Radius.circular(0),
                          bottomRight:Radius.circular(0),

                        ),
                        child:Container(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                            Container(
                              height:150,
                              width: double.infinity,
                              child: Stack(
                                  children:[
                                    Container(
                                      alignment: Alignment.bottomLeft,

                                      /* background black light to dark gradient color */
                                      decoration: BoxDecoration(
                                        gradient: new LinearGradient(
                                          begin: const Alignment(0.0, -1.0),
                                          end: const Alignment(0.0, 0.6),
                                          colors: <Color>[
                                            const Color(0x8A000000).withOpacity(0.0),
                                            const Color(0x8A000000).withOpacity(0.9),
                                          ],
                                        ),
                                      ),

                                    ),

                              Positioned(
                                  top:10,right:10,
                                 child: Container(
                                     decoration:BoxDecoration(
                                       color:Colors.orange,
                                       borderRadius: BorderRadius.circular(5),
                                     ),
                                     padding: EdgeInsets.only(left:5,right: 5,top:5,bottom:5),
                                     child:Text(widget.details.planName!='no'?widget.details.planName:'Not Selected',style:TextStyle(color:Theme.of(context).primaryColorLight))
                                 ),

                              ),
                                    widget.details.profileStatus=='approved'? Positioned(
                                      top:0,left:5,
                                      child: Tooltip(
                                        message: 'Open/Close',
                                        child: Switch(
                                          value: widget.details.liveStatus,
                                          onChanged: (value){

                                            setState(() {
                                              if(value==true){
                                                widget.details.liveStatus = true;

                                              } else {
                                                widget.details.liveStatus = false;
                                              }

                                            });

                                            statusUpdate('vendor',widget.details.shopId,'livestatus',widget.details.liveStatus);
                                          },
                                          activeTrackColor: Colors.lightGreenAccent,
                                          activeColor: Colors.green,
                                          inactiveTrackColor: Colors.red,

                                        ),
                                      ),
                                    ):Container(),
                                    Positioned(
                                        bottom:10,left:10,right:10,
                                        child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:[
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children:[

                                                 Container(
                                                   width:200,
                                                   child:Text(widget.details.general.subtitle,
                                                     overflow: TextOverflow.ellipsis,maxLines: 1,
                                                     style:TextStyle(color:Theme.of(context).primaryColorLight),
                                                   ),
                                                 ),
                                                  Container(
                                                    decoration:BoxDecoration(
                                                      color: widget.details.profileStatus=='waiting'?Colors.blue:widget.details.profileStatus=='approved'?Colors.green:Colors.red,
                                                      borderRadius: BorderRadius.circular(5),
                                                    ),
                                                    padding: EdgeInsets.only(left:5,right: 5,top:5,bottom:5),
                                                    child:Text(widget.details.profileStatus,style:TextStyle(color:Theme.of(context).primaryColorLight))
                                                  ),
                                                ]
                                              ),

                                            ]
                                        )
                                    )
                                  ]
                              ),
                            ),
                          ]
                          ),
                        ),
                      ),
                    ]
                ),

                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Padding(
                          padding:EdgeInsets.only(left:10,right:10,top:10,bottom:10),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  Container(
                                    height: 45,
                                    width: 45,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: widget.details.image=='no_image'?AssetImage("assets/img/food.png"):NetworkImage(widget.details.image),
                                          fit: BoxFit.fill
                                      ),
                                      shape: BoxShape.circle, color: Colors.white, boxShadow:
                                    [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5.0,
                                      ),
                                    ],

                                    ),
                                  ),
                                  SizedBox(width:10),

                                  Text('ID ${widget.details.shopId} - ${widget.details.shopName.toUpperCase()}'),

                                ],
                              ),
                              IconButton(onPressed: (){
                                imagePickerBottomSheet(widget.details.shopId, widget.details);
                              }, icon: Icon(Icons.more_horiz))
                            ],
                          )
                      ),
                      Padding(
                          padding:EdgeInsets.only(left:15,right:15,bottom:10),
                          child:Wrap(
                              children:[
                                Icon(Icons.phone,size:15,color:Colors.grey),
                                SizedBox(width:5),
                                Text(widget.details.general.mobile,style:TextStyle(color:Colors.grey)),
                              ]
                          )
                      ),
                      Padding(
                          padding:EdgeInsets.only(left:15,right:15,bottom:10),
                          child:Row(
                              children:[
                                Icon(Icons.add_location,size:15,color:Colors.grey),
                                SizedBox(width:5),
                                Expanded(
                                  child:Text(widget.details.general.pickupAddress,style:TextStyle(color:Colors.grey)),
                                )

                              ]
                          )
                      ),
                      ClipRRect(
                        //borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft:Radius.circular(10),
                          bottomRight:Radius.circular(10),

                        ),
                        child:Container(
                          color:Theme.of(context).dividerColor,
                          width:double.infinity,
                          padding:EdgeInsets.only(bottom:10,top:10,left:15,right:15,),
                          child:Wrap(
                              children:[
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:4,
                                  child:Padding(
                                    padding:EdgeInsets.only(top:5),
                                    // ignore: deprecated_member_use
                                    child:FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileView(type: widget.type,coverImage: widget.details.coverImage, shopId: widget.details.shopId,shopName: widget.details.shopName,status: widget.details.profileStatus,)));
                                      },
                                      color:Colors.blue,
                                      splashColor:Colors.blue,
                                      textColor:Colors.white,
                                      child:Text(S.of(context).view_more,style:Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.white))),
                                    ),
                                  ),
                                ),
                                widget.details.profileComplete=='5'&&  widget.details.profileStatus=='waiting'?Div(
                                  colS:4,
                                  colM:4,
                                  colL:4,
                                  child:GestureDetector(
                                    onTap: () {},
                                    child: Center(
                                        child:Tooltip(
                                          message:S.of(context).approved,
                                          child:Switch(
                                            value: widget.details.status,
                                            onChanged: (value){
                                              setState(() {
                                                isSwitched=value;

                                              });

                                              if(value==true){
                                                widget.details.status = true;
                                                statusMemberUpdate(widget.details.shopId,widget.details.planId,);
                                              }

                                            },
                                            activeTrackColor: Colors.lightGreenAccent,
                                            activeColor: Colors.green,

                                          ),
                                        )

                                    ),

                                  ),
                                ):widget.details.profileStatus=='approved'|| widget.details.profileStatus=='unapproved'?Div(
                                  colS:4,
                                  colM:4,
                                  colL:4,
                                  child:GestureDetector(
                                    onTap: () {},
                                    child: Center(
                                      child:Tooltip(
                                        message: 'Blocked',
                                        child:Switch(
                                          value: widget.details.status,
                                          onChanged: (value){
                                            setState(() {
                                              isSwitched=value;

                                            });

                                            if(value==true){
                                              widget.details.status = true;
                                              statusUpdate('vendor',widget.details.shopId,'status','unapproved');
                                            } else{
                                              widget.details.status = false;
                                              statusUpdate('vendor',widget.details.shopId,'status','approved');
                                            }


                                          },
                                          activeTrackColor: Colors.red,
                                          activeColor: Colors.red,

                                        ),
                                      )

                                    ),

                                  ),
                                ):Container(),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:3,
                                  child:Padding(
                                      padding:EdgeInsets.only(top:10),
                                      child:Wrap(
                                          alignment: WrapAlignment.end,
                                          children:[
                                            Icon(Icons.star,size:17,color:Colors.orangeAccent),
                                            SizedBox(width:3),
                                            Padding(
                                                padding:EdgeInsets.only(top:2),child:Text(widget.details.rating.toString()))
                                          ]
                                      )
                                  ),
                                )

                              ]
                          ),
                        ),
                      ),

                    ]
                )
              ]
          ),
        ),
      ),
    );
  }

  imagePickerBottomSheet(id, VendorModel vendorDetails) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: ()  async{
                    Navigator.pop(context);
                   // setState(() {widget.con.hcategoryList.clear();});
                      return  showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(S.of(context).confirm),
                            content: Text("Are you sure you wish to delete this vendor?"),
                            actions: <Widget>[
                              // ignore: deprecated_member_use
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    widget.con.vendorDelete(id);
                                  },
                                  child: Text(S.of(context).delete)
                              ),
                              // ignore: deprecated_member_use
                              FlatButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(S.of(context).cancel),
                              ),
                            ],
                          );
                        },
                      );
                    },
                ),
                new ListTile(
                  leading: new Icon(Icons.settings),
                  title: new Text(S.of(context).settings),
                  onTap: () async {
                    Navigator.pop(context);
                    // setState(() {widget.con.hcategoryList.clear();});
                    return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return AlertDialog(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('S.of(context).best_seller'),
                                Switch(
                                  value: vendorDetails.bestSeller,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == true) {
                                        vendorDetails.bestSeller = true;
                                        statusUpdate('vendor', vendorDetails.shopId, 'best_seller', 1);
                                      } else {
                                        vendorDetails.bestSeller = false;
                                        statusUpdate('vendor', vendorDetails.shopId, 'best_seller', 0);
                                      }
                                    });
                                  },
                                  activeColor: Colors.green,
                                )
                              ],
                            ),
                            actions: <Widget>[
                              // ignore: deprecated_member_use
                              FlatButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('ok'),
                              ),
                            ],
                          );
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          );
        });
  }
}

