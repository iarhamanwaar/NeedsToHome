import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:multisuperstore/src/models/address.dart';
import 'package:multisuperstore/src/models/coupon.dart';
import 'package:multisuperstore/src/models/explore_search.dart';
import 'package:multisuperstore/src/models/main_category.dart';
import 'package:multisuperstore/src/models/searchisresult.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_repository.dart';
import '../models/vendor.dart';
import '../models/trending.dart';
import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';
import '../models/slide.dart';
import '../models/category.dart';
import '../models/inter_sort.dart';

import '../models/shop_type.dart';

ValueNotifier<List<ShopType>> currentRecommendation = new ValueNotifier<List<ShopType>>(<ShopType>[]);
ValueNotifier<List<Address>> catchLocationList = new ValueNotifier<List<Address>>(<Address>[]);
Future<Stream<Slide>> getSlides(id) async {
  Uri uri = Helper.getUri('api/slider/$id');
   print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => Slide.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Slide.fromJSON({}));
  }
}

Future<Stream<Slide>> getVendorSlides(id) async {
  Uri uri = Helper.getUri('api/shopSetting/banner/$id');

  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => Slide.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Slide.fromJSON({}));
  }
}


// ignore: missing_return
Future<Stream<Category>> getCategories(shopId) async {
  Uri uri = Helper.getUri('api/categories/$shopId');


  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => Category.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  }
}

// ignore: missing_return
Future<Stream<CouponModel>> getCoupons(shopId) async {
  Uri uri = Helper.getUri('api/coupons/$shopId');

  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => CouponModel.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  }
}


// ignore: missing_return
Future<Stream<ShopType>> getShopType(id) async {

  Uri uri = Helper.getUri('api/shop_category/shoptype/$id');

  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return ShopType.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  }
}



// ignore: missing_return
Future<Stream<ShopType>> getMyRecommendation() async {

  Uri uri = Helper.getUri('api/my_recommendation/');


  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return ShopType.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  }
}
// ignore: missing_return
Future<Stream<Trending>> getTrending() async {
  Uri uri = Helper.getUri('api/trends');
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => Trending.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  }
}


// ignore: missing_return
Future<Stream<MainCategoryModel>> getShopCategories() async {
  Uri uri = Helper.getUri('api/shop_category/shopcategories');
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => MainCategoryModel.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  }
}

// ignore: missing_return
Future<Stream<InterSortView>> getInterSort() async {
  Uri uri = Helper.getUri('api/inter_sort_view');

  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => InterSortView.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  }
}

// ignore: missing_return
Future<Stream<Explore>> getExplore() async {
  Uri uri = Helper.getUri('api/explore');

  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => Explore.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  }
}





Future<String> getZoneId() async {
  // ignore: deprecated_member_use
  Uri uri = Helper.getUri('api/getZone/');
  Map<String, dynamic> _queryParams = {};
  String zone;
  _queryParams['myLat'] = currentUser.value.latitude.toString();
  _queryParams['myLon'] = currentUser.value.longitude.toString();
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);
  final client = new http.Client();
  final response = await client.post(
    uri,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: '',
  );

  //print(json.decode(response.body)['data']);
  if (response.statusCode == 200) {
      zone = json.decode(response.body)['data'];
  } else {
    throw new Exception(response.body);
  }

  return zone;
 // return currentUser.value;
}





Future<Stream<Vendor>>getTopVendorList() async {
  Uri uri = Helper.getUri('api/home_settings/topvendor');
  Map<String, dynamic> _queryParams = {};



  _queryParams['myLat'] = currentUser.value.latitude.toString();
  _queryParams['myLon'] = currentUser.value.longitude.toString();
  _queryParams['zone_id'] = currentUser.value.zoneId;
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => Vendor.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Vendor.fromJSON({}));
  }
}


Future<Stream<Vendor>>getTopVendorListSearch(searchTxt) async {
  Uri uri = Helper.getUri('api/shopSearch');
  Map<String, dynamic> _queryParams = {};



  _queryParams['myLat'] = currentUser.value.latitude.toString();
  _queryParams['myLon'] = currentUser.value.longitude.toString();
  _queryParams['search'] = searchTxt;
  uri = uri.replace(queryParameters: _queryParams);

  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => Vendor.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Vendor.fromJSON({}));
  }
}

// ignore: missing_return
Future<SearchISResult> getTopVendorItemListSearch(searchTxt,type, filterId,) async {

  // ignore: deprecated_member_use
  Uri uri = Helper.getUri('api/shopSearch/$filterId/$type');
  Map<String, dynamic> _queryParams = {};



  _queryParams['myLat'] = currentUser.value.latitude.toString();
  _queryParams['myLon'] = currentUser.value.longitude.toString();
  _queryParams['zone_id'] = currentUser.value.zoneId;
  _queryParams['search'] = searchTxt;
  uri = uri.replace(queryParameters: _queryParams);
  SearchISResult res;
  print(uri);
  try {
    final client = new http.Client();
    final response = await client.post(
      uri,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(''),
    );
    if (response.statusCode == 200) {

      res = SearchISResult.fromJSON(json.decode(response.body)['data']);

      // print(res.payment.toMap());
      return res;
    } else {
      throw new Exception(response.body);
    }
  } catch(e){
    print(e);
  }
}


Future<Stream<ItemDetails>> getTopVendorProduct(id) async {

  // ignore: deprecated_member_use
  Uri uri = Helper.getUri('api/topProducts/$id');
  Map<String, dynamic> _queryParams = {};



  _queryParams['myLat'] = currentUser.value.latitude.toString();
  _queryParams['myLon'] = currentUser.value.longitude.toString();
  _queryParams['zone_id'] = currentUser.value.zoneId;
  uri = uri.replace(queryParameters: _queryParams);
  ItemDetails res;
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => ItemDetails.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new ItemDetails.fromJSON({}));
}}


Future<Stream<ItemDetails>> getFeatureProduct(id) async {

  // ignore: deprecated_member_use
  Uri uri = Helper.getUri('api/featuredProducts/$id');
  Map<String, dynamic> _queryParams = {};



  _queryParams['myLat'] = currentUser.value.latitude.toString();
  _queryParams['myLon'] = currentUser.value.longitude.toString();
  _queryParams['zone_id'] = currentUser.value.zoneId;
  uri = uri.replace(queryParameters: _queryParams);
  ItemDetails res;
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => ItemDetails.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new ItemDetails.fromJSON({}));
  }}


void setCurrentRecommendationItem() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('current_recommendation', json.encode(currentRecommendation.value));

}


Future<List<ShopType>> getCurrentRecommendation() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  currentRecommendation.value = List.from(json.decode(prefs.get('current_recommendation'))).map((element) => ShopType.fromJSON(element)).toList();

  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  currentRecommendation.notifyListeners();
  return currentRecommendation.value;
}

void setCatchLocationList() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(
        'catchLocationList', json.encode(catchLocationList.value));
  } catch(e){
    print('location store error');
     print(e);
  }
}

Future<List<Address>> getCatchLocationList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  catchLocationList.value = List.from(json.decode(prefs.get('catchLocationList'))).map((element) => Address.fromJSON(element)).toList();

  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  catchLocationList.notifyListeners();
  return catchLocationList.value;
}

Future<Stream<ItemDetails>> getFeatureProductList(focusId, shopType) async {

  Uri uri = Helper.getUri('api/featuredProductAll/$focusId/$shopType');
  Map<String, dynamic> _queryParams = {};


  _queryParams['myLat'] = currentUser.value.latitude.toString();
  _queryParams['myLon'] = currentUser.value.longitude.toString();
  _queryParams['zone_id'] = currentUser.value.zoneId;
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) =>  Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => ItemDetails.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new ItemDetails.fromJSON({}));
  }
}