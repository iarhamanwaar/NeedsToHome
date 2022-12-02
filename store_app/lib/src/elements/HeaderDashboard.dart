import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'package:login_and_signup_web/src/pages/languages.dart';
import 'package:login_and_signup_web/src/repository/settings_repository.dart' as settingRepo;
import '../repository/home_repository.dart' as repository;
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/controllers/order_controller.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/Order_tracking.dart';
import 'package:login_and_signup_web/src/pages/chat_page.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:vrouter/vrouter.dart';
import 'AppDrawer.dart';
import 'EmptyOrdersWidget.dart';
import 'MembershipPlanWidget.dart';
import 'PlanExpriedWidget.dart';
import 'VendorRegisterFormWidget.dart';

class MyScaffold extends StatefulWidget {
  final Widget vChild;
  final String title;

  const MyScaffold(
      this.vChild, {
        Key key,
        @required this.title,
      }) : super(key: key);
  @override
  _MyScaffoldState createState() => _MyScaffoldState();
}

class _MyScaffoldState extends StateMVC<MyScaffold> {

  OrderController _con;

  Timer timer;
  _MyScaffoldState() : super(OrderController()) {
    _con = controller;
  }
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {


    if(currentUser.value.profileStatus) {
      listenForIntOrderDetails();
    }
    // TODO: implement initState
    super.initState();
    countDocuments();

    if(int.parse(currentUser.value.profileComplete)<=3 ) {
      WidgetsBinding.instance.addPostFrameCallback((_) => sellerForm());
    } else if(currentUser.value.profileComplete=='4'){
      WidgetsBinding.instance.addPostFrameCallback((_) => pricePlan());
    }else if(currentUser.value.profileComplete=='5') {
      listenStatus();
      if(currentUser.value.profileStatus){

        if(int.parse(currentUser.value.expiredTime)*1000 <= (DateTime.now().millisecondsSinceEpoch)) {
          WidgetsBinding.instance.addPostFrameCallback((_) => planExpired());
        }
      }
    }
    //WidgetsBinding.instance.addPostFrameCallback((_) => alertBox1());
    // getTrackDetails();



    //print(Helper.calculateTimeDifferenceBetween(endDate: ), startDate:DateTime.fromMicrosecondsSinceEpoch((DateTime.now().millisecondsSinceEpoch) * 1000),type: 'day'));
  }
  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }





  toggleDrawer() async {
    if (_scaffoldKey.currentState.isDrawerOpen) {
      _scaffoldKey.currentState.openEndDrawer();
    } else {
      _scaffoldKey.currentState.openDrawer();
    }}


  listenForIntOrderDetails(){

    repository.getIntOrderDetailCount().then(( value) {

      currentUser.value.previousOrder = value;
      timer =Timer.periodic(new Duration(seconds: 3), (timer) {
        if(currentUser.value.apiToken!=null){
          listenForOrderDetails();
        }

      });

    }).whenComplete(() {


    });
  }

  listenStatus(){

    repository.getSingleValue('vendor','vendor_id', currentUser.value.id,'status',).then((value) {
      if(value=='waiting'){
        sellerForm();
      }

    }).catchError((e) {

    }).whenComplete(() {

    });


  }

  listenForOrderDetails(){

    repository.getOrderDetailCount().then(( value) {

      int newSale = value.count -  currentUser.value.previousOrder;

      setState(() {

        if(newSale>0){
          if(currentUser.value.apiToken!=null) {
            currentUser.value.previousOrder = value.count;
            loadMusic();
            CallPopupHelper.exit(context, _con, player, value);
          }

        }
      });
    }).whenComplete(() {

    });
  }
  int chatCount = 0;
  String localFilePath;
  final player = AudioPlayer();
  Future loadMusic() async {

    //await player.setAsset('assets/audio/calling.mp3');
    // ignore: deprecated_member_use
    await player.setUrl('${GlobalConfiguration().getString('base_upload')}uploads/audio/calling.mp3');
    await player.play();
  }



  countDocuments() async {

    FirebaseFirestore.instance.collection("chatUser").where("shopId", isEqualTo: currentUser.value.id).
    where("shopunRead", isEqualTo: 'false').snapshots().listen((snapshot) {


      setState(() {
        chatCount = snapshot.docs.length;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;

    return currentUser.value.auth==false? EmptyOrdersWidget():Container(
        color:Theme.of(context).primaryColor,
        child:Row(
          children: [
            if (!displayMobileLayout)
              AppDrawer(
                permanentlyDisplay: true,
              ),
            Expanded(
              child: Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  // when the app isn't displaying the mobile version of app, hide the menu button that is used to open the navigation drawer
                  automaticallyImplyLeading: displayMobileLayout,

                  backgroundColor: Theme.of(context).primaryColor,
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  title: ListTile(
                    contentPadding: EdgeInsets.only(left: 0, right: 0),
                    leading: Wrap(
                      children: [
                        Wrap(
                          children: [
    InkWell(
    onTap: () {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LanguagesWidget()));
    },
                         child:   Container(
                              padding: EdgeInsets.only(top: 2),
                              child: Image(image:   settingRepo.setting.value.mobileLanguage.value.languageCode=='en'?
                              AssetImage('assets/img/united-states-of-america.png'):settingRepo.setting.value.mobileLanguage.value.languageCode=='ar'?AssetImage('assets/img/united-arab-emirates.png'):
                              settingRepo.setting.value.mobileLanguage.value.languageCode=='fr'?AssetImage('assets/img/france.png'):
                              settingRepo.setting.value.mobileLanguage.value.languageCode=='es'?AssetImage('assets/img/spain.png'):
                              settingRepo.setting.value.mobileLanguage.value.languageCode=='de'?AssetImage('assets/img/germany.png'):
                              settingRepo.setting.value.mobileLanguage.value.languageCode=='my'?AssetImage('assets/img/malay.png'):
                              settingRepo.setting.value.mobileLanguage.value.languageCode=='ko'?AssetImage('assets/img/united-states-of-america.png'):
                              settingRepo.setting.value.mobileLanguage.value.languageCode=='zh'?AssetImage('assets/img/china.png'):
                              AssetImage('assets/img/united-states-of-america.png'), height: 20, width: 20),
                            )),

                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LanguagesWidget()));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 3, left: 5),
                                child: Text( settingRepo.setting.value.mobileLanguage.value.languageCode, style: Theme.of(context).textTheme.bodyText2),
                              ),
                            ),
                            Icon(Icons.arrow_drop_down,color:Colors.grey),
                          ],
                        ),

                      ],
                    ),
                    trailing: currentUser.value.profileStatus==true?Container(child:Wrap(children:[

                      GetPlatform.isWeb || GetPlatform.isMobile ? InkWell(
                        onTap: (){

                          /**   Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatPage())); */
                        },
                        child: Badge(

                          position: BadgePosition.topEnd(top: 0, end: 3),
                          animationDuration: Duration(milliseconds: 300),
                          animationType: BadgeAnimationType.slide,
                          badgeContent: Text(
                            chatCount.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          child: IconButton(icon: Icon(Icons.message), onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChatPage()));
                          }),
                        ),
                      ):Container(),
                      SizedBox(width:20),
                      SwitchOpen(),

                    ]) ) : Container(
                      padding: EdgeInsets.only(top:5),
                      child:Text('incomplete'),),

                  ),
                ),
                drawer: displayMobileLayout
                    ?  AppDrawer(
                  permanentlyDisplay: false,
                  callback: this.toggleDrawer,
                )
                    : null,
                body: widget.vChild,
              ),
            )
          ],
        )
    );
  }
  void sellerForm() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            insetPadding: EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
            backgroundColor: Colors.transparent,
            content: WillPopScope(
                onWillPop: () async => false,
                child:VendorRegisterForm()),
          )),
    ).then((valueFromDialog){

      if(currentUser.value.profileComplete=='4') {
        pricePlan();
      }else if( int.parse(currentUser.value.profileComplete)<=3 || !currentUser.value.profileStatus){
        sellerForm();
      }
    });
  }


  void pricePlan() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            insetPadding: EdgeInsets.only(left:0,right:0,bottom: 0,top:0),
            backgroundColor: Colors.transparent,
            content: WillPopScope(
                onWillPop: () async => false,
                child:MembershipPlan()),


          )),
    ).then((valueFromDialog){
      if(currentUser.value.profileComplete!='4') {
        sellerForm();
      } else if( currentUser.value.profileComplete=='4') {
        pricePlan();
      }

    });
  }

  Future<bool> onbackpress() async{
    return true;
  }
  void planExpired() {


    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
          onWillPop: onbackpress,
          child: AlertDialog(
            insetPadding: EdgeInsets.only(left:0,right:0,bottom: 0,top:0),
            backgroundColor: Colors.transparent,
            content: WillPopScope(
                onWillPop: () async => false,
                child:PlanExpiredWidget()),


          )),
    ).then((valueFromDialog){
      pricePlan();
    });
  }





}







class SwitchOpen extends StatefulWidget {
  @override
  _SwitchOpenState createState() => _SwitchOpenState();
}

class _SwitchOpenState extends State<SwitchOpen>   {

  bool isSwitched = false;

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return CustomSwitch(
      activeColor: Colors.black,
      value: currentUser.value.liveStatus,

      onChanged: (value) {
        print(value);

        setState(() {
          if(value==false) {
            currentUser.value.liveStatus = false;
          }else{
            currentUser.value.liveStatus = true;
          }
          currentUser.value;

          repository.userLiveStatus(currentUser.value.liveStatus);
          setCurrentUserUpdate(currentUser.value);
        });
      },
    );
  }
}


class CallPopupHelper {

  static exit(context, con, player, value) => showDialog(context: context, barrierDismissible: false, builder: (context) =>  CallPopup(con: con, player: player, orderTracking: value));
}

// ignore: must_be_immutable
class CallPopup extends StatefulWidget{
  CallPopup({Key key, this.con, this.player, this.orderTracking});
  OrderController con;
  OrderTracking orderTracking;
  final player;
  @override
  _CallPopupState createState() => _CallPopupState();
}

class _CallPopupState extends State<CallPopup> {

   bool cancelled = false;
  @override
  void initState() {
    if (GetPlatform.isWeb || GetPlatform.isMobile) {
      checkCurrentLiveStatus(widget.orderTracking.orderID);
    } else{

    }
    super.initState();
  }
  checkCurrentLiveStatus(orderId){
    FirebaseFirestore.instance.collection("orderDetails").where("shopId", isEqualTo: currentUser.value.id).where("orderId", isEqualTo: orderId).snapshots().listen((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()["status"] == 'cancelled') {
          setState(() {
            cancelled = true;
          });
        }
      });
    });
  }




  @override
  Widget build(BuildContext context) {

    return Responsive(
      alignment: WrapAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Div(
              colS:12,
              colM:8,
              colL:6,
              child:  Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                ),

                elevation: 0,
                backgroundColor: Colors.transparent,
                child: _buildChild(context),
                insetPadding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.2,
                  left:MediaQuery.of(context).size.width * 0.09,
                  right:MediaQuery.of(context).size.width * 0.09,
                  bottom:MediaQuery.of(context).size.width * 0.2,
                ),
              ),
            )
          ],
        )

      ],
    );

  }

  _buildChild
      (BuildContext context) => SingleChildScrollView(
    child:Container(

      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              cancelled?'CANCELLED':'NEW REQUEST',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                cancelled?'assets/img/cancelled_icon.png':'assets/img/neworder.png',
                height: 140,
                width: 140,
              ),
            ),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            Helper.pricePrint(widget.orderTracking.amount),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Text(
              cancelled?'#${widget.orderTracking.orderID} order has been cancelled by user':'#${widget.orderTracking.orderID} you have received a new order - ${widget.orderTracking.name}',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25, left: 25, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () async {
                    await widget.player.stop();
                    Navigator.pop(context);
                    // ignore: deprecated_member_use
                    VRouter.of(context).pushReplacement('/Order_new');
                  },
                  elevation: 2.0,
                  fillColor: Colors.redAccent,
                  child: Icon(
                    Icons.remove_red_eye_outlined,
                    size: 28.0,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
                cancelled? RawMaterialButton(
                  onPressed: () async {
                    await widget.player.stop();
                    Navigator.pop(context);

                  },
                  elevation: 2.0,
                  fillColor: Colors.red,
                  child: Icon(
                    Icons.cancel_outlined,
                    size: 28.0,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ):RawMaterialButton(
                  onPressed: () async {
                    await widget.player.stop();
                    Navigator.pop(context);
                    currentUser.value.previousOrder = currentUser.value.previousOrder-1;
                    widget.con.updateOrderPop(widget.orderTracking.orderID, 'Accepted');
                  },
                  elevation: 2.0,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  child: Icon(
                    Icons.check,
                    size: 28.0,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
              ],
            ),
          ),


        ],
      ),
    ),
  );

}
