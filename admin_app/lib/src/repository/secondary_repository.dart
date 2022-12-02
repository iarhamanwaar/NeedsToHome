import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/helpers/custom_trace.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/car_model.dart';
import 'package:login_and_signup_web/src/models/cashonhand.dart';
import 'package:login_and_signup_web/src/models/cinHistoryModel.dart';
import 'package:login_and_signup_web/src/models/coupon.dart';
import 'package:login_and_signup_web/src/models/currency.dart';
import 'package:login_and_signup_web/src/models/banner.dart';
import 'package:login_and_signup_web/src/models/delivery_Fees.dart';
import 'package:login_and_signup_web/src/models/delivery_Tips.dart';
import 'package:login_and_signup_web/src/models/drecommendation.dart';
import 'package:login_and_signup_web/src/models/driver_details.dart';
import 'package:login_and_signup_web/src/models/itemdelivery.dart';
import 'package:login_and_signup_web/src/models/policymodeel.dart';
import 'package:login_and_signup_web/src/models/provider.dart';
import 'package:login_and_signup_web/src/models/pushnotification.dart';
import 'package:login_and_signup_web/src/models/shop_type.dart';
import 'package:login_and_signup_web/src/models/shopratingmodel.dart';
import 'package:login_and_signup_web/src/models/staff.dart';
import 'package:login_and_signup_web/src/models/taxmodel.dart';
import 'package:login_and_signup_web/src/models/timezone.dart';
import 'package:login_and_signup_web/src/models/user.dart';
import 'package:login_and_signup_web/src/models/vendor_bussinesscard.dart';
import 'package:login_and_signup_web/src/models/vendor_membership.dart';
import 'package:login_and_signup_web/src/models/vendorwallet.dart';
import 'package:login_and_signup_web/src/models/version_control.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Alignment,Row;
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';

import '../models/excel_export.dart';

 addBannerData(BannerModel itemData, id,type) async {
User _user = currentUser.value;

 final String _apiToken = 'api_token=${_user.apiToken}';
  // ignore: deprecated_member_use
  final uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/banner/$type/${currentUser.value.id}/$id/${currentUser.value.id}?$_apiToken");


  try {

   var request = http.MultipartRequest('POST', uri);
   if( itemData.uploadImage!=null) {
    Uint8List data = await itemData.uploadImage.readAsBytes();
    List<int> list = data.cast();

    var pic = http.MultipartFile.fromBytes('image', list, filename: 'myFile.png');
    request.files.add(pic);
   }

   request.fields['title'] = itemData.title;
   request.fields['para'] = itemData.para;
   request.fields['type'] = itemData.type;
   request.fields['redirect_type'] = itemData.redirectType;
   request.fields['shopType'] = itemData.shopType;

   var response = await request.send();

   if (response.statusCode == 200) {
    response.stream.bytesToString().asStream().listen((event) {

     //It's done...
    });
   } else {}
  }catch (e) {

   print(e);

  }
}

Future<Stream<ShopRatingModel>> getReview(id) async {
 Uri uri = Helper.getUri('Api_admin/review/list/$id');

 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);
 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => ShopRatingModel.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new ShopRatingModel.fromJSON({}));
 }
}

adddreccomendation(DRecommendation itemData,type) async {
 User _user = currentUser.value;

 final String _apiToken = 'api_token=${_user.apiToken}';
 // ignore: deprecated_member_use
 final uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/drecommendation/$type/${currentUser.value.id}?$_apiToken");


 try {

  var request = http.MultipartRequest('POST', uri);
  request.fields['superID'] = itemData.superId;
  request.fields['shopTypeId'] = itemData.shopTypeId;
  //request.fields['focusTypeId'] = itemData.focusTypeId;
  var response = await request.send();
  if (response.statusCode == 200) {
   response.stream.bytesToString().asStream().listen((event) {

    //It's done...
   });
  } else {}
 }catch (e) {

  print(e);

 }
}
Future<Stream<CashOnHandModel>> getCashOnHAnd(type) async {
 Uri uri = Helper.getUri('Api_admin/cashonhand/$type/${currentUser.value.id}');

 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);
 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => CashOnHandModel.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new CashOnHandModel.fromJSON({}));
 }
}
addcinhistory(CashOnHandModel cashOnHandModel,type) async {
 User _user = currentUser.value;

 final String _apiToken = 'api_token=${_user.apiToken}';
 // ignore: deprecated_member_use
 final uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/collectcash/$type/${cashOnHandModel.id}/${currentUser.value.id}?$_apiToken");


 try {

  var request = http.MultipartRequest('POST', uri);
  request.fields['amount'] = cashOnHandModel.amount;
  var response = await request.send();
  if (response.statusCode == 200) {
   response.stream.bytesToString().asStream().listen((event) {


    print(response.statusCode);
    //It's done...
   });
  } else {}
 }catch (e) {

  print(e);

 }
}
Future<Stream<VendorWallet>> getVendorWallet(String type,id) async {
 Uri uri = Helper.getUri('Api_admin/VendorWallet/vendorlist/$type/$id');

 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);
 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => VendorWallet.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new VendorWallet.fromJSON({}));
 }
}
Future<Stream<Coupon>> getCouponList() async {
 Uri uri =Helper.getUri('Api_admin/coupon/list/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};
 _queryParams['api_token'] = currentUser.value.apiToken;
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
      .map((data) => Coupon.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new Coupon.fromJSON({}));
 }
}

Future<Stream<VersionControl>> getVersionList() async {
 Uri uri =Helper.getUri('Api_admin/version_control/list/${currentUser.value.id}');

 Map<String, dynamic> _queryParams = {};
 _queryParams['api_token'] = currentUser.value.apiToken;
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
      .map((data) => VersionControl.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new VersionControl.fromJSON({}));
 }
}


Future<Stream<CinHistoryModel>> getCINHistory() async {
 Uri uri = Helper.getUri('Api_admin/cinhistory/${currentUser.value.id}');

 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);
 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => CinHistoryModel.fromJson(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new CinHistoryModel.fromJson({}));
 }
}
Future<Stream<DRecommendation>> getDrec() async {
 Uri uri = Helper.getUri('Api_admin/drecommendation/list/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);

 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => DRecommendation.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new DRecommendation.fromJSON({}));
 }
}

Future<Stream<BannerModel>> getBanner(id) async {
 Uri uri = Helper.getUri('Api_admin/banner/list/$id/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);

 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => BannerModel.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new BannerModel.fromJSON({}));
 }
}








statusUpdate(table,id,select,value ) async {
 final String _apiToken = 'api_token=${currentUser.value.apiToken}';
 // ignore: deprecated_member_use
 final String url = '${GlobalConfiguration().getString('api_base_url')}api_admin/singleStatus/$table/$id/$select/$value?$_apiToken';

 bool res;
 final client = new http.Client();
 await client.post(
  Uri.parse(url),
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(''),
 );


 return res;
}

statusMemberUpdate(vendor, planId, ) async {
 final String _apiToken = 'api_token=${currentUser.value.apiToken}';
 // ignore: deprecated_member_use
 final String url = '${GlobalConfiguration().getString('api_base_url')}api_admin/statusMemberUpdate/$vendor/$planId/?$_apiToken';
 bool res;
 final client = new http.Client();
 await client.post(
  Uri.parse(url),
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(''),
 );


 return res;
}




addPaymentStatusUpdate(type,invoiceId, id) async {
 final String _apiToken = 'api_token=${currentUser.value.apiToken}';
 // ignore: deprecated_member_use
 final String url = '${GlobalConfiguration().getString('api_base_url')}api_admin/paymentstatusupdate/$type/$invoiceId/${currentUser.value.id}/$id?$_apiToken';
 bool res;
 final client = new http.Client();
 final response = await client.post(
  Uri.parse(url),
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(''),
 );

 if (response.statusCode == 200) {
  // setCurrentUser(response.body);
  // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  if (json.decode(response.body)['data'] == 'success') {
   res = true;
  } else {
   res = false;
  }
 } else {
  throw new Exception(response.body);
 }
 return res;
}

Future<VendorBusinessCard> vendorBusinessCard(id) async {
 // ignore: deprecated_member_use
 final String url = '${GlobalConfiguration().getString('api_base_url')}api/bussinessCard/$id';
 VendorBusinessCard res;
 final client = new http.Client();
 final response = await client.post(
  Uri.parse(url),
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(''),
 );



 if (response.statusCode == 200) {

  res = VendorBusinessCard.fromJSON(json.decode(response.body)['data']);


 } else {
  throw new Exception(response.body);
 }
 return res;
}
Future<Stream<VendorWallet>> getWallet(String type) async {
 Uri uri = Helper.getUri('Api_admin/VendorWallet/list/$type/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);
 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => VendorWallet.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new VendorWallet.fromJSON({}));
 }
}

addCategory(Currency currentData, paraType, id) async {
 // User _user = userRepo.currentUser.value;

 //final String _apiToken = 'api_token=${_user.apiToken}';
 // ignore: deprecated_member_use
 final uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/currency/$paraType/$id");


 try {

  var request = http.MultipartRequest('POST', uri);

  if( currentData.uploadImage!=null && currentData.uploadImage!='no_edit') {
   Uint8List data = await currentData.uploadImage.readAsBytes();
   List<int> list = data.cast();

   var pic = http.MultipartFile.fromBytes('image', list, filename: 'myFile.png');
   request.files.add(pic);
  }
  request.fields['currencyName'] = currentData.currencyName;
  request.fields['currencySymbol'] = currentData.currencySymbol;
  request.fields['country'] = currentData.country;

  var response = await request.send();

  if (response.statusCode == 200) {
   response.stream.bytesToString().asStream().listen((event) {

    //It's done...
   });
  } else {}
 }catch (e) {

  print(e);

 }
}


editVersion(VersionControl currentData, paraType, id) async {
  User _user = currentUser.value;
 final String _apiToken = 'api_token=${_user.apiToken}';
 // ignore: deprecated_member_use
 final uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/version_control/$paraType/${currentUser.value.id}/$id/?$_apiToken");


 try {

  var request = http.MultipartRequest('POST', uri);


  request.fields['appName'] = currentData.appName;
  request.fields['version'] = currentData.version;
  request.fields['appLink'] = currentData.appLink;

  var response = await request.send();

  if (response.statusCode == 200) {
   response.stream.bytesToString().asStream().listen((event) {

    //It's done...
   });
  } else {}
 }catch (e) {

  print(e);

 }
}

sendNotification(PushNotificationModel currentData) async {
 User _user = currentUser.value;

final String _apiToken = 'api_token=${_user.apiToken}';
 //ignore: deprecated_member_use
 final uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/pushNotification/do_add/${currentUser.value.id}?$_apiToken");


 try {

  var request = http.MultipartRequest('POST', uri);

  if( currentData.uploadImage!=null) {
   Uint8List data = await currentData.uploadImage.readAsBytes();
   List<int> list = data.cast();

   var pic = http.MultipartFile.fromBytes('image', list, filename: 'myFile.png');
   request.files.add(pic);
  }


  var response = await request.send();

  if (response.statusCode == 200) {
   response.stream.bytesToString().asStream().listen((event) {

    //It's done...
   });
  } else {}
 }catch (e) {

  print(e);

 }
}

addECoupon(Coupon itemData,  pageType, id) async {
 User _user = currentUser.value;

 final String _apiToken = 'api_token=${_user.apiToken}';
 // ignore: deprecated_member_use
 final uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/Coupon/$pageType/$id/${currentUser.value.id}?$_apiToken");


 try {

  var request = http.MultipartRequest('POST', uri);

  if( itemData.image!=null && itemData.image!='no_change') {
   Uint8List data = await itemData.image.readAsBytes();
   List<int> list = data.cast();
   var pic = http.MultipartFile.fromBytes('image', list, filename: 'myFile.png');
   request.files.add(pic);
  }
  request.fields['title'] = itemData.title;
  request.fields['couponType'] = itemData.couponType;
  request.fields['code'] = itemData.code;
  request.fields['zone'] = itemData.zone;
  if( itemData.shopId!=null) {
   request.fields['shopId'] = itemData.shopId;
  }
  if( itemData.discountType!=null) {
   request.fields['discountType'] = itemData.discountType;
  }
  if( itemData.discount!=null) {
   request.fields['discount'] = itemData.discount;
  }

  request.fields['terms'] = itemData.terms;
  request.fields['minimumPurchasedAmount'] = itemData.minimumPurchasedAmount;
  if(request.fields['couponType']=='3') {
   request.fields['limitUser'] = '1';
  } else {
   request.fields['limitUser'] = itemData.limit;
  }
  request.fields['startDate'] = itemData.startDate;
  request.fields['endDate'] = itemData.endDate;
  request.fields['maximumLimit'] = itemData.maximumLimit;
  var response = await request.send();
 print(uri);
  if (response.statusCode == 200) {
   response.stream.bytesToString().asStream().listen((event) {

    //It's done...
   });
  } else {}
 }catch (e) {

  print(e);

 }
}



addEdFocusShopType(ShopTypeModel itemData,  pageType, id) async {
   User _user = currentUser.value;

   final String _apiToken = 'api_token=${_user.apiToken}';
 // ignore: deprecated_member_use
 final uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/shopFocusType/$pageType/$id/${currentUser.value.id}?$_apiToken");
 try {

  var request = http.MultipartRequest('POST', uri);

  if( itemData.previewImage!=null && itemData.previewImage!='no_change') {
   Uint8List data = await itemData.previewImage.readAsBytes();
   List<int> list = data.cast();

   var pic = http.MultipartFile.fromBytes('previewImage', list, filename: 'myFile.png');
   request.files.add(pic);
  }

  if( itemData.coverImage!=null && itemData.coverImage!='no_change') {
   Uint8List data = await itemData.coverImage.readAsBytes();
   List<int> list = data.cast();

   var pic = http.MultipartFile.fromBytes('coverImage', list, filename: 'myFile.png');
   request.files.add(pic);
  }

  request.fields['title'] = itemData.focusTypeName;
  request.fields['color_code'] = itemData.colorCode;
  request.fields['commission'] = '0';
  request.fields['shop_type'] = itemData.shopTypeId;
  request.fields['superCategory'] = itemData.superCategory;
  var response = await request.send();

  if (response.statusCode == 200) {
   response.stream.bytesToString().asStream().listen((event) {

    //It's done...
   });
  } else {}
 }catch (e) {

  print(e);

 }
}



Future<Stream<ShopTypeModel>> getShopTypeList() async {
 Uri uri = Helper.getUri('Api_admin/shopFocusType/list/no/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);
 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => ShopTypeModel.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new ShopTypeModel.fromJSON({}));
 }
}

aECarType(CarTypeModel carTypeData, paraType, id) async {

 // ignore: deprecated_member_use
 Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/CarType/$paraType/$id/${currentUser.value.id}");
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);
 try {

  var request = http.MultipartRequest('POST', uri);

  if( carTypeData.uploadImage!=null && carTypeData.uploadImage!='no_change') {
   Uint8List data = await carTypeData.uploadImage.readAsBytes();
   List<int> list = data.cast();
   //print(.categoryName);
   var pic = http.MultipartFile.fromBytes('image', list, filename: 'myFile.png');
   request.files.add(pic);
  }
  request.fields['carType'] = carTypeData.cartype;
  request.fields['baseFare'] = carTypeData.basefare;
  request.fields['minimumFare'] = carTypeData.minimumfare;
  request.fields['distance'] = carTypeData.distancekm;
  request.fields['rightMinute'] = carTypeData.rightminute;
  request.fields['convenienceFees'] = carTypeData.conveniencefees;
  request.fields['cancelationFees'] = carTypeData.cancelationfees;
  //request.fields['admin'] = currentUser.value.id;

  var response = await request.send();

  if (response.statusCode == 200) {
   response.stream.bytesToString().asStream().listen((event) {

    //It's done...
   });
  } else {}
 }catch (e) {

  print(e);

 }
}

Future<Stream<Currency>> getCurrency() async {
 Uri uri = Helper.getUri('Api_admin/currency/list/no/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);
 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => Currency.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new Currency.fromJSON({}));
 }
}




Future<Stream<CarTypeModel>> getCarType() async {
 Uri uri = Helper.getUri('Api_admin/CarType/list/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);

 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => CarTypeModel.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new CarTypeModel.fromJSON({}));
 }
}
Future<bool> vendorDelete(  id) async {

 // ignore: deprecated_member_use
 final String url = '${GlobalConfiguration().getString('api_base_url')}api_admin/vendorDelete/$id';
 bool res;
 final client = new http.Client();
 final response = await client.post(
  Uri.parse(url),
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(''),
 );

 if (response.statusCode == 200) {
  // setCurrentUser(response.body);
  // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  if (json.decode(response.body)['data'] == 'success') {
   res = true;
  } else {
   res = false;
  }
 } else {
  throw new Exception(response.body);
 }
 return res;
}

Future<bool> globalDelete(String table,  id) async {

 // ignore: deprecated_member_use
 final String url = '${GlobalConfiguration().getString('api_base_url')}api_admin/globalDelete/$table/$id';
 bool res;
 final client = new http.Client();
 final response = await client.post(
  Uri.parse(url),
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(''),
 );

 if (response.statusCode == 200) {
  // setCurrentUser(response.body);
  // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  if (json.decode(response.body)['data'] == 'success') {
   res = true;
  } else {
   res = false;
  }
 } else {
  throw new Exception(response.body);
 }
 return res;
}



addEdDeliveryFees(DeliveryFees itemData,  pageType, id) async {
 User _user =currentUser.value;

 final String _apiToken = 'api_token=${_user.apiToken}';
 // ignore: deprecated_member_use
 final url = "${GlobalConfiguration().getString('base_url')}Api_admin/deliveryFees/$pageType/$id/${currentUser.value.id}?$_apiToken";




 bool res;
 final client = new http.Client();
 final response = await client.post(
  Uri.parse(url),
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(itemData.toMap()),
 );

 if (response.statusCode == 200) {

  if (json.decode(response.body)['success'] == 'true') {
   res = true;
  } else {
   res = false;
  }
 } else {
  throw new Exception(response.body);
 }
 return res;


}

Future<Stream<DeliveryFees>>getDeliveryFees() async {
 Uri uri = Helper.getUri('Api_admin/deliveryFees/list/no/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);
 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => DeliveryFees.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new DeliveryFees.fromJSON({}));
 }
}

addEdDeliveryTips(DeliveryTipsModel itemData,id,pageType) async {
   User _user = currentUser.value;

  final String _apiToken = 'api_token=${_user.apiToken}';
 // ignore: deprecated_member_use
 final url = "${GlobalConfiguration().getString('base_url')}Api_admin/deliveryTips/$pageType/$id/${currentUser.value.id}?$_apiToken";



 bool res;
 final client = new http.Client();
 final response = await client.post(
  Uri.parse(url),
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(itemData.toMap()),
 );

 if (response.statusCode == 200) {
  // setCurrentUser(response.body);
  // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  if (json.decode(response.body)['success'] == 'true') {
   res = true;
  } else {
   res = false;
  }
 } else {
  throw new Exception(response.body);
 }
 return res;


}


Future<Stream<DeliveryTipsModel>>getDeliveryTips() async {
 Uri uri = Helper.getUri('Api_admin/deliveryTips/list/no/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);

 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => DeliveryTipsModel.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new DeliveryTipsModel.fromJSON({}));
 }
}

Future<DriverDetailsModel> getDriverDetailsData(id) async {

 Uri uri = Helper.getUri('Api_admin/driverDetails/do_add/$id/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);

 DriverDetailsModel res;
 final client = new http.Client();
 final response = await client.post(
  uri,
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(''),
 );


 if (response.statusCode == 200) {

  if (response.statusCode == 200) {

   res = DriverDetailsModel.fromJSON(json.decode(response.body)['data']);
  } else {
   throw new Exception(response.body);
  }

  return res;
 } else {
  throw new Exception(response.body);
 }
}




Future<Stream<PolicyModel>> getPolicy() async {
 Uri uri = Helper.getUri('Api_admin/Policy/list/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);

 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => PolicyModel.fromJSON(data));
 } catch (e) {

  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new PolicyModel.fromJSON({}));
 }
}

Future<Stream<TimeZone>> getTimeZone() async {

 String url = '${GlobalConfiguration().getValue('api_base_url')}Api_admin/timezone';
 Uri uri=Uri.parse(url);
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);

 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => TimeZone.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new TimeZone.fromJSON({}));
 }
}

aEPolicy(PolicyModel policyData, paraType, id) async {
 // ignore: deprecated_member_use
 Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/Policy/$paraType/$id/${currentUser.value.id}");

 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);
 try {

  var request = http.MultipartRequest('POST', uri);
  request.fields['value'] = policyData.value;
  //request.fields['admin'] = currentUser.value.id;

  var response = await request.send();

  if (response.statusCode == 200) {
   response.stream.bytesToString().asStream().listen((event) {

    //It's done...
   });
  } else {}
 }catch (e) {

  print(e);

 }
}



aEStaff(StaffModel staffData, paraType, id) async {
 // ignore: deprecated_member_use
 Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/Staff/$paraType/$id/${currentUser.value.id}");
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);
 try {

  var request = http.MultipartRequest('POST', uri);

  if( staffData.uploadImage!=null && staffData.uploadImage!='no_change') {
   Uint8List data = await staffData.uploadImage.readAsBytes();
   List<int> list = data.cast();
   //print(.categoryName);
   var pic = http.MultipartFile.fromBytes('image', list, filename: 'myFile.png');
   request.files.add(pic);
  }
  request.fields['name'] = staffData.name;
  request.fields['phone'] = staffData.phone;
  request.fields['address'] = staffData.address;
  request.fields['email'] = staffData.email;
  request.fields['password'] = staffData.password;
  request.fields['role'] = staffData.role;
  //request.fields['admin'] = currentUser.value.id;

  var response = await request.send();

  if (response.statusCode == 200) {
   response.stream.bytesToString().asStream().listen((event) {
    var parsedJson = json.decode(event);
    print(parsedJson);
    print(response.statusCode);
    //It's done...
   });
  } else {}
 }catch (e) {

  print(e);

 }
}

Future<Stream<TaxModel>> getTax() async {
 Uri uri = Helper.getUri('Api_admin/Tax/list/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);

 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => TaxModel.fromJSON(data));
 } catch (e) {
  print(e);
  print('repository error');
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new TaxModel.fromJSON({}));
 }
}

aETax(TaxModel staffData, paraType, id) async {
 // ignore: deprecated_member_use
 Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/Tax/$paraType/$id/${currentUser.value.id}");

 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);
 try {

  var request = http.MultipartRequest('POST', uri);
  request.fields['tax'] = staffData.tax;
  //request.fields['admin'] = currentUser.value.id;

  var response = await request.send();

  if (response.statusCode == 200) {
   response.stream.bytesToString().asStream().listen((event) {

    //It's done...
   });
  } else {}
 }catch (e) {

  print(e);

 }
}


Future<Stream<VendorMembershipModel>> getMemberPlanList() async {
 Uri uri = Helper.getUri(
     'Api_admin/VendorMembership/list/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);

 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => VendorMembershipModel.fromJSON(data));
 } catch (e) {
  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new VendorMembershipModel.fromJSON({}));
 }
}

aEVendorMembership(VendorMembershipModel vendorMembershipdata, paraType, id) async {

 // ignore: deprecated_member_use
 Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/VendorMembership/$paraType/$id/${currentUser.value.id}");
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);
 try {

  var request = http.MultipartRequest('POST', uri);

  if( vendorMembershipdata.uploadImage!=null && vendorMembershipdata.uploadImage!='no_change') {
   Uint8List data = await vendorMembershipdata.uploadImage.readAsBytes();
   List<int> list = data.cast();
   //print(.categoryName);
   var pic = http.MultipartFile.fromBytes('image', list, filename: 'myFile.png');
   request.files.add(pic);
  }
  request.fields['planname'] = vendorMembershipdata.planname;
  request.fields['price'] = vendorMembershipdata.price;
  request.fields['commission'] = vendorMembershipdata.commission;
  request.fields['productlimit'] = vendorMembershipdata.productlimit;
  request.fields['validity'] = vendorMembershipdata.validity;
  request.fields['shoptype'] = vendorMembershipdata.shoptype;
  request.fields['admin'] = currentUser.value.id;

  var response = await request.send();

  if (response.statusCode == 200) {
   response.stream.bytesToString().asStream().listen((event) {

    //It's done...
   });
  } else {}
 }catch (e) {

  print(e);

 }
}
Future<Stream<ItemDeliveryModel>> getItemDelivery() async {
 Uri uri = Helper.getUri('Api_admin/ItemDeliverBooking/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);

 try {
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => ItemDeliveryModel.fromJson(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new ItemDeliveryModel.fromJson({}));
 }
}

addwalletStatusUpdate(type,invoiceId, id,amount,usertype) async {
 final String _apiToken = 'api_token=${currentUser.value.apiToken}';
 // ignore: deprecated_member_use
 final String url = '${GlobalConfiguration().getString(
     'api_base_url')}api_admin/walletstatusupdate/$type/$invoiceId/$usertype/$id/$amount?$_apiToken';
 final client = new http.Client();
 await client.post(
  Uri.parse(url),
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(''),
 );
}

Future<void> createExcel(List<ExcelExportModel> listExcel,List  _listData, filename) async {


 final Workbook workbook = Workbook();
 final Worksheet sheet = workbook.worksheets[0];

 var schema = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
 Style globalStyle = workbook.styles.add('style');

 for (var i = 0; i < listExcel.length; i++) {
  sheet.getRangeByName('${schema[i]}1').columnWidth = listExcel[i].columnWidth;
  globalStyle.bold = listExcel[i].bold;
  sheet.getRangeByName('${schema[i]}1').cellStyle = globalStyle;
  sheet.getRangeByName('${schema[i]}1').setText(listExcel[i].title);
 }


 int inc= 2;
 for (var j = 0; j < _listData.length; j++) {
  for (var i = 0; i < listExcel.length; i++) {
   sheet.getRangeByName('${schema[i]}$inc').setText(_listData[j][i]);

  }

  inc++;
 }

 final List<int> bytes = workbook.saveAsStream();
 workbook.dispose();

 if (kIsWeb) {
  AnchorElement(
      href:
      'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
   ..setAttribute('download', '$filename.xlsx')
   ..click();
 } else {
  print(filename);
  final String path = (await getApplicationSupportDirectory()).path;
  final String fileName =
  Platform.isWindows ? '$path\\$filename.xlsx' : '$path/$filename.xlsx';
  final File file = File(fileName);
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open(fileName);
 }
}