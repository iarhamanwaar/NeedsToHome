import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/helpers/custom_trace.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/models/checkout.dart';
import 'package:login_and_signup_web/src/models/driver_status.dart';
import 'package:login_and_signup_web/src/models/invoice.dart';
import 'package:login_and_signup_web/src/models/order_list.dart';
import 'package:login_and_signup_web/src/models/summary_report.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';


Future<Stream<OrderList>> getOrderList(String status) async {
 Uri uri = Helper.getUri('Api_vendor/Order/list/$status/null/${currentUser.value.id}');
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
      .map((data) => OrderList.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new OrderList.fromJSON({}));
 }
}



Future<Stream<OrderList>> getOrderTakeawayList(String status) async {
  Uri uri = Helper.getUri('Api_vendor/takeawayOrder/list/$status/null/${currentUser.value.id}');
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
        .map((data) => OrderList.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new OrderList.fromJSON({}));
  }
}


Future<Stream<OrderList>> getOrderListSearch(String status) async {
  Uri uri = Helper.getUri('Api_vendor/Order/search/null/$status/${currentUser.value.id}');
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
        .map((data) => OrderList.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new OrderList.fromJSON({}));
  }
}

// ignore: missing_return
Future<Stream<Map<String, dynamic>>> getInvoiceReport(id) async {
  Uri uri = Helper.getUri('Api_vendor/Order/invoiceList/null/null/$id/');
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
        .map((data) => data);
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
   // return new Stream.value(new PaymentReport.fromJSON({}));
  }
}


Future<InvoiceModel> getInvoice(orderID) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}Api_vendor/Order/invoicefull/$orderID/null/${currentUser.value.id}?$_apiToken';
  InvoiceModel res;
  final client = new http.Client();
  final response = await client.post(
      Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );


  if (response.statusCode == 200) {


      res = InvoiceModel.fromJSON(json.decode(response.body)['data']);

    return res;
  } else {
    throw new Exception(response.body);
  }
}


// ignore: missing_return
Future<Checkout> getInvoiceDetails(orderID) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}Api_vendor/Order/invoiceView/$orderID/null/${currentUser.value.id}?$_apiToken';

  Checkout res;
  try {
    final client = new http.Client();
    final response = await client.post(
        Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(''),
    );



    if (response.statusCode == 200) {

      res = Checkout.fromJSON(json.decode(response.body)['data']);

     // print(res.payment.toMap());
      return res;
    } else {
      throw new Exception(response.body);
    }
  } catch(e){
     print(e);
  }
}



// ignore: missing_return
Future<bool> orderStatusUpdate (orderID, status) async {

  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}Api_vendor/Order/statusUpdate/$orderID/$status/${currentUser.value.id}?$_apiToken';


  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );


  if (response.statusCode == 200) {
    bool res;


    res =  true;
    return res;
  } else {
    throw new Exception(response.body);
  }
}


// ignore: missing_return
Future<bool> updateAmount (orderID, amount) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}Api_vendor/Order/amountUpdate/$amount/$orderID/${currentUser.value.id}?$_apiToken';


  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );

print(url);
  if (response.statusCode == 200) {
    bool res;


    res =  true;
    return res;
  } else {

    throw new Exception(response.body);
  }
}


// ignore: missing_return
Future<DriverStatus> manualStatusUpdate (orderID, id) async {
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}Api_vendor/orderAssign/update/$id/$orderID';

  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );


  if (response.statusCode == 200) {

    return DriverStatus.fromJSON(json.decode(response.body)['data']);
  } else {
    throw new Exception(response.body);
  }
}



// ignore: missing_return
Future<DriverStatus> orderStatusUpdateStep2 (type, driverState, orderID) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}Api_vendor/orderAssign/$type/$driverState/$orderID/${currentUser.value.id}?$_apiToken';

  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );


  if (response.statusCode == 200) {


    return DriverStatus.fromJSON(json.decode(response.body)['data']);
  } else {
    throw new Exception(response.body);
  }
}




Future<Stream<DropDownModel>> getDriverData(type, driverState, orderID) async {

  Uri uri = Helper.getUri('Api_vendor/orderAssign/$type/$driverState/$orderID/${currentUser.value.id}');
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
        .map((data) => DropDownModel.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new DropDownModel.fromJSON({}));
  }
}

Future<SummaryReport> getSummaryReport(vendorID) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}Api_vendor/Order/summaryReport/null/null/$vendorID?$_apiToken';

  SummaryReport res;
  final client = new http.Client();
  final response = await client.post(
      Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );


  if (response.statusCode == 200) {


      res = SummaryReport.fromJSON(json.decode(response.body)['data']);

    return res;
  } else {
    throw new Exception(response.body);
  }
}







