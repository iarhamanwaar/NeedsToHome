import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/components/chat.dart';
import '../repository/user_repository.dart';
import '../elements/PermissionDeniedWidget.dart';


class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentUser.value.apiToken == null
          ? PermissionDeniedWidget()
          : Container(
        width: double.infinity,
        color: Theme.of(context).primaryColorDark,
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
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 30.0),
                  Text(S.of(context).chat,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4.merge(TextStyle(color:Theme.of(context).colorScheme.primary))
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
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("chatUser").
                          orderBy('timestamp', descending: true).snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError || snapshot.data == null) {
                              return Container();
                            } else {
                              return  snapshot.data.docs.length==0?Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:[
                                    Center(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset('assets/img/pngegg.png',
                                              width:60,height:60,
                                            ),
                                            Container(
                                                child:Text('No chats is available',)
                                            ),
                                          ],
                                        )
                                    ),


                                  ]
                              ):ListView.builder(

                                itemCount: snapshot.data.docs.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(top: 16),
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  DocumentSnapshot chat = snapshot.data.docs[index];

                                  return  chat['userId']==currentUser.value.id?ChatUsersList(
                                    shopName: chat['shopName'],
                                    lastChat: chat['lastChat'],

                                    image:
                                    // ignore: deprecated_member_use
                                    "${GlobalConfiguration().getString('base_upload')}uploads/vendor_image/vendor_${chat['shopId']}.png",
                                    time: chat['timestamp'],
                                    mobile: chat['userMobile'],
                                    shopId: chat['shopId'],
                                    read: chat['shopunRead'],
                                    isMessageRead: (index == 0 || index == 3) ? true : false,
                                  ):Container()
                                  ;
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
