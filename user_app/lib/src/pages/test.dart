import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';


class TestPart extends StatefulWidget {
  const TestPart({Key key}) : super(key: key);

  @override
  _TestPartState createState() => _TestPartState();
}

class _TestPartState extends State<TestPart> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettoken();
  }


  gettoken() {


    FirebaseMessaging.instance.getToken().then((deviceid) {

      var table = 'user2';
      FirebaseFirestore.instance.collection('devToken').doc(table).set({'devToken': deviceid, 'userId': '1'}).catchError((e) {
        print('firebase error');
        print(e);

      }).then((value) {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('12'),
    );
  }
}
