import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/helpers/custom_trace.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/banner.dart';
import 'package:login_and_signup_web/src/models/delivery_timeslot.dart';
import 'package:login_and_signup_web/src/models/driver_details.dart';
import 'package:login_and_signup_web/src/models/vendorwallet.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Alignment,Row;
import 'package:universal_html/html.dart' show AnchorElement, Blob, Url, document;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import '../models/excel_export.dart';

 addBannerData(BannerModel itemData,pageType,id) async {

  // ignore: deprecated_member_use
  Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_vendor/banner/$pageType/${currentUser.value.id}/$id");
  Map<String, dynamic> _queryParams = {};

  _queryParams['api_token'] = currentUser.value.apiToken;
  uri = uri.replace(queryParameters: _queryParams);

  try {

   var request = http.MultipartRequest('POST', uri);
   if(itemData.uploadImage!='no_edit') {
    Uint8List data = await itemData.uploadImage.readAsBytes();
    List<int> list = data.cast();
    var pic = http.MultipartFile.fromBytes(
        'image', list, filename: 'myFile.png');
    request.files.add(pic);
   }
   request.fields['title'] = itemData.title;
   request.fields['para'] = itemData.para;
   request.fields['categoryId'] = itemData.categoryId;
   //request.fields['type'] = itemData.type;

   request.fields['redirect_type'] = itemData.redirectType;

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

addVendorWallet(amount) async {

 // ignore: deprecated_member_use
 Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_admin/VendorWallet/add/${currentUser.value.id}");

 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);

 try {

  var request = http.MultipartRequest('POST', uri);
  request.fields['amount'] = amount;
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







Future<Stream<BannerModel>> getBanner(id) async {
 Uri uri = Helper.getUri('Api_vendor/banner/list/$id/${currentUser.value.id}');
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
      .map((data) => BannerModel.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new BannerModel.fromJSON({}));
 }
}




/* wallet banner */
Future<Stream<VendorWallet>> getWalletBanner() async {
 Uri uri = Helper.getUri('Api_admin/VendorWallet/list/${currentUser.value.id}');

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

Future<Stream<DeliveryTimeSlotModel>> getDeliveryTimeSlot() async {
 Uri uri = Helper.getUri('Api_vendor/deliveryTimeSlot/list/null/${currentUser.value.id}');
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
      .map((data) => DeliveryTimeSlotModel.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new DeliveryTimeSlotModel.fromJSON({}));
 }
}


addEddDeliveryTimeSlotData(DeliveryTimeSlotModel itemData) async {


  final String _apiToken = 'api_token=${ currentUser.value.apiToken}';
 // ignore: deprecated_member_use
 final String url = '${GlobalConfiguration().getString('api_base_url')}api_vendor/deliveryTimeSlot/do_add/null/${currentUser.value.id}?$_apiToken';

 bool res;
 final client = new http.Client();
 final response = await client.post(
  Uri.parse(url),
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(itemData.toMap()),
 );
 print(url);
 if (response.statusCode == 200) {

  if (json.decode(response.body)['success'] == 'true') {
   res = true;
  } else {
   res = false;
  }
 } else {
  throw new Exception(response.body);
 }
 return res;
}

Future<DriverDetailsModel> getDriverDetailsData(id) async {

 Uri uri = Helper.getUri('Api_vendor/driverDetails/do_add/$id/${currentUser.value.id}');
 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);

 DriverDetailsModel res;
 final client = new http.Client();
 final response = await client.post(
  uri,
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(''),
 );


 if (response.statusCode == 200) {

  if (response.statusCode == 200) {

   res = DriverDetailsModel.fromJSON(json.decode(response.body)['data']);
  } else {
   throw new Exception(response.body);
  }

  return res;
 } else {
  throw new Exception(response.body);
 }
}

Future<void> createExcel(List<ExcelExportModel> listExcel,List  _listData, filename, fileType) async {


 final Workbook workbook = Workbook();
 final Worksheet sheet = workbook.worksheets[0];

 var schema = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
 Style globalStyle = workbook.styles.add('style');

 for (var i = 0; i < listExcel.length; i++) {
  sheet.getRangeByName('${schema[i]}1').columnWidth = listExcel[i].columnWidth;
  globalStyle.bold = listExcel[i].bold;
  sheet.getRangeByName('${schema[i]}1').cellStyle = globalStyle;
  sheet.getRangeByName('${schema[i]}1').setText(listExcel[i].title);
 }


 int inc= 2;
 for (var j = 0; j < _listData.length; j++) {
  for (var i = 0; i < listExcel.length; i++) {
   sheet.getRangeByName('${schema[i]}$inc').setText(_listData[j][i]);

  }

  inc++;
 }

 final List<int> bytes = workbook.saveAsStream();
 workbook.dispose();

 if (kIsWeb) {
  if(fileType=='xl') {
   AnchorElement(
       href:
       'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(
           bytes)}')
    ..setAttribute('download', '$filename.xlsx')
    ..click();
  } else if(fileType=='csv') {

  }
 } else {
  print(filename);
  final String path = (await getApplicationSupportDirectory()).path;
   String fileName;
  if(fileType=='xl') {

   // ignore: unnecessary_statements
   Platform.isWindows ? '$path\\$filename.xlsx' : '$path/$filename.xlsx';
  } else if(fileType=='csv') {
   // ignore: unnecessary_statements
   Platform.isWindows ? '$path\\$filename.xlsx' : '$path/$filename.csv';
  }
  final File file = File(fileName);
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open(fileName);
 }
}

void generateCSV(List<String> listHeader,List  _listData, filename, fileType){
  List<String> rowHeader = listHeader;
 List<List<dynamic>> rows = [];
 rows.add(rowHeader);
  for (var j = 0; j < _listData.length; j++) {
   List<dynamic> dataRow = [];
   for (var i = 0; i < listHeader.length; i++) {


    dataRow.add(_listData[j][i]);

   }
   rows.add(dataRow);
 }
 String csv = const ListToCsvConverter().convert(rows);
 final bytes = utf8.encode(csv);
 final blob =  Blob([bytes]);
 final url = Url.createObjectUrlFromBlob(blob);
 final anchor = document.createElement('a')  as    AnchorElement..href = url..style.display = 'none'         ..download = 'yourcsvname.csv';
document.body.children.add(anchor);
 anchor.click();
 Url.revokeObjectUrl(url);

}