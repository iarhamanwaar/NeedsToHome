import 'package:multisuperstore/src/models/vendor.dart';

import '../helpers/custom_trace.dart';

class Slide {
  String id;
  // ignore: non_constant_identifier_names
  String slider_text;
  // ignore: non_constant_identifier_names
  String redirect_type;
  // ignore: non_constant_identifier_names
  String para;
  String image;
  String 	superCategoryId;
  String shopTypeId;
  Vendor  vendorDetails = new Vendor();


  Slide();

  Slide.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      slider_text = jsonMap['slider_text'] != null ? jsonMap['slider_text'] : '';
      redirect_type = jsonMap['redirect_type'] != null ? jsonMap['redirect_type'] :  '';
      para = jsonMap['para'] != null ? jsonMap['para'] :  '';
      shopTypeId = jsonMap['shopTypeId'] != null ? jsonMap['shopTypeId'] :  '';
      image = jsonMap['image'];
      superCategoryId = jsonMap['superCategoryId'] != null ? jsonMap['superCategoryId'] :  '';
      vendorDetails = jsonMap['vendorDetails'] != null ? Vendor.fromJSON(jsonMap['vendorDetails']) : Vendor.fromJSON({});
    } catch (e) {
      id = '';
      slider_text = '';
      redirect_type = '';
      para = '';
      image = '';
      superCategoryId = '';
      shopTypeId = '';

      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}
