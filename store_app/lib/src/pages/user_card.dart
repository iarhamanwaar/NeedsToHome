import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:login_and_signup_web/src/elements/CardWidget.dart';
import 'package:login_and_signup_web/src/elements/UserWidget.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

class UserCard extends StatefulWidget {
  const UserCard({Key key,@required double gap,this.con, this.keyButton1, this.showTutorial})  : gap = gap, super(key: key);
  final UserController con;
  final GlobalKey keyButton1;
  final double gap;
  final Function showTutorial;
  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {


  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(widget.gap),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          UserAvatar(
               keyButton1: widget.keyButton1,
                userAvatar: currentUser.value.image,
                width: 75,
                height: 75,
               showTutorial: widget.showTutorial,
              ),
              SizedBox(height: 15),
              Text(
                currentUser.value.name,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5),
              Text(
                '${S.of(context).member_since}  ${currentUser.value.registerDate}',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 15),
              Text('${S.of(context).your_zone} ${currentUser.value.zoneName}(${currentUser.value.zoneId})'),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.mail,
                    size: 16,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(currentUser.value.email),
                ],
              ),
              SizedBox(height: 35),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          S.of(context).rating,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Text('${widget.con.profileDetails.ratingTotal}(${widget.con.profileDetails.ratingNum})'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          S.of(context).total_orders,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Text(widget.con.profileDetails.totalOrders.toString()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          S.of(context).total_products,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Text(widget.con.profileDetails.totalProducts.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [],
          ),
        ],
      ),
    );
  }







}
