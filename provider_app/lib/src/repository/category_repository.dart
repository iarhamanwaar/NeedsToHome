import 'dart:convert';
import '/src/models/select_dropdown.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import '../helpers/helper.dart';
import '../models/category.dart';

Future<Stream<Category>> getCategories() async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}categories';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => Category.fromJSON(data));
}

/*
Future<Stream<SelectDropdown>> getCategory() async {
  final String url = 'http://192.168.1.8/jps_masteradmin/index.php/Api_provider/categories';
  print(url);
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .map((data) => SelectDropdown.fromJSON(data));
} */

Future<Stream<SelectDropdown>> getCategory() async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}Api_provider/categories';
  print(url);
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) {
    return SelectDropdown.fromJSON(data);
  });
}

Future<Stream<SelectDropdown>> getSubCategory(id) async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}Api_provider/subcategories/$id';
  print(url);
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) {
    return SelectDropdown.fromJSON(data);
  });
}
