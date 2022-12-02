
import '/src/models/statusmanage.dart';

import '../helpers/custom_trace.dart';

class Bookingmodel {
  String bookid;
  String userid;

  String providerid;
  String categoryid;
  // ignore: non_constant_identifier_names
  String category_name;

  String subcategoryid;
  // ignore: non_constant_identifier_names
  String subcategory_name;
  String date;
  String time;
  String address;
  double latitude;
  double longtitude;
  String description;
  String service;
  String chargeperhrs;
  int bookingtime;
  // ignore: non_constant_identifier_names
  String subcategory_img;
  String providename;
  String providermobile;
  String providerimage;
  String status;
  String mobile;
  String username;
  List<Statusmanage> statusManger;

  Bookingmodel();
  Bookingmodel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      bookid = jsonMap['bookid'];
      userid = jsonMap['userid'];
      providerid = jsonMap['providerid'];
      categoryid = jsonMap['categoryid'];
      category_name = jsonMap['category_name'];
      subcategoryid = jsonMap['subcategoryid'];
      subcategory_name = jsonMap['subcategory_name'];
      date = jsonMap['date'];
      time = jsonMap['time'];
      address = jsonMap['address'];
      longtitude = jsonMap['longtitude'];
      latitude = jsonMap['latitude'];
      description = jsonMap['description'];
      service = jsonMap['service'];
      chargeperhrs = jsonMap['chargeperhrs'];
      bookingtime = jsonMap['bookingtime'];
      subcategory_img = jsonMap['subcategory_img'];
      providename = jsonMap['providename'];
      providermobile = jsonMap['providermobile'];
      providerimage = jsonMap['providerimage'];
      status = jsonMap['status'];
      username = jsonMap['username'];
      mobile = jsonMap['mobile'];
      statusManger =
          jsonMap['statusManger'] != null ? List.from(jsonMap['statusManger']).map((element) => Statusmanage.fromJSON(element)).toList() : null;
    } catch (e) {
      userid = '';
      bookid = '';
      providerid = '';
      categoryid = '';
      category_name = '';
      subcategoryid = '';
      subcategory_name = '';
      longtitude = 0.0;
      latitude = 0.0;
      time = '';
      date = '';
      address = '';
      description = '';
      service = '';
      chargeperhrs = '';
      bookingtime = 0;
      subcategory_img = '';
      providename = '';
      providermobile = '';
      providerimage = '';
      status = '';
      statusManger = [];
      username = '';
      mobile = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["userid"] = userid;
    map["providerid"] = providerid;
    map["categoryid"] = categoryid;
    map["category_name"] = category_name;
    map["subcategoryid"] = subcategoryid;
    map["subcategory_name"] = subcategory_name;
    map["longtitude"] = longtitude;
    map["latitude"] = latitude;
    map["time"] = time;
    map["date"] = date;
    map["address"] = address;
    map["description"] = description;
    map["service"] = service;
    map["chargeperhrs"] = chargeperhrs;
    map["bookingtime"] = bookingtime;
    map["subcategory_img"] = subcategory_img;
    map["providename"] = providename;
    map["providermobile"] = providermobile;
    map["providerimage"] = providerimage;
    map["status"] = status;
    map["username"] = username;
    map["mobile"] = mobile;
    return map;
  }
}
