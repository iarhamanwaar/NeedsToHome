import 'package:login_and_signup_web/src/helpers/custom_trace.dart';

class ShopSellerKyc{
  String id;
  String personalProof;
  String selectedYear;
  String businessType;
  String holdersName;
  String accountNumber;
  String bankCode;
  String branch;
  String bankName;

  ShopSellerKyc();
  ShopSellerKyc.fromJSON(Map<String,dynamic> jsonMap){
    try{
      id=jsonMap['id'];
      personalProof=jsonMap['personalProof'];
      selectedYear=jsonMap['selectedYear'] != null ? jsonMap['selectedYear'] : '';
      businessType=jsonMap['businessType'] != null ? jsonMap['businessType'] : '';
      holdersName = jsonMap['holdersName']  != null ? jsonMap['holdersName'] : '';
      accountNumber = jsonMap['accountNumber'] != null ? jsonMap['accountNumber'] : '';
      bankCode  = jsonMap['bankCode'] != null ? jsonMap['bankCode'] : '';
      branch  = jsonMap['branch'] != null ? jsonMap['branch'] : '';
      bankName  = jsonMap['bankName'] != null ? jsonMap['bankName'] : '';
    }
    catch(e){
      id='';
      personalProof='';
      selectedYear='';
      businessType='';
      holdersName = '';
      accountNumber = '';
      bankCode= '';
      branch= '';
      bankName= '';
      print(CustomTrace(StackTrace.current,message: e));
    }
  }
  Map<String, dynamic> toJson() => {
    "id": id,
    "personalProof": personalProof,
    "selectedYear": selectedYear,
    "businessType": businessType,
    "holdersName": holdersName,
    "accountNumber": accountNumber,
    "bankCode": bankCode,
    "branch": branch,
    "bankName": bankName,
  };
  Map toMap(){
    var map=new Map<String,dynamic>();
    map['id']=id;
    map['personalProof']=personalProof;
    map['selectedYear']=selectedYear;
    map['businessType']=businessType;
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