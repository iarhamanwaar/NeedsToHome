import 'dart:convert';
import 'dart:io';
import '/src/helpers/custom_trace.dart';
import '/src/models/bookingmodel.dart';
import '/src/models/paymentdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import '../helpers/helper.dart';
import '../models/order_status.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as userRepo;

ValueNotifier<PaymentDetails> currentPayment = new ValueNotifier(PaymentDetails());
ValueNotifier<Bookingmodel> currentBookView = new ValueNotifier(Bookingmodel());




Future<Stream<Bookingmodel>> getOrdersdetails(String bookid) async {


  //final String url = '${GlobalConfiguration().getString('api_base_url')}api/order/list/${bookid}';
  final String url = 'http://192.168.1.8/jps_masteradmin/index.php/Api_provider/order/list/$bookid';
  print(url);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return Bookingmodel.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new Bookingmodel.fromJSON({}));
  }
}

Future<bool> paymentData(int i) async {
  PaymentDetails _payment = currentPayment.value;

  final String url = '${GlobalConfiguration().getValue('base_url')}api_provider/bookingstatus/update';
  print(_payment.toMap());
  print(url);
  final client = new http.Client();
  final response = await client.put(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(_payment.toMap()),
  );
  print(url);
  if (response.statusCode == 200) {
    return true;
  } else {
    throw new Exception(response.body);
  }
}

Future<bool> statusUpdate(status, date, id) async {
  print(id);
  var statusManage = {'status': status, 'time': date, 'bookId': id};

  final String url = '${GlobalConfiguration().getValue('base_url')}api_provider/statusUpdate/update';

  print(url);
  final client = new http.Client();
  final response = await client.put(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(statusManage),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    throw new Exception(response.body);
  }
}




Future<Stream<OrderStatus>> getOrderStatus() async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(new OrderStatus());
  }
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url = '${GlobalConfiguration().getValue('api_base_url')}order_statuses?$_apiToken';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) {
    return OrderStatus.fromJSON(data);
  });
}

