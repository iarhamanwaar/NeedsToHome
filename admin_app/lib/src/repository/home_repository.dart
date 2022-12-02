import 'dart:convert';
import 'dart:io';
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/helpers/custom_trace.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/bargraph1.dart';
import 'package:login_and_signup_web/src/models/dashboard.dart';
import 'package:login_and_signup_web/src/models/dashboard_counter.dart';
import 'package:http/http.dart' as http;
import 'package:login_and_signup_web/src/models/top_vendor.dart';
import 'package:login_and_signup_web/src/models/topproduct.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';



Future<Dashboard> dashboardTopBar() async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api_admin/dashboard/topbar/${currentUser.value.id}?$_apiToken';


  final client = new http.Client();
  final response = await client.post(
      Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );

  if (response.statusCode == 200) {
      

      return  Dashboard.fromJSON(json.decode(response.body)['data']);

  } else {
    throw new Exception(response.body);
  }

}


Future<Stream<TopProduct>> getTopProducts() async {

  Uri uri = Helper.getUri('Api_admin/dashboard/topproducts/${currentUser.value.id}');
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
        .map((data) => TopProduct.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new TopProduct.fromJSON({}));
  }
}


Future<Stream<BarGraph1Model>> getBarGraph() async {

  Uri uri = Helper.getUri('Api_admin/dashboard/bargraph1/${currentUser.value.id}');
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
        .map((data) => BarGraph1Model.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new BarGraph1Model.fromJSON({}));
  }
}


Future<Stream<DashboardCounter>> getDashboardCounter() async {

  Uri uri = Helper.getUri('Api_admin/dashboard/dashboardcounter/${currentUser.value.id}');
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
        .map((data) => DashboardCounter.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new DashboardCounter.fromJSON({}));
  }
}


Future<Stream<TopVendor>> getTopVendor() async {

  Uri uri = Helper.getUri('Api_admin/dashboard/topVendors/${currentUser.value.id}');
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
        .map((data) => TopVendor.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new TopVendor.fromJSON({}));
  }
}






