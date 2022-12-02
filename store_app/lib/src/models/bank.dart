
class Bank {
  String bankName;
  String accountNo;
  String swiftCode;
  String personalProof;
  String businessType;
  String holdersName;
  String branch;



  // used for indicate if client logged in or not
  bool auth;

//  String role;

  Bank();

  Bank.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      bankName = jsonMap['bankName'] != null ? jsonMap['bankName'] : '';
      accountNo = jsonMap['accountNumber'] != null ? jsonMap['accountNumber'] : '';
      swiftCode = jsonMap['bankCode'] != null ? jsonMap['bankCode'] : '';
      personalProof = jsonMap['personalProof'] != null ? jsonMap['personalProof'] : '';
      businessType = jsonMap['businessType'] != null ? jsonMap['businessType'] : '';
      holdersName = jsonMap['holdersName'] != null ? jsonMap['holdersName'] : '';
      branch = jsonMap['branch'] != null ? jsonMap['branch'] : '';


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["bankName"] = bankName;
    map["accountNo"] = accountNo;
    map["swiftCode"] = swiftCode;
    map["swiftCode"] = swiftCode;




    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}
