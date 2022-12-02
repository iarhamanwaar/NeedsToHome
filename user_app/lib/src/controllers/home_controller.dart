
import 'package:multisuperstore/src/models/explore_search.dart';
import 'package:multisuperstore/src/models/main_category.dart';
import 'package:multisuperstore/src/models/searchisresult.dart';
import 'package:multisuperstore/src/models/vendor_businesscard.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../models/vendor.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/trending.dart';
import '../models/slide.dart';
import '../repository/home_repository.dart';
import '../models/inter_sort.dart';
import '../models/shop_type.dart';
import 'package:multisuperstore/src/repository/vendor_repository.dart' as repository;


class HomeController extends ControllerMVC {
  List<Slide> slides = <Slide>[];
  List<Slide> middleSlides = <Slide>[];
  List<Slide> fixedSlider = <Slide>[];
  List<Vendor>vendorList = <Vendor>[];
  List<Vendor>vendorSearch = <Vendor>[];
  List<InterSortView> interSortView = <InterSortView>[];
  List<Trending> trending = <Trending>[];
  List<ShopType> shopTypeList= <ShopType>[];
  List<ShopType> myRecommendationList= <ShopType>[];
  List<SearchISResult> searchResultList= <SearchISResult>[];
  List<MainCategoryModel> mainShopCategories = <MainCategoryModel>[];
  List<Explore> exploreList = <Explore>[];
  bool loader = false;
  String searchState = 'no_data';
  bool pageLoader = true;
  bool notFound = false;
  String currentSuperCategory;
  SearchISResult searchResultData = new SearchISResult();
  List<ItemDetails> itemData = <ItemDetails>[];
  List<ItemDetails> featuredData = <ItemDetails>[];
  VendorBusinessCard businessCardData = new VendorBusinessCard();
  int shopType;
  int focusId;
  HomeController() {
    //listenForCategories();


  }

  Future<void> listenForSlides(id) async {
    final Stream<Slide> stream = await getSlides(id);
    stream.listen((Slide _slide) {
      setState(() => slides.add(_slide));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }


  Future<void> listenForMiddleSlides(id) async {
    final Stream<Slide> stream = await getSlides(id);
    stream.listen((Slide _slide) {
      setState(() => middleSlides.add(_slide));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForFixedSlides(id) async {
    final Stream<Slide> stream = await getSlides(id);
    stream.listen((Slide _slide) {
      setState(() => fixedSlider.add(_slide));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForVendor() async {
    setState(() => vendorList.clear());
    final Stream<Vendor> stream = await getTopVendorList();
    stream.listen((Vendor _list) {
      setState(() => vendorList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForVendorSearch(searchTxt) async {
    setState(() =>loader = true);
    setState(() => vendorSearch.clear());
    final Stream<Vendor> stream = await getTopVendorListSearch(searchTxt);
    stream.listen((Vendor _list) {
      setState(() =>loader = false);
      setState(() => vendorSearch.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {

    });
  }

  Future<void> listenForVendorItemSearch(searchTxt, type, filterId) async {
   if(searchTxt!='') {
     setState(() => searchState = 'finding');
     getTopVendorItemListSearch(searchTxt, type, filterId).then((value) {
       searchResultData = value;
     }).catchError((e) {

     }).whenComplete(() {
       setState(() => searchState = 'find');
     });
   }
  }

  Future<void> listenForFeatureProductList(focusId,shopType) async {

    int i= 1;
    currentRecommendation.value.forEach((element) {
      if(element.homeShopType!=null){
        if(element.shopType!='7' && element.shopType!='2') {

          if (i == 1) {
            shopType = int.parse(element.homeShopType);
            focusId = int.parse(element.id);
            i++;
          }}
      }
    });
      final Stream<ItemDetails> stream = await getFeatureProductList(focusId, shopType);
      stream.listen((ItemDetails _product) {
        setState(() => featuredData.add(_product));

      }, onError: (a) {
        print(a);
        // ignore: deprecated_member_use

      }, onDone: () {});

  }

  Future<void> listenForTopProduct(id) async {


    int i= 1;
    currentRecommendation.value.forEach((element) {
      if(element.homeShopType!=null){
        if(element.shopType!='7' && element.shopType!='2') {

          if (i == 1) {
            shopType = int.parse(element.homeShopType);
            i++;
          }}
      }
    });
    final Stream<ItemDetails> stream = await getTopVendorProduct(shopType);
    stream.listen((ItemDetails _list) {

      setState(() => itemData.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {

    });

  }


  Future<void> listenForFeaturedProduct(id) async {

    int i= 1;
    currentRecommendation.value.forEach((element) {
      if(element.homeShopType!=null){
        if(element.shopType!='7' && element.shopType!='2') {

          if (i == 1) {
            shopType = int.parse(element.homeShopType);

            i++;
          }}
      }
    });

    final Stream<ItemDetails> stream = await getFeatureProduct(shopType);
    stream.listen((ItemDetails _list) {

      setState(() => featuredData.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {

    });

  }





  Future<void> listenForDealOfDay(id) async {
    setState(() => shopTypeList.clear());
    currentSuperCategory = id;
    final Stream<ShopType> stream = await getShopType(id);
    stream.listen((ShopType _type) {
      if(currentSuperCategory==_type.shopType || id == 'first') {
        setState(() => shopTypeList.add(_type));
      }
    }, onError: (a) {}, onDone: () {});
  }

  Future<void> listenForMyRecommendation() async {
    setState(() => myRecommendationList.clear());
    final Stream<ShopType> stream = await getMyRecommendation();
    stream.listen((ShopType _type) {
      setState(() => myRecommendationList.add(_type));
    }, onError: (a) {}, onDone: () {
      currentUser.value.recommendation = 'load';
      setCurrentUserUpdate(currentUser.value);
      print(currentRecommendation.value.length);

      currentRecommendation.value = myRecommendationList;
      setCurrentRecommendationItem();
    });
  }




  Future<void> listenForShopCategories() async {
    final Stream<MainCategoryModel> stream = await getShopCategories();
    stream.listen((MainCategoryModel _type) {
      setState(() => mainShopCategories.add(_type));
    }, onError: (a) {}, onDone: () {
      if (currentUser.value.filterId == '' || currentUser.value.filterId == null) {
        mainShopCategories.forEach((element) {
          if (element.selected) {
            currentUser.value.filterId = element.id;
          }
        });
      }
    });
  }


  void getBusinessCard(id) async {

      repository.vendorBusinessCard(id).then((value) {
        setState(() => loader = true);
           setState(() =>businessCardData = value);

           print(businessCardData.preview);

      }).catchError((e) {

      }).whenComplete(() {

      });
    }

  openMap(latitude,longitude) async{
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    // ignore: deprecated_member_use
    if (await canLaunch(googleUrl)) {
      // ignore: deprecated_member_use
    await launch(googleUrl);
    } else {
    throw 'Could not open the map.';
    }
  }

  checkMyShopList(id){
    var res;
     if( currentUser.value.favoriteShop.length!=0) {

       currentUser.value.favoriteShop.forEach((element) {
         if (element == id) {
           res = 'yes';
         }
       });
     }
      if (res == 'yes') {
        return true;
      } else {
        return false;

    }
  }

  addToFavorite(id) async {

    if (currentUser.value.apiToken == null) {
      Navigator.of(context).pushReplacementNamed('/Login');
    } else {
      if (checkMyShopList(id) == false) {
        currentUser.value.favoriteShop.add(id);
        showToast(S.of(context).this_store_was_added_to_favorite, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);

      } else {
        currentUser.value.favoriteShop.remove(id);
        showToast(S.of(context).this_store_was_removed_to_favorite, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);

      }
      repository.addFavoriteShop().then((value) {});
      Navigator.pop(context);
    }

  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);

  }

/*
  Future<void> listenForCategories() async {
    final Stream<Category> stream = await getCategories();
    stream.listen((Category _category) {
      setState(() => categories.add(_category));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForShopType() async {
    final Stream<Category> stream = await getCategories();
    stream.listen((Category _category) {
      setState(() => categories.add(_category));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  } */



  // ignore: non_constant_identifier_names
  Future<void> listenForInter_sort_view() async {
    final Stream<InterSortView> stream = await getInterSort();
    stream.listen((InterSortView _interSort) {
      setState(() => interSortView.add(_interSort));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForExplore() async {
    final Stream<Explore> stream = await getExplore();
    stream.listen((Explore _interSort) {
      setState(() => exploreList.add(_interSort));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }


  listenForZone(){
    setState(() => middleSlides.clear());
    setState(() => slides.clear());
    setState(() => pageLoader = true,);

     getZoneId().then((value) {
          currentUser.value.zoneId = value;
          print(currentUser.value.zoneId);
          setCurrentUser(currentUser.value);
    }).catchError((e) {

    }).whenComplete(() {
       setState(() => pageLoader = false,);
       listenForVendor();
       listenForShopCategories();
       listenForSlides(1);
      listenForMiddleSlides(2);
       listenForFixedSlides(3);
       listenForTopProduct(2);
       listenForFeaturedProduct(2);
    });
  }


  recommendManage(id){
      currentRecommendation.value.forEach((element) {
         if(id==element.id){
           currentRecommendation.value.removeWhere((item) => item.id == id);
         }
      });
  }




  Future<void> refreshHome() async {
    setState(() {
      slides = <Slide>[];
    });
    await listenForSlides(1);
  }
}
