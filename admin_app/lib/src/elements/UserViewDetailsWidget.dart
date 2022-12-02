
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/components/padding_constants.dart';
import 'package:login_and_signup_web/src/models/user_model.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
// ignore: must_be_immutable
class UserViewDetailsWidget extends StatefulWidget {
  UserViewDetailsWidget({Key key, this.userData}) : super(key: key);
  UserModel userData;

  @override
  _UserViewDetailsWidgetState createState() => _UserViewDetailsWidgetState();
}

class _UserViewDetailsWidgetState extends State<UserViewDetailsWidget> {
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
          height: 320,

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
                  Text(S.of(context).name,style:Theme.of(context).textTheme.subtitle1),
                  Container(
                      width:size.width > 670 ? size.width * 0.2: 140,
                    alignment: Alignment.topRight,
                    child:Text(widget.userData.userName,
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
                        child:Text(widget.userData.email,
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
                        child:Text(widget.userData.phone,
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
                        child:Text(widget.userData.address,

                            textAlign: TextAlign.right,
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
                        child:Text(widget.userData.date,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            maxLines: 1,
                            style:Theme.of(context).textTheme.subtitle1)
                    ),
                  ]
              ),
              SizedBox(height:5),

           /**   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Status',style:Theme.of(context).textTheme.subtitle1),
                    Container(
                        width:size.width > 670 ? size.width * 0.2: 140,
                        alignment: Alignment.topRight,
                        child:Text('Waiting',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:Theme.of(context).textTheme.subtitle1)
                    ),
                  ]
              ), */
   SizedBox(height:30),

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
              radius: PaddingConstants.avatarRadius,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(PaddingConstants.avatarRadius)),
                  child: widget.userData.image=='no_image'?Image.asset("assets/img/userImage.png"): Image.network(widget.userData.image)
              ),
            ),
        ),
      ],
    );
  }
}
