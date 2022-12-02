
class DeliveryTimeSlotModel {
  String fromTime;
  String toTime;
  int timeId;
  int id;



  // used for indicate if client logged in or not
  bool auth;

//  String role;

  DeliveryTimeSlotModel();

  DeliveryTimeSlotModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      fromTime = jsonMap['fromTime'] != null ? jsonMap['fromTime'] : '';
      toTime = jsonMap['toTime'] != null ? jsonMap['toTime'] : '';
      timeId = jsonMap['timeId'] != null ? jsonMap['timeId'] : 0;
      id =  jsonMap['id'] != null ? jsonMap['id'] : 0;


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["fromTime"] = fromTime;
    map["toTime"] = toTime;
    map["timeId"] = timeId;




    return map;
  }


}
