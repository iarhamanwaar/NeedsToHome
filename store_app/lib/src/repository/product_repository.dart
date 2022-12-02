import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/helpers/custom_trace.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/models/addon.dart';
import 'package:login_and_signup_web/src/models/category_List.dart';
import 'package:login_and_signup_web/src/models/category.dart';
import 'package:login_and_signup_web/src/models/product.dart';
import 'package:login_and_signup_web/src/models/product_details2.dart';
import 'package:login_and_signup_web/src/models/product_model.dart';
import 'package:login_and_signup_web/src/models/subcategory_List.dart';
import 'package:login_and_signup_web/src/models/user.dart';
import 'package:login_and_signup_web/src/models/variant.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';



Future<Stream<DropDownModel>> getDropdownDataNC(table, select) async {

 Uri uri = Helper.getUri('Api_vendor/globaldropdown/$table/$select/${currentUser.value.id}');
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
      .map((data) => DropDownModel.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new DropDownModel.fromJSON({}));
 }
}



addCategory(CategoryModel categoryData, paraType, id) async {

 // ignore: deprecated_member_use
 Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_vendor/category/$paraType/$id/${currentUser.value.id}");
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
   print('data12');
  }
  request.fields['categoryName'] = categoryData.categoryName;
  request.fields['vendor'] = currentUser.value.id;

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

addSubCategory(SubCategoryListModel categoryData, paraType, id) async {

 // ignore: deprecated_member_use
 Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_vendor/subcategory/$paraType/$id/${currentUser.value.id}");
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

  request.fields['sub_category_name'] = categoryData.subcategoryName;
  request.fields['category'] = categoryData.categoryId;
  request.fields['vendor'] = currentUser.value.id;

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
Future<bool> updateTodaydeals(productId, status) async {



 Uri uri = Helper.getUri('Api_vendor/product/todaydeals/$productId/$status/${currentUser.value.id}');
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
productData(ProductModel productData, paraType, id) async {

 // ignore: deprecated_member_use
 Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_vendor/product/$paraType/$id/null/${currentUser.value.id}");

 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);
 print(uri);
 try {

  var request = http.MultipartRequest('POST', uri);

  if(productData.uploadImage!=null) {

   Uint8List data = await productData.uploadImage.readAsBytes();
   List<int> list = data.cast();
   var pic = http.MultipartFile.fromBytes('image', list, filename: 'myFile.png');
   request.files.add(pic);
  }

  request.fields['category'] = productData.category;
  request.fields['subCategory'] = productData.subCategory;
  request.fields['productTitle'] = productData.productTitle;
  request.fields['salePrice'] = productData.salePrice.toString();
  request.fields['strikePrice'] = productData.strikePrice.toString();
  request.fields['quantity'] = productData.quantity;
  request.fields['unit'] = productData.unit;
  request.fields['stock'] = productData.stock;
  request.fields['tax'] = productData.tax.toString();
  request.fields['discount'] = productData.discount.toString();
  request.fields['vendor'] = currentUser.value.id;
  request.fields['maxQty'] = productData.maxQty;

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

productItemData(ProductModel productData, paraType, id) async {

 // ignore: deprecated_member_use
 Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_vendor/Itemproduct/$paraType/$id/null/${currentUser.value.id}");

 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);

 try {

  var request = http.MultipartRequest('POST', uri);

  if(productData.uploadImage!=null) {

   Uint8List data = await productData.uploadImage.readAsBytes();
   List<int> list = data.cast();
   var pic = http.MultipartFile.fromBytes('image', list, filename: 'myFile.png');
   request.files.add(pic);
  }
  request.fields['category'] = productData.category;
  request.fields['foodType'] = productData.itemType;
  request.fields['productTitle'] = productData.productTitle;
  request.fields['salePrice'] = productData.salePrice.toString();
  request.fields['strikePrice'] = productData.strikePrice.toString();
  request.fields['quantity'] = productData.quantity;
  request.fields['unit'] = productData.unit;
  request.fields['stock'] = productData.stock;
  request.fields['vendor'] = currentUser.value.id;
  request.fields['tax'] = productData.tax;
  request.fields['discount'] = productData.discount.toString();
  request.fields['fromTime'] = productData.fromTime.toString();
  request.fields['toTime'] = productData.toTime.toString();
  request.fields['maxQty'] = productData.maxQty.toString();
  request.fields['packingCharge'] = productData.packingCharge.toString();

  var response = await request.send();

print(uri);
  if (response.statusCode == 200) {
   response.stream.bytesToString().asStream().listen((event) {


    //It's done...
   });
  } else {}
 }catch (e) {

  print(e);

 }
}



productVariant(variantModel productData, paraType, id,functionType) async {
 // User _user = userRepo.currentUser.value;

 //final String _apiToken = 'api_token=${_user.apiToken}';
 // ignore: deprecated_member_use
 Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_vendor/$functionType/$paraType/$id/${currentUser.value.shopTypeId}/${currentUser.value.id}");


 Map<String, dynamic> _queryParams = {};

 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);

 try {

  var request = http.MultipartRequest('POST', uri);

  if(productData.uploadImage!='no_change') {

   Uint8List data = await productData.uploadImage.readAsBytes();
   List<int> list = data.cast();
   var pic = http.MultipartFile.fromBytes('image', list, filename: 'myFile.png');
   request.files.add(pic);
  }


  request.fields['variant_id'] = productData.variant_id.toString();
  request.fields['salePrice'] = productData.sale_price.toString();
  request.fields['strikePrice'] = productData.strike_price.toString();
  request.fields['quantity'] = productData.quantity;
  request.fields['unit'] = productData.unit;
  request.fields['vendor'] = currentUser.value.id;
  request.fields['foodType'] = productData.foodType;
  request.fields['tax'] = productData.tax;
  request.fields['discount'] = productData.discount.toString();
  request.fields['maxQty'] = productData.maxQty.toString();
  if(functionType!='product') {
   request.fields['packingCharge'] = productData.packingCharge;
  }

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
editProductAvailableTime(ProductDetails2 productData, paraType, id) async {

 // ignore: deprecated_member_use
 Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_vendor/Itemproduct/$paraType/$id/null/${currentUser.value.id}");

 Map<String, dynamic> _queryParams = {};
 _queryParams['api_token'] = currentUser.value.apiToken;
 uri = uri.replace(queryParameters: _queryParams);


 try {

  var request = http.MultipartRequest('POST', uri);

  request.fields['fromTime'] = productData.fromTime;
  request.fields['toTime'] = productData.toTime;
  request.fields['title'] =productData.product_name;


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
Future<Stream<CategoryListModel>> getCategory() async {
 Uri uri = Helper.getUri('Api_vendor/category/list/null/${currentUser.value.id}');
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
      .map((data) => CategoryListModel.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new CategoryListModel.fromJSON({}));
 }
}

Future<Stream<SubCategoryListModel>> getSubCategory() async {
 Uri uri = Helper.getUri('Api_vendor/subcategory/list/null/${currentUser.value.id}');
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
      .map((data) => SubCategoryListModel.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new SubCategoryListModel.fromJSON({}));
 }
}


Future<Stream<DropDownModel>> getDropdownData(table, select) async {
 Uri uri = Helper.getUri('Api_vendor/globaldropdown/$table/$select');

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


Future<Stream<variantModel>> getVariantData(id,pageType) async {
 Uri uri = Helper.getUri('Api_vendor/$pageType/variantlist/$id/null/${currentUser.value.id}');
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
      .map((data) => variantModel.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new variantModel.fromJSON({}));
 }
}


Future<Stream<AddonModel>> getAddonData(id) async {
 Uri uri = Helper.getUri('Api_vendor/Itemproduct/addon_list/$id/null/${currentUser.value.id}');
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
      .map((data) => AddonModel.fromJSON(data));
 } catch (e) {

  print(e);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new AddonModel.fromJSON({}));
 }
}


addEdAddon(AddonModel itemData, pageType, id) async {
 User _user = currentUser.value;

 final String _apiToken = 'api_token=${_user.apiToken}';
 // ignore: deprecated_member_use
 final url = "${GlobalConfiguration().getString('base_url')}Api_vendor/Itemproduct/$pageType/$id/null/${currentUser.value.id}?$_apiToken";



 bool res;
 final client = new http.Client();
 final response = await client.post(
  Uri.parse(url),
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(itemData.toMap()),
 );

 if (response.statusCode == 200) {
  // setCurrentUser(response.body);
  // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
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

Future<Stream<DropDownModel>> getDropdownDataSC(table, select, column, para1) async {
 Uri uri = Helper.getUri('Api_vendor/globaldropdownsc/$table/$select/$column/$para1');

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


Future<bool> globalDelete(String table,  id) async {

 // ignore: deprecated_member_use
 final String url = '${GlobalConfiguration().getString('api_base_url')}api_vendor/$table/delete/$id';
print(url);
 bool res;
 final client = new http.Client();
 final response = await client.post(
     Uri.parse(url),
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  body: json.encode(''),
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



Future<Stream<Product>> getProducts(listType) async {
 Uri uri = Helper.getUri('api_vendor/$listType/list/null/null/${currentUser.value.id}');
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
      .map((data) => Product.fromJSON(data));
 } catch (e) {
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  return new Stream.value(new Product.fromJSON({}));
 }
}

Future<bool> updateProductStatus(productId,status) async {
 Uri uri = Helper.getUri('Api_vendor/product/product_status/$productId/$status/${currentUser.value.id}');
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

