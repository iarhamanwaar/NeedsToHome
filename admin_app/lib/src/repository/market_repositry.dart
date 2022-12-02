import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_and_signup_web/src/models/vendormodel.dart';
import 'package:login_and_signup_web/src/models/vendorshoptype.dart';
import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';
import '../models/address.dart';
import '../repository/user_repository.dart';



Future<Stream<Vendor>> getVendorList() async {
  Uri uri = Helper.getUri('Api_admin/vendor/maplist/null/${currentUser.value.id}');
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
        .map((data) => Vendor.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Vendor.fromJSON({}));
  }
}
Future<Stream<Vendor>> getNearMarkets(Address myLocation, Address areaLocation, id) async {
  Uri uri = Helper.getUri('api/home_settings/topvendor/$id');
  Map<String, dynamic> _queryParams = {};

  //_queryParams['myLon'] = currentUser.value.longitude.toString();
  //_queryParams['myLat'] =  currentUser.value.latitude.toString();


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






Future<Stream<VendorShopType>> getShopType() async {

  Uri uri = Helper.getUri('api/home_settings/shoptype');


  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', uri));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) {
    return VendorShopType.fromJSON(data);
  });

}


