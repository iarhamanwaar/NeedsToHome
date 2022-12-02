
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/packagemodel.dart';
import 'package:login_and_signup_web/src/models/providerbooking.dart';
import 'package:login_and_signup_web/src/models/providerdata_model.dart';
import 'package:login_and_signup_web/src/models/subcategory_List.dart';
import 'package:login_and_signup_web/src/models/supercategory.dart';
import 'package:login_and_signup_web/src/models/zone.dart';
import 'package:toast/toast.dart';
import '../models/category.dart';
import '../models/provider.dart';
import '../repository/hservice_repository.dart';
import '../repository/hservice_repository.dart' as repository;
import 'package:mvc_pattern/mvc_pattern.dart';


class HServiceController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKeyState;
  GlobalKey<FormState> formKey;
  GlobalKey<FormState> subcategoryFormKey;
  List<CategoryModel> hcategoryList = <CategoryModel>[];
  CategoryModel hcategoryData = CategoryModel();
  SuperCategoryModel superCategoryData=SuperCategoryModel();
  PackageModel packageData=PackageModel();
  SubCategoryListModel subcategoryData = new SubCategoryListModel();
  List<SubCategoryListModel> subcategoryList = <SubCategoryListModel>[];
  List<SuperCategoryModel> supercategoryList = <SuperCategoryModel>[];
  List<ProviderBooking> bookingDetailsList=<ProviderBooking>[];
  List<ZoneModel> zoneList=<ZoneModel>[];
  List<ProviderModel> providerList=<ProviderModel>[];
  List<ProviderModel> providerListTemp=<ProviderModel>[];
  List<ZoneModel> zoneListTemp=<ZoneModel>[];
  ProviderModel providerData=ProviderModel();
  List<ProviderServiceDataModel> providerServiceList = <ProviderServiceDataModel>[];
  GlobalKey<FormState> registerFormKey;
  // ignore: non_constant_identifier_names
  List<PackageModel> PackageList = <PackageModel>[];
  OverlayEntry loader;
  HServiceController() {
    subcategoryFormKey =  new GlobalKey<FormState>();
    loader = Helper.overlayLoader(context);
    formKey = new GlobalKey<FormState>();
    registerFormKey = new GlobalKey<FormState>();
  }


  Future<void> listenForCategories() async {
    setState(() => hcategoryList.clear());
    final Stream<CategoryModel> stream = await getCategory();
    stream.listen((CategoryModel _category) {
      setState(() => hcategoryList.add(_category));

    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }
  Future<void> listenForProviderBooking() async {
    setState(() => bookingDetailsList.clear());
    final Stream<ProviderBooking> stream = await getProviderBooking();
    stream.listen((ProviderBooking _booking) {
      setState(() => bookingDetailsList.add(_booking));
    }, onError: (a) {
    }, onDone: () {});
  }

  Future<void> listenForProviderService(id) async {
    setState(() => providerServiceList.clear());
    final Stream<ProviderServiceDataModel> stream = await getProviderService(id);
    stream.listen((ProviderServiceDataModel _data) {
      setState(() => providerServiceList.add(_data));
    }, onError: (a) {
    }, onDone: () {});
  }
  Future<void> listenForZone() async {
    setState(() => zoneList.clear());
    setState(()=>zoneListTemp.clear());
    final Stream<ZoneModel> stream = await getZone();
    stream.listen((ZoneModel _zone) {
      setState(() => zoneList.add(_zone));
      setState(()=>zoneListTemp.add(_zone));

    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForProvider() async {
    setState(() {
      providerList.clear();
      providerListTemp.clear();
    });
    final Stream<ProviderModel> stream = await getProvider();
    stream.listen((ProviderModel _type) {
      setState(() {
        providerList.add(_type);
        providerListTemp.add(_type);
      },

      );
    }, onError: (a) {
      print(a);
      print('error');
    }, onDone: () {
      print('done');
    });
  }

  Future<void>  addEditProvider(paraType, id,context) async {
    if (registerFormKey.currentState.validate()) {
      registerFormKey.currentState.save();
      if (providerData.uploadImage!= null) {
        Overlay.of(context).insert(loader);
        await repository.aEProvider(providerData, paraType, id).then((value) {
          showToastPopup("Update Successfully", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {
          loader.remove();
          // ignore: deprecated_member_use

        }).whenComplete(() {
          Helper.hideLoader(loader);
          Navigator.pop(context);
          setState(() => providerList.clear());
          listenForProvider();
          return true;
        });
      } else {
        showToastPopup("Please Upload Image", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }
    }
  }


  filterProviderUser( List<ProviderModel> users, String filterString) {
    List<ProviderModel> tempUsers = users;
    List<ProviderModel> _users = tempUsers
        .where((u) =>
    (u.username.toLowerCase().contains(filterString.toLowerCase())) ||
        (u.id.toString().toLowerCase().contains(filterString.toLowerCase())))
        .toList();
    print(_users.length);
    return _users;
  }



  filterZone( List<ZoneModel> zone, String filterString) {
    List<ZoneModel> tempZone = zone;
    List<ZoneModel> _zones = tempZone
        .where((u) =>
    (u.title.toLowerCase().contains(filterString.toLowerCase())) ||
        (u.id.toString().toLowerCase().contains(filterString.toLowerCase())))
        .toList();
    //print(_users.length);
    return _zones;
  }
  // ignore: missing_return
  Future<bool>  addEditCategory(paraType, id,context) async{

    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if(hcategoryData.uploadImage!=null) {
        Overlay.of(context).insert(loader);
        await repository.aECategory(hcategoryData, paraType, id).then((value) {
          showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {
          loader.remove();
          // ignore: deprecated_member_use

        }).whenComplete(() {
          Helper.hideLoader(loader);
          Navigator.pop(context);
          setState(() => hcategoryList.clear());
          listenForCategories();
          return true;
        });
      } else {
        showToastPopup("Upload your image", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT, );
      }
    }



  }

  Future<void> listenForSuperCategories() async {
    setState(() => supercategoryList.clear());
    final Stream<SuperCategoryModel> stream = await getSuperCategory();
    stream.listen((SuperCategoryModel _category) {
      setState(() => supercategoryList.add(_category));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void>  addEditSuperCategory(paraType, id,context) async{

    if (formKey.currentState.validate()) {
      formKey.currentState.save();
        Overlay.of(context).insert(loader);
        await repository.aESuperCategory(superCategoryData, paraType, id).then((value) {
          print(superCategoryData.categoryName);
          showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {
          loader.remove();
          // ignore: deprecated_member_use

        }).whenComplete(() {
          Helper.hideLoader(loader);
          Navigator.pop(context);
          setState(() => supercategoryList.clear());
          listenForSuperCategories();
          return true;
        });
    }



  }

  Future<void> listenForPackage() async {
    setState(() => PackageList.clear());
    final Stream<PackageModel> stream = await getPackage();
    stream.listen((PackageModel _category) {
      setState(() => PackageList.add(_category));

    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  // ignore: missing_return
  Future<bool>  addEditPackage(paraType, id,context) async{

    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if(packageData.image!=null) {
        Overlay.of(context).insert(loader);
        await repository.aEPackage(packageData, paraType, id).then((value) {
          showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {
          loader.remove();
          // ignore: deprecated_member_use

        }).whenComplete(() {
          Helper.hideLoader(loader);
          Navigator.pop(context);
          setState(() =>PackageList.clear());
          listenForPackage();
          return true;
        });
      } else {
        showToastPopup("Upload your image", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT, );
      }
    }



  }

  delete(table, id){

   print(id);
    repository.globalDelete(table, id).then((value) {
      showToast("Delete Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);


    }).catchError((e) {
      // loader.remove();
      // ignore: deprecated_member_use

    }).whenComplete(() {
      // Helper.hideLoader(loader);
       listenForCategories();
       listenForPackage();
       listenForSubCategories();
       if(table=='supercategory') {
         listenForSuperCategories();
       }
       if(table=='zone'){
         listenForZone();
       }
       if(table=='provider'){
         listenForProvider();
       }
       print('supercategory');
    });
  }


  Future<void> listenForSubCategories() async {
    setState(() => subcategoryList.clear());

    final Stream<SubCategoryListModel> stream = await getSubCategory();
    stream.listen((SubCategoryListModel _category) {
      setState(() => subcategoryList.add(_category));

    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }


  Future<bool> addEditSubCategory(paraType, id, context) async {




    if (subcategoryFormKey.currentState.validate()) {
      subcategoryFormKey.currentState.save();

      if(subcategoryData.uploadImage!=null) {
        Overlay.of(context).insert(loader);

        await repository.addSubCategory(subcategoryData, paraType, id).then((value) {
          showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {
          loader.remove();
          // ignore: deprecated_member_use

        }).whenComplete(() {
          Helper.hideLoader(loader);
          setState(() => subcategoryList.clear());
          listenForSubCategories();
          Navigator.pop(context);
        });
      } else {
        showToastPopup("Upload your image", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT, );
      }
    }

    return true;
  }


  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

  void showToastPopup(String msg, context,  {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }






}