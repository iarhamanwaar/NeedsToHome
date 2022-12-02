import 'package:cloud_firestore/cloud_firestore.dart';
import '/src/components/chat.dart';
import '/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:handy/generated/l10n.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 27.0, left: 10.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 30.0),
                  Text(
                    S.of(context).chat,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4.merge(
                        TextStyle(color: Theme.of(context).primaryColorLight)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.88,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("chatUser")
                              .orderBy('timestamp', descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError || snapshot.data == null) {
                              return Container();
                            } else {
                              return ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(top: 16),
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  DocumentSnapshot chat =
                                      snapshot.data.documents[index];
                                  return chat['providerid'] ==
                                          currentUser.value.id
                                      ? ChatUsersList(
                                          userName: chat['sendername'],
                                          lastChat: chat['lastchat'],
                                          time: chat['timestamp'],
                                          mobile: chat['usermobile'],
                                          userId: chat['userid'],
                                          isMessageRead:
                                              (index == 0 || index == 3)
                                                  ? true
                                                  : false,
                                        )
                                      : Container();
                                },
                              );
                            }
                          }),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
