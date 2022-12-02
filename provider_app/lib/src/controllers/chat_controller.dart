import 'package:cloud_firestore/cloud_firestore.dart';
import '/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class ChatController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;

  cartController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  sendChat(chatTxt, providerId, userId, providerMobile, username) {
    String chatRoom = '${DateTime.now().millisecondsSinceEpoch}$userId-$providerId';
    FirebaseFirestore.instance.collection('chatList').doc(chatRoom).set({
      'message': chatTxt.text,
      'userid': userId,
      'providerid': providerId,
      'sendername': currentUser.value.name,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'transfertype': 'provider'
    }).catchError((e) {
      print(e);
    });
    String chatMaster = 'U$userId-F$providerId';
    FirebaseFirestore.instance.collection('chatUser').doc(chatMaster).set(
      {
        'providerid': providerId,
        'userid': userId,
        'lastchat': chatTxt.text,
        'providermobile': providerMobile,
        'usermobile': currentUser.value.phone,
        'sendername': username,
        'providername': currentUser.value.name,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'transfertype': 'finder',
      },
    ).catchError((e) {
      print(e);
    });

    return true;
  }
}
