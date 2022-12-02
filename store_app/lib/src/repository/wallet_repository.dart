import 'dart:convert';
import 'dart:io';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:login_and_signup_web/src/models/vendorwallet.dart';
import 'package:login_and_signup_web/src/models/walletmodel.dart';
import '../models/recharge.dart';
import 'user_repository.dart';
import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';

/*
Future<Stream<WalletTransactions>> getTransaction(type) async {
  Uri uri = Helper.getUri('api/wallet/list/${currentUser.value.id}/$type');
 print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => WalletTransactions.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new WalletTransactions.fromJSON({}));
  }
}
 */


Future<WalletModel> getWalletBanner() async {
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString(
      'api_base_url')}api_vendor/walletSystem/banner/${currentUser.value.id}';



  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );

  if (response.statusCode == 200) {

    return  WalletModel.fromJSON(json.decode(response.body)['data']);
  } else {
    throw new Exception(response.body);
  }


}



// ignore: non_constant_identifier_names
Future<bool> SendRecharge(Recharge data) async {
  data.status = 'waiting';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api/recharge';

  bool res;
  final client = new http.Client();
  final response = await client.post(
      Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(data.toMap()),
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

Future<Stream<VendorWallet>> getWallet() async {
  Uri uri = Helper.getUri('Api_vendor/VendorWallet/list/${currentUser.value.id}');
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

sendRequestAmount(amount) async {
  // ignore: deprecated_member_use
  Uri uri = Uri.parse("${GlobalConfiguration().getString('api_base_url')}api_vendor/VendorWallet/add/${currentUser.value.id}");
  // ignore: deprecated_member_use

  try {
    var request = http.MultipartRequest('POST', uri);


    request.fields['amount'] = amount;
    var response = await request.send();
    if (response.statusCode == 200) {
      response.stream.bytesToString().asStream().listen((event) {

        //It's done...
      });
    } else {}
  } catch (e) {

  }
}
