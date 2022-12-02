import 'package:login_and_signup_web/src/helpers/custom_trace.dart';

class ShopBankDetails{
  String id;
  String holdersName;
  String accountNumber;
  String bankCode;
  String branch;
  String bankName;


  ShopBankDetails();

  ShopBankDetails.fromJSON(Map<String,dynamic> jsonMap){
    try {
      id = jsonMap['id'];
      holdersName = jsonMap['holdersName']  != null ? jsonMap['holdersName'] : '';
      accountNumber = jsonMap['accountNumber'] != null ? jsonMap['accountNumber'] : '';
      bankCode  = jsonMap['bankCode'] != null ? jsonMap['bankCode'] : '';
      branch  = jsonMap['branch'] != null ? jsonMap['branch'] : '';
      bankName  = jsonMap['bankName'] != null ? jsonMap['bankName'] : '';
    } catch (e) {
      id = '';
      holdersName = '';
      accountNumber = '';
      bankCode= '';
      branch= '';
      bankName= '';

      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["holdersName"] = holdersName;
    map["accountNumber"] = accountNumber;
    map["bankCode"] = bankCode;
    map["branch"] = branch;
    map["bankName"] = bankName;
    return map;
  }
  @override
  String toString() {
    var map = this.toMap();
    return map.toString();
  }
}