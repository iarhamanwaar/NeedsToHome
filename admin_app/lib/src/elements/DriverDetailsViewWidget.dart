
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/components/padding_constants.dart';
import 'package:login_and_signup_web/src/models/driverregistermodel.dart';
import 'package:login_and_signup_web/src/repository/secondary_repository.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: must_be_immutable
class DriverDetailsViewWidget extends StatefulWidget {
  DriverRegistermodel driverData;
  DriverDetailsViewWidget({Key key, this.driverData}) : super(key: key);

  @override
  _DriverDetailsViewWidgetState createState() => _DriverDetailsViewWidgetState();
}

class _DriverDetailsViewWidgetState extends State<DriverDetailsViewWidget> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PaddingConstants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    var size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          height: 480,

          padding: EdgeInsets.only(left: PaddingConstants.padding,top: PaddingConstants.avatarRadius
              + PaddingConstants.padding, right: PaddingConstants.padding,bottom: PaddingConstants.padding
          ),
          margin: EdgeInsets.only(top:PaddingConstants.avatarRadius,left:size.width >670 ? size.width * 0.27: PaddingConstants.padding,right:size.width >670 ? size.width * 0.27: PaddingConstants.padding),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(PaddingConstants.padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                ),
              ]
          ),
          child:SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text(S.of(context).driver_id,style:Theme.of(context).textTheme.subtitle1),
                      Container(
                          width:size.width > 670 ? size.width * 0.2: 140,
                          alignment: Alignment.topRight,
                          child:Text(widget.driverData.id.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:Theme.of(context).textTheme.subtitle1)
                      ),

                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text(S.of(context).name,style:Theme.of(context).textTheme.subtitle1),
                      Container(
                          width:size.width > 670 ? size.width * 0.2: 140,
                          alignment: Alignment.topRight,
                          child:Text(widget.driverData.firstname,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:Theme.of(context).textTheme.subtitle1)
                      ),

                    ]
                ),
                SizedBox(height:5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text('Last Name',style:Theme.of(context).textTheme.subtitle1),
                      Container(
                          width:size.width > 670 ? size.width * 0.2: 140,
                          alignment: Alignment.topRight,
                          child:Text(widget.driverData.lastname,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:Theme.of(context).textTheme.subtitle1)
                      ),

                    ]
                ),
                SizedBox(height:5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text(S.of(context).email,style:Theme.of(context).textTheme.subtitle1),
                      Container(
                          width:size.width > 670 ? size.width * 0.2: 140,
                          alignment: Alignment.topRight,
                          child:Text(widget.driverData.email,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:Theme.of(context).textTheme.subtitle1)
                      ),

                    ]
                ),
                SizedBox(height:5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text(S.of(context).phone,style:Theme.of(context).textTheme.subtitle1),
                      Container(
                          width:size.width > 670 ? size.width * 0.2: 140,
                          alignment: Alignment.topRight,
                          child:Text(widget.driverData.mobile.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:Theme.of(context).textTheme.subtitle1)
                      ),

                    ]
                ),
                SizedBox(height:5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text(S.of(context).gender,style:Theme.of(context).textTheme.subtitle1),
                      Container(
                          width:size.width > 670 ? size.width * 0.2: 140,
                          alignment: Alignment.topRight,
                          child:Text(widget.driverData.gender,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:Theme.of(context).textTheme.subtitle1)
                      ),

                    ]
                ),
                SizedBox(height:5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text('Age',style:Theme.of(context).textTheme.subtitle1),
                      Container(
                          width:size.width > 670 ? size.width * 0.27: 140,
                          alignment: Alignment.topRight,
                          child:Text(widget.driverData.age.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:Theme.of(context).textTheme.subtitle1)
                      ),
                    ]
                ),
                SizedBox(height:5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text(S.of(context).address,style:Theme.of(context).textTheme.subtitle1),
                      Container(
                          width:size.width > 670 ? size.width * 0.2: 140,
                          alignment: Alignment.topRight,
                          child:Text(widget.driverData.address1,

                              textAlign: TextAlign.right,
                              style:Theme.of(context).textTheme.subtitle1)
                      ),

                    ]
                ),
                SizedBox(height:5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text('Proof',style:Theme.of(context).textTheme.subtitle1),
                      Container(
                          width:size.width > 670 ? size.width * 0.2: 140,
                          alignment: Alignment.topRight,
                          child:Text('df',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:Theme.of(context).textTheme.subtitle1)
                      ),
                    ]
                ),
                SizedBox(height:5),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text('Live Status',style:Theme.of(context).textTheme.subtitle1),
                      Container(
                          width:size.width > 670 ? size.width * 0.2: 140,
                          alignment: Alignment.topRight,
                          child:Text(widget.driverData.liveStatus,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:Theme.of(context).textTheme.subtitle1)
                      ),
                    ]
                ),


                SizedBox(height:5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text('Driving Mode',style:Theme.of(context).textTheme.subtitle1),
                      Container(
                          width:size.width > 670 ? size.width * 0.2: 140,
                          alignment: Alignment.topRight,
                          child:Text(widget.driverData.drivingMode.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:Theme.of(context).textTheme.subtitle1)
                      ),
                    ]
                ),
                SizedBox(height:15),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text('Proof Type',style:Theme.of(context).textTheme.subtitle1),
                      Container(
                          width:size.width > 670 ? size.width * 0.2: 140,
                          alignment: Alignment.topRight,
                          child:InkWell(
                            onTap: () async {
                              final url = widget.driverData.proof;
                              print( url);
                              if (await canLaunch(url)) {
                              await launch(
                              url,
                              forceSafariVC: false,
                              );
                              }
                            },
                            child: Text('click - ${widget.driverData.proofType.toString()}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style:Theme.of(context).textTheme.subtitle1),
                          )
                      ),
                    ]
                ),
                SizedBox(height:5),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text('Account Holder',style:Theme.of(context).textTheme.subtitle1),
                      Container(
                          width:size.width > 670 ? size.width * 0.2: 140,
                          alignment: Alignment.topRight,
                          child:Text(widget.driverData.accountHolder.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:Theme.of(context).textTheme.subtitle1)
                      ),
                    ]
                ),
                SizedBox(height:5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text('Account No',style:Theme.of(context).textTheme.subtitle1),
                      Container(
                          width:size.width > 670 ? size.width * 0.2: 140,
                          alignment: Alignment.topRight,
                          child:Text(widget.driverData.accountNo.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:Theme.of(context).textTheme.subtitle1)
                      ),
                    ]
                ),
                SizedBox(height:5),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text('Bank Name',style:Theme.of(context).textTheme.subtitle1),
                      Container(
                          width:size.width > 670 ? size.width * 0.2: 140,
                          alignment: Alignment.topRight,
                          child:Text(widget.driverData.bankName.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:Theme.of(context).textTheme.subtitle1)
                      ),
                    ]
                ),
                SizedBox(height:5),


                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text('Bank Code',style:Theme.of(context).textTheme.subtitle1),
                      Container(
                          width:size.width > 670 ? size.width * 0.2: 140,
                          alignment: Alignment.topRight,
                          child:Text(widget.driverData.bankCode.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:Theme.of(context).textTheme.subtitle1)
                      ),
                    ]
                ),
                SizedBox(height:20),




                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text('Store Id',style:Theme.of(context).textTheme.subtitle1),
                      Container(
                          width:size.width > 670 ? size.width * 0.2: 140,
                          alignment: Alignment.topRight,
                          child:Text(widget.driverData.storeId.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:Theme.of(context).textTheme.subtitle1)
                      ),
                    ]
                ),
                SizedBox(height:5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text(S.of(context).created_date,style:Theme.of(context).textTheme.subtitle1),
                      Container(
                          width:size.width > 670 ? size.width * 0.2: 140,
                          alignment: Alignment.topRight,
                          child:Text(widget.driverData.date,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              style:Theme.of(context).textTheme.subtitle1)
                      ),
                    ]
                ),
                SizedBox(height:5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text('Verified',style:Theme.of(context).textTheme.subtitle1),
                      GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: Switch(
                            value: widget.driverData.status=='success'?true:false,

                            onChanged: (value){
                              setState(() {
                                if(value==false) {
                                  widget.driverData.status = 'unsuccess';
                                } else{
                                  widget.driverData.status = 'success';
                                }
                                statusUpdate('driver',widget.driverData.id,'status',widget.driverData.status);

                              });
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,

                          ),
                        ),

                      ),
                    ]
                ),

                Align(
                  alignment: Alignment.center,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                    color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                    shape: StadiumBorder(),
                    child: Text(
                      S.of(context).close,
                      style: Theme.of(context).textTheme.headline6.merge(
                          TextStyle(
                              color: Theme.of(context)
                                  .primaryColorLight)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: PaddingConstants.padding,
          right: PaddingConstants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 40,
            backgroundImage:  widget.driverData.image=='no_image'?Image.asset("assets/img/userImage.png"):
            NetworkImage(widget.driverData.image,scale: 1)

          ),
        ),
      ],
    );
  }
}
