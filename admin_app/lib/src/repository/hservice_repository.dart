


import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';


import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/helpers/custom_trace.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/category.dart';

import 'package:http/http.dart' as http;
import 'package:login_and_signup_web/src/models/packagemodel.dart';
import 'package:login_and_signup_web/src/models/providerbooking.dart';
import 'package:login_and_signup_web/src/models/providerdata_model.dart';
import 'package:login_and_signup_web/src/models/subcategory_List.dart';
import 'package:login_and_signup_web/src/models/supercategory.dart';
import 'package:login_and_signup_web/src/models/zone.dart';

import 'package:login_and_signup_web/src/repository/user_repository.dart';

import '../models/provider.dart';






Future<Stream<ProviderBooking>> getProviderBooking() async {

  Uri uri = Helper.getUri('Api_admin/BookingList/');
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
        .map((data) => ProviderBooking.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new ProviderBooking.fromJSON({}));
  }
}


Future<Stream<ProviderServiceDataModel>> getProviderService(id) async {

  Uri uri = Helper.getUri('Api_admin/providerData/list/$id');
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
        .map((data) => ProviderServiceDataModel.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new ProviderServiceDataModel.fromJSON({}));
  }
}

Future<Stream<CategoryModel>> getCategory() async {

  Uri uri = Helper.getUri('Api_admin/h_category/list/${currentUser.value.id}');
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
        .map((data) => CategoryModel.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new CategoryModel.fromJSON({}));
  }
}
Future<Stream<ZoneModel>> getZone() async {

  Uri uri = Helper.getUri('Api_admin/Zone/');
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
        .map((data) => ZoneModel.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new ZoneModel.fromJSON({}));
  }
}

aECategory(CategoryModel categoryData, paraType, id) async {

  // ignore: deprecated_member_use
  Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/h_category/$paraType/$id/${currentUser.value.id}");
  Map<String, dynamic> _queryParams = {};

  _queryParams['api_token'] = currentUser.value.apiToken;
  uri = uri.replace(queryParameters: _queryParams);
  try {

    var request = http.MultipartRequest('POST', uri);

    if( categoryData.uploadImage!=null && categoryData.uploadImage!='no_change') {
      Uint8List data = await categoryData.uploadImage.readAsBytes();
      List<int> list = data.cast();

      var pic = http.MultipartFile.fromBytes('image', list, filename: 'myFile.png');
      request.files.add(pic);
    }
    request.fields['categoryName'] = categoryData.categoryName;
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

Future<Stream<PackageModel>> getPackage() async {

  Uri uri = Helper.getUri('Api_admin/Package/list/${currentUser.value.id}');
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
        .map((data) => PackageModel.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new PackageModel.fromJSON({}));
  }
}


aEPackage(PackageModel packageData, paraType, id) async {

  // ignore: deprecated_member_use
  Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/Package/$paraType/$id/${currentUser.value.id}");
  Map<String, dynamic> _queryParams = {};

  _queryParams['api_token'] = currentUser.value.apiToken;
  uri = uri.replace(queryParameters: _queryParams);
  try {

    var request = http.MultipartRequest('POST', uri);

    if( packageData.image!=null && packageData.image!='no_change') {
      Uint8List data = await packageData.image.readAsBytes();
      List<int> list = data.cast();
      //print(categoryData.categoryName);
      var pic = http.MultipartFile.fromBytes('image', list, filename: 'myFile.png');
      request.files.add(pic);
    }
    request.fields['name'] = packageData.name;
    request.fields['admin'] = currentUser.value.id;

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

Future<Stream<SuperCategoryModel>> getSuperCategory() async {

  Uri uri = Helper.getUri('Api_admin/SuperCategory/list/${currentUser.value.id}');
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
        .map((data) => SuperCategoryModel.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new SuperCategoryModel.fromJSON({}));
  }
}

aESuperCategory(SuperCategoryModel categoryData, paraType, id) async {
  // ignore: deprecated_member_use
  Uri uri = Uri.parse("${GlobalConfiguration().getString(
      'base_url')}Api_admin/SuperCategory/$paraType/$id/${currentUser.value.id}");
  print(uri);
  Map<String, dynamic> _queryParams = {};
  _queryParams['api_token'] = currentUser.value.apiToken;
  uri = uri.replace(queryParameters: _queryParams);
  try {
    var request = http.MultipartRequest('POST', uri);

    request.fields['sortBy']=categoryData.sortBy;
    request.fields['categoryName'] = categoryData.categoryName;
    request.fields['admin'] = currentUser.value.id;

    var response = await request.send();

    if (response.statusCode == 200) {
      response.stream.bytesToString().asStream().listen((event) {
        var parsedJson = json.decode(event);
        print(parsedJson);
        print(response.statusCode);
        //It's done...
      });
    } else {}
  } catch (e) {
    print(e);
  }
}


Future<bool> globalDelete(String table,  id) async {

  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api_admin/globalDelete/$table/$id';
  print(url);
  bool res;
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );
print('return');
print(json.decode(response.body)['data']);
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

Future<Stream<ProviderModel>> getProvider() async {
  Uri uri = Helper.getUri('Api_admin/Provider/list/${currentUser.value.id}');
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
        .map((data) => ProviderModel.fromJSON(data));
  } catch (e) {
    print(e);
    print('repository error');
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new ProviderModel.fromJSON({}));
  }
}

aEProvider(ProviderModel providerData, paraType, id) async {


  // ignore: deprecated_member_use
  Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/Provider/$paraType/$id/${currentUser.value.id}");
  Map<String, dynamic> _queryParams = {};

  _queryParams['api_token'] = currentUser.value.apiToken;
  uri = uri.replace(queryParameters: _queryParams);
  try {

    var request = http.MultipartRequest('POST', uri);

    if( providerData.uploadImage!=null && providerData.uploadImage!='no_change') {
      Uint8List data = await providerData.uploadImage.readAsBytes();
      List<int> list = data.cast();
      //print(.categoryName);
      var pic = http.MultipartFile.fromBytes('image', list, filename: 'myFile.png');
      request.files.add(pic);
    }
    request.fields['username'] = providerData.username;
    request.fields['lastname'] = providerData.lastname;
    request.fields['dob'] = providerData.dob;
    request.fields['gender'] = providerData.gender;
    request.fields['email'] = providerData.email;
    request.fields['password'] = providerData.password;
    request.fields['mobile'] = providerData.mobile;
    request.fields['address1'] = providerData.address1;
    request.fields['address2'] = providerData.address2;
    request.fields['city'] = providerData.city;
    request.fields['state'] = providerData.state;
    request.fields['zipcode'] = providerData.zipcode;
    request.fields['aboutyou'] = providerData.about;
    request.fields['work_exp'] = providerData.workingexperience;
    request.fields['status'] = providerData.status.toString();
    request.fields['latitude'] = providerData.latitude;
    request.fields['longitude'] = providerData.longitude;
    //request.fields['token'] = providerData.;
    request.fields['device_id'] = providerData.deviceid;
    request.fields['livestatus'] = providerData.liveStatus;




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

Future<Stream<SubCategoryListModel>> getSubCategory() async {
  Uri uri = Helper.getUri('Api_admin/subcategory/list/null/${currentUser.value.id}');
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
        .map((data) => SubCategoryListModel.fromJSON(data));
  } catch (e) {

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new SubCategoryListModel.fromJSON({}));
  }
}

addSubCategory(SubCategoryListModel categoryData, paraType, id) async {

  // ignore: deprecated_member_use
  Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/subcategory/$paraType/$id/${currentUser.value.id}");
  Map<String, dynamic> _queryParams = {};

  _queryParams['api_token'] = currentUser.value.apiToken;
  uri = uri.replace(queryParameters: _queryParams);



  try {

    var request = http.MultipartRequest('POST', uri);

    if( categoryData.uploadImage!=null && categoryData.uploadImage!='no_change') {
      Uint8List data = await categoryData.uploadImage.readAsBytes();
      List<int> list = data.cast();
      var pic = http.MultipartFile.fromBytes('image', list, filename: 'myFile.png');
      request.files.add(pic);
    }

    request.fields['categoryName'] = categoryData.subcategoryName;
    request.fields['categoryId'] = categoryData.categoryId;
    request.fields['vendor'] = currentUser.value.id;

    var response = await request.send();
    if (response.statusCode == 200) {
      response.stream.bytesToString().asStream().listen((event) {
        var parsedJson = json.decode(event);
        print(parsedJson);

        //It's done...
      });
    } else {}
  }catch (e) {

    print(e);

  }
}







