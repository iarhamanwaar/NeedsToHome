import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import '../helpers/helper.dart';

class ForceUpdate extends StatefulWidget {

  @override
  _ForceUpdateState createState() => _ForceUpdateState();
}

class _ForceUpdateState extends State<ForceUpdate>  with SingleTickerProviderStateMixin {



  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();


  Future<void> checkForUpdate() async {

    InAppUpdate.checkForUpdate().then((info) {
      setState(() {

      });
      InAppUpdate.performImmediateUpdate().then((_) {
        setState(() {

        });
      }).catchError((e) {

        showSnack(e.toString());
      });
    }).catchError((e) {

      showSnack(e.toString());
    });
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: Helper.of(context).onWillPop,

    child:Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/update.png'), fit: BoxFit.cover)),
          ),

         

          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  alignment:Alignment.center,
                  padding: EdgeInsets.only(left:25,right: 25),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(

                      'New update is available',
                      style: TextStyle(
                          color:Colors.black,
                          fontSize: 21,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        "The current version of this application is no longer supported. We apologize for any inconvenience we may have caused you",
                        style:Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),),

                SizedBox(
                  height: size.height * 0.1,
                ),






                Container(
                  height:49,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    onPressed: () async {
                      checkForUpdate();
                    },
                    color: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                        'Update Now',
                        style:Theme.of(context).textTheme.headline1.merge(TextStyle(color:Theme.of(context).primaryColorLight,fontWeight: FontWeight.bold,))

                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    MaterialButton(
                      onPressed:(){},
                      focusColor: Colors.transparent,
                      child: Text("Thanks!",),
                    ),


                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),

        ],
      ),
    ));
  }


}
