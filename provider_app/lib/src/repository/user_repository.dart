import 'dart:convert';
import 'dart:io';
import 'package:handy/src/models/zonelistmodel.dart';
import '/src/helpers/custom_trace.dart';
import '/src/models/dashboard_model.dart';
import '/src/models/rating.dart';
import '/src/models/timer_catch.dart';
import '../repository/settings_repository.dart' as settingRepo;
import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/helper.dart';
import '../models/address.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as userRepo;
import '../models/category.dart';

ValueNotifier<User> currentUser = new ValueNotifier(User());
ValueNotifier<TimerCatch> currentTimerCatch = new ValueNotifier(TimerCatch());
Address deliveryAddress = new Address();

Future<User> login(User user) async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}Api_provider/login';
  print(url);
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );

  if (response.statusCode == 200) {
    setCurrentUser(response.body);


    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    print(currentUser.value.toMap());
  } else {
    throw new Exception(response.body);
  }
  return currentUser.value;
}

Future<bool> status(status) async {
  bool res;
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}Api_provider/profile/status/${currentUser.value.id}/${currentUser.value.liveStatus}/';

  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );

  if (response.statusCode == 200) {
    res = true;
  } else {
    throw new Exception(response.body);
  }
  return res;
}

Future<Stream<ZoneListModel>> getZoneList() async {
  Uri uri = Helper.getUri('Api_provider/getZoneList/list/${currentUser.value.id}');
  print(uri);
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
        .map((data) => ZoneListModel.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new ZoneListModel.fromJSON({}));
  }
}

Future<User> register(User user) async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}register';
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  }
  return currentUser.value;
}

Future<bool> resetPassword(email, otp) async {
  print(email);
  //Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Email/resetPassword/");
  // ignore: deprecated_member_use
  Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Email/resetPassword/");

  print(uri);
  try {
    var request = http.MultipartRequest('POST', uri);


    request.fields['email'] = email;
    request.fields['otp'] = otp;
    request.fields['type'] = 'provider';

    var response = await request.send();

    if (response.statusCode == 200) {
      response.stream.bytesToString().asStream().listen((event) {


        print(response.statusCode);
        //It's done...
      });
    } else {}
  } catch (e) {

  }
  return true;
}

Future<bool> removeService(categoryId, subcategoryId) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}Api_provider/services/delete/$categoryId/$subcategoryId/${currentUser.value.id}';
  print(url);
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );
  if (response.statusCode == 200) {
    print(json.decode(response.body)['data']);
    return true;
  } else {
    return false;
  }
}

Future<bool> addService(Category category) async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}Api_provider/services/do_add/${currentUser.value.id}';
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(category.toMap()),
  );
  if (response.statusCode == 200) {
    print(json.decode(response.body)['data']);
    return true;
  } else {
    return false;
  }
}

Future<bool> giveRegister(Rating ratingData) async {
  print(ratingData.toMap());
  final String url = '${GlobalConfiguration().getValue('api_base_url')}Api_provider/rating/do_add/${currentUser.value.id}';
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(ratingData.toMap()),
  );
  if (response.statusCode == 200) {
    print(json.decode(response.body)['data']);
    return true;
  } else {
    return false;
  }
}

Future<void> logout() async {
  currentUser.value = new User();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
}

void setCurrentUser(jsonString) async {
  try {
    if (json.decode(jsonString)['data'] != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('current_user', json.encode(json.decode(jsonString)['data']));
    }
  } catch (e) {
    print(jsonString);
  }
}


Future<User> getCurrentUser(loadType) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
//  prefs.clear();
  if (currentUser.value.auth == null && prefs.containsKey('current_user')) {
    currentUser.value = User.fromJSON(json.decode(await prefs.get('current_user')));
    currentUser.value.auth = true;
  } else {
    currentUser.value.auth = false;
  }
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  currentUser.notifyListeners();

  if (loadType == 'firstLoad') {
    settingRepo.initSettings();
  }
  return currentUser.value;
}



Future<User> update(User user) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  final String url = '${GlobalConfiguration().getValue('api_base_url')}users/${currentUser.value.id}?$_apiToken';
  final client = new http.Client();
  print(user.toMap());
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  setCurrentUser(response.body);
  currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  return currentUser.value;
}

Future<Stream<Address>> getAddresses() async {
  User _user = currentUser.value;
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}delivery_addresses?$_apiToken&search=user_id:${_user.id}&searchFields=user_id:=&orderBy=is_default&sortedBy=desc';
  print(url);
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) {
    return Address.fromJSON(data);
  });
}

Future<Address> addAddress(Address address) async {
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'api_token=${_user.apiToken}';
  address.userId = _user.id;
  final String url = '${GlobalConfiguration().getValue('api_base_url')}delivery_addresses?$_apiToken';
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(address.toMap()),
  );
  return Address.fromJSON(json.decode(response.body)['data']);
}

Future<Address> updateAddress(Address address) async {
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'api_token=${_user.apiToken}';
  address.userId = _user.id;
  final String url = '${GlobalConfiguration().getValue('api_base_url')}delivery_addresses/${address.id}?$_apiToken';
  final client = new http.Client();
  final response = await client.put(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(address.toMap()),
  );
  return Address.fromJSON(json.decode(response.body)['data']);
}

Future<Address> removeDeliveryAddress(Address address) async {
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url = '${GlobalConfiguration().getValue('api_base_url')}delivery_addresses/${address.id}?$_apiToken';
  final client = new http.Client();
  final response = await client.delete(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  );
  return Address.fromJSON(json.decode(response.body)['data']);
}

Future<Stream<Category>> getService() async {
  Uri uri = Helper.getUri('Api_provider/services/list/${currentUser.value.id}');
  print(uri);
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
    return new Stream.value(new Category.fromJSON({}));
  }
}

Future<DashboardModel> getDashboardDetails() async {

  Uri uri = Helper.getUri('Api_provider/dashboard/topbar/${currentUser.value.id}');
  Map<String, dynamic> _queryParams = {};

  _queryParams['api_token'] = currentUser.value.apiToken;
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);
  DashboardModel res;
  final client = new http.Client();
  final response = await client.post(
    uri,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );

  print(json.decode(response.body)['data']);

  if (response.statusCode == 200) {
    // setCurrentUser(response.body);
    // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    print(json.decode(response.body)['data']);
    if (response.statusCode == 200) {

      res = DashboardModel.fromJSON(json.decode(response.body)['data']);
    } else {
      throw new Exception(response.body);
    }

    return res;
  } else {
    throw new Exception(response.body);
  }
}

Future<bool> updatePassword(User user) async {

  Uri uri = Uri.parse("${GlobalConfiguration().getValue('base_url')}Api_provider"
      "/updatePassword");

  final client = new http.Client();
  final response = await client.post(
    uri,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  if (response.statusCode == 200) {

    return true;
  } else {
    throw new Exception(response.body);
  }
}