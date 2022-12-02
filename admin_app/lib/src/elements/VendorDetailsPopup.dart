
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/models/vendor_bussinesscard.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';


// ignore: must_be_immutable
class VendorFullDetailsPopWidget extends StatefulWidget {

  String shopId;
  VendorBusinessCard vendorBusinessCard;
  VendorFullDetailsPopWidget({Key key,  this.shopId,this.vendorBusinessCard}) : super(key: key);
  @override
  _VendorFullDetailsPopWidgetState createState() => _VendorFullDetailsPopWidgetState();
}

class _VendorFullDetailsPopWidgetState extends StateMVC<VendorFullDetailsPopWidget> {


 @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
       color: Theme.of(context).primaryColor
      ),

      child: Stack(
        clipBehavior: Clip.none, alignment: Alignment.center,
        children: <Widget>[

          Container(
            padding: EdgeInsets.only(top:0
            ),

            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                  ),
                ]
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                ClipRRect(
                  //borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft:Radius.circular(0),
                      bottomRight:Radius.circular(0),
                    ),

                    child:
                    Image(image:AssetImage('assets/img/resturentdefaultbg.jpg'),
                        width:double.infinity,
                        height:160,
                        fit:BoxFit.fill
                    )
                ),
                Container(
                  padding: EdgeInsets.only(left:10,right:10,top:10),
                  child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text(widget.vendorBusinessCard.basicInformation.companyLegalName??'',
                            style: Theme.of(context).textTheme.headline3
                        )
                      ]
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top:20,left:10,right:10),
                    child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:[
                          Icon(
                              Icons.access_time,size:16
                          ),
                          SizedBox(width:10),
                          Expanded(
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text (widget.vendorBusinessCard.basicInformation.subtitle,maxLines: 1,style: Theme.of(context).textTheme.caption),



                                  RichText(
                                    text: TextSpan(text: 'Time',
                                        style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.blue)),
                                        children: [
                                          new TextSpan(
                                              text: (' ${widget.vendorBusinessCard.basicInformation.openingTime} - ${widget.vendorBusinessCard.basicInformation.closingTime}'),
                                              style: Theme.of(context).textTheme.caption

                                          )
                                        ]),
                                  ),
                                ],
                              )
                          ),
                          SizedBox(width:10),


                        ]
                    )
                ),
                Container(
                    padding: EdgeInsets.only(top:10,left:10,right:10),
                    child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:[
                          Icon(
                              Icons.money,size:16
                          ),
                          SizedBox(width:10),
                          Expanded(
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  RichText(
                                    text: TextSpan(text:  widget.vendorBusinessCard.basicInformation.mobile??'',
                                        style: Theme.of(context).textTheme.caption,
                                        children: [
                                          new TextSpan(
                                              text: '',
                                              style: Theme.of(context).textTheme.caption

                                          )
                                        ]),
                                  ),
                                ],
                              )
                          ),


                        ]
                    )
                ),
                Container(
                    padding: EdgeInsets.only(top:10,left:10,right:10),
                    child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:[
                          Icon(
                              Icons.brunch_dining,size:16
                          ),
                          SizedBox(width:10),
                          Expanded(
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  RichText(
                                    text: TextSpan(text: 'Holidays',
                                        style: Theme.of(context).textTheme.caption,
                                        children: [
                                          new TextSpan(
                                              text:  (' ${widget.vendorBusinessCard.basicInformation.holidays.monVal?'Mon':''}'??''
                                                  '${widget.vendorBusinessCard.basicInformation.holidays.tueVal?'Tue':''}'??''
                                                  '${widget.vendorBusinessCard.basicInformation.holidays.wedVal?'Wed':''}'??''
                                                  '${widget.vendorBusinessCard.basicInformation.holidays.thurVal?'Thur':''}'??''
                                                  '${widget.vendorBusinessCard.basicInformation.holidays.friVal?'Fri':''}'??''
                                                  '${widget.vendorBusinessCard.basicInformation.holidays.satVal?'Sat':''}'??''
                                                  '${widget.vendorBusinessCard.basicInformation.holidays.sunVal?'Sun':''}'??''
                                              ),
                                              style: Theme.of(context).textTheme.caption

                                          )
                                        ]),
                                  ),
                                ],
                              )
                          ),


                        ]
                    )
                ),

                Container(
                    padding: EdgeInsets.only(top:20,left:10,right:10),
                    child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:[
                          Icon(
                              Icons.location_on_outlined,size:16
                          ),
                          SizedBox(width:10),
                          Expanded(
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  RichText(
                                    text: TextSpan(text: 'Near to you ',
                                        style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.blue)),
                                        children: [
                                          new TextSpan(
                                              text: widget.vendorBusinessCard.basicInformation.pickupAddress??'',
                                              style: Theme.of(context).textTheme.caption

                                          )
                                        ]),
                                  ),
                                ],
                              )
                          ),
                          SizedBox(width:10),
                          InkWell(
                            onTap: (){
                                openMap( widget.vendorBusinessCard.basicInformation.latitude,  widget.vendorBusinessCard.basicInformation.longitude);
                            },
                            child: Align(
                                child:Icon(Icons.directions,size:18,color:Colors.red,)
                            ),
                          )

                        ]
                    )
                ),




                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      padding: EdgeInsets.only(top:40,bottom:20),
                      width: double.infinity,
                      color: Theme.of(context).primaryColor,
                      child:Column(children:[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children:[
                              InkWell(
                                onTap: () async{
                                  final url =widget.vendorBusinessCard.socialLinks.faceBook;
                                  if (await canLaunch(url)) {
                                    await launch(
                                      url,
                                      forceSafariVC: false,
                                    );
                                  }
                                  print('check you!');
                                },
                                child: Container(
                                  height: 35,width:35,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:Theme.of(context).primaryColor,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0,2),
                                            blurRadius: 6.0
                                        )
                                      ],
                                      image: DecorationImage(image: AssetImage('assets/img/facebook.png'),)
                                  ),
                                ),
                              ),
                              SizedBox(width:30),
                              InkWell(
                                onTap: () async{
                                  final url = widget.vendorBusinessCard.socialLinks.whatsApp;
                                  if (await canLaunch(url)) {
                                    await launch(
                                      url,
                                      forceSafariVC: false,
                                    );
                                  }
                                },
                                child: Container(
                                  height: 35,width:35,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:Theme.of(context).primaryColor,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0,2),
                                            blurRadius: 6.0
                                        )
                                      ],
                                      image: DecorationImage(image: AssetImage('assets/img/whatsap.png'),)
                                  ),
                                ),
                              ),
                              SizedBox(width:30),
                              InkWell(
                                onTap: () async{
                                  final url = widget.vendorBusinessCard.socialLinks.twitter;
                                  if (await canLaunch(url)) {
                                    await launch(
                                      url,
                                      forceSafariVC: false,
                                    );
                                  }
                                },
                                child: Container(
                                  height: 35,width:35,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:Theme.of(context).primaryColor,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0,2),
                                            blurRadius: 6.0
                                        )
                                      ],
                                      image: DecorationImage(image: AssetImage('assets/img/twitter.png'),)
                                  ),
                                ),
                              ),
                              SizedBox(width:30),
                              InkWell(
                                onTap: () async{
                                  final url = widget.vendorBusinessCard.socialLinks.instagram;
                                  if (await canLaunch(url)) {
                                    await launch(
                                      url,
                                      forceSafariVC: false,
                                    );
                                  }
                                },
                                child: Container(
                                  height: 35,width:35,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:Theme.of(context).primaryColor,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0,2),
                                            blurRadius: 6.0
                                        )
                                      ],
                                      image: DecorationImage(image: AssetImage('assets/img/google.png'),)
                                  ),
                                ),
                              ) ,
                            ]
                        ),
                        SizedBox(height:20),



                      ])
                  ),
                ),
                SizedBox(height:20),


              ],
            ),

          ),
          Positioned(
            top:-40,
            child: Container(
                margin: EdgeInsets.only(top:10),
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:Colors.white,
                ),


                height: 66,
                width:66,
                child:ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child:Image.network(widget.vendorBusinessCard.coverImage, height: 66,width:66,
                      fit: BoxFit.fill,)

                )


            ),
          ),

        ],
      )
    );
  }

 openMap(latitude,longitude) async{
   String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
   if (await
   canLaunch(googleUrl)) {
     await launch(googleUrl);
   } else {
     throw 'Could not open the map.';
   }
 }
}
