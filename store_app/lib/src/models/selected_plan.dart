
class SelectedPlan {
  String vendorId;
  String planId;
  String paymentStatus;
  String paymentType;
  String amount;
  String paymentGateway;
  String key;
  String token;
  String passingType;


  // used for indicate if client logged in or not
  bool auth;

//  String role;

  SelectedPlan();

  SelectedPlan.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      vendorId = jsonMap['vendorId'] != null ? jsonMap['vendorId'] : '';
      planId = jsonMap['planId'] != null ? jsonMap['planId'] : '';
      paymentStatus = jsonMap['paymentStatus'] != null ? jsonMap['paymentStatus'] : '';
      paymentType = jsonMap['paymentType'] != null ? jsonMap['paymentType'] : '';
      amount = jsonMap['amount'] != null ? jsonMap['amount'] : '';
      paymentGateway = jsonMap['paymentGateway'] != null ? jsonMap['paymentGateway'] : '';
      key = jsonMap['key'] != null ? jsonMap['key'] : '';
      token = jsonMap['token'] != null ? jsonMap['token'] : '';
      passingType = jsonMap['passingType'] != null ? jsonMap['passingType'] : '';
    } catch (e) {

      print(e);
    }
  }

  Map<String, dynamic> toJson() => {
    "vendorId": vendorId,
    "planId": planId,
    "paymentStatus": paymentStatus,
    "paymentType": paymentType,
    "amount": amount,
    "paymentGateway": paymentGateway,
    "key": key,
    "token": token,
    "passingType":passingType,

  };
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["vendorId"] = vendorId;
    map["planId"] = planId;
    map["paymentStatus"] = paymentStatus;
    map["paymentType"] = paymentType;
    map["key"] = key;
    map["token"] = token;
    map["paymentGateway"] = paymentGateway;
    map["passingType"] = passingType;




    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}
