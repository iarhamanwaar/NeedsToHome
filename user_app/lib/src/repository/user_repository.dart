import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:multisuperstore/src/helpers/helper.dart';
import '../models/registermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

ValueNotifier<UserLocal> currentUser = new ValueNotifier(UserLocal());

Future<UserLocal> login(UserLocal user) async {
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api/login';

  final client = new http.Client();
  final response = await client.post(
      Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );

  //print(json.decode(response.body)['data']);
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = UserLocal.fromJSON(json.decode(response.body)['data']);

    print(currentUser.value.toMap());
  } else {
    throw new Exception(response.body);
  }
  return currentUser.value;
}

Future<bool> resetPassword(email, otp) async {
  Uri uri = Uri.parse("${GlobalConfiguration().getValue('base_url')}Email/resetPassword/");
  // ignore: deprecated_member_use
  //Uri uri = Uri.parse("https://optimaprotech.com/test/index.php/Email/resetPassword");

  try {
    var request = http.MultipartRequest('POST', uri);


    request.fields['email'] = email;
    request.fields['otp'] = otp;
    request.fields['type'] = 'user';

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

Future<bool> updatePassword(RegisterModel user) async {

  Uri uri = Uri.parse("${GlobalConfiguration().getValue('base_url')}api/updatePassword");
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

Future<void> logout() async {
  currentUser.value = new UserLocal();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
}

Future<bool> register(RegisterModel user) async {

  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api/registerUpdate';

  bool res;
  final client = new http.Client();
  final response = await client.post(
      Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
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

void setCurrentUser(jsonString) async {
  if (json.decode(jsonString)['data'] != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user', json.encode(json.decode(jsonString)['data']));
  }
}

void setCurrentUserUpdate(UserLocal jsonString) async {

  try {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user', json.encode(jsonString.toMap()));
    update(jsonString);
  } catch (e){
     print('store error $e');
  }
}

Future<UserLocal> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  if (currentUser.value.auth == null && prefs.containsKey('current_user')) {
    currentUser.value = UserLocal.fromJSON(json.decode(prefs.get('current_user')));
    currentUser.value.auth = true;
  } else {
    currentUser.value.auth = false;
  }
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  currentUser.notifyListeners();
  return currentUser.value;
}

Future<UserLocal> update(UserLocal user) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('base_url')}api/profileupdate/${currentUser.value.id}?$_apiToken';
  print(url);
  final client = new http.Client();
   await client.post(
      Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  //setCurrentUser(response.body);
  //currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  return currentUser.value;
}

Future<UserLocal> smartLogin(RegisterModel user) async {
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api/smartLogin';



  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );



  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = UserLocal.fromJSON(json.decode(response.body)['data']);


  } else {
    throw new Exception(response.body);
  }
  return  currentUser.value;
}

Future<bool> checkValue(table,col,para) async {
  // ignore: deprecated_member_use
  Uri uri = Helper.getUri('api/checkValue/'+table +'/'+ col);
  Map<String, dynamic> _queryParams = {};
  bool  zone;
  _queryParams['para'] = para;

  uri = uri.replace(queryParameters: _queryParams);

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