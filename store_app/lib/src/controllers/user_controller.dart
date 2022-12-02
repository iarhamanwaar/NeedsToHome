
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/models/delivery_setting.dart';
import 'package:login_and_signup_web/src/models/profile_response.dart';
import 'package:login_and_signup_web/src/models/selected_plan.dart';
import 'package:login_and_signup_web/src/models/shopbasicinformation.dart';
import 'package:login_and_signup_web/src/models/shopsellerkyc.dart';
import 'package:login_and_signup_web/src/models/socialmedia_link.dart';
import 'package:login_and_signup_web/src/models/vendor_membership.dart';
import 'package:login_and_signup_web/src/models/vendorprofile.dart';
import 'package:login_and_signup_web/src/models/zoneList.dart';
import 'package:login_and_signup_web/src/repository/product_repository.dart';
import 'package:login_and_signup_web/src/repository/settings_repository.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:vrouter/vrouter.dart';
import 'package:login_and_signup_web/src/models/register.dart';
import 'package:login_and_signup_web/src/models/user.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/user_repository.dart' as repository;
import 'package:toast/toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController extends ControllerMVC {
  GlobalKey<FormState> loginFormKey;
  GlobalKey<FormState> registerFormKey;
  Registermodel registerData = new Registermodel();
  SocialMediaLink socialMedia=new SocialMediaLink();
  User userData = new User();

  String otpNumber;
  List<DropDownModel> dropDownList = <DropDownModel>[];
  List<ZoneListModel> zoneList = <ZoneListModel>[];
  List<VendorMembershipModel> vendorMembershipList = <VendorMembershipModel>[];
  TextEditingController openTime;
  TextEditingController closeTime;
  GlobalKey<ScaffoldState> scaffoldKeyState;
  GlobalKey<FormState> generalFormKey;
  GlobalKey<FormState> bankFormKey;
  ProfileResponse profileDetails = new ProfileResponse();
  ShopBasicInformation generalModel = new ShopBasicInformation();
  SelectedPlan selectedPlan = SelectedPlan();
  DeliverySettingsModel deliverySettingData = new DeliverySettingsModel();
  ShopSellerKyc bankModel = new ShopSellerKyc();
  OverlayEntry loader;
  String password;
  String prePassword;
  String rePassword;
  bool loaderData=false;
  String terms;

  VendorProfile vendorProfileData = new VendorProfile();
  ShopBasicInformation basicInformationData = new ShopBasicInformation();
  ShopSellerKyc sellerKycData = new ShopSellerKyc();
  UserController() {
    openTime = TextEditingController();
    closeTime = TextEditingController();
    loader = Helper.overlayLoader(context);
    this.scaffoldKeyState = new GlobalKey<ScaffoldState>();
    loginFormKey = new GlobalKey<FormState>();
    registerFormKey = new GlobalKey<FormState>();
    generalFormKey = new GlobalKey<FormState>();
    bankFormKey = new GlobalKey<FormState>();
  /**  _firebaseMessaging.getToken().then((String _deviceToken) {}).catchError((e) {
      print('Notification not configured');
    }); */

  //  FirebaseMessaging.instance.getToken().then((value) => print(value));
  }

  register(onLogInSelected){

      if (registerFormKey.currentState.validate()) {
        registerFormKey.currentState.save();
        Overlay.of(context).insert(loader);
        repository.registerUser(registerData).then((value) {
          if (value == true) {

            showToast("Register Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
           // Navigator.of(context).pushReplacementNamed('/Login');
            onLogInSelected();
          }else{
            // ignore: deprecated_member_use
            scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
              content: Text('This email is already register'),
            ));
          }
        }).catchError((e) {
          // ignore: deprecated_member_use
          scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
            content: Text('Error'),
          ));
        }).whenComplete(() {
          Helper.hideLoader(loader);
        });
      }
 }




  Future<void> listenForDropdown(table, select, column, para1) async {
    dropDownList.clear();
    final Stream<DropDownModel> stream = await getDropdownDataSC(table, select, column, para1);

    stream.listen((DropDownModel _list) {
      setState(() => dropDownList.add(_list));

    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }




  login(){
    if(loginFormKey.currentState.validate()){
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);

      repository.loginUser(userData).then((value) {
        if (value.auth == true && value != null) {
          if (GetPlatform.isWeb || GetPlatform.isMobile) {
            gettoken();
          }
          // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
          setting.notifyListeners();
         // Provider.of(context, listen: false).authenticate();
          // ignore: deprecated_member_use
          VRouter.of(context).pushReplacement('/dashboard');

        }else {
          // ignore: deprecated_member_use
          scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
            content: Text('Invalid Email & password'),
          ));
        }
      }).catchError((e) {
        print(e);
        loader.remove();
        // ignore: deprecated_member_use
        scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
          content: Text('Error'),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
}




  gettoken() {
    var table = 'shop' + currentUser.value.id;
    print('firebase token');
    FirebaseMessaging.instance.getToken().then((deviceid) {
      print('firebase token$deviceid');
      if(GetPlatform.isWeb) {

        FirebaseFirestore.instance.collection('shopTokenWeb').doc(table).set(
            {'devToken': deviceid, 'shopId': currentUser.value.id}).catchError((
            e) {

          print(e);
        });
      } else{
        FirebaseFirestore.instance.collection('shopToken').doc(table).set(
            {'devToken': deviceid, 'shopId': currentUser.value.id}).catchError((
            e) {

          print(e);
        });
      }
    });
  }
  update() async {

    if (generalFormKey.currentState.validate()) {
      generalFormKey.currentState.save();
      Overlay.of(context).insert(loader);

      currentUser.value.name = generalModel.ownerName;
      if(generalModel.pickupAddress!=null) {
        currentUser.value.profileStatus = true;
      }
      if(currentUser.value.auth!=null) {
        setCurrentUserUpdate(currentUser.value);
      }

      repository.updateProfile(generalModel,'general').then((value) {

        showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);


      }).catchError((e) {

      }).whenComplete(() {
        Helper.hideLoader(loader);
      });

    }
  }

  bankDetailsUpdate(){
    if (bankFormKey.currentState.validate()) {
      bankFormKey.currentState.save();
      Overlay.of(context).insert(loader);
    showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);

      repository.updateProfile(bankModel,'bank_detail').then((value) {


      }).catchError((e) {

      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }

  }

  deliveryDetailsUpdate(){
   Overlay.of(context).insert(loader);
   currentUser.value.autoAssign = deliverySettingData.autoAssign;
   currentUser.value.driverAllAccess = deliverySettingData.allowAllDeliveryBoys;
   print( currentUser.value.toMap());
   if(currentUser.value.auth!=null) {
     setCurrentUserUpdate(currentUser.value);
   }
      repository.updateProfile(deliverySettingData,'deliverySetting').then((value) {
        showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }).catchError((e) {
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
  }

  socialMediaUpdate(){
    if (registerFormKey.currentState.validate()) {
      registerFormKey.currentState.save();

      Overlay.of(context).insert(loader);
      repository.updateProfile(socialMedia, 'social_setting').then((value) {
        showToast("Update Successfully", gravity: Toast.BOTTOM,
            duration: Toast.LENGTH_SHORT);
      }).catchError((e) {}).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  basicInfoUpdate(){

    repository.addUpdateProfile(basicInformationData,'basic','yes').then((value) {

      showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);


    }).catchError((e) {

    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  kycOfSellersUpdate(){
    repository.addUpdateProfile(sellerKycData, 'kyc','no').then((value) {
      showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }).catchError((e) {

    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }
  settingUpdate(){
    repository.addUpdateProfile(sellerKycData, 'setting','no').then((value) {
      showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }).catchError((e) {

    }).whenComplete(() {
      currentUser.value.profileComplete = '4';
      if(currentUser.value.auth!=null) {
        setCurrentUserUpdate(currentUser.value);
      }
      Navigator.pop(context, true);
      Helper.hideLoader(loader);
    });
  }

  getPaymentStatus(matchingKey){
    Overlay.of(context).insert(loader);
    repository.getSingleValue('vendor', 'vendor_id',currentUser.value.id,'purchasekey',).then((value) {
           if(matchingKey==value){
             currentUser.value.profileComplete = '5';
             Navigator.pop(context);
             Navigator.pop(context);
             Helper.hideLoader(loader);
           }
    }).catchError((e) {

    }).whenComplete(() {

    });
  }

  getSingleValue(){
    repository.getSingleValue('policy', 'policy_id',5,'value',).then((value) {
      setState(() {
        terms = value;
      });
    }).catchError((e) {

    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  getSingleStatus(){
    repository.getSingleValue('policy', 'policy_id',5,'value',).then((value) {
      setState(() {
        terms = value;
      });
    }).catchError((e) {

    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  getProfileDetailData() {

    repository.getProfileDetails().then((value) {
      setState(() {
        loaderData = true;
        profileDetails = value;

        openTime.text = profileDetails.general.openingTime;
        closeTime.text = profileDetails.general.closingTime;

        print(closeTime.text);

      } );

    }).catchError((e) {
      loader.remove();
      // ignore: deprecated_member_use
      scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
        content: Text('Error'),
      ));
    }).whenComplete(() {

    });
  }

  updatePassword(user, backToLogin) {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.updatePassword(user).then((value) {
        setState(() {
          user = new User();
        } );

        backToLogin();
      }).catchError((e) {
        loader.remove();
        // ignore: deprecated_member_use
        scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
          content: Text('Error'),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }


  upDatePlans(SelectedPlan selectedPlanData) {
    Overlay.of(context).insert(loader);

    repository.updateVendorPlan(selectedPlanData).then((value) {
      showToast("Plan Selected successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }).catchError((e) {

      loader.remove();
      // ignore: deprecated_member_use
      scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
        content: Text('Error'),
      ));
    }).whenComplete(() {
      currentUser.value.profileComplete = '5';
      if(currentUser.value.auth!=null) {
        setCurrentUserUpdate(currentUser.value);
      }
      Navigator.pop(context);
      Navigator.pop(context);
      Helper.hideLoader(loader);
    });
  }


  passwordUpdate(){
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
     
       if(password==rePassword){
         Overlay.of(context).insert(loader);
         repository.passwordManagement('update', password,prePassword).then((value) {
           if(value==true) {
             showToast("Update Successfully", gravity: Toast.BOTTOM,
                 duration: Toast.LENGTH_SHORT);
           } else{
             showToast("Previous Password Not Matched", gravity: Toast.BOTTOM,
                 duration: Toast.LENGTH_SHORT);
           }
         }).whenComplete(() {
           Helper.hideLoader(loader);
         });
         }else {
         showToast("Password is not matched", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
       }
       }
    }


  Future<void> listenForMembership(id) async {

    final Stream<VendorMembershipModel> stream = await getMembership(id);
    stream.listen((VendorMembershipModel _list) {
      setState(() => vendorMembershipList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForZone() async {

    final Stream<ZoneListModel> stream = await getZoneList();
    stream.listen((ZoneListModel _list) {
      setState(() => zoneList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      print(zoneList.length);
    });
  }

}
