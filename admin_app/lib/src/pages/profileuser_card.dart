import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/components/card.dart';
import 'package:login_and_signup_web/src/elements/useradmin.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';

class ProfileUserCard extends StatelessWidget {
  const ProfileUserCard({
    Key key,
    @required double gap,
  })  : _gap = gap,
        super(key: key);

  final double _gap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(_gap),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserAvatarAdmin(
                userAvatar: 'https://pbs.twimg.com/profile_images/1276524106662449152/RWkF0y0i_reasonably_small.jpg',
                width: 75,
                height: 75,
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
                  currentUser.value.email,
                style: TextStyle(color: Colors.grey),
              ),

              SizedBox(height: 35),
              /**   Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Tweets',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Text('326'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Followers',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Text('191'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Following',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Text('101'),
                      ],
                    ),
                  ),
                ],
              ), */
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
