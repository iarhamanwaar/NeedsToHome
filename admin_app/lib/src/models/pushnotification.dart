
class PushNotificationModel {
  String userType;
  String title;
  String message;
  var uploadImage;



  // used for indicate if client logged in or not
  bool auth;

//  String role;

  PushNotificationModel();

  PushNotificationModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      userType = jsonMap['userType'] != null ? jsonMap['userType'] : '';
      title = jsonMap['title'] != null ? jsonMap['title'] : '';
      message = jsonMap['message'] != null ? jsonMap['message'] : '';
      uploadImage = jsonMap['uploadImage'] != null ? jsonMap['uploadImage'] : '';


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["userType"] = userType;
    map["title"] = title;
    map["message"] = message;




    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}
