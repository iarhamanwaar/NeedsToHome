import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/helpers/custom_trace.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/password_update.dart';
import 'package:login_and_signup_web/src/models/profile_response.dart';
import 'package:login_and_signup_web/src/models/register.dart';
import 'package:http/http.dart' as http;
import 'package:login_and_signup_web/src/models/selected_plan.dart';
import 'package:login_and_signup_web/src/models/user.dart';
import 'package:login_and_signup_web/src/models/vendor_membership.dart';
import 'package:login_and_signup_web/src/models/zoneList.dart';
import 'package:shared_preferences/shared_preferences.dart';
ValueNotifier<User> currentUser = new ValueNotifier(User());

Future<bool> registerUser(Registermodel user) async {
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api_vendor/register';

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



Future<bool> updateProfile(dataValue, type) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api_vendor/profileUpdate/$type/${currentUser.value.id}?$_apiToken';
  print(url);
  bool res;
  final client = new http.Client();
  final response = await client.post(
      Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(dataValue.toMap()),
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


// ignore: missing_return
Future<User> loginUser(User user) async {

    // ignore: deprecated_member_use
    final String url = '${GlobalConfiguration().getString('api_base_url')}api_vendor/login';
    try {

    final client = new http.Client();
    final response = await client.post(
        Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(user.toMap()),
    );

    print(json.decode(response.body)['data']);

    if (response.statusCode == 200) {
      // setCurrentUser(response.body);
      // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
      print(json.decode(response.body)['data']);
      if (response.statusCode == 200) {
        setCurrentUser(response.body);
        currentUser.value = User.fromJSON(json.decode(response.body)['data']);
      } else {
        throw new Exception(response.body);
      }
      print(currentUser.value.name);
      return currentUser.value;
    } else {
      throw new Exception(response.body);
    }
  }catch (e) {
      print(e);
  }
}


void setCurrentUser(jsonString) async {
  if (json.decode(jsonString)['data'] != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user', json.encode(json.decode(jsonString)['data']));
  }
}
Future<User> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();


  if (currentUser.value.auth == null && prefs.containsKey('current_user')) {

    currentUser.value = User.fromJSON(json.decode(prefs.get('current_user')));

    currentUser.value.auth = true;
  } else {
    currentUser.value.auth = false;
  }
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  currentUser.notifyListeners();
  return currentUser.value;
}

Future<Stream<User>> paymentStatus() async {

  // ignore: deprecated_member_use
  Uri uri = Helper.getUri('api_vendor/paymentstatus/${currentUser.value.id}');
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
        .map((data) => User.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new User.fromJSON({}));
  }
}

Future<void> logout() async {
  currentUser.value = new User();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
}


void setCurrentUserUpdate(User jsonString) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('current_user', json.encode(jsonString.toMap()));
}

Future<ProfileResponse> getProfileDetails() async {
  Uri uri = Helper.getUri('Api_vendor/profileUpdate/profilelist/${currentUser.value.id}');
  Map<String, dynamic> _queryParams = {};

  _queryParams['api_token'] = currentUser.value.apiToken;
  uri = uri.replace(queryParameters: _queryParams);
 print(uri);
  ProfileResponse res;
  final client = new http.Client();
  final response = await client.post(
    uri,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );


  if (response.statusCode == 200) {
    // setCurrentUser(response.body);
    // currentUser.value = User.fromJSON(json.decode(response.body)['data']);

    if (response.statusCode == 200) {

      res = ProfileResponse.fromJSON(json.decode(response.body)['data']);
    } else {
      throw new Exception(response.body);
    }

    return res;
  } else {
    throw new Exception(response.body);
  }
}


Future<ProfileResponse> updateVendorPlan(SelectedPlan selectedPlan) async {

  Uri uri = Helper.getUri('Api_vendor/membership_plan/plan_update/${currentUser.value.id}');
  Map<String, dynamic> _queryParams = {};

  _queryParams['api_token'] = currentUser.value.apiToken;
  uri = uri.replace(queryParameters: _queryParams);

  ProfileResponse res;
  final client = new http.Client();
  final response = await client.post(
    uri,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(selectedPlan.toMap()),
  );

  print(json.decode(response.body)['data']);

  if (response.statusCode == 200) {
    if (response.statusCode == 200) {

      res = ProfileResponse.fromJSON(json.decode(response.body)['data']);
    } else {
      throw new Exception(response.body);
    }

    return res;
  } else {
    throw new Exception(response.body);
  }
}


// ignore: missing_return
Future<bool> passwordManagement(type, value,value2) async {
  PasswordUpdate password = new PasswordUpdate();
  password.newPassword = value;
  password.oldPassword = value2;
  password.vendorId = currentUser.value.id;
  bool state;
  // ignore: deprecated_member_use
  Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_vendor/passwordManagement/$type/${currentUser.value.id}");

  Map<String, dynamic> _queryParams = {};

  _queryParams['api_token'] = currentUser.value.apiToken;
  uri = uri.replace(queryParameters: _queryParams);

  final client = new http.Client();
  final response = await client.post(
    uri,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(password.toMap()),
  );


  if (response.statusCode == 200) {
    if (response.statusCode == 200) {

       state = json.decode(response.body)['data'];
       return state;
    } else {
      throw new Exception(response.body);
    }


  } else {
    throw new Exception(response.body);
  }

}

addUpdateProfile(itemData, type, image) async {

  // ignore: deprecated_member_use
  Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_vendor/profileUpdateSteps/$type/null/${currentUser.value.id}");

  Map<String, dynamic> _queryParams = {};

  _queryParams['api_token'] = currentUser.value.apiToken;
  uri = uri.replace(queryParameters: _queryParams);

  print(uri);
  try {

    var request = http.MultipartRequest('POST', uri);
    print(image);
   if(image=='yes') {
     Uint8List data = await itemData.logo.readAsBytes();
      List<int> list = data.cast();
      var pic = http.MultipartFile.fromBytes(
          'image', list, filename: 'myFile.png');
      request.files.add(pic);
      print('jack');
    }

    print(json.encode(itemData));
    request.fields['title'] = json.encode(itemData);

    var response = await request.send();
 print('send success');
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


Future<Stream<VendorMembershipModel>> getMembership(id) async {
  Uri uri = Helper.getUri('Api_vendor/membership_plan/list/$id/${currentUser.value.id}');
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


Future<Stream<ZoneListModel>> getZoneList() async {
  Uri uri = Helper.getUri('Api_vendor/getZoneList/list/${currentUser.value.id}');

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
        .map((data) => ZoneListModel.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new ZoneListModel.fromJSON({}));
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
Future<bool> updatePassword(User user) async {
  Uri uri = Uri.parse("${GlobalConfiguration().getValue('base_url')}Api_vendor/updatePassword");
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


reSetPassword(email, otp) async {
  Uri uri = Uri.parse("${GlobalConfiguration().getValue('base_url')}Email/resetPassword/");


 // Uri uri = Uri.parse("https://optimaprotech.com/test/index.php/Email/resetPassword");
  // ignore: deprecated_member_use

  try {
  var request = http.MultipartRequest('POST', uri);


  request.fields['email'] = email;
  request.fields['otp'] = otp;
  request.fields['type'] = 'vendor';

  var response = await request.send();

  if (response.statusCode == 200) {
    response.stream.bytesToString().asStream().listen((event) {

      //It's done...
    });
  } else {}
} catch (e) {

  }
}

