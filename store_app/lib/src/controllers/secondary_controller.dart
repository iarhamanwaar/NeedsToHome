import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/banner.dart';
import 'package:login_and_signup_web/src/models/delivery_timeslot.dart';
import 'package:login_and_signup_web/src/models/driver_details.dart';
import 'package:login_and_signup_web/src/repository/secondary_repository.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toast/toast.dart';
import '../repository/secondary_repository.dart' as repository;
import '../repository/product_repository.dart' as repository1;
class SecondaryController extends ControllerMVC {
  GlobalKey<FormState> bannerFormKey;
  BannerModel bannerData = new BannerModel();
  DriverDetailsModel driverDetailsData = new DriverDetailsModel();
  DeliveryTimeSlotModel deliveryTimeSlotData = new DeliveryTimeSlotModel();
  List<BannerModel> bannerList = <BannerModel>[];
  List<DeliveryTimeSlotModel> deliverTimeSlotList = <DeliveryTimeSlotModel>[];

  OverlayEntry loader;
  TextEditingController openTime;
  TextEditingController closeTime;
  GlobalKey<FormState> formKey;
  bool loaderData=false;
  SecondaryController() {

    loader = Helper.overlayLoader(context);
    bannerFormKey = new GlobalKey<FormState>();
    openTime = TextEditingController();
    closeTime = TextEditingController();
    formKey = new GlobalKey<FormState>();
  }


  addBanner(context1, pageType ,id){

    if (bannerFormKey.currentState.validate()) {
      bannerFormKey.currentState.save();
      setState(() => bannerList.clear());
      if (bannerData.uploadImage != null) {

        Overlay.of(context1).insert(loader);

        repository.addBannerData(bannerData, pageType,id).then((value) {
          Helper.hideLoader(loader);
          Navigator.pop(context1);
        }).catchError((e) {}).whenComplete(() {
          Helper.hideLoader(loader);
          listenForBanner('1');
        });
      }else {
        showToastPopup("Upload your image", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT, );
      }
    }
  }

  Future<void> listenForBanner(id) async {

    final Stream<BannerModel> stream = await getBanner(id);
    stream.listen((BannerModel _banner) {
      setState(() => bannerList.add(_banner));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      PaintingBinding.instance.imageCache.clear();
    });
  }



  Future<void> listenForDeliveryTimeSlot() async {
    final Stream<DeliveryTimeSlotModel> stream = await getDeliveryTimeSlot();
    stream.listen((DeliveryTimeSlotModel _list) {
      setState(() => deliverTimeSlotList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }
  addEdWallet(amount){
    if(formKey.currentState.validate()) {
      formKey.currentState.save();
      Overlay.of(context).insert(loader);
      setState(() => deliverTimeSlotList.clear());
      repository.addVendorWallet(amount).then((value) {
        showToastPopup("Update Successfully", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT, );
      }).catchError((e) {
        print(e);
        loader.remove();
        // ignore: deprecated_member_use

      }).whenComplete(() {
        listenForDeliveryTimeSlot();
        Navigator.pop(context);
        Helper.hideLoader(loader);
      });
    }
  }
  addEddDeliverTimeSlot(context){
    if(formKey.currentState.validate()) {
      formKey.currentState.save();
      print('data time');
      print(deliveryTimeSlotData.toMap());
      Overlay.of(context).insert(loader);
      setState(() => deliverTimeSlotList.clear());
      repository.addEddDeliveryTimeSlotData(deliveryTimeSlotData).then((value) {
        showToastPopup("Update Successfully", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT, );
      }).catchError((e) {
        print(e);
        loader.remove();
        // ignore: deprecated_member_use

      }).whenComplete(() {
        listenForDeliveryTimeSlot();
        Navigator.pop(context);
        Helper.hideLoader(loader);
      });
    }
  }

  delete(table, id){

    repository1.globalDelete(table, id).then((value) {
      showToast("Delete Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);


    }).catchError((e) {
      // loader.remove();
      // ignore: deprecated_member_use

    }).whenComplete(() {
      // Helper.hideLoader(loader);
      if(table=='banner') {
           listenForBanner('1');
      }else if(table=='deliveryTimeSlot'){
        listenForDeliveryTimeSlot();
      }
    });
  }

  chatStatusUpdate(userId,shopId){
    String chatMaster = 'U$userId-F$shopId';
    FirebaseFirestore.instance.collection('chatUser').doc(chatMaster).update(
        {
          'shopunRead': 'true',
        },
    ).catchError((e) {
      print(e);
    });

    return true;
  }

  sendChat(chatTxt, shopId, userId,  userMobile, userName) {
    String chatRoom = '${DateTime.now().millisecondsSinceEpoch}$userId-$shopId';
    FirebaseFirestore.instance.collection('chatList').doc(chatRoom).set({
      'message': chatTxt.text,
      'userId': userId,
      'shopId': shopId,
      'senderName': currentUser.value.name,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'transferType': 'Shop'
    }).catchError((e) {
      print(e);
    });
    String chatMaster = 'U$userId-F$shopId';
    FirebaseFirestore.instance.collection('chatUser').doc(chatMaster).update(
      {
        'shopId': shopId,
        'userId': userId,
        'lastChat': chatTxt.text,
        'shopMobile': currentUser.value.phone,
        'userMobile': userMobile,
        'userName': userName,
        'shopName': currentUser.value.shopName,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'transferType': 'Shop',
        'phone': 9675087369,
      },
    ).catchError((e) {
      print(e);
    });

    return true;

  }

  getDriverDetails(id){
    repository.getDriverDetailsData(id).then((value) {
      setState(() {
        loaderData = true;
        driverDetailsData = value;

      } );

    }).catchError((e) {
      loader.remove();


    }).whenComplete(() {

    });
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

  void showToastPopup(String msg, context,  {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }
}