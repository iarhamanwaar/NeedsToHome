import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/car_model.dart';
import 'package:login_and_signup_web/src/models/cashonhand.dart';
import 'package:login_and_signup_web/src/models/cinHistoryModel.dart';
import 'package:login_and_signup_web/src/models/coupon.dart';
import 'package:login_and_signup_web/src/models/currency.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/models/banner.dart';
import 'package:login_and_signup_web/src/models/delivery_Fees.dart';
import 'package:login_and_signup_web/src/models/delivery_Tips.dart';
import 'package:login_and_signup_web/src/models/drecommendation.dart';
import 'package:login_and_signup_web/src/models/driver_details.dart';
import 'package:login_and_signup_web/src/models/invoice.dart';
import 'package:login_and_signup_web/src/models/itemdelivery.dart';
import 'package:login_and_signup_web/src/models/policymodeel.dart';
import 'package:login_and_signup_web/src/models/provider.dart';
import 'package:login_and_signup_web/src/models/pushnotification.dart';
import 'package:login_and_signup_web/src/models/shop_type.dart';
import 'package:login_and_signup_web/src/models/shopratingmodel.dart';
import 'package:login_and_signup_web/src/models/staff.dart';
import 'package:login_and_signup_web/src/models/summary_report.dart';
import 'package:login_and_signup_web/src/models/taxmodel.dart';
import 'package:login_and_signup_web/src/models/timezone.dart';
import 'package:login_and_signup_web/src/models/vendor_bussinesscard.dart';
import 'package:login_and_signup_web/src/models/vendor_membership.dart';
import 'package:login_and_signup_web/src/models/vendorwallet.dart';
import 'package:login_and_signup_web/src/models/version_control.dart';
import 'package:login_and_signup_web/src/repository/order_repository.dart';
import 'package:login_and_signup_web/src/repository/product_repository.dart';
import 'package:login_and_signup_web/src/repository/secondary_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toast/toast.dart';
import '../repository/secondary_repository.dart' as repository;


class SecondaryController extends ControllerMVC {
  GlobalKey<FormState> bannerFormKey;
  bool loaderData=false;
  List<CarTypeModel> carTypeList=<CarTypeModel>[];
  DriverDetailsModel driverDetailsData = new DriverDetailsModel();

  List<TimeZone> timezoneList=<TimeZone>[];
  List<VersionControl>   versionList  =<VersionControl>[];
  VersionControl versionData = new VersionControl();
  List<ShopRatingModel> shopRatingList=<ShopRatingModel>[];
  ProviderModel providerData=ProviderModel();
  InvoiceModel invoiceData = new InvoiceModel();
  SummaryReport summaryData = new SummaryReport();
  GlobalKey<FormState> generalFormKey;
  BannerModel bannerData = new BannerModel();
  DeliveryFees deliveryFees = new DeliveryFees();
  CarTypeModel carTypeData=CarTypeModel();
  Currency currencyData = Currency();
  GlobalKey<FormState> deliveryFeesFormKey;
  GlobalKey<FormState> currencyFormKey;
  GlobalKey<FormState> deliveryTipsFormKey;
  double totalPaid;
  double totalDue;
  // ignore: deprecated_member_use
  List<Map<String, dynamic>> source = List<Map<String, dynamic>>();
  // ignore: deprecated_member_use
  List<Map<String, dynamic>> originalSource = List<Map<String, dynamic>>();
  bool isLoading = true;
  List<DropDownModel> dropDownList = <DropDownModel>[];
  PushNotificationModel pushNotificationData = new PushNotificationModel();
  ShopTypeModel shopTypeData = new ShopTypeModel();
  DeliveryTipsModel deliveryTips = new DeliveryTipsModel();
  VendorBusinessCard businessCardData = new VendorBusinessCard();
  List<CashOnHandModel> cashOnHandList=<CashOnHandModel>[];
  List<CinHistoryModel> cinHistoryList=<CinHistoryModel>[];
  List<CashOnHandModel> cashOnHandListTemp=<CashOnHandModel>[];
  List<CinHistoryModel>cinHistoryListTemp=<CinHistoryModel>[];
  List<DeliveryTipsModel> deliveryTipsList = <DeliveryTipsModel>[];
  List<ShopTypeModel> shopTypeList = <ShopTypeModel>[];
  List<BannerModel> bannerList = <BannerModel>[];
  List<DeliveryFees> deliveryFeesList = <DeliveryFees>[];
  List<Currency> currencyList = <Currency>[];
  List<VendorWallet> vendorWalletList=<VendorWallet>[];
  List<VendorWallet> vendorWalletListTemp=<VendorWallet>[];
  List<VendorWallet> driverWalletList=<VendorWallet>[];
  List<VendorWallet> driverWalletListTemp=<VendorWallet>[];
  List<VendorWallet> providerWalletList=<VendorWallet>[];
  List<VendorWallet> providerWalletListTemp=<VendorWallet>[];
  TextEditingController controllerTitle ;
  TextEditingController controllerText ;
  List<StaffModel> staffList=<StaffModel>[];
  List<ItemDeliveryModel> itemDeliveryList=<ItemDeliveryModel>[];
  StaffModel staffData=StaffModel();
  VendorMembershipModel vendorMembershipData=VendorMembershipModel();
  // ignore: non_constant_identifier_names
  List<VendorMembershipModel> MemberPlanList = <VendorMembershipModel>[];
  List<PolicyModel> policyList=<PolicyModel>[];
  PolicyModel policyData=PolicyModel();
  List<TaxModel> taxList=<TaxModel>[];
  TaxModel taxData=TaxModel();
  VendorWallet vendorData =VendorWallet();
  List<VendorWallet> walletList=<VendorWallet>[];
  DRecommendation drData=DRecommendation();
  List <DRecommendation> drList=<DRecommendation>[];
  Coupon couponData=Coupon();
  List<Coupon> couponList=<Coupon>[];
  OverlayEntry loader;
  GlobalKey<FormState> registerFormKey;

  TextEditingController openTime;
  TextEditingController closeTime;
  GlobalKey<FormState> formKey;
  SecondaryController() {
    openTime = TextEditingController();
    closeTime = TextEditingController();
    formKey = new GlobalKey<FormState>();
    registerFormKey = new GlobalKey<FormState>();
    loader = Helper.overlayLoader(context);
    controllerTitle  = TextEditingController();
    controllerText  = TextEditingController();
    controllerTitle.addListener(() {
      setState(() {});
    });
    controllerText.addListener(() {
      setState(() {});
    });
    bannerFormKey = new GlobalKey<FormState>();
    generalFormKey = new GlobalKey<FormState>();
    deliveryFeesFormKey = new GlobalKey<FormState>();
    deliveryTipsFormKey = new GlobalKey<FormState>();
    currencyFormKey = new GlobalKey<FormState>();
  }
  Future<void> listenForReview(id) async {

    final Stream<ShopRatingModel> stream = await getReview(id);
    stream.listen((ShopRatingModel _banner) {
      setState(() => shopRatingList.add(_banner));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      print('shopRatingList:${shopRatingList.length}');
      //print(walletList.length);
    });
  }
  addBanner(context,pageType,id){
    if (bannerFormKey.currentState.validate()) {
      bannerFormKey.currentState.save();
      print(bannerData.toMap());
      Overlay.of(context).insert(loader);
      
      if( (bannerData.uploadImage!=null && pageType=='do_add') || pageType=='update') {
       setState(()=>bannerList.clear());
        repository.addBannerData(bannerData, id, pageType).then((value) {
          showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {}).whenComplete(() {
          listenForBanner(bannerData.type);
          Navigator.pop(context);

          Helper.hideLoader(loader);
        });
      } else {
        showToastPopup("Upload your image", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT, );
      }

    }
  }

  void getBusinessCard(id) async {

    vendorBusinessCard(id).then((value) {
      setState(() =>businessCardData = value);

      print(businessCardData.preview);

    }).catchError((e) {

    }).whenComplete(() {

    });
  }

  Future<void> listenForInvoiceList(shopId) async {
    setState(() => isLoading = true);
    final Stream<Map<String, dynamic>> stream = await getInvoiceReport(shopId);
    stream.listen((Map<String, dynamic> _list) {
      setState(() => source.add(_list));
      setState(() => originalSource.add(_list));
      setState(() => isLoading = false);
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }
  listenForSummary(id){
    getSummaryReport(id).then((value) {
      setState((){
        summaryData = value;
        if(summaryData.totalPaidCommission==0){
          totalPaid =1;
        }
        if(summaryData.totalDueCommission==0){
          totalDue =1;
        }
      });


    }).whenComplete(() {

    });
  }
  Future<void> listenForCOH(type) async {
    cashOnHandList.clear();
    cashOnHandListTemp.clear();
    final Stream<CashOnHandModel> stream = await getCashOnHAnd(type);
    stream.listen((CashOnHandModel _banner) {
      setState(() => cashOnHandList.add(_banner));
      setState(() => cashOnHandListTemp.add(_banner));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      print(cashOnHandList.length);
    });
  }
  Future<void> listenForCIN() async {
    cinHistoryList.clear();
    cinHistoryListTemp.clear();
    final Stream<CinHistoryModel> stream = await getCINHistory();
    stream.listen((CinHistoryModel _banner) {
      setState(() => cinHistoryList.add(_banner));
      setState(() => cinHistoryListTemp.add(_banner));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      print(cashOnHandList.length);
    });
  }
  Future<void> listenForSVendorWallet(type,id) async {
    setState(() => vendorWalletList.clear());
    final Stream<VendorWallet> stream = await getVendorWallet(type,id);
    stream.listen((VendorWallet _banner) {
      setState(() => vendorWalletList.add(_banner));
      setState(() => vendorWalletListTemp.add(_banner));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      //print(walletList.length);
    });
  }
  Future<void> listenForCoupon() async{
    couponList.clear();
    final Stream<Coupon> stream=await getCouponList();
    stream.listen((Coupon coupon) {
      setState(() =>couponList.add(coupon));
    },onError: (a) {
      print(a);
    }, onDone: () {

    });
  }

  Future<void> listenForVersionList() async{

    final Stream<VersionControl> stream=await getVersionList();
    stream.listen((VersionControl list) {
      setState(() =>versionList.add(list));
    },onError: (a) {
      print(a);
    }, onDone: () {
    });
  }

  Future<void> listenForProviderWallet() async {

    final Stream<VendorWallet> stream = await getWallet('provider');
    stream.listen((VendorWallet _banner) {
      setState(() => providerWalletList.add(_banner));
      setState(() => providerWalletListTemp.add(_banner));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      //print(walletList.length);
    });
  }
  Future<void> listenForVendorWallet(type) async {
    setState(() => vendorWalletList.clear());
    final Stream<VendorWallet> stream = await getWallet(type);
    stream.listen((VendorWallet _banner) {
      setState(() => vendorWalletList.add(_banner));
      setState(() => vendorWalletListTemp.add(_banner));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      //print(walletList.length);
    });
  }
  Future<void> listenForDriverWallet() async {
    final Stream<VendorWallet> stream = await getWallet('driver');
    stream.listen((VendorWallet _banner) {
      setState(() => driverWalletList.add(_banner));
      setState(() => driverWalletListTemp.add(_banner));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      //print(walletList.length);
    });
  }
  addECinHistory(CashOnHandModel cindata,pagetype) {

    setState(() => cashOnHandList.clear());
    repository.addcinhistory(cindata,pagetype).then((value) {
      showToastPopup("Update Successfully", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }).catchError((e) {
      print(e);
    }).whenComplete(() {
      listenForCOH(pagetype);
    });

  }

  Future<void> listenForDrec() async {

    final Stream<DRecommendation> stream = await getDrec();
    stream.listen((DRecommendation _banner) {
      setState(() => drList.add(_banner));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      print(drList.length);
    });
  }
  filterCin( List<CashOnHandModel> users, String filterString) {
    List<CashOnHandModel> tempUsers = users;
    print("User Length:${users.length}");
    List<CashOnHandModel> _users = tempUsers
        .where((u) =>
    (u.id.toLowerCase().contains(filterString.toLowerCase())) ||
        (u.name.toString().toLowerCase().contains(filterString.toLowerCase())))
        .toList();
    print(_users.length);
    return _users;
  }
  filterCinHistory( List<CinHistoryModel> users, String filterString) {
    List<CinHistoryModel> tempUsers = users;
    print("User Length:${users.length}");
    List<CinHistoryModel> _users = tempUsers
        .where((u) =>
    (u.id.toLowerCase().contains(filterString.toLowerCase())) ||
        (u.driverId.toString().toLowerCase().contains(filterString.toLowerCase())))
        .toList();
    print(_users.length);
    return _users;
  }

  sendPushNotification() async{
    if (generalFormKey.currentState.validate()) {
      generalFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

      await repository.sendNotification(pushNotificationData).then((value) {

        if(pushNotificationData.uploadImage!=null){
          // ignore: deprecated_member_use
          pushNotificationData.uploadImage = '${GlobalConfiguration().getString('base_upload')}uploads/pushnotification_image/pushnotification_1.png';
        } else {
          pushNotificationData.uploadImage = 'no';
        }
        if(GetPlatform.isWeb || GetPlatform.isMobile){
          FirebaseFirestore.instance
              .collection('notificationall')
              .doc(timeStamp)
              .set({
            'title': pushNotificationData.title,
            'subtitle': pushNotificationData.message,
            'usertype': pushNotificationData.userType,
            'image': pushNotificationData.uploadImage
          }).catchError((e) {
            print(e);
          });

        }else {

          Firestore.instance
              .collection('notificationall')
              .document(timeStamp)
              .set({'title': pushNotificationData.title, 'subtitle':  pushNotificationData.message, 'usertype': pushNotificationData.userType, 'image': pushNotificationData.uploadImage}).catchError((e) {
            print(e);
          });

        }

        showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }).catchError((e) {
        loader.remove();
        // ignore: deprecated_member_use

      }).whenComplete(() {
        Helper.hideLoader(loader);

        // setState(() => currencyData.clear());

        return true;
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


  deliveryTipsUpdate(context,id,pageType) {
    if (deliveryTipsFormKey.currentState.validate()) {
      deliveryTipsFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      setState(()=>deliveryTipsList.clear());

      print(deliveryTips.toMap());
      repository.addEdDeliveryTips(deliveryTips,id,pageType).then((value) {
        showToastPopup("Update Successfully",context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);

      }).catchError((e) {
        print(e);
      }).whenComplete(() {
        Navigator.pop(context);
        listenForDeliveryTips();
        Helper.hideLoader(loader);


      });


    }
  }


  addEdCoupon(context,id,pageType) {

    if (registerFormKey.currentState.validate()) {
      registerFormKey.currentState.save();
         print(couponData.toMap());
      Overlay.of(context).insert(loader);
        repository.addECoupon(couponData, pageType,id).then((value) {
          showToastPopup("Update Successfully", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {
          print(e);
        }).whenComplete(() {
        Navigator.pop(context);
         listenForCoupon();
         Helper.hideLoader(loader);
        });
      } else {
        showToastPopup("Please upload your image",context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }
  }

  addEdrecommendation(context,pageType) {
    if (generalFormKey.currentState.validate()) {
      generalFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      setState(()=>drList.clear());
      repository.adddreccomendation(drData, pageType).then((value) {
        showToastPopup("Update Successfully", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }).catchError((e) {
        print(e);
      }).whenComplete(() {
        Navigator.pop(context);
        listenForDrec();
        Helper.hideLoader(loader);
      });
    } else {
      showToastPopup("Please upload your image",context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }
  }

  filterWallet( List<VendorWallet> users, String filterString) {
    List<VendorWallet> tempUsers = users;
    print("User Length:${users.length}");
    List<VendorWallet> _users = tempUsers
        .where((u) =>
    (u.id.toLowerCase().contains(filterString.toLowerCase())) ||
        (u.vendorId.toString().toLowerCase().contains(filterString.toLowerCase())))
        .toList();
    print(_users.length);
    return _users;
  }


  addEdFocusType(context,id,pageType) {
    if (generalFormKey.currentState.validate()) {
      generalFormKey.currentState.save();
             print(pageType);
             print(shopTypeData.previewImage);
      if( (shopTypeData.previewImage!=null && shopTypeData.coverImage!=null )) {
        Overlay.of(context).insert(loader);
        setState(() => shopTypeList.clear());


        repository.addEdFocusShopType(shopTypeData, pageType, id).then((value) {
          showToastPopup("Update Successfully", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {
          print(e);
        }).whenComplete(() {
         Navigator.pop(context);
          listenForShopTypeList();
          Helper.hideLoader(loader);
        });
      } else {
        showToastPopup("Please upload your image",context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);

      }


    }
  }

  Future<void> listenForDeliveryTips() async {

    final Stream<DeliveryTipsModel> stream = await getDeliveryTips();
    stream.listen((DeliveryTipsModel _list) {
      setState(() => deliveryTipsList.add(_list));
    }, onError: (a) {
      print(a);
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForPolicy() async {

    final Stream<PolicyModel> stream = await getPolicy();
    stream.listen((PolicyModel _list) {
      setState(() => policyList.add(_list));
    }, onError: (a) {
      print(a);
      print('error');
      print(a);
    }, onDone: () {
      print('Policy fetched');
    });
  }

  Future<void>  addEditPolicy(paraType, id,context) async {
    if (registerFormKey.currentState.validate()) {
      registerFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      await repository.aEPolicy(policyData, paraType, id).then((value) {
        showToastPopup("Update Successfully", context, gravity: Toast.BOTTOM,
            duration: Toast.LENGTH_SHORT);
      }).catchError((e) {
        loader.remove();
        // ignore: deprecated_member_use

      }).whenComplete(() {
        Helper.hideLoader(loader);

        setState(() => policyList.clear());
        listenForPolicy();
        return true;
      });
    }
  }

  Future<void> listenForTimeZone() async {
    setState(() => timezoneList.clear());
    final Stream<TimeZone> stream = await getTimeZone();
    stream.listen((TimeZone _list) {
      setState(() => timezoneList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {

    });
  }

  Future<void> listenForTax() async {

    final Stream<TaxModel> stream = await getTax();
    stream.listen((TaxModel _list) {
      setState(() => taxList.add(_list));
    }, onError: (a) {
      print(a);

      print(a);
    }, onDone: () {
      print('Policy fetched');
    });
  }

  Future<void>  addEditTax(paraType, id,context) async {
    if (registerFormKey.currentState.validate()) {
      registerFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      await repository.aETax(taxData, paraType, id).then((value) {
        showToastPopup("Update Successfully", context, gravity: Toast.BOTTOM,
            duration: Toast.LENGTH_SHORT);
      }).catchError((e) {
        loader.remove();
        // ignore: deprecated_member_use

      }).whenComplete(() {
        Helper.hideLoader(loader);
        Navigator.pop(context);
        setState(() => taxList.clear());
        listenForTax();
        return true;
      });
    }
  }



  Future<void>  addEditMemberPlanList(paraType, id,context) async {
    if (registerFormKey.currentState.validate()) {
      registerFormKey.currentState.save();
      if (vendorMembershipData.uploadImage!= null) {
        Overlay.of(context).insert(loader);
        await repository.aEVendorMembership(vendorMembershipData, paraType, id).then((value) {
          showToastPopup("Update Successfully", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {
          loader.remove();
          // ignore: deprecated_member_use

        }).whenComplete(() {
          Helper.hideLoader(loader);
          Navigator.pop(context);
          setState(() => MemberPlanList.clear());
          listenForMemberPlan();
          return true;
        });
      } else {
        showToastPopup("Please Upload Image", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }
    }
  }



  Future<void> listenForMemberPlan() async {
    setState(() => MemberPlanList.clear());
    final Stream<VendorMembershipModel> stream = await getMemberPlanList();
    stream.listen((VendorMembershipModel _plan) {
      setState(() => MemberPlanList.add(_plan),
      );
    }, onError: (a) {
      print(a);
      print('id:${MemberPlanList[0].id}');
    }, onDone: () {
      print('MemberPlan list fetched');

    });
  }


  Future<void> listenForShopTypeList() async {

    final Stream<ShopTypeModel> stream = await getShopTypeList();
    stream.listen((ShopTypeModel _list) {
      setState(() => shopTypeList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void>  addEditCarType(paraType, id,context) async {
    if (registerFormKey.currentState.validate()) {
      registerFormKey.currentState.save();
      if (carTypeData.uploadImage!= null) {
        Overlay.of(context).insert(loader);
        await repository.aECarType(carTypeData, paraType, id).then((value) {
          showToastPopup("Update Successfully", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {
          loader.remove();
          // ignore: deprecated_member_use

        }).whenComplete(() {
          Helper.hideLoader(loader);
          Navigator.pop(context);
          setState(() => carTypeList.clear());
          listenForCarType();
          return true;
        });
      } else {
        showToastPopup("Please Upload Image", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }
    }
  }

  Future<void> listenForCarType() async {
    setState(() => carTypeList.clear());
    final Stream<CarTypeModel> stream = await getCarType();
    stream.listen((CarTypeModel _type) {
      setState(() => carTypeList.add(_type),
      );
    }, onError: (a) {
      print(a);
    }, onDone: () {
      print('MemberPlan list fetched');
    });
  }


  paymentStatsUpdate(type,invoiceId,id) async{
    await repository.addPaymentStatusUpdate(type, invoiceId, id).then((value) {
      showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }).catchError((e) {
      loader.remove();
      // ignore: deprecated_member_use

    });
  }



  updateCurrency(context, paraType, id) async {
    if (currencyFormKey.currentState.validate()) {
      currencyFormKey.currentState.save();
      setState(() => currencyList.clear());
      if(currencyData.uploadImage!=null) {
        Overlay.of(context).insert(loader);
        await repository.addCategory(currencyData, paraType, id).then((value) {
          showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {
          loader.remove();
          // ignore: deprecated_member_use

        }).whenComplete(() {
          Helper.hideLoader(loader);
          Navigator.pop(context);
         // setState(() => currencyData.clear());
            listenForCurrency();
          return true;
        });
      } else {
        showToastPopup("Upload your image", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT, );
      }
    }
  }


  updateVersion(context, paraType, id) async {
    if (currencyFormKey.currentState.validate()) {

      currencyFormKey.currentState.save();
      setState(() => versionList.clear());

        Overlay.of(context).insert(loader);
        await repository.editVersion(versionData, paraType, id).then((value) {
          showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {
          loader.remove();
          // ignore: deprecated_member_use

        }).whenComplete(() {
          Helper.hideLoader(loader);
          Navigator.pop(context);
          // setState(() => currencyData.clear());
          listenForVersionList();
          return true;
        });

    }
  }

  Future<void> listenForBanner(id) async {
    if(bannerList.length!=0) {
    bannerList.clear();
    }
    final Stream<BannerModel> stream = await getBanner(id);
    stream.listen((BannerModel _banner) {
      setState(() => bannerList.add(_banner));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForItemDelivery() async {
    setState(() => itemDeliveryList.clear());
    final Stream<ItemDeliveryModel> stream = await getItemDelivery();
    stream.listen((ItemDeliveryModel _type) {
      setState(() => itemDeliveryList.add(_type),
      );
    }, onError: (a) {
      print(a);
      print('error');
    }, onDone: () {
      print('done');
    });
  }


  Future<void> listenForCurrency() async {
    print(1);
    final Stream<Currency> stream = await getCurrency();
    stream.listen((Currency _list) {
      setState(() => currencyList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }



  deliveryFeesUpdate(context, id, pageType) {
    if (deliveryFeesFormKey.currentState.validate()) {
      deliveryFeesFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      setState(()=>deliveryFeesList.clear());


      repository.addEdDeliveryFees(deliveryFees,pageType,id,).then((value) {
        showToastPopup("Update Successfully",context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);

      }).catchError((e) {
        print(e);
      }).whenComplete(() {
        Navigator.pop(context);
        listenForDeliveryFees();
        Helper.hideLoader(loader);

      });
    }

  }

  vendorDelete(id){

    repository.vendorDelete(id).then((value) {
      showToast("Delete Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);


    }).catchError((e) {
      // loader.remove();
      // ignore: deprecated_member_use

    }).whenComplete(() {
      // Helper.hideLoader(loader);
    });
  }

  delete(table, id){

    repository.globalDelete(table, id).then((value) {
      showToast("Delete Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);


    }).catchError((e) {
      // loader.remove();
      // ignore: deprecated_member_use

    }).whenComplete(() {
      // Helper.hideLoader(loader);
      if(table=='coupon'){
        listenForCoupon();
      }
      if(table=='logistics_pricing') {
        listenForDeliveryFees();
      } else if(table=='shop_focus'){
        listenForShopTypeList();
      } else if(table=='banner_master'){
        listenForBanner(1);
      } else if(table=='tips'){
        listenForDeliveryTips();
      } else if(table == 'currency_method'){
        currencyList.clear();
        listenForCurrency();
      }else if(table == 'd_recommendation'){
        listenForDrec();
      }
      listenForMemberPlan();
      listenForTax();

    });
  }
  Future<void>  addEditStaffList(paraType, id,context) async {
    if (registerFormKey.currentState.validate()) {
      registerFormKey.currentState.save();
      if (staffData.uploadImage!= null) {
        Overlay.of(context).insert(loader);
        await repository.aEStaff(staffData, paraType, id).then((value) {
          showToastPopup("Update Successfully", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {
          loader.remove();
          // ignore: deprecated_member_use

        }).whenComplete(() {
          Helper.hideLoader(loader);
          Navigator.pop(context);
          //setState(() => MemberPlanList.clear());
          //listenForMemberPlan();
          print('added Staff deatils');
          return true;
        });
      } else {
        showToastPopup("Please Upload Image", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }
    }
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

  walletStatsUpdate(type,invoiceId,id,amount,pagetype) async{
    Overlay.of(context).insert(loader);
    await repository.addwalletStatusUpdate(type, invoiceId, id,amount,pagetype).then((value) {
      showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }).catchError((e) {
      loader.remove();
      // ignore: deprecated_member_use
    }).whenComplete(() {
      Helper.hideLoader(loader);
      listenForVendorWallet(pagetype);
      Navigator.pop(context);
    });
  }


  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

  void showToastPopup(String msg, context,  {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);

  }

  Future<void> listenForDeliveryFees() async {
    print(1);
    final Stream<DeliveryFees> stream = await getDeliveryFees();
    stream.listen((DeliveryFees _list) {
      setState(() => deliveryFeesList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }





}