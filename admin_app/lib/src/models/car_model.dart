

import '../helpers/custom_trace.dart';

class CarTypeModel {
  String id;
  String cartype;
  String basefare;
  String minimumfare;
  String distancekm;
  String rightminute;
  String conveniencefees;
  String cancelationfees;
  var  uploadImage;

  CarTypeModel();

  CarTypeModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      cartype = jsonMap['cartype'];
      basefare = jsonMap['basefare'];
      minimumfare = jsonMap['minimumfare'];
      distancekm  = jsonMap['distancekm'];
      rightminute  = jsonMap['rightminute'];
      conveniencefees  = jsonMap['conveniencefees'];
      cancelationfees  = jsonMap['cancelationfees'];
      uploadImage = jsonMap['uploadImage'];
    } catch (e) {
      cartype = '';
      basefare = '';
      minimumfare = '';
      distancekm = '';
      rightminute = '';
      conveniencefees = '';
      cancelationfees = '';

      uploadImage = '';

      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["cartype"] = cartype;
    map["basefare"] = basefare;
    map["minimumfare"] = minimumfare;
    map["distancekm"] = distancekm;
    map["rightminute"] = rightminute;
    map["conveniencefees"] = conveniencefees;
    map["cancelationfees"] = cancelationfees;

    map["uploadImage"] = uploadImage;

    return map;
  }


}
