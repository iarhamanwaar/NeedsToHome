import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/models/ShopSellerKyc.dart';
import 'package:login_and_signup_web/src/models/admin_payment.dart';
import 'package:login_and_signup_web/src/models/admin_general.dart';
import 'package:login_and_signup_web/src/models/membership_plan_history.dart';
import 'package:login_and_signup_web/src/models/payment_gateway.dart';
import 'package:login_and_signup_web/src/models/rolepermissionmodel.dart';
import 'package:login_and_signup_web/src/models/rolesmodel.dart';
import 'package:login_and_signup_web/src/models/settings.dart';
import 'package:login_and_signup_web/src/models/bank.dart';
import 'package:login_and_signup_web/src/models/delivery_setting.dart';
import 'package:login_and_signup_web/src/models/general.dart';
import 'package:login_and_signup_web/src/models/profile_response.dart';
import 'package:login_and_signup_web/src/models/shopbasicinformation.dart';
import 'package:login_and_signup_web/src/models/smtp_model.dart';
import 'package:login_and_signup_web/src/models/timezone.dart';
import 'package:login_and_signup_web/src/models/vendor_bussinesscard.dart';
import 'package:login_and_signup_web/src/models/walletmodel.dart';
import 'package:login_and_signup_web/src/models/zonelistmodel.dart';
import 'package:login_and_signup_web/src/repository/product_repository.dart';
import 'package:login_and_signup_web/src/repository/secondary_repository.dart';
import 'package:login_and_signup_web/src/repository/settings_repository.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:toast/toast.dart';
import 'package:vrouter/vrouter.dart';
import 'package:login_and_signup_web/src/models/register.dart';
import 'package:login_and_signup_web/src/models/user.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/user_repository.dart' as repository;

class UserController extends ControllerMVC {
  GlobalKey<FormState> loginFormKey;
  GlobalKey<FormState> registerFormKey;
  Registermodel registerData = new Registermodel();
  ShopSellerKyc sellerKycData = new ShopSellerKyc();
  WalletModel walletBannerData=new WalletModel();
  User userData = new User();
  List<DropDownModel> dropDownList = <DropDownModel>[];
  RolePermissionModel rolePermissionModel=RolePermissionModel();
  List<RolesModel> rolesList=<RolesModel>[];
  List<TimeZone> timezoneList=<TimeZone>[];
  List<VendorPlanHistory> vendorPlanList = <VendorPlanHistory>[];
  List<VendorPlanHistory> vendorPlanListTemp = <VendorPlanHistory>[];
  List<ZoneListModel> zoneList=<ZoneListModel>[];
  ShopBasicInformation basicInformationData = new ShopBasicInformation();
  TextEditingController openTime;
  TextEditingController closeTime;
  GlobalKey<ScaffoldState> scaffoldKeyState;
  GlobalKey<FormState> generalFormKey;
  GlobalKey<FormState> bankFormKey;
  ProfileResponse profileDetails = new ProfileResponse();
  PaymentGatewayModel paymentGateData = new PaymentGatewayModel();
  ProfileResponse adminProfileDetails = new ProfileResponse();
  SettingsModel settingDetails = new SettingsModel();
  GlobalKey<FormState> adminGeneralFormKey;
  GlobalKey<FormState> paymentFormKey;
  GlobalKey<FormState> smtpFormKey;
  GlobalKey<FormState> deliveryFormKey;
  General generalModel = new General();
  String otpNumber;
  String email;
  String timezone;
  String distancetype;
  Bank bankModel = new Bank();
  AdminGeneral adminGeneral = new AdminGeneral();
  DeliverySettingsModel delivery = new DeliverySettingsModel();
  VendorBusinessCard businessCardData = new VendorBusinessCard();
  Smtp smtp = new Smtp();
  AdminPayment adminPayment = new AdminPayment();
  OverlayEntry loader;
  String password;
  String terms;
  String prePassword;
  String rePassword;
  bool loaderData=false;
  UserController() {
    openTime = TextEditingController();
    closeTime = TextEditingController();
    loader = Helper.overlayLoader(context);
    this.scaffoldKeyState = new GlobalKey<ScaffoldState>();
    loginFormKey = new GlobalKey<FormState>();
    registerFormKey = new GlobalKey<FormState>();
    generalFormKey = new GlobalKey<FormState>();
    bankFormKey = new GlobalKey<FormState>();

    adminGeneralFormKey = new GlobalKey<FormState>();
    paymentFormKey = new GlobalKey<FormState>();
    smtpFormKey = new GlobalKey<FormState>();
    deliveryFormKey = new GlobalKey<FormState>();

  }

  register(){

      if (registerFormKey.currentState.validate()) {
        registerFormKey.currentState.save();
        repository.registerUser(registerData).then((value) {
          if (value == true) {
            showToast("Register Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
           // Navigator.of(context).pushReplacementNamed('/Login');
          }else{
            // ignore: deprecated_member_use
            scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
              content: Text('This mobile number is already register'),
            ));
          }
        }).catchError((e) {

        }).whenComplete(() {

        });
      }
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

  Future<void> listenForDropdown(table, select, column, para1) async {
    dropDownList.clear();
    final Stream<DropDownModel> stream = await getDropdownDataSC(table, select, column, para1);

    stream.listen((DropDownModel _list) {
      setState(() => dropDownList.add(_list));

    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForDropdownNC(table, select) async {
    dropDownList.clear();
    final Stream<DropDownModel> stream = await getDropdownDataNC(table, select);

    stream.listen((DropDownModel _list) {
      setState(() => dropDownList.add(_list));

    }, onError: (a) {
      print(a);
    }, onDone: () {});
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

  void getBusinessCard(id) async {

    vendorBusinessCard(id).then((value) {
      setState(() =>businessCardData = value);

      print(businessCardData.preview);

    }).catchError((e) {

    }).whenComplete(() {

    });
  }
  listenForWalletBanner(id){
    setState(() => walletBannerData = new WalletModel());
    getWalletBanner(id).then((value) {


      setState(() =>  walletBannerData = value);
    }).catchError((e) {


    }).whenComplete(() {

    });
  }

  login(){
    if(loginFormKey.currentState.validate()){
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.loginUser(userData).then((value) {

        if (value.auth == true ) {

          if(GetPlatform.isWeb || GetPlatform.isMobile){

            gettoken();
          }
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
    FirebaseMessaging.instance.getToken().then((deviceid) {

      var table = 'admin' + currentUser.value.id;
      print('webtoken');
      if(GetPlatform.isWeb) {

        FirebaseFirestore.instance.collection('adminTokenWeb').doc(table)
            .set({'devToken': deviceid, 'adminId': currentUser.value.id})
            .catchError((e) {
          print(e);
        });
      } else{
        FirebaseFirestore.instance.collection('adminToken').doc(table)
            .set({'devToken': deviceid, 'adminId': currentUser.value.id})
            .catchError((e) {
          print(e);
        });
      }
    });
  }




  bankDetailsUpdate(){
    if (bankFormKey.currentState.validate()) {
      bankFormKey.currentState.save();

      showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      repository.updateProfile(bankModel,'bank_detail').then((value) {


      }).catchError((e) {

      }).whenComplete(() {

      });
    }

  }

  updatePassword(user, backToLogin) {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.updatePassword(user).then((value) {
        //backToLogin();
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

  Future<void> listenForTimeZone(id) async {

    final Stream<TimeZone> stream = await repository.getTimeZone();
    stream.listen((TimeZone _list) {
      setState(() => timezoneList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      setState(() =>  timezone = id);
    });
  }


  updateProfileAdmin(){
    if (generalFormKey.currentState.validate()) {
      generalFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      currentUser.value.name = userData.name;
      currentUser.value.email = userData.email;
      currentUser.value.address = userData.address;
      currentUser.value.phone = userData.phone;
      setCurrentUserUpdate( currentUser.value);
      repository.updateProfileAdminData(currentUser.value).then((value) {

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
  emailUpdate() {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();

      Overlay.of(context).insert(loader);
      repository.emailManagement(email, password).then((value) {
        if (value == true) {
          showToast("Update Successfully", gravity: Toast.BOTTOM,
              duration: Toast.LENGTH_SHORT);
          setState(() {
            currentUser.value.email = email;
          });
        } else {
          showToast("Password is Wrong", gravity: Toast.BOTTOM,
              duration: Toast.LENGTH_SHORT);
        }
      }).whenComplete(() {
        Navigator.pop(context);
        Helper.hideLoader(loader);
      });
    }
  }
  listenForSetting() {

    repository.getAdminSettingDetailData().then((value) {
      setState(() {
        loaderData = true;

        settingDetails = value;

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


  getVendorProfileDetailData(id) {

    repository.getVendorProfileDetails(id).then((value) {
      setState(() {
        loaderData = true;
        profileDetails = value;
       // openTime.text = profileDetails.general.openTime;
       // closeTime.text = profileDetails.general.closeTime;
      } );

    }).catchError((e) {

      // ignore: deprecated_member_use
      scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
        content: Text('Error'),
      ));
    }).whenComplete(() {
      //Helper.hideLoader(loader);
    });
  }

  listenForPaymentGate(){
    repository.getPaymentGatewayDetails().then((value) {
      setState(() {
        loaderData = true;
         paymentGateData = value;

      } );

    }).catchError((e) {
      loader.remove();
      // ignore: deprecated_member_use
      scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
        content: Text('Error'),
      ));
    }).whenComplete(() {
      //Helper.hideLoader(loader);
    });

  }
  generalDetailsUpdate(){

      if (adminGeneralFormKey.currentState.validate()) {
        adminGeneralFormKey.currentState.save();
        Overlay.of(context).insert(loader);
        repository.updateProfile(adminGeneral, 'general').then((value) {
          showToast("Update Successfully", gravity: Toast.BOTTOM,
              duration: Toast.LENGTH_SHORT);
        }).catchError((e) {

        }).whenComplete(() {
          Helper.hideLoader(loader);
        });
      }

  }
  Future<void> listenForPlanHistory() async {
    setState(() => vendorPlanList.clear());
    setState(() => vendorPlanListTemp.clear());
    final Stream<VendorPlanHistory> stream = await getMembershipPlanHistory();
    stream.listen((VendorPlanHistory _list) {
      setState(() => vendorPlanList.add(_list));
      setState(() => vendorPlanListTemp.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {

    });
  }

  paymentGatewayDetailsUpdate(){
      print(paymentGateData.toMap());
    if (generalFormKey.currentState.validate()) {
      generalFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.updatePaymentGate(paymentGateData).then((value) {
        showToast("Update Successfully", gravity: Toast.BOTTOM,
            duration: Toast.LENGTH_SHORT);
      }).catchError((e) {

      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }

  }

  paymentDetailsUpdate(){
    if (paymentFormKey.currentState.validate()) {
      paymentFormKey.currentState.save();
      setting.value.currencyRight = adminPayment.currencyPosition;
      Overlay.of(context).insert(loader);
      repository.updateProfile(adminPayment,'payment').then((value) {

        showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }).catchError((e) {

      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }
  smptDetailsUpdate(){
    if (smtpFormKey.currentState.validate()) {
      smtpFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.updateProfile(smtp,'smtp').then((value) {

        showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }).catchError((e) {

      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  deliveryDetailsUpdate(){

      if (deliveryFormKey.currentState.validate()) {
        deliveryFormKey.currentState.save();
        Overlay.of(context).insert(loader);
        print(delivery.toMap());
        repository.updateProfile(delivery, 'delivery').then((value) {
          showToast("Update Successfully", gravity: Toast.BOTTOM,
              duration: Toast.LENGTH_SHORT);
        }).catchError((e) {

        }).whenComplete(() {
          Helper.hideLoader(loader);
        });
      }
  }
  filtermemberhistoryplan( List<VendorPlanHistory> users, String filterString) {
    List<VendorPlanHistory> tempUsers = users;
    print("User Length:${users.length}");
    List<VendorPlanHistory> _users = tempUsers
        .where((u) =>
    (u.id.toLowerCase().contains(filterString.toLowerCase())) ||
        (u.planId.toString().toLowerCase().contains(filterString.toLowerCase())) || (u.planName.toString().toLowerCase().contains(filterString.toLowerCase())) )
        .toList();
    print(_users.length);
    return _users;
  }


  Future<void> listenForRoles() async {
    final Stream<RolesModel> stream = await getRoles();
    stream.listen((RolesModel _list) {
      setState(() => rolesList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  addRolePermission(){
    print(rolePermissionModel.toMap());
    Overlay.of(context).insert(loader);
    repository.addRole(rolePermissionModel).then((value) {
      showToast("Update Successfully", gravity: Toast.BOTTOM,
          duration: Toast.LENGTH_SHORT);
    }).catchError((e) {
      Helper.hideLoader(loader);
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

  void showToastPopup(String msg, context,  {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }
}