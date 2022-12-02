
import 'package:flutter/material.dart';
import 'package:multisuperstore/src/pages/chat_detail_page.dart';
import 'package:timeago/timeago.dart' as timeago;
// ignore: must_be_immutable
class ChatUsersList extends StatefulWidget {
  String shopName;
  String lastChat;
  String image;
  String shopId;
  int time;
  bool isMessageRead;
  String mobile;
  String read;
  ChatUsersList(
      {@required this.shopName,
        @required this.lastChat,
        this.mobile,
        @required this.image,
        @required this.time,
        this.shopId,
        this.read,
        @required this.isMessageRead});
  @override
  _ChatUsersListState createState() => _ChatUsersListState();
}

class _ChatUsersListState extends State<ChatUsersList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatDetailPage(shopId: widget.shopId, shopName: widget.shopName, shopMobile: widget.mobile)));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.image),
                    maxRadius: 30,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.shopName),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.lastChat,
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(   timeago.format(DateTime
                .fromMillisecondsSinceEpoch(
    widget.time ))
           ,
              style: TextStyle(fontSize: 12, color: widget.isMessageRead ? Colors.pink : Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }


}
