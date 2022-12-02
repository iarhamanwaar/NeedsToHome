import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/src/components/chat_bubble.dart';
import '/src/components/chat_detail_page_appbar.dart';
import '/src/controllers/chat_controller.dart';
import '/src/repository/user_repository.dart';

import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

enum MessageType {
  Sender,
  Receiver,
}

// ignore: must_be_immutable
class ChatDetailPage extends StatefulWidget {
  ChatDetailPage({Key key, this.userId, this.userName, this.mobile});
  String userId;
  String userName;
  String mobile;
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends StateMVC<ChatDetailPage> {
  ChatController _con;
  _ChatDetailPageState() : super(ChatController()) {
    _con = controller;
  }

  final _txtController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  //AudioPlayer advancedPlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
    Timer(
        Duration(milliseconds: 300),
        () => _scrollController
            .jumpTo(_scrollController.position.maxScrollExtent));
  }

  void initPlayer() {
    /**advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    advancedPlayer.positionHandler = (p) => setState(() {
          _position = p;
        }); **/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatDetailPageAppBar(
          userId: widget.userId,
          userName: widget.userName,
          mobile: widget.mobile),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chatList")
                    .where("userid", isEqualTo: widget.userId)
                    .where("providerid", isEqualTo: currentUser.value.id)
                    .snapshots(),
                builder: (context, snapshot) {
                  Timer(
                      Duration(milliseconds: 300),
                      () => _scrollController
                          .jumpTo(_scrollController.position.maxScrollExtent));
                  if (snapshot.hasError || snapshot.data == null) {
                    return Container();
                  } else {
                    return KeyboardAvoider(
                      autoScroll: true,
                      child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        controller: _scrollController,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ChatBubble(
                            chatMessage: snapshot.data.docs[index],
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 8, bottom: 10),
              height: 80,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextField(
                        controller: _txtController,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                          hintText: 'Enter your text',
                          contentPadding: EdgeInsets.all(16.0),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.only(right: 5, bottom: 9, top: 9),
                      child: FloatingActionButton(
                        onPressed: () async {
                          await _con.sendChat(
                              _txtController,
                              currentUser.value.id,
                              widget.userId,
                              widget.mobile,
                              widget.userName);

                          setState(() {
                            _txtController.text = '';
                          });
                          //  audioCache.play('img/audio/chatsend.mp3');
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.pink,
                        elevation: 0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
