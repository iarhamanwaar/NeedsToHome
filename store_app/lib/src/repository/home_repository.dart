import 'dart:convert';
import 'dart:io';
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/helpers/custom_trace.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/Order_tracking.dart';
import 'package:login_and_signup_web/src/models/bargraph.dart';
import 'package:login_and_signup_web/src/models/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:login_and_signup_web/src/models/topproducts.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';

Future<Stream<TopProduct>> getTopProducts(id) async {

  Uri uri = Helper.getUri('Api_vendor/dashboard/topproducts/${currentUser.value.id}/$id');
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
        .map((data) => TopProduct.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new TopProduct.fromJSON({}));
  }
}

Future<Dashboard> dashboardTopBar() async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api_vendor/dashboard/topbar/${currentUser.value.id}?$_apiToken';

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

Future<OrderTracking> getOrderDetailCount() async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api_vendor/dashboard/liveordertrack/${currentUser.value.id}?$_apiToken';

  final client = new http.Client();
  final response = await client.post(
      Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );

  if (response.statusCode == 200) {

    return  OrderTracking.fromJSON(json.decode(response.body)['data']);

  } else {
    throw new Exception(response.body);
  }

}

Future<int> getIntOrderDetailCount() async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api_vendor/dashboard/initialOrderCount/${currentUser.value.id}?$_apiToken';


  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );

  if (response.statusCode == 200) {

    return  json.decode(response.body)['data'];

  } else {
    throw new Exception(response.body);
  }

}

Future<Stream<BarGraphModel>> getBarGraph() async {

  Uri uri = Helper.getUri('Api_vendor/dashboard/bargraph/${currentUser.value.id}');
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
        .map((data) => BarGraphModel.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new BarGraphModel.fromJSON({}));
  }
}


Future<bool>  userLiveStatus(status) async {
  Uri uri = Helper.getUri('Api_vendor/dashboard/live_status/${currentUser.value.id}/$status');
  Map<String, dynamic> _queryParams = {};

  _queryParams['api_token'] = currentUser.value.apiToken;
  uri = uri.replace(queryParameters: _queryParams);
  final client = new http.Client();
  final response = await client.post(
    uri,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );


  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

getSingleValue(table, col1, para1, select) async {

  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api_vendor/getGlobalObject/$table/$col1/$para1/$select';

  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body)['data'];
  } else {
    throw new Exception(response.body);
  }


}

