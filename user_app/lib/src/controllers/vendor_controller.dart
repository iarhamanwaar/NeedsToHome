
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multisuperstore/src/models/coupon.dart';
import 'package:multisuperstore/src/models/product_details2.dart';
import 'package:multisuperstore/src/models/slide.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/helper.dart';
import '../models/category.dart';

import '../repository/home_repository.dart';
import '../models/restaurant_product.dart';
import '../repository/vendor_repository.dart';
import '../models/vendor.dart';

class VendorController extends ControllerMVC {
  List<Vendor> vendorList = <Vendor>[];
  List<Vendor> tempVendorList = <Vendor>[];
  List<Category> categories = <Category>[];
  List<Slide> middleSlides = <Slide>[];
  List<ProductDetails2> productSlide = <ProductDetails2>[];
  List<RestaurantProduct> vendorResProductList = <RestaurantProduct>[];
  List<CouponModel> couponList = <CouponModel>[];
  bool notFound = false;
  String todayDeals;
  String middleSidleLock;
  VendorController();

  Future<void> listenForVendorList(int shopType, int focusId) async {

    final Stream<Vendor> stream = await getVendorList(shopType, focusId);

    stream.listen((Vendor _list) {
      setState(() => vendorList.add(_list));
      setState(() => tempVendorList.add(_list));

    }, onError: (a) {
      print(a);
    }, onDone: () {

      vendorList.forEach((element) {

        setState(() {
          if(element.shopId=='no_data' ){

            notFound = true;
          }

        });
      });
    });
  }

  Future<void> listenForVendorListOffer(shopType, offerType, offer,shopTypeId ) async {

    final Stream<Vendor> stream = await getVendorListOffer(shopType, offerType, offer, shopTypeId);

    stream.listen((Vendor _list) {
      setState(() => vendorList.add(_list));
      vendorList.forEach((element) {
        print(element.logo);
      });
    }, onError: (a) {
      print(a);
    }, onDone: () {
      vendorList.forEach((element) {

        setState(() {
          if(element.shopId=='no_data' || element.shopId=='not_found'){

            notFound = true;
          }

        });
      });
    });
  }



  Future<void> listenForCategories(shopId) async {
    final Stream<Category> stream = await getCategories(shopId);
    stream.listen((Category _category) {
      setState(() => categories.add(_category));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForOffers(shopId) async {
    final Stream<CouponModel> stream = await getCoupons(shopId);
    stream.listen((CouponModel _category) {
      setState(() => couponList.add(_category));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }


  Future<void> listenForRestaurantProduct(int shopType, loaderTest) async {
    final Stream<RestaurantProduct> stream = await get_restaurantProduct(shopType);

    stream.listen((RestaurantProduct _list) {
      setState(() => vendorResProductList.add(_list));

      vendorResProductList.forEach((element) {
        print('list');
        print(element.category_name);
      });

    }, onError: (a) {
      print(a);
    }, onDone: () {
      loaderTest();

    });
  }


  sendChat(chatTxt, userId, shopId, shopMobile, shopName) {
    String chatRoom = '${DateTime.now().millisecondsSinceEpoch}$userId-$shopId';
   FirebaseFirestore.instance.collection('chatList').doc(chatRoom).set({
      'message': chatTxt.text,
      'userid': userId,
      'providerid': shopId,
      'sendername': currentUser.value.name,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'transfertype': 'User'
    }).catchError((e) {
      print(e);
    });
    /*String chatMaster = 'U$userId-F$shopId';
    FirebaseFirestore.instance.collection('chatUser').doc(chatMaster).set(
      {
        'shopId': shopId,
        'userId': userId,
        'lastChat': chatTxt.text,
        'shopMobile': shopMobile,
        'shopunRead': 'false',
        'userMobile': currentUser.value.phone,
        'userName': currentUser.value.name,
        'shopName': shopName,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'transferType': 'User',
        'phone': 9675087369,
      },
    ).catchError((e) {
      print(e);
    }); */

    return true;

}

  Future<void> listenForMiddleSlides(id) async {
    final Stream<Slide> stream = await getSlides(id);
    stream.listen((Slide _slide) {
      setState(() => middleSlides.add(_slide));
    }, onError: (a) {
      print(a);
    }, onDone: () {


      setState(() {
        middleSidleLock = middleSlides[0].id;
      });
    });
  }

  Future<void> listenForMiddleSlidesVideo(id) async {
    final Stream<Slide> stream = await getVendorSlides(id);
    stream.listen((Slide _slide) {
      setState(() => middleSlides.add(_slide));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      setState(() {
        middleSidleLock = middleSlides[0].id;
      });
    });
  }



  void listenForFavoritesShop() async {
    final Stream<Vendor> stream = await getFavoritesShop();
    stream.listen((Vendor _favorite) {
      setState(() {
        vendorList.add(_favorite);
      });
    }, onError: (a) {
      // ignore: deprecated_member_use

    }, onDone: () {

      vendorList.forEach((element) {

        setState(() {


          if(element.shopId=='not_found'){
            notFound = true;
          }

        });
      });
    });
  }

  void listenForVendorSlide({String id}) async {
    final Stream<ProductDetails2> stream = await getShopProductSlide(id);
    stream.listen((ProductDetails2 _list) {
      setState(() {
        productSlide.add(_list);
      });
    }, onError: (a) {
      // ignore: deprecated_member_use

    }, onDone: () {

      setState(() {
        todayDeals = productSlide[0].id;
      });

    });
  }

  shopFilter(List<Vendor> list,type){
    List<Vendor> tempList = list;
    List<Vendor> dataList = <Vendor>[];
    if(type=='Takeaway') {
      tempList.forEach((element) {
        if (element.takeaway) {
            dataList.add(element);
        }
      });
    } else if(type=='All') {
      dataList = tempList;
    } else if(type=='Opened Shop'){
      tempList.forEach((element) {
        if (Helper.shopOpenStatus(element)) {
          dataList.add(element);
        }
      });

    } else if(type=='Rating'){

      tempList.sort((a, b) {
        double aValue = double.parse(a.ratingTotal.replaceAll(',',''));
        double bValue = double.parse(b.ratingTotal.replaceAll(',',''));
        return aValue.toInt() - bValue.toInt() ;

      });
      dataList = tempList.reversed.toList();

    } else if(type=='Distance'){
      tempList.sort((a, b) {
        double aValue = double.parse(a.distance.replaceAll(',',''));
        double bValue = double.parse(b.distance.replaceAll(',',''));
        return aValue.toInt() - bValue.toInt() ;

      });
      dataList = tempList;
    }else if(type =='Delivery Time'){
      tempList.sort((a, b) {
        double aValue = double.parse(Helper.calculateTime(double.parse(a.distance.replaceAll(',','')),int.parse(a.handoverTime),true));
        double bValue = double.parse(Helper.calculateTime(double.parse(b.distance.replaceAll(',','')),int.parse(b.handoverTime),true));
        return aValue.toInt() - bValue.toInt() ;

      });
      dataList = tempList;
    }

   return dataList;
  }

}
